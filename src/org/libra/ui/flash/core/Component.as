package org.libra.ui.flash.core {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import org.libra.displayObject.JSprite;
	import org.libra.ui.flash.components.JToolTip;
	import org.libra.ui.flash.interfaces.IComponent;
	import org.libra.ui.flash.interfaces.IDragable;
	import org.libra.ui.flash.managers.DragManager;
	import org.libra.ui.flash.managers.ToolTipManager;
	import org.libra.ui.invalidation.InvalidationFlag;
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
	public class Component extends JSprite implements IComponent, IDragable {
		
		/**
		 * 宽度
		 */
		protected var actualWidth:Number;
		
		/**
		 * 高度
		 */
		protected var actualHeight:Number;
		
		protected var enabled:Boolean;
		
		/**
		 * 是否已经绘制过了。
		 * 绘制方法只调用一次
		 * 在每次被添加到舞台上调用。
		 */
		protected var inited:Boolean;
		
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
		
		private var invalidationFlag:InvalidationFlag;
		
		public function Component(x:int = 0, y:int = 0) { 
			super();
			
			//取消flash默认的焦点边框
			this.focusRect = false;
			this.enabled = true;
			setLocation(x, y);
			
			invalidationFlag = new InvalidationFlag();
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
		
		override public function removeFromParent(destroy:Boolean = false):void { 
            if (parent) {
				if (parent is Container) {
					(parent as Container).remove(this, destroy);
				}else {
					parent.removeChild(this);
					if(destroy)
						this.destroy();	
				}
			}
        }
		
		public function setLocation(x:int, y:int):void { 
			this.x = x;
			this.y = y;
		}
		
		public function setSize(w:int, h:int):void {
			if (actualWidth != w || actualHeight != h) {
				this.actualWidth = w;
				this.actualHeight = h;
				invalidate(InvalidationFlag.SIZE);
			}
		}
		
		public function setBounds(x:int, y:int, w:int, h:int):void {
			this.x = x;
			this.y = y;
			setSize(w, h);
		}
		
		public function setEnabled(val:Boolean):void {
			this.enabled = val;
			this.tabEnabled = this.mouseChildren = this.mouseEnabled = val;
			invalidate(InvalidationFlag.STATE);
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
		
		override public function destroy():void {
			removeAllEventListener();
			setDragEnabled(false);
		}
		
		override public function toString():String {
			return getQualifiedClassName(this);
		}
		
		override public function dispatchEvent(event:Event):Boolean {
			if (this.hasEventListener(event.type)) {
				return super.dispatchEvent(event);	
			}
			return false;
		}
		
		/* INTERFACE org.libra.ui.interfaces.IDragable */
		
		public function setDragEnabled(val:Boolean):void {
			if (this.dragEnabled != val) {
				this.dragEnabled = val;
				if (dragEnabled) this.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
				else this.removeEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
			}
		}
		
		public function getDragBmd():BitmapData {
			var bmd:BitmapData = new BitmapData(actualWidth, actualHeight, true, 0);
			bmd.draw(this);
			return bmd;
		}
		
		public function addChildAll(...rest):void {
			for (var i:* in rest) this.addChild(rest[i]);
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters and setters
		-------------------------------------------------------------------------------------------*/
		
		override public function get width():Number {
			return actualWidth;
		}
		
		override public function set width(value:Number):void {
			setSize(value, actualHeight);
		}
		
		override public function get height():Number {
			return actualHeight;
		}
		
		override public function set height(value:Number):void {
			setSize(actualWidth, value);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		protected function invalidate(flag:int = -1):void {
			this.invalidationFlag.setInvalid(flag);
			if(inited)
				addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		/**
		 * 添加到舞台上时，调用该方法
		 * 在这个方法中，将实例化一些可视对象变量。
		 * 以免在添加到舞台之前，就大量实例化暂时没有用到的对象。
		 */
		protected function init():void {
			inited = true;
			this.invalidate();
		}
		
		/**
		 * 渲染组件
		 * 主要作用是重新布局。
		 * 比如当宽度或者高度改变时，重新绘制下组件
		 */
		protected function draw():void {
			if (this.invalidationFlag.isSizeInvalid())
				resize();
			if (this.invalidationFlag.isDataInvalid())
				refreshData();
			if (this.invalidationFlag.isStateInvalid())
				refreshState();
			if (this.invalidationFlag.isStyleInvalid())
				refreshStyle();
			if (this.invalidationFlag.isTextInvalid())
				refreshText();
		}
		
		protected function refreshText():void {
			
		}
		
		protected function refreshStyle():void {
			
		}
		
		protected function refreshState():void {
			
		}
		
		protected function refreshData():void {
			
		}
		
		protected function resize():void {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onInvalidate(e:Event):void {
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
			this.invalidationFlag.reset();
		}
		
		/**
		 * 添加到舞台事件
		 * @param	e
		 */
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			if (!inited) init();
		}
		
		private function onStartDrag(e:MouseEvent):void {
			DragManager.startDrag(this);
		}
	}

}