package org.libra.ui.base {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.libra.displayObject.JSprite;
	import org.libra.ui.components.JToolTip;
	import org.libra.ui.interfaces.IComponent;
	import org.libra.ui.interfaces.IDragEnabled;
	import org.libra.ui.managers.DragManager;
	import org.libra.ui.managers.ToolTipManager;
	import org.libra.utils.GraphicsUtil;
	
	/**
	 * <p>
	 * 所有组件的父类
	 * </p>
	 *
	 * @class Component
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-30-2012
	 * @version 1.0
	 * @see
	 */
	public class Component extends JSprite implements IComponent, IDragEnabled {
		
		/**
		 * 宽度
		 */
		protected var $width:Number;
		
		/**
		 * 高度
		 */
		protected var $height:Number;
		
		protected var enabled:Boolean;
		
		/**
		 * 是否已经绘制过了。
		 * 绘制方法只调用一次
		 * 在每次被添加到舞台上调用。
		 */
		protected var drawed:Boolean;
		
		/**
		 * 背景，永远在最底层
		 */
		protected var background:DisplayObject;
		
		/**
		 * 遮罩
		 */
		protected var $mask:Shape;
		
		private var dragEnabled:Boolean;
		
		protected var toolTipText:String;
		
		public function Component(x:int = 0, y:int = 0) { 
			super();
			
			//取消flash默认的焦点边框
			this.focusRect = false;
			this.enabled = true;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			setLocation(x, y);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 设置可是对象的层次
		 * 先判断所设之层是否和原层一样，若不一样再使用setChildIndex方法。
		 * 避免多余的重绘。
		 * @param	child
		 * @param	index
		 */
		override public function setChildIndex(child:DisplayObject, index:int):void {
			if (index >= this.numChildren) {
				index = this.numChildren - 1;
			}
			super.setChildIndex(child, index);
		}
		
		/**
		 * 如果index为0，要确保背景在最底层
		 * @param	child
		 * @param	index
		 * @return
		 */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			if (index == 0 && this.background) {
				index = child == background ? 0 : 1;
			}
			return super.addChildAt(child, index);
		}
		
		override public function removeFromParent(dispose:Boolean = false):void { 
            if (parent) {
				if (parent is Container) {
					(parent as Container).remove(this, dispose);
				}else {
					parent.removeChild(this);
					if(dispose)
						this.dispose();	
				}
			}
        }
		
		public function setLocation(x:int, y:int):void { 
			this.x = x;
			this.y = y;
		}
		
		public function setSize(w:int, h:int):void {
			if ($width != w || $height != h) {
				this.$width = w;
				this.$height = h;
				invalidate();
			}
		}
		
		public function setBounds(x:int, y:int, w:int, h:int):void {
			this.x = x;
			this.y = y;
			this.$width = w;
			this.$height = h;
			invalidate();
		}
		
		public function setEnabled(val:Boolean):void {
			this.enabled = val;
			this.tabEnabled = this.mouseChildren = this.mouseEnabled = val;
		}
		
		public function isEnabled():Boolean {
			return this.enabled;
		}
		
		public function setToolTipText(text:String):void {
			this.toolTipText = text;
			ToolTipManager.getInstance().setToolTip(this, text ? JToolTip.getInstance() : null);
		}
		
		public function initToolTip():void {
			JToolTip.getInstance().text = this.toolTipText;
		}
		
		/**
		 * 设置背景
		 * @param	bg
		 */
		public function setBackground(bg:DisplayObject):void {
			if (this.background) this.removeChild(this.background);
			this.background = bg;
			super.addChildAt(bg, 0);
		}
		
		public function setMask(rect:Rectangle = null):void {
			if (rect) {
				if (!this.$mask) this.$mask = new Shape();
				GraphicsUtil.drawRect($mask.graphics, rect.x, rect.y, rect.width, rect.height);
				this.addChild($mask);
				this.mask = $mask;
			}else {
				if ($mask.parent) $mask.parent.removeChild($mask);
				this.mask = null;
			}
		}
		
		override public function dispose():void {
			if (this.hasEventListener(Event.ADDED_TO_STAGE)) {
				this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}
			setDragEnabled(false);
		}
		
		override public function toString():String {
			return 'Component';
		}
		
		override public function dispatchEvent(event:Event):Boolean {
			if (this.hasEventListener(event.type)) {
				return super.dispatchEvent(event);	
			}
			return false;
		}
		
		/* INTERFACE org.libra.ui.interfaces.IDragEnabled */
		
		public function setDragEnabled(val:Boolean):void {
			if (this.dragEnabled != val) {
				this.dragEnabled = val;
				if (dragEnabled) this.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
				else this.removeEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
			}
		}
		
		public function getDragBmd():BitmapData {
			var bmd:BitmapData = new BitmapData($width, $height, true, 0);
			bmd.draw(this);
			return bmd;
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters and setters
		-------------------------------------------------------------------------------------------*/
		
		override public function get width():Number {
			return $width;
		}
		
		override public function set width(value:Number):void {
			this.$width = value;
			invalidate();
		}
		
		override public function get height():Number {
			return $height;
		}
		
		override public function set height(value:Number):void {
			this.$height = value;
			this.invalidate();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		protected function invalidate():void {
			if(drawed)
				addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		/**
		 * 添加到舞台上时，调用该方法
		 * 在这个方法中，将实例化一些可视对象变量。
		 * 以免在添加到舞台之前，就大量实例化暂时没有用到的对象。
		 */
		protected function draw():void {
			drawed = true;
			invalidate();
		}
		
		/**
		 * 渲染组件
		 * 主要作用是重新布局。
		 * 比如当宽度或者高度改变时，重新绘制下组件
		 */
		protected function render():void {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onInvalidate(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			render();
		}
		
		/**
		 * 添加到舞台事件
		 * @param	e
		 */
		protected function onAddToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			if (!drawed) draw();
		}
		
		/**
		 * 从舞台上移除事件
		 * @param	e
		 */
		protected function onRemoveFromStage(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onStartDrag(e:MouseEvent):void {
			DragManager.startDrag(this);
		}
	}

}