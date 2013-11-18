package org.libra.ui.flash.components {
	import org.libra.ui.flash.core.Component;
	
	/**
	 * <p>
	 * 
	 * </p>
	 *
	 * @class JRichLabel
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-11-2012
	 * @version 1.0
	 * @see
	 */
	public class JRichLabel extends Component {
		
		protected var _maxNum:int;
		
		private var _strList:Vector.<String>;
		
		public function JRichLabel() {
			super();
			_strList = new Vector.<String>();
			_maxNum = 20;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Getters and setter
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		//override protected function initTextField(text:String = ''):void {
			//super.initTextField(text);
			//_textField.wordWrap = true;
		//}
		
		//override protected function refreshText():void {
			//super.refreshText();
		//}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}