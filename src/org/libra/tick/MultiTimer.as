package org.libra.tick {
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public final class MultiTimer {
		
		private static var instance:MultiTimer;
		
		private var timerEnabledList:Vector.<ITimerable>;
		private var pause:Boolean;
		private var sleepTimer:SleepTimer;
		
		public function MultiTimer(singleton:Singleton) { 
			timerEnabledList = new Vector.<ITimerable>();
			pause = true;
			sleepTimer = new SleepTimer(100);
			sleepTimer.addEventListener(TimerEvent.TIMER, onTimerHandler);
		}
		
		private function onTimerHandler(e:TimerEvent):void {
			for each(var b:ITimerable in timerEnabledList) {
				b.doAction();
			}
		}
		
		public function addItem(timerEnabled:ITimerable):void {
			if (!hasItem(timerEnabled)) {
				this.timerEnabledList[timerEnabledList.length] = timerEnabled;
				this.setPause(false);
			}
		}
		
		public function removeItem(timerEnabled:ITimerable):void {
			var index:int = timerEnabledList.indexOf(timerEnabled);
			if (index != -1) {
				timerEnabledList.splice(index, 1);
			}
			if (this.timerEnabledList.length == 0) {
				this.setPause(true);
			}
		}
		
		public function clearItem():void {
			this.timerEnabledList.length = 0;
		}
		
		public function hasItem(timerEnabled:ITimerable):Boolean {
			return this.timerEnabledList.indexOf(timerEnabled) != -1;
		}
		
		public function setPause(value:Boolean):void {
			if (this.pause != value) {
				this.pause = value;
				if (value) {
					this.sleepTimer.stop();
				}else {
					if (!this.sleepTimer.running) {
						this.sleepTimer.start();
					}
				}
			}
		}
		
		public function isPause():Boolean {
			return this.pause;
		}
		
		public function setDelay(value:int):void {
			this.sleepTimer.setDelay(value);
		}
		
		public static function getInstance():MultiTimer {
			return instance ||= new MultiTimer(new Singleton());
		}
		
	}

}
class Singleton{}