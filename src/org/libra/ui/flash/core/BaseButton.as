package org.libra.ui.flash.core {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.base.stateus.BaseButtonStatus;
	import org.libra.ui.base.stateus.interfaces.IButtonStatus;
	import org.libra.ui.utils.JFont;
	
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
		
		protected var curStatus:int;
		
		protected var resName:String;
		
		protected var status:IButtonStatus;
		
		protected var textX:int;
		
		protected var textY:int;
		
		public function BaseButton(x:int = 0, y:int = 0, text:String = '',  resName:String = 'btn') { 
			curStatus = NORMAL;
			this.resName = resName;
			this.initStatus();
			super(x, y, text);
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
		
		protected function initStatus():void {
			this.status = new BaseButtonStatus();
			this.status.setResName(resName);
			this.addChild(this.status.getDisplayObject());
		}
		
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			setFont(JFont.FONT_BTN);
			this.textAlign = 'center';
			this.text = text;
		}
		
		override protected function render():void {
			super.render();
			this.status.setSize($width, $height);
			if (this.curStatus == MOUSE_OVER) this.status.toMouseOver();
			else if (this.curStatus == MOUSE_DOWN) this.status.toMouseDown();
			else this.status.toNormal();
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
			if (enabled) {
				if (e.type == MouseEvent.MOUSE_DOWN) {
					this.curStatus = MOUSE_DOWN;
					this.status.toMouseDown();
					this.textField.x = textX + 1;
					this.textField.y = textY + 1;
				}else {
					curStatus = MOUSE_OVER;
					this.status.toMouseOver();
					this.textField.x = textX;
					this.textField.y = textY;
				}
			}
		}
		
		private function onRollOverAndOut(e:MouseEvent):void {
			if (enabled) {
				if (e.type == MouseEvent.ROLL_OVER) {
					curStatus = MOUSE_OVER;
					this.status.toMouseOver();
				}else {
					curStatus = NORMAL;
					this.status.toNormal();
					this.textField.x = textX;
					this.textField.y = textY;
				}
			}
		}
	}

}