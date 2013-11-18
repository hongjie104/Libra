package org.libra.ui.flash.theme {
	import flash.geom.Rectangle;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class DefaultScrollBlockTheme
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class ScrollBlockSkin {
		
		protected var _hScrollThumb:String;
		
		protected var _vScrollThumb:String;
		
		protected var _hScrollBtnBg:String;
		
		protected var _vScrollBtnBg:String;
		
		private var _hScrollBtnScale9Rect:Rectangle;
		
		private var _vScrollBtnScale9Rect:Rectangle;
		
		public function ScrollBlockSkin(vScrollThumb:String, vScrollBtnBg:String, vScrollBtnScale9Rect:Rectangle, hScrollThumb:String = '', hScrollBtnBg:String = '', hScrollBtnScale9Rect:Rectangle = null) { 
			this._vScrollBtnBg = vScrollBtnBg;
			this._vScrollThumb = vScrollThumb;
			this._vScrollBtnScale9Rect = vScrollBtnScale9Rect;
			this._hScrollBtnBg = hScrollBtnBg;
			this._hScrollThumb = hScrollThumb;
			this._hScrollBtnScale9Rect = hScrollBtnScale9Rect;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get vScrollBtnBg():String {
			return _vScrollBtnBg;
		}
		
		public function get vScrollThumb():String {
			return _vScrollThumb;
		}
		
		public function get vScrollBtnScale9Rect():Rectangle {
			return _vScrollBtnScale9Rect;
		}
		
		public function get hScrollThumb():String {
			return _hScrollThumb;
		}
		
		public function get hScrollBtnBg():String {
			return _hScrollBtnBg;
		}
		
		public function get hScrollBtnScale9Rect():Rectangle {
			return _hScrollBtnScale9Rect;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}