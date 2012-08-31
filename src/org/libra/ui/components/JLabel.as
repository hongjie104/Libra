package org.libra.ui.components {
	import org.libra.ui.base.BaseText;
	import org.libra.ui.style.Style;
	
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
		
		public function JLabel(text:String='', x:Number=0, y:Number=0) {
			super(text, x, y);
			this.mouseChildren = this.mouseEnabled = false;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}