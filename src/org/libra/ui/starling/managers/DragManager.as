package org.libra.ui.starling.managers {
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import org.libra.log4a.Logger;
	import org.libra.ui.starling.core.IDragable;
	import org.libra.ui.starling.core.IDropable;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.MatrixUtil;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class DragManager
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/04/2012
	 * @version 1.0
	 * @see
	 */
	public final class DragManager {
		
		/**
		 * 拖拽过程中，被添加到舞台上的可视对象。
		 */
		private static var dragImage:Image;
		
		/**
		 * 被拖拽的控件
		 */
		private static var dragComponent:IDragable;
		
		private static var dropComponent:IDropable;
		
		static private var startPoint:Point = new Point();
		
		static private var helpPoint:Point = new Point();
		
		static private var helpMatrix:Matrix = new Matrix();
		
		static private var helpRect:Rectangle = new Rectangle();
		
		private static var stage:Stage;
		
		public function DragManager() {
			throw new Error(getQualifiedClassName(this) + '不能实例化!');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function startDrag(dragComponent:IDragable):void {
			DragManager.dragComponent = dragComponent;
			if (dragImage) {
				dragImage.texture = dragComponent.getDragTexture();
			}else {
				dragImage = new Image(dragComponent.getDragTexture());
				dragImage.touchable = false;
			}
			stage = UIManager.getInstance().starlingRoot.stage;
			dragComponent.parent.localToGlobal(new Point(dragComponent.x, dragComponent.y), startPoint);
			dragImage.x = startPoint.x;
			dragImage.y = startPoint.y;
			stage.addChild(dragImage);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 停止拖动，播放动画
		 */
		private static function stopDrag():void {
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			dragImage.removeFromParent();
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
				/*dragSprite.parent.removeChild(dragSprite);
				dropComponent.addDragComponent(dragComponent);*/
				Logger.info('拖拽成功');
			}else {
				//拖拽失败
				//dragInitiator.dragFail();
				//如果组件不被容器所接受，那么播放失败动画
				/*var t:TweenLite = TweenLite.to(dragSprite, .5, { x:startPoint.x, y:startPoint.y, ease:Linear.easeNone, 
					onComplete:function():void { t.kill(); dragSprite.parent.removeChild(dragSprite); }} );*/
				Logger.info('拖拽失败');
			}
		}
		
		private static function getDropComponentUnderPoint(container:DisplayObjectContainer, p:Point):IDropable {
			var localX:Number = p.x;
            var localY:Number = p.y;
			
			var child:DisplayObject;
			var dropComponent:IDropable;
			var target:IDropable;
			var numChildren:int = container.numChildren;
			for (var i:int = numChildren - 1; i >= 0;--i) { // front to back!
				child = container.getChildAt(i);
				if (child is DisplayObjectContainer) {
					target = getDropComponentUnderPoint(child as DisplayObjectContainer, p);
					if (target) return target;
				}
				dropComponent = child as IDropable;
				if (dropComponent) {
					if (dropComponent.isDropAccept(dragComponent)) {
						container.getTransformationMatrix(child, helpMatrix);
						MatrixUtil.transformCoords(helpMatrix, localX, localY, helpPoint);
						target = hitTest(child, p);
						if (target) return target;
					}
				}
			}
			return null;
		}
		
		private static function hitTest(displayObject:DisplayObject, p:Point):IDropable {
			if (!displayObject.visible || !displayObject.touchable) return null;
			if (displayObject.getBounds(displayObject, helpRect).containsPoint(p)) return displayObject as IDropable;
			return null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		static private function onTouch(e:TouchEvent):void {
			var touch:Touch = e.getTouch(stage);
			if (touch) {
				if (touch.phase == TouchPhase.MOVED) {
					touch.getMovement(stage, helpPoint);
					dragImage.x += helpPoint.x;
					dragImage.y += helpPoint.y;
					dropComponent = getDropComponentUnderPoint(stage, touch.getLocation(stage, helpPoint));
				}else if (touch.phase == TouchPhase.ENDED) {
					stopDrag();
				}
			}
		}
	}

}