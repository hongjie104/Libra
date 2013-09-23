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
		
		protected var $barSkin:String;
		
		protected var $barBgSkin:String;
		
		protected var $barScale9Rect:Rectangle;
		
		protected var $barBgScale9Rect:Rectangle;
		
		protected var $barX:int;
		
		protected var $barY:int;
		
		protected var $barWidth:int;
		
		protected var $width:int;
		
		protected var $height:int;
		
		public function ProgressBarSkin(barskin:String, barScale9Rect:Rectangle, barBgskin:String, barBgScale9Rect:Rectangle, barX:int = 29, barY:int = 1, barWidth:int = 142, width:int = 200, height:int = 18) { 
			this.$barSkin = barskin;
			this.$barScale9Rect = barScale9Rect;
			this.$barBgSkin = barBgskin;
			this.$barBgScale9Rect = barBgScale9Rect;
			$barX = barX;
			$barY = barY;
			$barWidth = barWidth;
			$width = width;
			$height = height;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get barSkin():String {
			return $barSkin;
		}
		
		public function get barScale9Rect():Rectangle {
			return $barScale9Rect;
		}
		
		public function get barBgSkin():String {
			return $barBgSkin;
		}
		
		public function get barBgScale9Rect():Rectangle {
			return $barBgScale9Rect;
		}
		
		public function get width():int {
			return $width;
		}
		
		public function get height():int {
			return $height;
		}
		
		public function get barX():int {
			return $barX;
		}
		
		public function get barY():int {
			return $barY;
		}
		
		public function get barWidth():int {
			return $barWidth;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}