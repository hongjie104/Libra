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
		
		protected var $hScrollThumb:String;
		
		protected var $vScrollThumb:String;
		
		protected var $hScrollBtnBg:String;
		
		protected var $vScrollBtnBg:String;
		
		private var $hScrollBtnScale9Rect:Rectangle;
		
		private var $vScrollBtnScale9Rect:Rectangle;
		
		public function ScrollBlockSkin(vScrollThumb:String, vScrollBtnBg:String, vScrollBtnScale9Rect:Rectangle, hScrollThumb:String = '', hScrollBtnBg:String = '', hScrollBtnScale9Rect:Rectangle = null) { 
			this.$vScrollBtnBg = vScrollBtnBg;
			this.$vScrollThumb = vScrollThumb;
			this.$vScrollBtnScale9Rect = vScrollBtnScale9Rect;
			this.$hScrollBtnBg = hScrollBtnBg;
			this.$hScrollThumb = hScrollThumb;
			this.$hScrollBtnScale9Rect = hScrollBtnScale9Rect;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get vScrollBtnBg():String {
			return $vScrollBtnBg;
		}
		
		public function get vScrollThumb():String {
			return $vScrollThumb;
		}
		
		public function get vScrollBtnScale9Rect():Rectangle {
			return $vScrollBtnScale9Rect;
		}
		
		public function get hScrollThumb():String {
			return $hScrollThumb;
		}
		
		public function get hScrollBtnBg():String {
			return $hScrollBtnBg;
		}
		
		public function get hScrollBtnScale9Rect():Rectangle {
			return $hScrollBtnScale9Rect;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}