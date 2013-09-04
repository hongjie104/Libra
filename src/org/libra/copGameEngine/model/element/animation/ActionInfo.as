package org.libra.copGameEngine.model.element.animation {
	import com.apowo.dreamer.lib.Config;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * <p>
	 * 一种动作，包含了N帧信息
	 * </p>
	 *
	 * @class ActionInfo
	 * @author Eddie
	 * @qq 32968210
	 * @date 04/30/2013
	 * @version 1.0
	 * @see
	 */
	public final class ActionInfo {
		
		//static public const PLAY_OVER:String = "playOver";
		
		private var $frameList:Vector.<FrameInfo>;
		
		private var $curStep:int;
		
		private var $totalStep:int;
		
		private var $time:int;
		
		private var $loop:int;
		
		private var $totalLoop:int;
		
		public function ActionInfo() {
			$time = $curStep = $totalStep = 0;
			setTotalLoop( -1);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		public function setTotalLoop(value:int):void {
			this.$loop = 0;
			this.$totalLoop = value;
		}
		
		public function parse(action:String):void {
			var actionArr:Array = Config.motionConfig[action];
			if (actionArr == null) 
				actionArr = Config.motionConfig["stand"];
			$curStep = 0;
			$totalStep = actionArr.length;
			var value:* = null;
			for (var i:* in actionArr) {
				var head:Object = actionArr[i]["head"];
				var body:Object = actionArr[i]["body"];
				var arm:Object = actionArr[i]["arm"];
				var leg:Object = actionArr[i]["leg"];
				var duration:int = actionArr[i]["duration"];
				if(duration)
				$frameList.push(new FrameInfo(head, body, arm, leg, duration));
				else
				$frameList.push(new FrameInfo(head, body, arm, leg));
			}
		}
		
		public function addStep():Boolean {
			$time += 100;
			if ($time >= $frameList[curStep].duration) {
				$time = 0;
				$curStep += 1;
				if ($curStep >= $totalStep) {
					$curStep = 0;
					if ($totalLoop > 0) {
						if (++$loop >= $totalLoop) {
							stop();
							return false;
						}
					}
				}
				return true;
			}
			return false;
		}
		
		public function stop():void {
			setTotalLoop( -1);
			//dispatchEvent(new Event(PLAY_OVER));
		}
		
		public function getFrame(value:String):int {
			switch(value) {
				case "head":
					return $frameList[$curStep].head.getFrame();
				case "body":
					return $frameList[$curStep].body.getFrame();
				case "arm":
					return $frameList[$curStep].arm.getFrame();
				case "leg":
					return $frameList[$curStep].leg.getFrame();
				default:
					return -1;
			}
		}
		
		public function getOffset(value:String):Point {
			switch(value) {
				case "head":
					return $frameList[$curStep].head.getOffset();
				case "body":
					return $frameList[$curStep].body.getOffset();
				case "arm":
					return $frameList[$curStep].arm.getOffset();
				case "leg":
					return $frameList[$curStep].leg.getOffset();
				default:
					return null;
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}