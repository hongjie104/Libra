package org.libra.ui.flash.managers {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.libra.ui.flash.interfaces.IComponent;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ToolTipManager
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/01/2012
	 * @version 1.0
	 * @see
	 */
	public final class ToolTipManager {
		
		/**
		 * 该类实例
		 */
		private static var _instance:ToolTipManager = null;
		
		/**
		 * 存放组件对应的提示组件的集合
		 */
		private var _tiggerToolTipMap:Dictionary;
		
		/**
		 * 当前提示组件
		 */
		private var _currentToolTip:IComponent;
		
		/**
		 * 时间类，用于计算鼠标进入组件多少时间后开始显示提示框
		 */
		private var _timer:Timer;
		
		/**
		 * 显示ToolTip的目标组件
		 */
		private var _toolTipTarget:IComponent;
		
		public function ToolTipManager(singleton:Singleton) {
			_tiggerToolTipMap = new Dictionary(true);
			//鼠标进入组件后，间隔一段时间后，显示toolTip
			//默认是200毫秒
			_timer = new Timer(200, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleted);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 设置组件的提示组件
		 * @param	_toolTipTarget 组件
		 * @param	toolTip 提示组件，若为null，则删除组件的提示组件
		 */
		public function setToolTip(_toolTipTarget:IComponent, toolTip:IComponent):void { 
			if (toolTip) {
				if (!_tiggerToolTipMap[_toolTipTarget]) {
					_toolTipTarget.addEventListener(MouseEvent.ROLL_OVER, onTriggerOverHandler, false, 0, true);
					_toolTipTarget.addEventListener(MouseEvent.ROLL_OUT, onTriggerOutHandler, false, 0, true);
					_toolTipTarget.addEventListener(MouseEvent.MOUSE_DOWN, onTriggerOutHandler, false, 0, true);
				}
				_tiggerToolTipMap[_toolTipTarget] = toolTip;
			}else {
				if (_tiggerToolTipMap[_toolTipTarget]) {
					_toolTipTarget.removeEventListener(MouseEvent.ROLL_OVER, onTriggerOverHandler);
					_toolTipTarget.removeEventListener(MouseEvent.ROLL_OUT, onTriggerOutHandler);
					_toolTipTarget.removeEventListener(MouseEvent.MOUSE_DOWN, onTriggerOutHandler);
					_tiggerToolTipMap[_toolTipTarget] = null;
				}
			}
		}
		
		/**
		 * 获取该类实例
		 * @return
		 */
		public static function get instance():ToolTipManager {
			return _instance ||= new ToolTipManager(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 显示提示框
		 */
		private function showCustomToolTip():void {
			UIManager.instance.stage.addChild(_currentToolTip as DisplayObject);
			onMouseMove(null);
			UIManager.instance.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			/*
			//让ToolTip出现在物品的下方，且居中显示
			var targetPoint:Point = _toolTipTarget.localToGlobal(new Point(_toolTipTarget.x, _toolTipTarget.y));
			_currentToolTip.x = targetPoint.x + (_toolTipTarget.getWidth() >> 1) - (_currentToolTip.getWidth() >> 1);
			_currentToolTip.y = targetPoint.y + _toolTipTarget.getHeight() + 2;
			if (_currentToolTip.x < 0) _currentToolTip.x = 0;
			else if (_currentToolTip.x + _currentToolTip.getWidth() > main.stage.stageWidth)
				_currentToolTip.x = main.stage.stageWidth - _currentToolTip.getWidth();
			if (_currentToolTip.y + _currentToolTip.getHeight() > main.stage.stageHeight) {
				_currentToolTip.y = main.stage.stageHeight - _currentToolTip.getHeight();
			}*/
		}
		
		/**
		 * 移除提示框
		 */
		private function hideCustomToolTip():void {
			UIManager.instance.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			if (!this._timer.running) {
				if(_currentToolTip.parent)
					_currentToolTip.parent.removeChild(_currentToolTip as DisplayObject);
			}
			this._timer.reset();
			_currentToolTip = null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 统计鼠标进入组件的时间结束事件
		 * 显示对应的提示框
		 * @param	e
		 */
		private function onTimerCompleted(e:TimerEvent):void {
			this.showCustomToolTip();
		}
		
		/**
		 * 鼠标移出组件后，移除提示框
		 * @param	e
		 */
		private function onTriggerOutHandler(e:MouseEvent):void {
			var toolTip:IComponent = _tiggerToolTipMap[e.currentTarget] as IComponent;
			if(toolTip){
				if (toolTip == _currentToolTip) {
					hideCustomToolTip();
				}
			}
		}
		
		/**
		 * 鼠标进入组件后，开始计时，时间到了就调用showCustomToolTip方法
		 * @param	e
		 */
		private function onTriggerOverHandler(e:MouseEvent):void {
			this._toolTipTarget = e.currentTarget as IComponent;
			if (_toolTipTarget) {
				//初始化一下ToolTip
				var toolTip:IComponent = _tiggerToolTipMap[_toolTipTarget] as IComponent;
				if (toolTip) { 
					_toolTipTarget.initToolTip();
					if (_currentToolTip) {
						if (_currentToolTip != toolTip) {
							if (_currentToolTip.parent)
								_currentToolTip.parent.removeChild(_currentToolTip as DisplayObject);
						}
					}
					_currentToolTip = toolTip;
					this._timer.start();
				}
			}
		}
		
		private function onMouseMove(e:MouseEvent):void {
			const stage:Stage = UIManager.instance.stage;
			_currentToolTip.x = stage.mouseX + 10;
			_currentToolTip.y = stage.mouseY;
			if (_currentToolTip.x + _currentToolTip.width > stage.stageWidth - 10) {
				_currentToolTip.x = stage.stageWidth - _currentToolTip.width - 10;
			}
			if (_currentToolTip.y + _currentToolTip.height > stage.stageHeight - 10) {
				_currentToolTip.y = stage.stageHeight - _currentToolTip.height - 10;
			}
		}
	}

}
final class Singleton{}