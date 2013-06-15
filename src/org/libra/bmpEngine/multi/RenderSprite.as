package org.libra.bmpEngine.multi {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.libra.utils.MathUtil;
	
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
	public class RenderSprite {
		
		protected var $rect:Rectangle;
		
		protected var $x:int;
		
		protected var $y:int;
		
		protected var $scaleX:Number;
		
		protected var $scaleY:Number;
		
		protected var $visible:Boolean;
		
		protected var $bitmapData:BitmapData;
		
		protected var $updated:Boolean;
		
		public function RenderSprite(bitmapData:BitmapData = null) {
			$bitmapData = bitmapData;
			$rect = $bitmapData ? $bitmapData.rect : null;
			$visible = true;
			$scaleX = $scaleY = 1;
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
				$updated = true;
			}
		}
		
		public function get y():int {
			return $y;
		}
		
		public function set y(val:int):void {
			if ($y != val) {
				$y = val;
				$updated = true;
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
			$rect = $bitmapData ? $bitmapData.rect : null;
			$updated = true;
		}
		
		public function get updated():Boolean {
			return $updated;
		}
		
		public function set updated(value:Boolean):void {
			$updated = value;
		}
		
		public function get width():int {
			return $rect ? $rect.width : 0;
		}
		
		public function get height():int {
			return $rect ? $rect.height : 0;
		}
		
		public function get visible():Boolean {
			return $visible;
		}
		
		public function set visible(value:Boolean):void {
			if ($visible != value) {
				$visible = value;
				$updated = true;
			}
		}
		
		public function get rect():Rectangle {
			return $rect;
		}
		
		public function dispose():void {
			if ($bitmapData) $bitmapData.dispose();
			$bitmapData = null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function scale():void {
			const matrix:Matrix = new Matrix();
			matrix.scale(this.$scaleX, this.$scaleY);
			
			const scaledBitmapData:BitmapData = new BitmapData(width * MathUtil.abs($scaleX), height * MathUtil.abs($scaleY), true, 0x0);
			scaledBitmapData.draw($bitmapData, matrix);
			bitmapData = scaledBitmapData.clone();
			scaledBitmapData.dispose();
			$updated = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}