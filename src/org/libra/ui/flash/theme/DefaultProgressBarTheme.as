package org.libra.ui.flash.theme {
	import flash.geom.Rectangle;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class DafaultProgressBarTheme
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class DefaultProgressBarTheme {
		
		protected var $barResName:String;
		
		protected var $barBgResName:String;
		
		protected var $barScale9Rect:Rectangle;
		
		protected var $barBgScale9Rect:Rectangle;
		
		protected var $barX:int;
		
		protected var $barY:int;
		
		protected var $barWidth:int;
		
		protected var $width:int;
		
		protected var $height:int;
		
		public function DefaultProgressBarTheme(barResName:String, barScale9Rect:Rectangle, barBgResName:String, barBgScale9Rect:Rectangle, barX:int = 29, barY:int = 1, barWidth:int = 142, w:int = 200, h:int = 18) { 
			this.$barResName = barResName;
			this.$barScale9Rect = barScale9Rect;
			this.$barBgResName = barBgResName;
			this.$barBgScale9Rect = barBgScale9Rect;
			$barX = barX;
			$barY = barY;
			$barWidth = barWidth;
			$width = w;
			$height = h;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get barResName():String {
			return $barResName;
		}
		
		public function get barScale9Rect():Rectangle {
			return $barScale9Rect;
		}
		
		public function get barBgResName():String {
			return $barBgResName;
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