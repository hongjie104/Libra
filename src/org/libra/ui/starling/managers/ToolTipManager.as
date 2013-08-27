package org.libra.ui.starling.managers {
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import org.libra.ui.starling.core.IComponent;
	import starling.display.DisplayObject;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ToolTipManager
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/04/2012
	 * @version 1.0
	 * @see
	 */
	public final class ToolTipManager {
		
		private static var helpPoint:Point = new Point();
		
		private static var instance:ToolTipManager;
		
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
		
		/**
		 * '0' 代表鼠标事件, 正数用于touch事件。
		 */
		private var touchPointID:int = -1;
		
		/**
		 * 当鼠标移入控件时，200毫秒后才出现toolTip
		 * 此时touchPointID的值仍然为-1，为了判断是不是在200毫秒内，
		 * 故申明了一个记录临时的touchPointID的变量tmpTouchPointID
		 * 当2toolTip添加到舞台后，将tmpTouchPointID赋值给touchPointID
		 */
		private var tmpTouchPointID:int = -1;
		
		/**
		 * 仍然是200毫秒的原因。
		 * 在toolTip被添加到舞台后，需要使用touch来计算当前鼠标的坐标
		 */
		private var touch:Touch;
		
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
		 * @param	toolTipTarget 组件
		 * @param	toolTip 提示组件，若为null，则删除组件的提示组件
		 */
		public function setToolTip(toolTipTarget:IComponent, toolTip:IComponent):void { 
			if (toolTip) {
				if (!tiggerToolTipMap[toolTipTarget]) {
					toolTipTarget.addEventListener(TouchEvent.TOUCH, onTouch);
				}
				tiggerToolTipMap[toolTipTarget] = toolTip;
			}else {
				if (tiggerToolTipMap[toolTipTarget]) {
					toolTipTarget.removeEventListener(TouchEvent.TOUCH, onTouch);
					tiggerToolTipMap[toolTipTarget] = null;
				}
			}
		}
		
		public static function getInstance():ToolTipManager {
			return instance ||= new ToolTipManager(new Singleton());
		}
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 显示提示框
		 */
		private function showCustomToolTip():void {
			//当tooltip加入到舞台之后，进行初始化
			currentToolTip.addEventListener(Event.ADDED_TO_STAGE, onToopTipAddToStage);
			updateToolTipLocation();
			UIManager.getInstance().starlingRoot.stage.addChild(currentToolTip as DisplayObject);
			touchPointID = tmpTouchPointID;
		}
		
		/**
		 * 移除提示框
		 */
		private function hideCustomToolTip():void {
			currentToolTip.removeFromParent();
			currentToolTip = null;
			this.timer.reset();
			tmpTouchPointID = touchPointID = -1;
		}
		
		private function updateToolTipLocation():void {
			var stage:Stage = UIManager.getInstance().starlingRoot.stage;
			touch.getLocation(stage, helpPoint);
			var x:int = helpPoint.x + 6;
			var y:int = helpPoint.y + 6;
			if (x + currentToolTip.width + 6 > stage.stageWidth) x = stage.stageWidth - currentToolTip.width - 6;
			if (y + currentToolTip.height + 6 > stage.stageHeight) y = stage.stageHeight - currentToolTip.height - 6;
			currentToolTip.x = x;
			currentToolTip.y = y;
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
		
		private function onTouch(e:TouchEvent):void {
			var displayObject:DisplayObject = e.currentTarget as DisplayObject;
			var touch:Touch = e.getTouch(displayObject);
			if (touch) {
				this.touch = touch;
				this.toolTipTarget = e.currentTarget as IComponent;
				if (touchPointID >= 0 || tmpTouchPointID >= 0) {
					if (touchPointID >= 0) {
						if (touch.phase == TouchPhase.HOVER) {
							touch.getLocation(displayObject, helpPoint);
							ScrollRectManager.adjustTouchLocation(helpPoint, displayObject);
							var isInBounds:Boolean = toolTipTarget.hitTest(helpPoint, true) != null;
							if (isInBounds) {
								//在控件上移动，tooltip也跟着动
								updateToolTipLocation();
							}else {
								hideCustomToolTip();
							}
						}else if (touch.phase == TouchPhase.BEGAN) {
							hideCustomToolTip();
						}
					}
				}else {
					if (touch.phase == TouchPhase.HOVER) {
						//开始计时，200毫秒后控件出现
						if (toolTipTarget) {
							var toolTip:IComponent = tiggerToolTipMap[toolTipTarget] as IComponent;
							if (toolTip) { 
								if (currentToolTip) {
									if (currentToolTip != toolTip) {
										currentToolTip.removeFromParent();
									}
								}
								currentToolTip = toolTip;
								this.timer.start();
								tmpTouchPointID = touch.id;
							}
						}
					}
				}
			}else {
				hideCustomToolTip();
			}
		}
		
		private function onToopTipAddToStage(e:Event):void {
			currentToolTip.removeEventListener(Event.ADDED_TO_STAGE, onToopTipAddToStage);
			//初始化一下ToolTip
			toolTipTarget.initToolTip();
		}
	}

}
final class Singleton{}