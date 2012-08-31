package org.libra.ui.base {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.libra.ui.style.Filter;
	
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
	public class Component extends Sprite {// implements IComponent {
		
		/**
		 * 宽度
		 */
		protected var $width:int;
		
		/**
		 * 高度
		 */
		protected var $height:int;
		
		protected var enable:Boolean;
		
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
		
		public function Component(x:Number = 0, y:Number = 0) { 
			super();
			
			//取消flash默认的焦点边框
			this.focusRect = false;
			this.enable = true;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			setLocation(x, y);
			invalidate();
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
		
		public function removeFromParent(dispose:Boolean = false):void { 
            if (parent) {
				parent.removeChild(this);
				if(dispose)
					this.dispose();
			}
        }
		
		public function setLocation(x:Number, y:Number):void { 
			this.x = x;
			this.y = y;
		}
		
		public function setSize(w:int, h:int):void {
			this.$width = w;
			this.$height = h;
			invalidate();
		}
		
		public function setWidth(val:int):void {
			this.$width = val;
			invalidate();
		}
		
		public function getWidth():int {
			return this.$width;
		}
		
		public function setHeight(val:int):void {
			this.$height = val;
			invalidate();
		}
		
		public function getHeight():int {
			return this.$height;
		}
		
		public function setEnable(val:Boolean):void {
			this.enable = val;
			this.tabEnabled = this.mouseChildren = this.mouseEnabled = val;
		}
		
		public function isEnable():Boolean {
			return this.enable;
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
		
		public function dispose():void {
			if (this.hasEventListener(Event.ADDED_TO_STAGE)) {
				this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			}
		}
		
		override public function toString():String {
			return 'Component';
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		protected function invalidate():void {
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		/**
		 * 渲染组件
		 */
		protected function render():void {
			//GraphicsUtil.drawRect(this.graphics, 0, 0, $width, $height, Style.BACKGROUND);
		}
		
		/**
		 * 添加到舞台上时，调用该方法
		 */
		protected function draw():void {
			drawed = true;
			this.filters = Filter.SHADOW_FILTER;
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
	}

}