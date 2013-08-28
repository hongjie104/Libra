package org.libra.copGameEngine.model.basic {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import org.libra.copGameEngine.component.IBitmapDataRender;
	import org.libra.copGameEngine.model.bitmapDataCollection.BaseBmdCollection;
	import org.libra.copGameEngine.model.bitmapDataCollection.BmdCollectionFactory;
	import org.libra.copGameEngine.model.bitmapDataCollection.IBmdCollection;
	import org.libra.tick.ITickable;
	import org.libra.tick.Tick;
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
		
		protected var $bitmap:Bitmap;
		
		protected var $bmdClass:String;
		
		protected var $bitmapDataRender:IBitmapDataRender;
		
		protected var $bmdCollection:IBmdCollection;
		
		public function JBitmapObject(bitmapDataRender:IBitmapDataRender = null) {
			super();
			$bitmapDataRender = bitmapDataRender;
			if ($bitmapDataRender) addComponent($bitmapDataRender, $bitmapDataRender.name);
			$bitmap = new Bitmap();
			$bitmap.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSize(width:int, height:int):void {
			if ($bitmap.bitmapData) $bitmap.bitmapData.dispose();
			$bitmap.bitmapData = new BitmapData(width, height, true, 0x0);
			if ($bitmapDataRender) this.$bitmapDataRender.bitmapData = $bitmap.bitmapData;
		}
		
		public function get bitmap():Bitmap {
			return $bitmap;
		}
		
		public function get bmdCollection():IBmdCollection {
			return this.$bmdCollection;
		}
		
		override public function set type(value:int):void {
			super.type = value;
			//设置Type时，需要读取配置文件，取出配置信息后将bmdClass进行赋值
			resetBmdCollection();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function resetBmdCollection():void {
			$bmdCollection = BmdCollectionFactory.getInstance().getBmdCollection($type, $bmdClass, BaseBmdCollection);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		protected function onAddedToStage(e:Event):void {
			$bitmap.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			$bitmap.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			if ($bitmapDataRender && $bitmapDataRender is ITickable) Tick.getInstance().addItem(this.$bitmapDataRender as ITickable);
		}
		
		protected function onRemovedFromStage(e:Event):void {
			$bitmap.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			$bitmap.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			if ($bitmapDataRender && $bitmapDataRender is ITickable) Tick.getInstance().removeItem(this.$bitmapDataRender as ITickable);
		}
	}

}