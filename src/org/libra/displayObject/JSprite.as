package org.libra.displayObject {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import org.libra.displayObject.interfaces.ISprite;
	/**
	 * <p>
	 * 给Sprite稍微加上一些常用的方法
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
		 * @private
		 */
		private var _eventListeners:Dictionary;
		
		/**
		 * 构造函数
		 */
		public function JSprite() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void { 
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			if(!_eventListeners)
				_eventListeners = new Dictionary();
			//将添加的事件侦听器侦听事件类型以及事件处理函数保存起来全部事件侦听函数
			//都保存在一个数组中，这个数组可以通过_eventListeners[事件类型]来访问
			if (!_eventListeners[type]) 
				_eventListeners[type] = new Vector.<Function>();
			//防止重复
			if(_eventListeners[type].indexOf(listener) == -1)
				_eventListeners[type].push(listener);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void { 
			super.removeEventListener(type, listener, useCapture);
			//查询需要移除的事件类型对应侦听器是否存在，若存在则从记录中移除
			if (_eventListeners[type]) { 
				//查询欲移除的侦听函数是否存在于记录中，若存在则移除
				var index:int = _eventListeners[type].indexOf(listener);
				if (index != -1) { 
					_eventListeners[type].splice(index, 1);
					//若一个事件的全部侦听器都移除完毕，则在记录本中将记录该事件的数组移去
					if(!_eventListeners[type].length)
						delete _eventListeners[type];
				}
			}
		}
		
		/**
		 * 移除全部事件侦听器
		 */
		public function removeAllEventListener():void { 
			for (var event:String in _eventListeners) { 
				for each(var listener:Function in _eventListeners[event]) { 
					removeEventListener(event, listener);
				}
			}
			_eventListeners = new Dictionary();
		}
		
		/* INTERFACE org.libra.displayObject.interfaces.ISprite */
		
		/**
		 * 从父容器中移除自己
		 * @param	dispose 移除时是否销毁自己,默认为false
		 * @default false
		 */
		public function removeFromParent(dispose:Boolean = false):void {
			if (this.parent) {
				this.parent.removeChild(this);
				if (dispose) this.dispose();
			}
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			if(child.parent == this)
				return super.removeChild(child);
			return null;
		}
		
		override public function removeChildAt(index:int):DisplayObject {
			if (index > this.numChildren - 1) return null;
			return super.removeChildAt(index);
		}
		
		/**
		 * 释放内存
		 */
		public function dispose():void {
			removeAllEventListener();
			removeChildren();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 加入到舞台上的事件
		 * @private
		 * @param	e
		 */
		protected function onAddToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		/**
		 * 从舞台移除的事件
		 * @private
		 * @param	e
		 */
		protected function onRemoveFromStage(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
	}

}