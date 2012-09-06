package org.libra.tick {
	import flash.events.TimerEvent;
	import org.jpixel.interfaces.ITimerable;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public final class MultiTimer {
		
		private static var instance:MultiTimer;
		private var timerableList:Vector.<ITimerable>;
		private var pause:Boolean;
		private var sleepTimer:SleepTimer;
		
		public function MultiTimer(singleton:Singleton) { 
			timerableList = new Vector.<ITimerable>();
			pause = true;
			sleepTimer = new SleepTimer(100);
			sleepTimer.addEventListener(TimerEvent.TIMER, onTimerHandler);
		}
		
		private function onTimerHandler(e:TimerEvent):void {
			for each(var b:ITimerable in timerableList) {
				b.doAction();
			}
		}
		
		public function addItem(timerable:ITimerable):void {
			if (!hasItem(timerable)) {
				this.timerableList[timerableList.length] = timerable;
				this.setPause(false);
			}
		}
		
		public function removeItem(timerable:ITimerable):void {
			var index:int = timerableList.indexOf(timerable);
			if (index != -1) {
				timerableList.splice(index, 1);
			}
			if (this.timerableList.length == 0) {
				this.setPause(true);
			}
		}
		
		public function clearItem():void {
			this.timerableList.length = 0;
		}
		
		public function hasItem(timerable:ITimerable):Boolean {
			return this.timerableList.indexOf(timerable) != -1;
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