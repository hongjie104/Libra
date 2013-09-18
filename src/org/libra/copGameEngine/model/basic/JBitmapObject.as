package org.libra.copGameEngine.model.basic {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.libra.copGameEngine.component.IBitmapDataRender;
	import org.libra.copGameEngine.model.bitmapDataCollection.BaseBmdCollection;
	import org.libra.copGameEngine.model.bitmapDataCollection.BmdCollectionFactory;
	import org.libra.utils.asset.IAsset;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JDisplayObject
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class JBitmapObject extends GameObject {
		
		protected var $sprite:Sprite;
		
		protected var $bitmap:Bitmap;
		
		protected var $bmdClass:String;
		
		protected var $bitmapDataRender:IBitmapDataRender;
		
		protected var $bmdCollection:IAsset;
		
		public function JBitmapObject(width:int, height:int, bitmapDataRender:IBitmapDataRender = null) {
			super();
			$bitmap = new Bitmap(new BitmapData(width, height, true, 0x0));
			$sprite = new Sprite();
			$sprite.mouseChildren = $sprite.mouseEnabled = false;
			$sprite.addChild($bitmap);
			
			$bitmapDataRender = bitmapDataRender;
			if ($bitmapDataRender) {
				$bitmapDataRender.bitmapData = $bitmap.bitmapData;
				addComponent($bitmapDataRender, $bitmapDataRender.name);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSize(width:int, height:int):void {
			if ($bitmap.bitmapData) $bitmap.bitmapData.dispose();
			$bitmap.bitmapData = new BitmapData(width, height, true, 0x0);
			if ($bitmapDataRender) this.$bitmapDataRender.bitmapData = $bitmap.bitmapData;
		}
		
		public function get displayObject():DisplayObject {
			return $sprite;
		}
		
		public function get bmdCollection():IAsset {
			return this.$bmdCollection;
		}
		
		public function set bmdCollection(val:IAsset):void {
			$bmdCollection = val;
		}
		
		override public function set type(value:int):void {
			super.type = value;
			//设置Type时，需要读取配置文件，取出配置信息后将bmdClass进行赋值
			resetBmdCollection();
		}
		
		public function get x():Number {
			return $sprite.x;
		}
		
		public function set x(val:Number):void {
			$sprite.x = val;
		}
		
		public function get y():Number {
			return $sprite.y;
		}
		
		public function set y(val:Number):void {
			$sprite.y = val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function resetBmdCollection():void {
			$bmdCollection = BmdCollectionFactory.getInstance().getBmdCollection($bmdClass, BaseBmdCollection);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}