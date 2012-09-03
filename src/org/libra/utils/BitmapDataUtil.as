package org.libra.utils {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
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
		
		public function BitmapDataUtil() {
			
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
		 public static function getScaledBitmapData(source:BitmapData, w:int, h:int, scaleInfo:Rectangle):BitmapData { 
			var sourceImgWidth:int = source.width;
			var sourceImgHeight:int = source.height;
			var bmpData:BitmapData = new BitmapData(w, h, true, 0x000000);
			var matrix:Matrix = new Matrix();
			//绘制后的图像数据的剪裁区域，它用来定义绘制后的位图数据哪些部分是需要保留的，类似于遮罩，不处于这个区域内部的像素将被忽略
			//对于Scale9来说，我们需要定义9个这样的裁剪区域，分别对应文章示意图中的9个区域
			//var clipRect:Rectangle;
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
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}