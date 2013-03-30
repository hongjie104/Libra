package org.libra.utils {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class SystemStatus
	 * @author Eddie
	 * @qq 32968210
	 * @date 11-20-2011
	 * @version 1.0
	 * @see
	 */
	public class SystemStatus extends Sprite {
		
		private var statTime:int;
		private var timer:Timer;
		private var statFrame:int;
		private var tf:TextField;
		private static var instance:SystemStatus;
		
		public function SystemStatus(){
			super();
			
			if (instance != null){
				throw new Error("singleton");
			}
			this.mouseChildren = this.mouseEnabled = false;
			addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			this.timer = new Timer(1000);
			this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
			this.timer.start();
			this.statTime = getTimer();
			this.tf = new TextField();
			this.tf.border = true;
			this.tf.backgroundColor = 16777215;
			this.tf.background = true;
			addChild(this.tf);
			this.tf.autoSize = TextFieldAutoSize.LEFT;
			this.tf.mouseEnabled = false;
			this.alpha = 0.5;
		}
		
		/*-----------------------------------------------------------------------------------------
		   Public methods
		 -------------------------------------------------------------------------------------------*/
		public static function getInstance():SystemStatus {
			return instance ||= new SystemStatus();
		}
		
		/*-----------------------------------------------------------------------------------------
		   Private methods
		 -------------------------------------------------------------------------------------------*/
		private function onTimer(event:TimerEvent):void {
			var timer:int = getTimer();
			var fps:int = this.statFrame / (timer - this.statTime) * 1000;
			this.statTime = timer;
			this.statFrame = 0;
			this.tf.text = "fps:" + fps + "\n";
			this.tf.appendText("vmVersion:" + System.vmVersion + "\n");
			this.tf.appendText("player:" + Capabilities.version + " ");
			if (Capabilities.isDebugger){
				this.tf.appendText("debug");
			}
			this.tf.appendText("\nmem:" + System.totalMemory / 1024 / 1024 + "MB\n");
			this.tf.appendText("os:" + Capabilities.os + "\n");
			this.tf.appendText("os language:" + Capabilities.language + "\n");
			this.tf.appendText("pageCode:" + System.useCodePage + "\n");
			this.tf.appendText("playerType:" + Capabilities.playerType + "\n");
			this.tf.appendText("screenResolution:" + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY + "\n");
		}
		
		private function onEnterFrame(event:Event):void {
			statFrame += 1;
		}
	
		/*-----------------------------------------------------------------------------------------
		   Event Handlers
		 -------------------------------------------------------------------------------------------*/
	
	}

}