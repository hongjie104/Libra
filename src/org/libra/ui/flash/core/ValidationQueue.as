package org.libra.ui.flash.core {
	import flash.display.DisplayObjectContainer;
	import org.libra.tick.ITickable;
	import org.libra.tick.Tick;
	
	/**
	 * <p>
	 * 更新UI控件的控制器
	 * </p>
	 *
	 * @class ValidationQueue
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/20/2013
	 * @version 1.0
	 * @see
	 */
	public final class ValidationQueue implements ITickable {
		
		/**
		 * 单例
		 * @private
		 */
		private static var instance:ValidationQueue;
		
		/**
		 * @private
		 */
		private var $validating:Boolean;
		
		/**
		 * @private
		 */
		private var $delayedQueue:Vector.<Component>;
		
		/**
		 * @private
		 */
		private var $queue:Vector.<Component>;
		
		public function ValidationQueue(singleton:Singleton) {
			$delayedQueue = new Vector.<Component>();
			$queue = new Vector.<Component>();
			Tick.getInstance().addItem(this);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function addControl(control:Component, delayIfValidating:Boolean):void {
			const currentQueue:Vector.<Component> = (this.$validating || delayIfValidating) ? this.$delayedQueue : this.$queue;
			const queueLength:int = currentQueue.length;
			const containerControl:DisplayObjectContainer = control as DisplayObjectContainer;
			for(var i:int = 0; i < queueLength; i++) {
				var item:Component = currentQueue[i];
				if(control == item && currentQueue == this.$queue) {
					//already queued
					return;
				}
				if(containerControl && containerControl.contains(item)) {
					break;
				}
			}
			currentQueue.splice(i, 0, control);
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			this.$validating = true;
			const l:int = $queue.length;
			if (l) {
				//这里的循环,索引值一定要从小到大
				//因为在addControl方法中加入待更新控件时,是按照一定顺序排列的。
				//顺序是，如果被加入的控件的父容器在待更新队列中，那么控件就放在其父容器之后
				var count:int = 0;
				while(count < l) {
					this.$queue[count++].validate();
				}
				$queue.length = 0;
				const temp:Vector.<Component> = this.$queue;
				this.$queue = this.$delayedQueue;
				this.$delayedQueue = temp;
			}
			this.$validating = false;
		}
		
		public static function getInstance():ValidationQueue {
			return instance ||= new ValidationQueue(new Singleton());
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function get tickabled():Boolean {
			return true;
		}
		
		public function set tickabled(value:Boolean):void {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}

final class Singleton { }