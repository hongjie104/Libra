package org.libra.ui.flash.components {
	import org.libra.ui.base.BaseText;
	import org.libra.ui.utils.JFont;
	
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
		
		public function JLabel(x:int = 0, y:int = 0, text:String = '') { 
			super(x, y, text);
			this.mouseChildren = this.mouseEnabled = false;
			this.setSize(60,20);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function toString():String {
			return 'JLabel';
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			this.textAlign = 'left';
			this.text = text;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}