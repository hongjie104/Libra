package org.libra.utils.bytes {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	public final class BitmapBytes {
		public function BitmapBytes() {
			
		}
		
		public static function bitmapDataToByteArray(bmd:BitmapData):ByteArray {    
			//getPixels方法用于读取指定像素区域生成一个ByteArray，Rectangle是一个区域框，就是起始坐标     
			var pixels:ByteArray = bmd.getPixels(bmd.rect); 			
			//下面俩行将数据源的高和宽一起存储到数组中,为翻转的时候提供高度和宽度     
			pixels.writeShort(bmd.width);    
			pixels.writeShort(bmd.height);    
			return pixels;    
		}    
		//次方法的参数必须是像上面的ByteArray形式一样的,即需要对象的大小;     
		//此方法返回的Bitmap可以直接赋值给Image的source属性     
		public static function byteArrayToBitmapData(byArr:ByteArray):BitmapData{    
			if(byArr == null){
				return null;    
			}    
			//读取出存入时图片的高和宽,因为是最后存入的数据,所以需要到尾部读取     
			var bmd:ByteArray = byArr;    
			bmd.position = bmd.length-2;    
			var imageHeight:int = bmd.readShort();    
			bmd.position = bmd.length-4;    
			var imageWidth:int = bmd.readShort(); 
			var copyBmp:BitmapData = new BitmapData(imageWidth, imageHeight, true, 0x0);
			bmd.position = 0;
			/*
			//利用setPixel方法给图片中的每一个像素赋值,做逆操作     
			//ByteArray数组从零开始存储一直到最后都是图片数据,因为读入时的高和宽都是一样的,所以当循环结束是正好读完     
			bmd.position = 0;
			for( var i:uint=0; i<imageHeight ; i++ ) {
				for( var j:uint=0; j<imageWidth; j++ ) {    
					copyBmp.setPixel(j, i, bmd.readUnsignedInt());    
				}
			}
			*/
			copyBmp.setPixels(new Rectangle(0, 0, imageWidth, imageHeight), bmd);
			return copyBmp;    
		}
	}
}