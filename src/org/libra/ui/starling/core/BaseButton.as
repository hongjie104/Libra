package org.libra.ui.starling.core {
	import flash.geom.Point;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.ui.starling.core.state.BaseButtonState;
	import org.libra.ui.starling.core.state.IButtonState;
	import org.libra.ui.starling.managers.ScrollRectManager;
	import org.libra.ui.starling.theme.ButtonTheme;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * <p>
	 * 按钮父类
	 * </p>
	 *
	 * @class BaseButton
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/28/2012
	 * @version 1.0
	 * @see
	 */
	public class BaseButton extends BaseText {
		
		/**
		 * 正常状态
		 * @private
		 */
		private static const NORMAL:int = 0;
		
		/**
		 * 鼠标后者触摸抬起
		 * @private
		 */
		private static const MOUSE_UP:int = 1;
		
		/**
		 * 鼠标或者触摸按下
		 * @private
		 */
		private static const MOUSE_DOWN:int = 2;
		
		/**
		 * 鼠标或者触摸进入组件
		 * @private
		 */
		private static const MOUSE_OVER:int = 3;
		
		/**
		 * 在碰撞检测时需要用到很多Point,所以就申明一个私有静态的Point
		 * 以便随时使用,避免生成多个Point
		 * @private
		 */
		private static var helpPoint:Point = new Point();
		
		/**
		 * 按钮的状态管理
		 * 负责根据不同的状态显示不同的texture
		 * @private
		 */
		protected var state:IButtonState;
		
		/**
		 * 按钮当前的状态
		 * @private
		 */
		protected var curState:int;
		
		/**
		 * '0' 代表鼠标事件, 正数用于touch事件。
		 * @private
		 */
		protected var touchPointID:int = -1;
		
		/**
		 * 碰撞检测方法中，标记当前碰撞点是不是在组件上
		 * @private
		 */
		private var hoverSupported:Boolean;
		
		/**
		 * 按钮的主题风格
		 * 控制着按钮的皮肤
		 * @private
		 */
		protected var theme:ButtonTheme;
		
		/**
		 * 构造函数
		 * @private
		 * @param	theme
		 * @param	widht
		 * @param	height
		 * @param	x
		 * @param	y
		 * @param	text
		 */
		public function BaseButton(theme:ButtonTheme, widht:int, height:int, x:int = 0, y:int = 0, text:String = '') { 
			super(widht, height, x, y, text);
			this.theme = theme;
			this.textAlign = 'center';
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override public function set enabled(val:Boolean):void {
			if(!val) this.touchPointID = -1;
			super.enabled = val;
		}
		
		/**
		 * 触发按钮点击事件
		 */
		public function doClick():void {
			this.dispatchEventWith(Event.TRIGGERED);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void {
			super.init();
			initState();
			this.setBackground(state.getDisplayObject());
		}
		
		/**
		 * 初始化按钮状态管理
		 * 这个方法可以被自定义的按钮类重写
		 * 以实现不同的按钮状态管理
		 * @private
		 */
		protected function initState():void {
			state = new BaseButtonState(theme);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			super.resize();
			this.state.setSize(_actualWidth, _actualHeight);
		}
		
		/**
		 * 设置按钮应有的状态，等待被渲染
		 * @private
		 * @param	val
		 */
		protected function setCurState(val:int):void {
			if (curState != val) {
				this.curState = val;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshState():void {
			super.refreshState();
			switch(this.curState) {
				case NORMAL:
					state.toNormal();
					if (_textImage) {
						_textImage.x = _textX;
						_textImage.y = _textY;
					}
					break;
				case MOUSE_UP:
					state.toMouseUp();
					if (_textImage) {
						_textImage.x = _textX;
						_textImage.y = _textY;
					}
					break;
				case MOUSE_OVER:
					state.toMouseOver();
					if (_textImage) {
						_textImage.x = _textX;
						_textImage.y = _textY;
					}
					break;
				case MOUSE_DOWN:
					state.toMouseDown();
					if (_textImage) {
						_textImage.x = _textX + 1;
						_textImage.y = _textY + 1;
					}
					break;
			}
		}
		
		/**
		 * 按钮被点击后调用该方法
		 * 该方法被JCheckBox等组件重写
		 * 用来实现选择状态的改变
		 * @private
		 */
		protected function changSelected():void {
			
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
			this.touchPointID = -1;
		}
		
		/**
		 * 触摸事件
		 * @param	e
		 */
		private function onTouch(e:TouchEvent):void {
			if (!this.enabled) return;
			
			const touches:Vector.<Touch> = e.getTouches(this);
			if(!touches.length) {
				//end of hover
				setCurState(NORMAL);
				return;
			}
			
			if(this.touchPointID >= 0) {
				var touch:Touch;
				for each(var currentTouch:Touch in touches) {
					if(currentTouch.id == this.touchPointID) {
						touch = currentTouch;
						break;
					}
				}
				if(!touch) {
					//end of hover
					setCurState(MOUSE_UP);
					return;
				}
				touch.getLocation(this, helpPoint);
				ScrollRectManager.adjustTouchLocation(helpPoint, this);
				var isInBounds:Boolean = this.hitTest(helpPoint, true) != null;
				if(touch.phase == TouchPhase.MOVED) {
					setCurState(isInBounds ? MOUSE_DOWN : NORMAL);
				}else if (touch.phase == TouchPhase.ENDED) { 
					this.touchPointID = -1;
					if(isInBounds) {
						if(this.hoverSupported) {
							touch.getLocation(this, helpPoint);
							this.localToGlobal(helpPoint, helpPoint);
							setCurState(this.stage.hitTest(helpPoint, true) == this ? MOUSE_OVER : MOUSE_UP);
						}else { 
							setCurState(MOUSE_UP);
						}
						doClick();
						changSelected();
					}else { 
						setCurState(NORMAL);
						hoverSupported = false;
					}
				}
			}else {//if we get here, we don't have a saved touch ID yet
				for each(touch in touches) {
					if(touch.phase == TouchPhase.BEGAN) {
						setCurState(MOUSE_DOWN);
						this.touchPointID = touch.id;
						return;
					}else if (touch.phase == TouchPhase.HOVER) { 
						setCurState(MOUSE_OVER);
						this.hoverSupported = true;
						return;
					}
				}
			}
		}
	}

}