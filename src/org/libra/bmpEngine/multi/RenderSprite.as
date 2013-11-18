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
		
		protected var _rect:Rectangle;
		
		protected var _x:int;
		
		protected var _y:int;
		
		protected var _scaleX:Number;
		
		protected var _scaleY:Number;
		
		protected var _visible:Boolean;
		
		protected var _bitmapData:BitmapData;
		
		protected var _updated:Boolean;
		
		public function RenderSprite(bitmapData:BitmapData = null) {
			_bitmapData = bitmapData;
			_rect = _bitmapData ? _bitmapData.rect : null;
			_visible = true;
			_scaleX = _scaleY = 1;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get x():int {
			return _x;
		}
		
		public function set x(val:int):void {
			if (_x != val) {
				_x = val;
				_updated = true;
			}
		}
		
		public function get y():int {
			return _y;
		}
		
		public function set y(val:int):void {
			if (_y != val) {
				_y = val;
				_updated = true;
			}
		}
		
		public function get scaleX():Number {
			return _scaleX;
		}
		
		public function set scaleX(value:Number):void {
			if (_scaleX != value) {
				_scaleX = value;
				scale();
			}
		}
		
		public function get scaleY():Number {
			return _scaleY;
		}
		
		public function set scaleY(value:Number):void {
			if (_scaleY != value) {
				_scaleY = value;
				scale();
			}
		}
		
		public function get bitmapData():BitmapData {
			return _bitmapData;
		}
		
		public function set bitmapData(value:BitmapData):void {
			_bitmapData = value;
			_rect = _bitmapData ? _bitmapData.rect : null;
			_updated = true;
		}
		
		public function get updated():Boolean {
			return _updated;
		}
		
		public function set updated(value:Boolean):void {
			_updated = value;
		}
		
		public function get width():int {
			return _rect ? _rect.width : 0;
		}
		
		public function get height():int {
			return _rect ? _rect.height : 0;
		}
		
		public function get visible():Boolean {
			return _visible;
		}
		
		public function set visible(value:Boolean):void {
			if (_visible != value) {
				_visible = value;
				_updated = true;
			}
		}
		
		public function get rect():Rectangle {
			return _rect;
		}
		
		public function dispose():void {
			if (_bitmapData) _bitmapData.dispose();
			_bitmapData = null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function scale():void {
			const matrix:Matrix = new Matrix();
			matrix.scale(this._scaleX, this._scaleY);
			
			const scaledBitmapData:BitmapData = new BitmapData(width * MathUtil.abs(_scaleX), height * MathUtil.abs(_scaleY), true, 0x0);
			scaledBitmapData.draw(_bitmapData, matrix);
			bitmapData = scaledBitmapData.clone();
			scaledBitmapData.dispose();
			_updated = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}