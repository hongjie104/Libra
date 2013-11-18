package org.libra.ui.flash.theme {
	import flash.geom.Rectangle;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ContainerSkin
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class ContainerSkin {
		
		protected var _skin:String;
		
		protected var _scale9Rect:Rectangle;
		
		public function ContainerSkin(skin:String, scale9Rect:Rectangle) { 
			this._skin = skin;
			this._scale9Rect = scale9Rect;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get skin():String {
			return _skin;
		}
		
		public function get scale9Rect():Rectangle {
			return _scale9Rect;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}