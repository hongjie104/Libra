package org.libra.displayObject {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import org.libra.displayObject.interfaces.ISprite;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JSprite
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/09/2012
	 * @version 1.0
	 * @see
	 */
	public class JSprite extends Sprite implements ISprite {
		
		/**
		 * 记录所有事件侦听器
		 */
		private var eventListeners:Dictionary;
		
		public function JSprite() {
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function clearChildren():void {
			while (this.numChildren > 0) this.removeChildAt(0);
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void { 
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			if(!eventListeners)
				eventListeners = new Dictionary();
			//将添加的事件侦听器侦听事件类型以及事件处理函数保存起来全部事件侦听函数
			//都保存在一个数组中，这个数组可以通过eventListeners[事件类型]来访问
			if (!eventListeners[type]) 
				eventListeners[type] = new Vector.<Function>();
			//防止重复
			if(eventListeners[type].indexOf(listener) == -1)
				eventListeners[type].push(listener);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void { 
			super.removeEventListener(type, listener, useCapture);
			//查询需要移除的事件类型对应侦听器是否存在，若存在则从记录中移除
			if (eventListeners[type]) { 
				//查询欲移除的侦听函数是否存在于记录中，若存在则移除
				var index:int = eventListeners[type].indexOf(listener);
				if (index != -1) { 
					eventListeners[type].splice(index, 1);
					//若一个事件的全部侦听器都移除完毕，则在记录本中将记录该事件的数组移去
					if(!eventListeners[type].length)
						delete eventListeners[type];
				}
			}
		}
		
		/**
		 * 移除全部事件侦听器
		 */
		public function removeAllEventListener():void { 
			for (var event:String in eventListeners) { 
				for each(var listener:Function in eventListeners[event]) { 
					removeEventListener(event, listener);
				}
			}
		}
		
		/* INTERFACE org.libra.displayObject.interfaces.ISprite */
		
		public function removeFromParent(destroy:Boolean = false):void {
			if (this.parent) {
				this.parent.removeChild(this);
				if (destroy) this.destroy();
			}
		}
		
		public function destroy():void {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		protected function onAddToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		protected function onRemoveFromStage(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
	}

}