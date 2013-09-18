package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.BaseText;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.DefaultTextTheme;
	import org.libra.ui.flash.theme.DefaultTheme;
	import org.libra.ui.flash.theme.JFont;
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
		
		private var $scrollBar:JScrollBar;
		
		private var $scrollBarAutoHide:Boolean;
		
		public function JTextArea(theme:DefaultTextTheme = null, x:int = 0, y:int = 0, text:String = '') { 
			super(theme ? theme : UIManager.getInstance().theme.textAreaTheme, x, y, text);
			$scrollBarAutoHide = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			$textField.wordWrap = $textField.multiline = true;
			this.setFont(JFont.FONT_INPUT);
			this.text = text;
			$textField.selectable = $textField.mouseEnabled = true;
			this.$textField.type = TextFieldType.INPUT;
			$textField.background = true;
			$textField.backgroundColor = DefaultTheme.BACKGROUND;
		}
		
		/**
		 * Changes the thumb percent of the scrollbar based on how much text is shown in the text area.
		 */
		protected function updateScrollBar():void {
			var visibleLines:int = $textField.numLines - $textField.maxScrollV + 1;
			var percent:Number = visibleLines / $textField.numLines;
			$scrollBar.setSliderParams(1, $textField.maxScrollV, $textField.scrollV);
			$scrollBar.thumbPercent = percent;
			$scrollBar.pageSize = visibleLines;
		}
		
		public function set autoHideScrollBar(value:Boolean):void {
		   if ($scrollBarAutoHide != value) {
			   this.$scrollBarAutoHide = value;
			   invalidate(InvalidationFlag.STATE);
		   }
        }
		
		/**
		 * @inheritDoc
		 */
		override public function clone():Component {
			return new JTextArea($theme, x, y, $text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			
			$scrollBar = new JScrollBar(Constants.VERTICAL);
			$scrollBar.autoHide = $scrollBarAutoHide;
			this.addChild($scrollBar);
		}
		
		override protected function resize():void {
			$textField.width = $actualWidth - $scrollBar.width - 4;
			$scrollBar.x = $actualWidth - $scrollBar.width;
			$scrollBar.height = $actualHeight;
			updateScrollBar();
		}
		
		override protected function refreshState():void {
			$scrollBar.autoHide = this.$scrollBarAutoHide;
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			this.$scrollBar.addEventListener(Event.CHANGE, onScrollBarScroll);
			$textField.addEventListener(Event.SCROLL, onTextScroll);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			this.$scrollBar.removeEventListener(Event.CHANGE, onScrollBarScroll);
			$textField.removeEventListener(Event.SCROLL, onTextScroll);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		//override protected function onTextChanged(e:Event):void {
			//super.onTextChanged(e);
			//this.updateScrollBar();
		//}
		
		private function onScrollBarScroll(e:Event):void {
			$textField.scrollV = Math.round($scrollBar.value);
		}
		
		private function onTextScroll(e:Event):void {
			updateScrollBar();
		}
		
		private function onMouseWheel(e:MouseEvent):void {
			$scrollBar.changeValue(0 - e.delta);
			$textField.scrollV = Math.round($scrollBar.value);
		}
		
	}

}