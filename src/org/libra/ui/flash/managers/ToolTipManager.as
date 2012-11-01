package org.libra.ui.flash.managers {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.libra.ui.interfaces.IComponent;
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
		private static var instance:ToolTipManager = null;
		
		/**
		 * 存放组件对应的提示组件的集合
		 */
		private var tiggerToolTipMap:Dictionary;
		
		/**
		 * 当前提示组件
		 */
		private var currentToolTip:IComponent;
		
		/**
		 * 时间类，用于计算鼠标进入组件多少时间后开始显示提示框
		 */
		private var timer:Timer;
		
		/**
		 * 显示ToolTip的目标组件
		 */
		private var toolTipTarget:IComponent;
		
		public function ToolTipManager(singleton:Singleton) {
			tiggerToolTipMap = new Dictionary(true);
			//鼠标进入组件后，间隔一段时间后，显示toolTip
			//默认是200毫秒
			timer = new Timer(200, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleted);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 设置组件的提示组件
		 * @param	toolTipEnabled 组件
		 * @param	toolTip 提示组件，若为null，则删除组件的提示组件
		 */
		public function setToolTip(toolTipEnabled:IComponent, toolTip:IComponent):void { 
			if (toolTip) {
				if (!tiggerToolTipMap[toolTipEnabled]) {
					toolTipEnabled.addEventListener(MouseEvent.ROLL_OVER, onTriggerOverHandler, false, 0, true);
					toolTipEnabled.addEventListener(MouseEvent.ROLL_OUT, onTriggerOutHandler, false, 0, true);
					toolTipEnabled.addEventListener(MouseEvent.MOUSE_DOWN, onTriggerOutHandler, false, 0, true);
				}
				tiggerToolTipMap[toolTipEnabled] = toolTip;
			}else {
				if (tiggerToolTipMap[toolTipEnabled]) {
					toolTipEnabled.removeEventListener(MouseEvent.ROLL_OVER, onTriggerOverHandler);
					toolTipEnabled.removeEventListener(MouseEvent.ROLL_OUT, onTriggerOutHandler);
					toolTipEnabled.removeEventListener(MouseEvent.MOUSE_DOWN, onTriggerOutHandler);
					tiggerToolTipMap[toolTipEnabled] = null;
				}
			}
		}
		
		/**
		 * 获取该类实例
		 * @return
		 */
		public static function getInstance():ToolTipManager {
			return instance ||= new ToolTipManager(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
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
		 * 显示提示框
		 */
		private function showCustomToolTip():void {
			UIManager.getInstance().stage.addChild(currentToolTip as DisplayObject);
			onMouseMove(null);
			UIManager.getInstance().stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			/*
			//让ToolTip出现在物品的下方，且居中显示
			var targetPoint:Point = toolTipTarget.localToGlobal(new Point(toolTipTarget.x, toolTipTarget.y));
			currentToolTip.x = targetPoint.x + (toolTipTarget.getWidth() >> 1) - (currentToolTip.getWidth() >> 1);
			currentToolTip.y = targetPoint.y + toolTipTarget.getHeight() + 2;
			if (currentToolTip.x < 0) currentToolTip.x = 0;
			else if (currentToolTip.x + currentToolTip.getWidth() > main.stage.stageWidth)
				currentToolTip.x = main.stage.stageWidth - currentToolTip.getWidth();
			if (currentToolTip.y + currentToolTip.getHeight() > main.stage.stageHeight) {
				currentToolTip.y = main.stage.stageHeight - currentToolTip.getHeight();
			}*/
		}
		
		/**
		 * 移除提示框
		 */
		private function hideCustomToolTip():void {
			UIManager.getInstance().stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			if (!this.timer.running) {
				if(currentToolTip.parent)
					currentToolTip.parent.removeChild(currentToolTip as DisplayObject);
			}
			this.timer.reset();
			currentToolTip = null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		/**
		 * 鼠标移出组件后，移除提示框
		 * @param	e
		 */
		private function onTriggerOutHandler(e:MouseEvent):void {
			var toolTip:IComponent = tiggerToolTipMap[e.currentTarget] as IComponent;
			if(toolTip){
				if (toolTip == currentToolTip) {
					hideCustomToolTip();
				}
			}
		}
		
		/**
		 * 鼠标进入组件后，开始计时，时间到了就调用showCustomToolTip方法
		 * @param	e
		 */
		private function onTriggerOverHandler(e:MouseEvent):void {
			this.toolTipTarget = e.currentTarget as IComponent;
			if (toolTipTarget) {
				//初始化一下ToolTip
				var toolTip:IComponent = tiggerToolTipMap[toolTipTarget] as IComponent;
				if (toolTip) { 
					toolTipTarget.initToolTip();
					if (currentToolTip) {
						if (currentToolTip != toolTip) {
							if (currentToolTip.parent)
								currentToolTip.parent.removeChild(currentToolTip as DisplayObject);
						}
					}
					currentToolTip = toolTip;
					this.timer.start();
				}
			}
		}
		
		private function onMouseMove(e:MouseEvent):void {
			const stage:Stage = UIManager.getInstance().stage;
			currentToolTip.x = stage.mouseX + 10;
			currentToolTip.y = stage.mouseY;
			if (currentToolTip.x + currentToolTip.width > stage.stageWidth - 10) {
				currentToolTip.x = stage.stageWidth - currentToolTip.width - 10;
			}
			if (currentToolTip.y + currentToolTip.height > stage.stageHeight - 10) {
				currentToolTip.y = stage.stageHeight - currentToolTip.height - 10;
			}
		}
	}

}
class Singleton{}