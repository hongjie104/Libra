package org.libra.ui.starling.core {
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ValidationQueue
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/27/2012
	 * @version 1.0
	 * @see
	 */
	public final class ValidationQueue implements IAnimatable {
		
		private static var instance:ValidationQueue;
		
		private var validating:Boolean;
		
		private var delayedQueue:Vector.<Component>;
		
		private var queue:Vector.<Component>;
		
		public function ValidationQueue(singleton:Singleton) {
			delayedQueue = new Vector.<Component>();
			queue = new Vector.<Component>();
			Starling.juggler.add(this);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function addControl(control:Component, delayIfValidating:Boolean):void {
			const currentQueue:Vector.<Component> = (this.validating || delayIfValidating) ? this.delayedQueue : this.queue;
			const queueLength:int = currentQueue.length;
			const containerControl:DisplayObjectContainer = control as DisplayObjectContainer;
			for(var i:int = 0; i < queueLength; i++) {
				var item:DisplayObject = currentQueue[i] as DisplayObject;
				if(control == item && currentQueue == this.queue) {
					//already queued
					return;
				}
				if(containerControl && containerControl.contains(item)) {
					break;
				}
			}
			currentQueue.splice(i, 0, control);
		}
		
		/* INTERFACE starling.animation.IAnimatable */
		
		public function advanceTime(time:Number):void {
			this.validating = true;
			
			const l:int = queue.length;
			var count:int = 0;
			while(count < l) {
				this.queue[count++].validate();
			}
			queue.length = 0;
			
			/*while(this.queue.length) {
				var item:Component = this.queue.shift();
				item.validate();
			}*/
			const temp:Vector.<Component> = this.queue;
			this.queue = this.delayedQueue;
			this.delayedQueue = temp;
			this.validating = false;
		}
		
		public static function getInstance():ValidationQueue {
			return instance ||= new ValidationQueue(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
class Singleton{}