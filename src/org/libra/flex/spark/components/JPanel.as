package org.libra.flex.spark.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.system.Capabilities;
	
	import org.libra.flex.utils.PopUpUtil;
	
	import spark.components.Panel;
	
	public class JPanel extends Panel
	{
		public function JPanel()
		{
			super();
		}
		
		public function show(parent:DisplayObject, modal:Boolean = false):void{
			PopUpUtil.instance.addPopUp(this, parent, modal, 1);
//			var stageheight:Number = Capabilities.screenResolutionY;
//			var stagewidth:Number = Capabilities.screenResolutionX;
			var stageWidth:int = this.stage.stageWidth;
			var stageHeight:int = this.stage.stageHeight;
			this.move((stageWidth - this.width) / 2, (stageHeight - this.height) / 2);
			
			this.stage.addEventListener(Event.RESIZE, onResize);
		}
		
		public function close():void{
			PopUpUtil.instance.removePopUp(this, 1);
			this.stage.removeEventListener(Event.RESIZE, onResize);
		}
		
		protected function onResize(evt:Event):void{
//			trace(this.stage.stageWidth, this.stage.stageHeight);
//			var stageheight:Number = Capabilities.screenResolutionY;
//			var stagewidth:Number = Capabilities.screenResolutionX;
			var stageWidth:int = this.stage.stageWidth;
			var stageHeight:int = this.stage.stageHeight;
			this.move((stageWidth - this.width) / 2, (stageHeight - this.height) / 2);
		}
	}
}