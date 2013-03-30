package org.libra.utils.displayObject {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class DisplayObjectUtil
	 * @author Eddie
	 * @qq 32968210
	 * @date 12-20-2011
	 * @version 1.0
	 * @see
	 */
	public final class DisplayObjectUtil {
		
		private static var grayFilters:Array;
		
		public function DisplayObjectUtil(){
		
		}
		
		/**
		 * 让可视对象变成灰色
		 * @param	child
		 */
		public static function applyGray(displayObject:DisplayObject):void {
			if (!grayFilters) {
				var matrix:Array = [];
				matrix = matrix.concat([0.3086, 0.6094, 0.082, 0, 0]);
				matrix = matrix.concat([0.3086, 0.6094, 0.082, 0, 0]);
				matrix = matrix.concat([0.3086, 0.6094, 0.082, 0, 0]);
				matrix = matrix.concat([0, 0, 0, 1, 0]);
				grayFilters = [new ColorMatrixFilter(matrix)];
			}
			
			displayObject.filters = grayFilters;
		}
		
		public static function applyCommon(child:DisplayObject):void {
			child.filters = [];
		}
		
		/**
		 * 向右旋转90度
		 * @param	bmpData
		 * @return
		 */
		public static function rotateRight(bmpData:BitmapData):BitmapData {
			var mc:Matrix = new Matrix();
			mc.rotate(Math.PI / 2);
			mc.translate(bmpData.height, 0);
			var bmpData:BitmapData = new BitmapData(bmpData.height, bmpData.width, true, 0);
			bmpData.draw(bmpData, mc);
			return bmpData;
		}
		
		/**
		 * 向左旋转90度
		 * @param	bmpData
		 * @return
		 */
		public static function rotateLeft(bmpData:BitmapData):BitmapData {
			var mc:Matrix = new Matrix();
			mc.rotate(-Math.PI / 2);
			mc.translate(0, bmpData.width);
			var bmpData:BitmapData = new BitmapData(bmpData.height, bmpData.width, true, 0);
			bmpData.draw(bmpData, mc);
			return bmpData;
		}
		
		/**
		 * 水平翻转
		 * @param	dsp
		 */
		public static function flipHorizontal(dsp:DisplayObject):void {
			var mc:Matrix = dsp.transform.matrix;
			mc.a = -1;
			//mc.tx = dsp.width + dsp.x;
			dsp.transform.matrix = mc;
		}
		
		/**
		 * 垂直翻转
		 * @param	dsp
		 */
		public static function flipVertical(dsp:DisplayObject):void {
			var mc:Matrix = dsp.transform.matrix;
			mc.d = -1;
			//mc.ty = dsp.height + dsp.y;
			dsp.transform.matrix = mc;
		}
		
		//private static var _shake_init_x:Number;
		//private static var _shake_init_y:Number;
		//private static var _target:DisplayObject;
		//private static var _maxDis:Number;
		//private static var _count:int = 0;
		//private static var _rate:Number;
		//
		///**
		 //* 震动显示对象
		 //* @param        target                震动目标对象
		 //* @param        time                        震动持续时长（秒）
		 //* @param        rate                        震动频率(一秒震动多少次)
		 //* @param        maxDis        震动最大距离
		 //*/
		//public static function shakeObj(target:DisplayObject, time:Number, rate:Number, maxDis:Number):void {
			//_target = target;
			//_shake_init_x = target.x;
			//_shake_init_y = target.y;
			//_maxDis = maxDis;
			//_count = time * rate;
			//_rate = rate;
			//
			//var timer:Timer = new Timer(1000 / rate, _count);
			//timer.addEventListener(TimerEvent.TIMER, shaking);
			//timer.addEventListener(TimerEvent.TIMER_COMPLETE, shakeComplete);
			//timer.start();
		//}
		//
		//static private function shaking(e:TimerEvent):void {
			//TweenLite.killTweensOf(_target);
			//_target.x = _shake_init_x + Math.random() * _maxDis;
			//_target.y = _shake_init_y + Math.random() * _maxDis;
			//TweenLite.to(_target, 999 / _rate, {x: _shake_init_x, y: _shake_init_y});
		//}
		//
		//static private function shakeComplete(e:TimerEvent):void {
			//TweenLite.killTweensOf(_target);
			//_target.x = _shake_init_x;
			//_target.y = _shake_init_y;
			//var timer:Timer = e.target as Timer;
			//timer.removeEventListener(TimerEvent.TIMER, shaking);
			//timer.removeEventListener(TimerEvent.TIMER_COMPLETE, shakeComplete);
		//}
	
	}

}