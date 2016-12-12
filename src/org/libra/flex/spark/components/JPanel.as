package org.libra.flex.spark.components
{
	import flash.display.DisplayObject;
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
			var Stageheight:Number = Capabilities.screenResolutionY;
			var Stagewidth:Number = Capabilities.screenResolutionX;
			this.move((Stagewidth - this.width) / 2, (Stageheight - this.height) / 2);
		}
		
		public function close():void{
			PopUpUtil.instance.removePopUp(this, 1);
		}
	}
}