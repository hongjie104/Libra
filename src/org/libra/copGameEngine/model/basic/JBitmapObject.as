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
		
		protected var _sprite:Sprite;
		
		protected var _bitmap:Bitmap;
		
		protected var _bmdClass:String;
		
		protected var _bitmapDataRender:IBitmapDataRender;
		
		protected var _bmdCollection:IAsset;
		
		public function JBitmapObject(width:int, height:int, bitmapDataRender:IBitmapDataRender = null) {
			super();
			_bitmap = new Bitmap(new BitmapData(width, height, true, 0x0));
			_sprite = new Sprite();
			_sprite.mouseChildren = _sprite.mouseEnabled = false;
			_sprite.addChild(_bitmap);
			
			_bitmapDataRender = bitmapDataRender;
			if (_bitmapDataRender) {
				_bitmapDataRender.bitmapData = _bitmap.bitmapData;
				addComponent(_bitmapDataRender, _bitmapDataRender.name);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSize(width:int, height:int):void {
			if (_bitmap.bitmapData) _bitmap.bitmapData.dispose();
			_bitmap.bitmapData = new BitmapData(width, height, true, 0x0);
			if (_bitmapDataRender) this._bitmapDataRender.bitmapData = _bitmap.bitmapData;
		}
		
		public function get displayObject():DisplayObject {
			return _sprite;
		}
		
		public function get bmdCollection():IAsset {
			return this._bmdCollection;
		}
		
		public function set bmdCollection(val:IAsset):void {
			_bmdCollection = val;
		}
		
		override public function set type(value:int):void {
			super.type = value;
			//设置Type时，需要读取配置文件，取出配置信息后将bmdClass进行赋值
			resetBmdCollection();
		}
		
		public function get x():Number {
			return _sprite.x;
		}
		
		public function set x(val:Number):void {
			_sprite.x = val;
		}
		
		public function get y():Number {
			return _sprite.y;
		}
		
		public function set y(val:Number):void {
			_sprite.y = val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function resetBmdCollection():void {
			_bmdCollection = BmdCollectionFactory.instance.getBmdCollection(_bmdClass, BaseBmdCollection);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}