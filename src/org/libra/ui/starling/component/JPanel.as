package org.libra.ui.starling.component {
	import org.libra.ui.starling.core.Container;
	import org.libra.ui.starling.theme.DefaultTheme;
	import org.libra.ui.starling.theme.PanelTheme;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * <p>
	 * 面板，不带TitleBar的
	 * </p>
	 *
	 * @class JPanel
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/28/2012
	 * @version 1.0
	 * @see
	 */
	public class JPanel extends Container {
		
		/**
		 * 所在的容器
		 * @private
		 */
		protected var owner:Container;
		
		/**
		 * 是否在舞台上
		 * @private
		 */
		protected var showing:Boolean;
		
		/**
		 * 面板的主题风格
		 * @private
		 */
		protected var theme:PanelTheme;
		
		/**
		 * 构造函数
		 * @private
		 * @param	owner
		 * @param	theme
		 * @param	width
		 * @param	height
		 * @param	x
		 * @param	y
		 */
		public function JPanel(owner:Container, theme:PanelTheme, width:int, height:int, x:int = 0, y:int = 0) {
			super(width, height, x, y);
			this.owner = owner;
			this.theme = theme;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 放置舞台上
		 */
		public function show():void {
			if (showing) return;
			this.owner.addChild(this);
			showing = true;
		}
		
		/**
		 * 关闭面板
		 * 从舞台上移除
		 */
		public function close():void {
			if (showing) {
				this.owner.removeChild(this);
				showing = false;
			}
		}
		
		/**
		 * 如果关着，那么打开
		 * 如果打开，那么关着
		 */
		public function showSwitch():void {
			showing ? close() : show();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void {
			super.init();
			this.setBackground(new JScale9Sprite(DefaultTheme.getInstance().getScale9Texture(theme)));
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			this.$background.width = $actualWidth;
			this.$background.height = $actualHeight;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			if (e.target == this) {
				this.addEventListener(TouchEvent.TOUCH, onTouch);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		/**
		 * 触摸事件
		 * 当触摸到面板时，面板自动置于容器的顶层
		 * @private
		 * @param	e
		 */
		private function onTouch(e:TouchEvent):void {
			if (!this.enabled) return;
			
			const touches:Vector.<Touch> = e.getTouches(this);
			if(!touches.length) return;
			
			for each(var touch:Touch in touches) {
				if(touch.phase == TouchPhase.BEGAN) {
					owner.bringToTop(this);
					return;
				}
			}
		}
	}

}