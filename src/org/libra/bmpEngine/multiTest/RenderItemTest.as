package org.libra.bmpEngine.multiTest {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class RenderItemTest
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 04/01/2013
	 * @version 1.0
	 * @see
	 */
	public class RenderItemTest {
		
		protected var $rect:Rectangle;
		
		protected var $x:int;
		
		protected var $y:int;
		
		protected var $width:int;
		
		protected var $height:int
		
		protected var $scaleX:Number;
		
		protected var $scaleY:Number;
		
		protected var $visible:Boolean;
		
		protected var $bitmapData:BitmapData;
		
		protected var $rebuild:Boolean;
		
		public function RenderItemTest(bitmapData:BitmapData) {
			$bitmapData = bitmapData;
			$rect = $bitmapData.rect;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get x():int {
			return $x;
		}
		
		public function set x(val:int):void {
			if ($x != val) {
				$x = val;
				$rebuild = true;
			}
		}
		
		public function get y():int {
			return $y;
		}
		
		public function set y(val:int):void {
			if ($y != val) {
				$y = val;
				$rebuild = true;
			}
		}
		
		public function get scaleX():Number {
			return $scaleX;
		}
		
		public function set scaleX(value:Number):void {
			if ($scaleX != value) {
				$scaleX = value;
				scale();
			}
		}
		
		public function get scaleY():Number {
			return $scaleY;
		}
		
		public function set scaleY(value:Number):void {
			if ($scaleY != value) {
				$scaleY = value;
				scale();
			}
		}
		
		public function get bitmapData():BitmapData {
			return $bitmapData;
		}
		
		public function set bitmapData(value:BitmapData):void {
			$bitmapData = value;
			$rebuild = true;
		}
		
		public function get rebuild():Boolean {
			return $rebuild;
		}
		
		public function set rebuild(value:Boolean):void {
			$rebuild = value;
		}
		
		public function get width():int {
			return $width;
		}
		
		public function get height():int {
			return $height;
		}
		
		public function get visible():Boolean {
			return $visible;
		}
		
		public function set visible(value:Boolean):void {
			$visible = value;
		}
		
		public function get rect():Rectangle {
			return $rect;
		}
		
		public function dispose():Boolean {
			if ($bitmapData) $bitmapData.dispose();
			$bitmapData = null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function scale():void {
			const matrix:Matrix = new Matrix();
			matrix.scale(this.$scaleX, this.$scaleY);
			
			const scaledBitmapData:BitmapData = new BitmapData($width * $scaleX, $height * $scaleY, true, 0x0);
			scaledBitmapData.draw($bitmapData, matrix);
			bitmapData = scaledBitmapData.clone();
			scaledBitmapData.dispose();
			$rebuild = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}