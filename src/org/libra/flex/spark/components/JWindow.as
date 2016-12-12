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
			PopUpUtil.instance.addPopUp(this, parent, modal, 1);
			var Stageheight:Number = Capabilities.screenResolutionY;
			var Stagewidth:Number = Capabilities.screenResolutionX;
			this.move((Stagewidth - this.width) / 2, (Stageheight - this.height) / 2);
		}
		
		protected function onClosed(evt:CloseEvent):void{
			this.removeEventListener(CloseEvent.CLOSE, onClosed);
			PopUpUtil.instance.removePopUp(this, 1);
		}
	}
}