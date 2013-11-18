package org.libra.ui.flash.theme {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BtnSkin
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class BtnSkin {
		
		protected var _skin:String;
		
		protected var _width:int;
		
		protected var _height:int;
		
		public function BtnSkin(w:int, h:int, skin:String) { 
			_width = w;
			_height = h;
			_skin = skin;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get skin():String {
			return _skin;
		}
		
		public function get width():int {
			return _width;
		}
		
		public function get height():int {
			return _height;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}