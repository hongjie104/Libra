package org.libra.flex.spark.components
{
	import flash.display.DisplayObject;
	import flash.system.Capabilities;
	
	import mx.events.CloseEvent;
	
	import org.libra.flex.utils.PopUpUtil;
	
	import spark.components.TitleWindow;
	
	public class JWindow extends TitleWindow
	{
		public function JWindow()
		{
			super();
			
			this.addEventListener(CloseEvent.CLOSE, onClosed);
		}
		
		public function show(parent:DisplayObject, modal:Boolean = false):void{
//			this.height = Capabilities.screenResolutionY - 100;
//			this.width = Capabilities.screenResolutionX;
//			this.move(0, 0);
			PopUpUtil.instance.addPopUp(this, parent, modal, 1);
		}
		
		public function close():void {
			this.removeEventListener(CloseEvent.CLOSE, onClosed);
			PopUpUtil.instance.removePopUp(this, 1);
		}
		
		protected function onClosed(evt:CloseEvent = null):void{
			close();
		}
	}
}