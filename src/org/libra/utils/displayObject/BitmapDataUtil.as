package org.libra.utils.displayObject {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import org.libra.ui.Constants;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BitmapDataUtil
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public final class BitmapDataUtil {
		
		static private const ZERO_POINT:Point = new Point();
		
		private static const ZERO_RECT:Rectangle = new Rectangle();
		
		public function BitmapDataUtil() {
			throw new Error('BitmapDataUtil无法实例化!');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		/**
         * 这个方法是实现位图Scale9缩放的关键，使用BitmapData.draw和图像矩阵Matrix来实现功能
         * @param source 源位图数据
         * @param w 调整后所需的宽度
         * @param h 调整后所需的高度
         * @param scaleInfo scale9定义矩形
         * @return 处理后的位图数据
         */        
		public static function getScale9BitmapData(source:BitmapData, w:int, h:int, scaleInfo:Rectangle):BitmapData { 
			var sourceImgWidth:int = source.width;
			var sourceImgHeight:int = source.height;
			var bmpData:BitmapData = new BitmapData(w, h, true, 0x000000);
			var matrix:Matrix = new Matrix();
			//绘制后的图像数据的剪裁区域，它用来定义绘制后的位图数据哪些部分是需要保留的，类似于遮罩，不处于这个区域内部的像素将被忽略
			//对于Scale9来说，我们需要定义9个这样的裁剪区域，分别对应9个区域
			//区域3的宽度
			var offsetRight:int = sourceImgWidth - scaleInfo.right;
			//区域7的高度
			var offsetBottom:int = sourceImgHeight - scaleInfo.bottom;
			var left:int = scaleInfo.left;
			var top:int = scaleInfo.top;
			//注意下面的循环，分别对应Scale9的9个区域，每个区域需要设置相应的裁剪区域，并使用Matrix来让图像缩放或移动位置
			var rect:Rectangle = new Rectangle();
			for (var i:int = 1; i < 10; i++) { 
				switch(i) { 
					case 1:
						rect.x = rect.y = 0; rect.width = left; rect.height = top;
						break;
					case 2:
						rect.x = left; rect.y = 0; rect.width = w - offsetRight - left; rect.height = top;
						matrix.a = rect.width / scaleInfo.width;
						matrix.tx = rect.x - rect.x * matrix.a;
						break;
					case 3:
						rect.x = w - offsetRight; rect.y = 0; rect.width = offsetRight; rect.height = top;
						matrix.tx = w - sourceImgWidth;
						break;
					case 4:
						rect.x = 0; rect.y = top; rect.width = left; rect.height = h - top - offsetBottom;
						matrix.d = rect.height / scaleInfo.height;
						matrix.ty = rect.y - rect.y * matrix.d;
						break;
					case 5:
						rect.x = left; rect.y = top; rect.width = w - left - offsetRight; rect.height = h - top - offsetBottom;
						matrix.a = rect.width / scaleInfo.width;
						matrix.d = rect.height / scaleInfo.height;
						matrix.tx = rect.x - rect.x * matrix.a;
						matrix.ty = rect.y - rect.y * matrix.d;
						break;
					case 6:
						rect.x = w - offsetRight; rect.y = top; rect.width = offsetRight; rect.height = h - top - offsetBottom;
						matrix.d = rect.height / scaleInfo.height;
						matrix.tx = w - sourceImgWidth;
						matrix.ty = rect.y - rect.y * matrix.d;
						break;
					case 7:
						rect.x = 0; rect.y = h - offsetBottom; rect.width = left; rect.height = offsetBottom;
						matrix.ty = h - sourceImgHeight;
						break;
					case 8:
						rect.x = left; rect.y = h - offsetBottom; rect.width = w - left - offsetRight; rect.height = offsetBottom;
						matrix.a = rect.width / scaleInfo.width;
						matrix.tx = rect.x - rect.x * matrix.a;
						matrix.ty = h - sourceImgHeight;
						break;
					case 9:
						rect.x = w - offsetRight; rect.y = h - offsetBottom; rect.width = offsetRight; rect.height = offsetBottom;
						matrix.tx = w - sourceImgWidth;
						matrix.ty = h - sourceImgHeight;
						break;
				}
				bmpData.draw(source, matrix, null, null, rect, true);
				matrix.identity();
			}
			return bmpData;
		}
		
		public static function getScale3BitmapData(source:BitmapData, length:int, scaleInfo:Rectangle, direction:int = 0):BitmapData { 
			var sourceImgWidth:int = source.width;
			var sourceImgHeight:int = source.height;
			var matrix:Matrix = new Matrix();
			var rect:Rectangle = new Rectangle();
			
			if (direction == Constants.HORIZONTAL) {
				//水平的
				var w:int = length; var h:int = source.height;
				var bmpData:BitmapData = new BitmapData(w, h, true, 0x000000);
				//绘制左边
				rect.width = scaleInfo.left; rect.height = h;
				bmpData.draw(source, matrix, null, null, rect, true);
				//绘制中间
				rect.x = scaleInfo.left; rect.width = w - scaleInfo.left - sourceImgWidth + scaleInfo.right;
				matrix.a = rect.width / scaleInfo.width;
				matrix.tx = rect.x - rect.x * matrix.a;
				bmpData.draw(source, matrix, null, null, rect, true);
				//绘制右边
				matrix.identity();
				rect.x = w - sourceImgWidth + scaleInfo.right; rect.width = sourceImgWidth - scaleInfo.right;
				matrix.tx = w - sourceImgWidth;
				bmpData.draw(source, matrix, null, null, rect, true);
			}else {
				//垂直的
				w = source.width; h = length;
				bmpData = new BitmapData(w, h, true, 0x000000);
				//绘制上边
				rect.width = w; rect.height = scaleInfo.top;
				bmpData.draw(source, matrix, null, null, rect, true);
				//绘制中间
				rect.y = scaleInfo.top; rect.height = h - scaleInfo.top + scaleInfo.bottom - sourceImgHeight;
				matrix.d = rect.height / scaleInfo.height;
				matrix.ty = rect.y - rect.y * matrix.d;
				bmpData.draw(source, matrix, null, null, rect, true);
				//绘制下边
				matrix.identity();
				rect.y = h + scaleInfo.bottom - sourceImgHeight; rect.height = sourceImgHeight - scaleInfo.bottom;
				matrix.ty = h - sourceImgHeight;
				bmpData.draw(source, matrix, null, null, rect, true);
			}
			return bmpData;
		}
		
		/**
		 * 切分位图为一组较小的位图
		 * @param source
		 * @param width
		 * @param height
		 * @return 
		 */
		public static function separateBitmapData(width:int, height:int, source:BitmapData, dispose:Boolean = true):Vector.<Vector.<BitmapData>> { 
			var result:Vector.<Vector.<BitmapData>> = new Vector.<Vector.<BitmapData>>();
			var row:int = int(source.height / height);
			var col:int = int(source.width / width);
			var bitmapData:BitmapData;
			var rect:Rectangle = new Rectangle(0, 0, width, height);
			for (var j:int = 0; j < row; j += 1) { 
				rect.y = j * height;
				result[j] = new Vector.<BitmapData>(col);
				for (var i:int = 0; i < col; i += 1) { 
					rect.x = i * width;
					result[j][i] = getBitmapData(rect, source);
				}
			}
			if(dispose){
				source.dispose();
				source = null;
			}
			return result;
		}
		
		/**
		 * 将bitmapData垂直翻转
		 * @param	bitmapData
		 * @return
		 */
		public static function flipVertical(bitmapData:BitmapData):BitmapData {
			var height:int = bitmapData.height;
			var width:int = bitmapData.width;
			var bmd:BitmapData = new BitmapData(width, height, true, 0x00000000);
            for (var xx:int = 0; xx < width; xx += 1) { 
                for (var yy:int = 0; yy < height; yy += 1) { 
                    bmd.setPixel32(xx, height - yy - 1, bitmapData.getPixel32(xx, yy));
                }
            }
            return bmd;
		}
		
		/**
		 * 将bitmapData水平翻转
		 * @param	bitmapData
		 * @return
		 */
		public static function flipHorizontal(bitmapData:BitmapData):BitmapData {
			var height:int = bitmapData.height;
			var width:int = bitmapData.width;
			var bmd:BitmapData = new BitmapData(width, height, true, 0x00000000);
            for (var yy:int = 0; yy < height; yy += 1) { 
                for (var xx:int = 0; xx < width; xx += 1) {
                    bmd.setPixel32(width - xx - 1, yy, bitmapData.getPixel32(xx, yy));
                }
            }
            return bmd;
		}
		
		/**
		 * 判断图片是不是全透明的
		 * @param	source
		 */
		public static function isEmpty(source:BitmapData):Boolean{
			var ba:ByteArray = source.getPixels(source.rect);
			ba.position = 0;
			const l:int = ba.length;
			for (var i:int; i < l; i = i + 4) { 
				if (ba.bytesAvailable) { 
					if(ba[i] != 0) return false;
				}else{
					return false;
				}
			}
			return true;
		}
		
		///**
		 //* 将图片中白色变成透明
		 //* @param	source
		 //*/
		//public static function changeTransparent(source:BitmapData):void {
			//var ba:ByteArray = source.getPixels(source.rect);
			//ba.position = 0;
			//const l:int = ba.length;
			//for (var i:int; i < l; i = i + 4) { 
				//if (ba.bytesAvailable) { 
				   //此处做白色颜色改为透明处理
				    //if (ba[i + 3] == 255 && ba[i + 1] == 255 && ba[i + 2] == 255) { 
						//ba[i] = 0;
				    //}
				//}
			//}
			//ba.position = 0;
			//source.setPixels(source.rect, ba)
		//}
		
		static public function flipHorizontalList(list:Vector.<BitmapData>):Vector.<BitmapData> {
			const l:int = list.length;
			var result:Vector.<BitmapData> = new Vector.<BitmapData>(l);
			for (var i:int = 0; i < l; i += 1) {
				result[i] = flipHorizontal(list[i]);
			}
			return result;
		}
		
		public static function getBitmapData(rect:Rectangle, source:BitmapData):BitmapData { 
			var bitmapData:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			bitmapData.copyPixels(source, rect, ZERO_POINT, null, null, true);
			return bitmapData;
		}
		
		/**
		 * 替换位图指定颜色值;
		 * @param bitmapData 位图;
		 * @param color 需要替换的颜色(ARBG);
		 * @param repColor 替换的颜色(ARBG);
		 * @param mask 用于隔离颜色成分的遮罩(ARBG 0x00FF0000);
		 */
		public static function replaceColor(bitmapData:BitmapData, color:uint, repColor:uint, mask:uint = 0x00FFFFFF):void {
			if (bitmapData == null || bitmapData.width < 1) {
				return;
			}
			bitmapData.threshold(bitmapData, bitmapData.rect, ZERO_POINT, "==", color, repColor, mask, true);
		}

		/**
		 * 获取图片真实大小（去除透明部分）
		 * @param bitmapData 位图;
		 * @return Rectangle
		 */
		public static function getRealImageRect(bitmapData : BitmapData) : Rectangle {
			if (bitmapData == null || bitmapData.width < 1) {
				return new Rectangle();
			}
			return bitmapData.getColorBoundsRect(0xFF000000, 0, false);
		}

		/**
		 * 是否空图片(去除透明部分)
		 * @param bitmapData 位图;
		 * @return
		 */
		public static function isEmptyImage(bitmapData : BitmapData) : Boolean {
			if (bitmapData == null || bitmapData.width < 1) {
				return false;
			}
			return getRealImageRect(bitmapData).equals(ZERO_RECT);
		}

		///**
		 //* 获取位图区域数组(0为障碍 1为通路)
		 //* @param bitmapData 位图
		 //* @param cellSize 方格大小
		 //* @return 区域数组
		 //*/
		//public static function getImageMapVector(bitmapData : BitmapData, cellSize : uint = 8) : Vector.<Vector.<int>> {
			//if (bitmapData == null || !bitmapData.transparent ) {
				//throw new Error("bitmapData值无效");
			//}
			//if (cellSize < 4) {
				//cellSize = 4;
			//} else if (cellSize > 50) {
				//cellSize = 50;
			//}
			//var rect : Rectangle = BitmapDataUtil.getRealImageRect(bitmapData);
			//var maxX : int = Math.ceil(rect.right / cellSize);
			//var maxY : int = Math.ceil(Math.ceil(rect.bottom / cellSize));
			//var startX : int = Math.floor(rect.left / cellSize);
			//var startY : int = Math.floor(rect.top / cellSize);
			//var map : Vector.<Vector.<int>> = new Vector.<Vector.<int>>(maxX);
			//var x : int;
			//var y : int;
			//var checkRect : Rectangle = new Rectangle(0, 0, cellSize, cellSize);
			//var checkBmd : BitmapData = new BitmapData(cellSize, cellSize, true, 0);
			//var point : Point = new Point();
			//for ( x = 0; x < startX; x++) {
				//map[x] = new Vector.<int>(maxY);
			//}
			//for (x = startX; x < maxX; x++) {
				//map[x] = new Vector.<int>(maxY);
				//for (y = startY; y < maxY; y++) {
					//checkRect.x = x * cellSize;
					//checkRect.y = y * cellSize;
					//checkBmd.copyPixels(bitmapData, checkRect, point);
					//if (!BitmapDataUtil.isEmptyImage(checkBmd)) {
						//map[x][y] = 1;
					//}
				//}
			//}
			//checkBmd.dispose();
			//checkRect = null;
			//rect = null;
			//point = null;
			//return map;
		//}

		/**
		 * 获取透明背景纹理
		 */
		//public static function getAlphaTextureBitmapData() : BitmapData {
			//var shape : Shape = new Shape();
			//shape.graphics.beginFill(0xDFDFDF);
			//shape.graphics.drawRect(8, 0, 8, 8);
			//shape.graphics.drawRect(0, 8, 8, 8);
			//shape.graphics.endFill();
			//var data : BitmapData = new BitmapData(16, 16, false, 0xFFFFFF);
			//data.draw(shape);
			//return data;
		//}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}