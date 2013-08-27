package org.libra.copGameEngine.basic {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import org.libra.copGameEngine.component.IBitmapDataRender;
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
		
		protected var $bitmapDataRender:IBitmapDataRender;
		
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
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		protected function onAddedToStage(e:Event):void {
			$bitmap.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			$bitmap.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			//if ($bitmapDataRender && $bitmapDataRender is ITickable) Tick.getInstance().addItem(this.$bitmapDataRender);
		}
		
		protected function onRemovedFromStage(e:Event):void {
			$bitmap.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			$bitmap.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//if ($bitmapDataRender && $bitmapDataRender is ITickable) Tick.getInstance().removeItem(this.$bitmapDataRender);
		}
	}

}