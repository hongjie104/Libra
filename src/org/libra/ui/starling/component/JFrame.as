package org.libra.ui.starling.component {
	import flash.geom.Point;
	import org.libra.ui.starling.core.Container;
	import org.libra.ui.starling.theme.DefaultTheme;
	import org.libra.ui.starling.theme.PanelTheme;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * <p>
	 * 带TitleBar的面板
	 * </p>
	 *
	 * @class JFrame
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/03/2012
	 * @version 1.0
	 * @see
	 */
	public class JFrame extends JPanel {
		
		/**
		 * 在拖拽过程中用到的一个Point
		 * 用来计算拖拽过程中的位移偏移量
		 * @private
		 */
		private static var helpPoint:Point = new Point();
		
		/**
		 * 一个透明的可视对象
		 * 用来响应拖拽事件
		 * @private
		 */
		private var bar:Quad;
		
		/**
		 * 响应拖拽事件的范围的高度
		 * @private
		 */
		private var barHeight:int;
		
		/**
		 * 是否在被拖拽中
		 * @private
		 */
		private var draging:Boolean;
		
		/**
		 * 关闭按钮
		 * @private
		 */
		private var closeBtn:JButton;
		
		/**
		 * 是否可以被关闭
		 * @private
		 * @default true
		 */
		private var closeEnabled:Boolean;
		
		/**
		 * 构造函数
		 * @private
		 * @param	owner
		 * @param	theme
		 * @param	width
		 * @param	height
		 * @param	x
		 * @param	y
		 * @param	barHeight
		 */
		public function JFrame(owner:Container, theme:PanelTheme, width:int, height:int, x:int = 0, y:int = 0, barHeight:int = 25) { 
			super(owner, theme, width, height, x, y);
			this.barHeight = barHeight;
			closeEnabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 设置是否可以被关闭
		 * 如果不能被关闭，关闭按钮将从显示列表中移除
		 * @param	val
		 */
		public function setCloseEnabled(val:Boolean):void {
			if (this.closeEnabled != val) {
				closeEnabled = val;
				closeEnabled ? addChild(closeBtn) : removeChild(closeBtn);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void {
			super.init();
			bar = new Quad(actualWidth, barHeight, 0xff0000);
			bar.alpha = .0;
			this.addChild(bar);
			
			initCloseBtn();
		}
		
		/**
		 * 初始化关闭按钮
		 * 子类可以重写该方法，实现不同样式的关闭按钮
		 * @private
		 */
		protected function initCloseBtn():void {
			closeBtn = new JButton(DefaultTheme.BTN_CLOSE, 21, 19, actualWidth - 25, 4);
			if(closeEnabled)
				this.addChild(closeBtn);
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
				bar.addEventListener(TouchEvent.TOUCH, onTouch);
				closeBtn.addEventListener(Event.TRIGGERED, onClose);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			bar.removeEventListener(TouchEvent.TOUCH, onTouch);
			closeBtn.removeEventListener(Event.TRIGGERED, onClose);
		}
		
		/**
		 * 面板的拖拽事件
		 * @private
		 * @param	e
		 */
		private function onTouch(e:TouchEvent):void {
			if (!this.enabled) return;
			
			const touch:Touch = e.getTouch(bar);
			if (touch) {
				if (touch.phase == TouchPhase.MOVED) {
					if (draging) {
						touch.getMovement(stage, helpPoint);
						this.x += helpPoint.x;
						this.y += helpPoint.y;
					}
				}else if (touch.phase == TouchPhase.BEGAN) {
					this.draging = true;
				}else if (touch.phase == TouchPhase.ENDED) {
					draging = false;
				}
			}
		}
		
		/**
		 * 关闭事件
		 * @private
		 * @param	e
		 */
		private function onClose(e:Event):void {
			this.close();
		}
	}

}