package org.libra.ui.flash.managers {
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.libra.ui.flash.interfaces.IDragable;
	import org.libra.ui.flash.interfaces.IDropable;
	import org.libra.ui.managers.UIManager;
	/**
	 * <p>
	 * 拖放管理类
	 * </p>
	 *
	 * @class DragManager
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/02/2012
	 * @version 1.0
	 * @see
	 */
	public final class DragManager {
		
		/**
		 * 只有Sprite才有startDrag stopDrag方法，所以申明为Sprite类型
		 */
		private static var dragSprite:Sprite;
		
		/**
		 * 拖动组件时呈现的Bitmap,放在dragSprite里
		 * 只要修改其bitmapData，就能呈现出不同的图案
		 */
		private static var dragBitmap:Bitmap;
		
		/**
		 * 被拖放的组件
		 */
		private static var dragComponent:IDragable;
		
		static private var dropComponent:IDropable;
		
		/**
		 * 开始拖动组件时的坐标
		 */
		private static var startPoint:Point;
		
		public function DragManager() {
			throw new Error('DragManager类不能实例化!');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function startDrag(dragComponent:IDragable):void {
			if (!dragBitmap) {
				dragBitmap = new Bitmap();
				dragSprite = new Sprite();
				dragSprite.addChild(dragBitmap);
			}
			
			DragManager.dragComponent = dragComponent;
			
			//获取组件拖动时的bitmapdata
			dragBitmap.bitmapData = dragComponent.getDragBmd();
			
			const stage:Stage = UIManager.getInstance().getStage();
			startPoint = dragComponent.parent.localToGlobal(new Point(dragComponent.x, dragComponent.y));
			dragSprite.x = startPoint.x;
			dragSprite.y = startPoint.y;
			stage.addChild(dragSprite);
			
			dragSprite.startDrag();
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 获取当前鼠标坐标下的容器
		 * @param	pos 当前鼠标坐标
		 * @return 容器
		 */
		private static function getAcceptContainer(pos:Point):IDropable {
			const targets:Array = UIManager.getInstance().getStage().getObjectsUnderPoint(pos);
			var l:int = targets.length;
			var con:IDropable;
			while (--l > -1) {
				if (targets[l] is IDropable) {
					con = targets[l] as IDropable;
					//先判断一下，鼠标点是否点击到了容器上。
					//if (con.isMouseHitMe(pos)) {
						if (con.isDropAccept(dragComponent)) {
							return con;
						}
					//}
				}
			}
			return null;
		}
		
		/**
		 * 停止拖动，播放动画
		 */
		public static function stopDrag():void {
			UIManager.getInstance().getStage().removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			UIManager.getInstance().getStage().removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			dragSprite.stopDrag();
			playMotion();
		}
		
		/**
		 * 播放动画
		 */
		static private function playMotion():void {
			if (dropComponent) {
				//拖拽成功
				//dragInitiator.dragSuccess();
				//如果成功拖放了，就直接移除拖放图案的托
				dragSprite.parent.removeChild(dragSprite);
				dropComponent.addDragComponent(dragComponent);
			}else {
				//拖拽失败
				//dragInitiator.dragFail();
				//如果组件不被容器所接受，那么播放失败动画
				var t:TweenLite = TweenLite.to(dragSprite, .5, { x:startPoint.x, y:startPoint.y, ease:Linear.easeNone, 
					onComplete:function():void { t.kill(); dragSprite.parent.removeChild(dragSprite); }} );
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		static private function onMouseMoveHandler(e:MouseEvent):void {
			dropComponent = getAcceptContainer(new Point(e.stageX, e.stageY));
		}
		
		static private function onMouseUpHandler(e:MouseEvent):void {
			stopDrag();
		}
	}

}