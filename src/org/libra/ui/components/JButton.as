package org.libra.ui.components {
	import org.libra.ui.base.BaseButton;
	
	/**
	 * <p>
	 * 按钮类
	 * </p>
	 *
	 * @class JButton
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class JButton extends BaseButton {
		
		public function JButton(x:int = 0, y:int = 0, text:String = '', resName:String = 'btn') { 
			super(x, y, text, resName);
			this.setSize(43, 26);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			setTextLocation(0, h - 21);
		}
		
		override public function toString():String {
			return 'JButton';
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}