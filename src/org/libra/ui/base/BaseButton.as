package org.libra.ui.base {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.base.states.BaseButtonState;
	import org.libra.ui.base.states.IState;
	
	/**
	 * <p>
	 * 按钮父类
	 * </p>
	 *
	 * @class BaseButton
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class BaseButton extends BaseText {
		
		protected var resName:String;
		
		protected var state:IState;
		
		protected var textX:int;
		
		protected var textY:int;
		
		public function BaseButton(resName:String, text:String = '', x:Number = 0, y:Number = 0) {
			this.resName = resName;
			this.initState();
			super(text, x, y);
			this.setSize(58, 32);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function doClick():void {
			dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		override public function toString():String {
			return 'BaseButton';
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function initState():void {
			this.state = new BaseButtonState();
			this.state.setResName(resName);
			this.addChild(this.state.getDisplayObject());
		}
		
		override protected function render():void {
			super.render();
			this.state.setSize($width, $height);
			this.state.toNormal();
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.addEventListener(MouseEvent.ROLL_OUT, onRollOverAndOut);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollOverAndOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseUpAndDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUpAndDown);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(MouseEvent.ROLL_OUT, onRollOverAndOut);
			this.removeEventListener(MouseEvent.ROLL_OVER, onRollOverAndOut);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseUpAndDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpAndDown);
		}
		
		override public function setTextLocation(x:int, y:int):void {
			super.setTextLocation(x, y);
			this.textX = x;
			this.textY = y;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onMouseUpAndDown(e:MouseEvent):void {
			if (enable) {
				if (e.type == MouseEvent.MOUSE_DOWN) {
					this.state.toMouseDown();
					this.textField.x = textX + 1;
					this.textField.y = textY + 1;
				}else {
					this.state.toMouseUp();
					this.textField.x = textX;
					this.textField.y = textY;
				}
			}
		}
		
		private function onRollOverAndOut(e:MouseEvent):void {
			if (enable) {
				if (e.type == MouseEvent.ROLL_OVER) {
					this.state.toMouseOver();
				}else {
					this.state.toNormal();
					this.textField.x = textX;
					this.textField.y = textY;
				}
			}
		}
	}

}