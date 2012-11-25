package org.libra.ui.starling.component {
	import org.libra.ui.starling.core.BaseText;
	
	/**
	 * <p>
	 * 标签
	 * </p>
	 *
	 * @class JLabel
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/28/2012
	 * @version 1.0
	 * @see
	 */
	public class JLabel extends BaseText {
		
		/**
		 * 构造函数
		 * @private
		 * @param	widht
		 * @param	height
		 * @param	x
		 * @param	y
		 * @param	text
		 */
		public function JLabel(widht:int, height:int, x:int = 0, y:int = 0, text:String = '') { 
			super(widht, height, x, y, text);
			this.touchable = false;
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