/**
 * Created with IntelliJ IDEA.
 * User: swiezy
 * Date: 17.04.2013
 * Time: 16:55
 */
package com.krechagames.lab.assets.starling {
	import com.krechagames.lab.assets.starling.display.StarlingDemoRoot;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import starling.core.Starling;
	import starling.events.Event;

	[SWF(width="1024", height="768", backgroundColor="0x000000", frameRate="60")]
	public class StarlingDemo extends Sprite {
		/**
		 * Starling instance
		 */
		private var app:Starling;

		public function StarlingDemo() {
			super();

			init();
		}

		/**
		 * Initialize Starling
		 */
		private function init():void {
			//stage
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			//starling
			app = new Starling(StarlingDemoRoot, stage);
			app.showStats = true;
			app.enableErrorChecking = false;
			app.addEventListener(Event.CONTEXT3D_CREATE, contextReadyHandler);
			Starling.current.stage.stageWidth = 1024 / 2;
			Starling.current.stage.stageHeight = 768 / 2;
		}

		/**
		 * Context is ready, start app
		 * @param event
		 */
		private function contextReadyHandler(event:Event):void {
			app.start();
		}
	}
}
