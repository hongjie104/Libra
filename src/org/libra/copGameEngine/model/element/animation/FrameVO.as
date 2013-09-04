package org.libra.copGameEngine.model.element.animation {
	import flash.geom.Point;
	/**
	 * <p>
	 * 一帧中某个部位的信息
	 * </p>
	 *
	 * @class FrameInfo
	 * @author Eddie
	 * @qq 32968210
	 * @date 04/30/2013
	 * @version 1.0
	 * @see
	 */
	public final class FrameVO {
		
		private var $x:int;
		
		private var $y:int;
		
		private var $frame:int;
		
		public function FrameVO(x:int, y:int, frame:int) { 
			$x = x;
			$y = y;
			$frame = frame;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function frame():int {
			return this.$frame;
		}
		
		public function get x():int {
			return $x;
		}
		
		public function get y():int {
			return $y;
		}
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}