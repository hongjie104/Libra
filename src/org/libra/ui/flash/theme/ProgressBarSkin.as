package org.libra.ui.flash.theme {
	import flash.geom.Rectangle;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ProgressBarSkin
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class ProgressBarSkin {
		
		protected var _barSkin:String;
		
		protected var _barBgSkin:String;
		
		protected var _barScale9Rect:Rectangle;
		
		protected var _barBgScale9Rect:Rectangle;
		
		protected var _barX:int;
		
		protected var _barY:int;
		
		protected var _barWidth:int;
		
		protected var _width:int;
		
		protected var _height:int;
		
		public function ProgressBarSkin(barskin:String, barScale9Rect:Rectangle, barBgskin:String, barBgScale9Rect:Rectangle, barX:int = 29, barY:int = 1, barWidth:int = 142, width:int = 200, height:int = 18) { 
			this._barSkin = barskin;
			this._barScale9Rect = barScale9Rect;
			this._barBgSkin = barBgskin;
			this._barBgScale9Rect = barBgScale9Rect;
			_barX = barX;
			_barY = barY;
			_barWidth = barWidth;
			_width = width;
			_height = height;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get barSkin():String {
			return _barSkin;
		}
		
		public function get barScale9Rect():Rectangle {
			return _barScale9Rect;
		}
		
		public function get barBgSkin():String {
			return _barBgSkin;
		}
		
		public function get barBgScale9Rect():Rectangle {
			return _barBgScale9Rect;
		}
		
		public function get width():int {
			return _width;
		}
		
		public function get height():int {
			return _height;
		}
		
		public function get barX():int {
			return _barX;
		}
		
		public function get barY():int {
			return _barY;
		}
		
		public function get barWidth():int {
			return _barWidth;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}