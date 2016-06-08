package org.libra.flex.spark.components {
	import flash.events.Event;
	import mx.controls.Image;
	import mx.core.mx_internal;
	use namespace mx_internal;
	
	public class JImage extends Image {
		public function JImage() {
			super();
		}
		
//		override mx_internal function contentLoaderInfo_completeEventHandler(event:Event):void {
//			super.contentLoaderInfo_completeEventHandler(event);
//			//this.dispatchEvent(new Event(Event.COMPLETE));
//		}
		
		override protected function contentLoaded():void {
			super.contentLoaded();
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}