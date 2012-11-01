package org.libra.ui.flash.core {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.flash.core.state.BaseButtonState;
	import org.libra.ui.flash.core.state.IButtonState;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.ui.text.JFont;
	
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
		
		protected static const NORMAL:int = 0;
		
		protected static const MOUSE_OVER:int = 1;
		
		protected static const MOUSE_DOWN:int = 2;
		
		protected var curState:int;
		
		protected var resName:String;
		
		protected var state:IButtonState;
		
		protected var textX:int;
		
		protected var textY:int;
		
		public function BaseButton(x:int = 0, y:int = 0, text:String = '',  resName:String = 'btn') { 
			curState = NORMAL;
			this.resName = resName;
			this.initState();
			super(x, y, text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function doClick():void {
			dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function initState():void {
			this.state = new BaseButtonState();
			this.state.setResName(resName);
			this.addChild(this.state.getDisplayObject());
		}
		
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			setFont(JFont.FONT_BTN);
			this.textAlign = 'center';
			this.text = text;
		}
		
		override protected function resize():void {
			this.state.setSize(actualWidth, actualHeight);
		}
		
		override protected function refreshState():void {
			if (this.curState == MOUSE_OVER) {
				this.state.toMouseOver();
				this.textField.x = textX;
				this.textField.y = textY;
			}else if (this.curState == MOUSE_DOWN) {
				this.state.toMouseDown();
				this.textField.x = textX + 1;
				this.textField.y = textY + 1;
			}else {
				this.state.toNormal();
				this.textField.x = textX;
				this.textField.y = textY;
			}
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
		
		protected function setCurState(state:int):void {
			if (curState != state) {
				this.curState = state;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onMouseUpAndDown(e:MouseEvent):void {
			if (enabled) {
				setCurState(e.type == MouseEvent.MOUSE_DOWN ? MOUSE_DOWN : MOUSE_OVER);
			}
		}
		
		private function onRollOverAndOut(e:MouseEvent):void {
			if (enabled) {
				setCurState(e.type == MouseEvent.ROLL_OVER ? MOUSE_OVER : NORMAL);
			}
		}
	}

}