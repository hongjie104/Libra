package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.BaseText;
	import org.libra.ui.style.Style;
	import org.libra.ui.text.JFont;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JTextArea
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-03-2012
	 * @version 1.0
	 * @see
	 */
	public class JTextArea extends BaseText {
		
		private var scrollBar:JScrollBar;
		
		public function JTextArea(x:int = 0, y:int = 0, text:String = '') { 
			super(x, y, text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			textField.wordWrap = textField.multiline = true;
			this.setFont(JFont.FONT_INPUT);
			this.text = text;
			textField.selectable = textField.mouseEnabled = true;
			this.textField.type = TextFieldType.INPUT;
			textField.background = true;
			textField.backgroundColor = Style.BACKGROUND;
		}
		
		/**
		 * Changes the thumb percent of the scrollbar based on how much text is shown in the text area.
		 */
		protected function updateScrollBar():void {
			var visibleLines:int = textField.numLines - textField.maxScrollV + 1;
			var percent:Number = visibleLines / textField.numLines;
			scrollBar.setSliderParams(1, textField.maxScrollV, textField.scrollV);
			scrollBar.setThumbPercent(percent);
			scrollBar.setPageSize(visibleLines);
		}
		
		public function setAutoHideScrollBar(value:Boolean):void {
            scrollBar.setAutoHide(value);
        }
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			
			scrollBar = new JScrollBar(Constants.VERTICAL);
			scrollBar.setAutoHide(true);
			this.addChild(scrollBar);
		}
		
		override protected function resize():void {
			textField.width = actualWidth - scrollBar.width - 4;
			scrollBar.x = actualWidth - scrollBar.width;
			scrollBar.height = actualHeight;
			updateScrollBar();
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			this.scrollBar.addEventListener(Event.CHANGE, onScrollBarScroll);
			textField.addEventListener(Event.SCROLL, onTextScroll);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			this.scrollBar.removeEventListener(Event.CHANGE, onScrollBarScroll);
			textField.removeEventListener(Event.SCROLL, onTextScroll);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		//override protected function onTextChanged(e:Event):void {
			//super.onTextChanged(e);
			//this.updateScrollBar();
		//}
		
		private function onScrollBarScroll(e:Event):void {
			textField.scrollV = Math.round(scrollBar.getValue());
		}
		
		private function onTextScroll(e:Event):void {
			updateScrollBar();
		}
		
		private function onMouseWheel(e:MouseEvent):void {
			scrollBar.changeValue(0 - e.delta);
			textField.scrollV = Math.round(scrollBar.getValue());
		}
		
	}

}