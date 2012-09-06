package org.libra.tick {
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	/**
	 * 扩展的Timer，会修正省电模式Timer次数减少的问题
	 * @author flashyiyi
	 *
	 */
	public class SleepTimer extends EventDispatcher {
		
		private var prevTimer:int;
		private var timer:Timer;
		
		private var delay:Number;
		private var currentCount:int;
		private var repeatCount:int;
		
		public function SleepTimer(delay:Number, repeatCount:int = 0){
			this.timer = new Timer(delay, int.MAX_VALUE);
			this.delay = delay;
			this.repeatCount = repeatCount;
		}
		
		public function start():void {
			this.prevTimer = getTimer();
			this.currentCount = 0;
			
			this.timer.addEventListener(TimerEvent.TIMER, timerHandler);
			this.timer.start();
		}
		
		public function stop():void {
			this.timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			this.timer.stop();
		}
		
		public function setDelay(value:int):void {
			this.delay = value;
			this.timer.delay = value;
		}
		
		public function reset():void {
			this.stop();
			this.start();
		}
		
		public function get running():Boolean {
			return timer.running;
		}
		
		protected function timerHandler(event:TimerEvent):void {
			var t:int = getTimer();
			while (t - prevTimer >= timer.delay){
				prevTimer += timer.delay;
				
				this.currentCount++;
				dispatchEvent(event);
				
				if (currentCount == repeatCount){
					this.stop();
					this.dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
				}
			}
		}
	}
}