package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.BaseText;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.theme.JFont;
	import org.libra.ui.flash.theme.Skin;
	import org.libra.ui.invalidation.InvalidationFlag;
	
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
		
		private var _scrollBar:JScrollBar;
		
		private var _scrollBarAutoHide:Boolean;
		
		public function JTextArea(x:int = 0, y:int = 0, text:String = '', font:JFont = null, filters:Array = null) { 
			super(x, y, text, font ? font : JFont.FONT_LABEL, filters);
			_scrollBarAutoHide = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			_textField.wordWrap = _textField.multiline = true;
			this.setFont(JFont.FONT_INPUT);
			this.text = text;
			_textField.selectable = _textField.mouseEnabled = true;
			this._textField.type = TextFieldType.INPUT;
			_textField.background = true;
			_textField.backgroundColor = Skin.BACKGROUND;
		}
		
		/**
		 * Changes the thumb percent of the scrollbar based on how much text is shown in the text area.
		 */
		protected function updateScrollBar():void {
			var visibleLines:int = _textField.numLines - _textField.maxScrollV + 1;
			var percent:Number = visibleLines / _textField.numLines;
			_scrollBar.setSliderParams(1, _textField.maxScrollV, _textField.scrollV);
			_scrollBar.thumbPercent = percent;
			_scrollBar.pageSize = visibleLines;
		}
		
		public function set autoHideScrollBar(value:Boolean):void {
		   if (_scrollBarAutoHide != value) {
			   this._scrollBarAutoHide = value;
			   invalidate(InvalidationFlag.STATE);
		   }
        }
		
		/**
		 * @inheritDoc
		 */
		override public function clone():Component {
			return new JTextArea(x, y, _text, _font, _filters);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			
			_scrollBar = new JScrollBar(Constants.VERTICAL);
			_scrollBar.autoHide = _scrollBarAutoHide;
			this.addChild(_scrollBar);
		}
		
		override protected function resize():void {
			_textField.width = _actualWidth - _scrollBar.width - 4;
			_scrollBar.x = _actualWidth - _scrollBar.width;
			_scrollBar.height = _actualHeight;
			updateScrollBar();
		}
		
		override protected function refreshState():void {
			_scrollBar.autoHide = this._scrollBarAutoHide;
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			this._scrollBar.addEventListener(Event.CHANGE, onScrollBarScroll);
			_textField.addEventListener(Event.SCROLL, onTextScroll);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			this._scrollBar.removeEventListener(Event.CHANGE, onScrollBarScroll);
			_textField.removeEventListener(Event.SCROLL, onTextScroll);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		//override protected function onTextChanged(e:Event):void {
			//super.onTextChanged(e);
			//this.updateScrollBar();
		//}
		
		private function onScrollBarScroll(e:Event):void {
			_textField.scrollV = Math.round(_scrollBar.value);
		}
		
		private function onTextScroll(e:Event):void {
			updateScrollBar();
		}
		
		private function onMouseWheel(e:MouseEvent):void {
			_scrollBar.changeValue(0 - e.delta);
			_textField.scrollV = Math.round(_scrollBar.value);
		}
		
	}

}