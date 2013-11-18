package org.libra.ui.flash.components {
	import org.libra.ui.flash.core.BaseText;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.JFont;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JLabel
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class JLabel extends BaseText {
		
		public function JLabel(x:int = 0, y:int = 0, text:String = null, font:JFont = null, filters:Array = null) { 
			super(x, y, text, font ? font : JFont.FONT_LABEL.clone(), filters);
			this.mouseChildren = this.mouseEnabled = false;
			setSize(100, 20);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			this.textAlign = 'left';
			this.text = text;
		}
		
		override public function clone():Component {
			return new JLabel(x, y, _text, _font, _filters);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}