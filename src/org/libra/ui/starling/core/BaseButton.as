package org.libra.ui.starling.core {
	import flash.geom.Point;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.ui.starling.core.state.BaseButtonState;
	import org.libra.ui.starling.core.state.IButtonState;
	import org.libra.ui.starling.managers.ScrollRectManager;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * <p>
	 * Description
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
		
		private static const NORMAL:int = 0;
		
		private static const MOUSE_UP:int = 1;
		
		private static const MOUSE_DOWN:int = 2;
		
		private static const MOUSE_OVER:int = 3;
		
		private static var helpPoint:Point = new Point();
		
		protected var state:IButtonState;
		
		protected var curState:int;
		
		/**
		 * '0' 代表鼠标事件, 正数用于touch事件。
		 */
		protected var touchPointID:int = -1;
		
		private var hoverSupported:Boolean;
		
		public function BaseButton(x:int, y:int, widht:int, height:int, text:String = '') { 
			super(x, y, widht, height, text);
			this.textAlign = 'center';
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function setEnabled(val:Boolean):void {
			if(!val) this.touchPointID = -1;
			super.setEnabled(val);
		}
		
		public function doClick():void {
			this.dispatchEventWith(Event.TRIGGERED);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function init():void {
			super.init();
			state = new BaseButtonState();
			this.setBackground(state.getDisplayObject());
		}
		
		override protected function resize():void {
			super.resize();
			this.state.setSize(actualWidth, actualHeight);
		}
		
		protected function setCurState(val:int):void {
			this.curState = val;
			this.invalidate(InvalidationFlag.STATE);
		}
		
		override protected function refreshState():void {
			super.refreshState();
			switch(this.curState) {
				case NORMAL:
					state.toNormal();
					if (textImage) {
						textImage.x = textX;
						textImage.y = textY;
					}
					break;
				case MOUSE_UP:
					state.toMouseUp();
					if (textImage) {
						textImage.x = textX;
						textImage.y = textY;
					}
					break;
				case MOUSE_OVER:
					state.toMouseOver();
					break;
				case MOUSE_DOWN:
					state.toMouseDown();
					if (textImage) {
						textImage.x = textX + 1;
						textImage.y = textY + 1;
					}
					break;
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			if (e.target == this) {
				this.addEventListener(TouchEvent.TOUCH, onTouch);
			}
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.touchPointID = -1;
		}
		
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
						//if(this._isToggle)
						//{
							//this.isSelected = !this._isSelected;
						//}
					}else { 
						setCurState(NORMAL);
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