package org.libra.tick {
	import flash.events.TimerEvent;
	
	/**
	 * <p>
	 * 时间管理
	 * </p>
	 *
	 * @class MultiTimer
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/06/2012
	 * @version 1.0
	 */
	public final class MultiTimer {
		
		/**
		 * 单例
		 * @private
		 */
		private static var _instance:MultiTimer;
		
		/**
		 * ITimerable对象集合
		 * @private
		 */
		private var timerEnabledList:Vector.<ITimerable>;
		
		/**
		 * 是否暂停
		 * @private
		 * @default false
		 */
		private var pause:Boolean;
		
		/**
		 * 避免flash睡眠机制影响的timer
		 * @private
		 */
		private var sleepTimer:SleepTimer;
		
		/**
		 * 构造函数
		 * @private
		 * @param	singleton
		 */
		public function MultiTimer(singleton:Singleton) { 
			timerEnabledList = new Vector.<ITimerable>();
			pause = true;
			sleepTimer = new SleepTimer(1000);
			sleepTimer.addEventListener(TimerEvent.TIMER, onTimerHandler);
		}
		
		/**
		 * 每1000毫秒触发该事件
		 * @private
		 * @param	e
		 */
		private function onTimerHandler(e:TimerEvent):void {
			for each(var b:ITimerable in timerEnabledList) {
				b.doAction();
			}
		}
		
		/**
		 * 增加一个对象
		 * @param	timerEnabled
		 */
		public function addItem(timerEnabled:ITimerable):void {
			if (!hasItem(timerEnabled)) {
				this.timerEnabledList[timerEnabledList.length] = timerEnabled;
				this.setPause(false);
			}
		}
		
		/**
		 * 移除一个对象
		 * @param	timerEnabled
		 */
		public function removeItem(timerEnabled:ITimerable):void {
			var index:int = timerEnabledList.indexOf(timerEnabled);
			if (index != -1) {
				timerEnabledList.splice(index, 1);
			}
			if (this.timerEnabledList.length == 0) {
				this.setPause(true);
			}
		}
		
		/**
		 * 清除所有对象
		 */
		public function clearItem():void {
			this.timerEnabledList.length = 0;
		}
		
		/**
		 * 是否包含某对象
		 * @param	timerEnabled
		 * @return 布尔值
		 */
		public function hasItem(timerEnabled:ITimerable):Boolean {
			return this.timerEnabledList.indexOf(timerEnabled) != -1;
		}
		
		/**
		 * 设置暂停
		 * @param	value 布尔值
		 */
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
		
		/**
		 * 是否暂停
		 * @return 布尔值
		 */
		public function isPause():Boolean {
			return this.pause;
		}
		
		/**
		 * 设置时间间隔
		 * @param	value
		 */
		public function setDelay(value:int):void {
			this.sleepTimer.setDelay(value);
		}
		
		/**
		 * 获取单例
		 * @private
		 * @return
		 */
		public static function get instance():MultiTimer {
			return _instance ||= new MultiTimer(new Singleton());
		}
		
	}

}
/**
 * 单例模式
 * @private
 */
final class Singleton{}