package org.libra.ui.flash.managers {
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.libra.ui.flash.interfaces.IDragabled;
	import org.libra.ui.flash.interfaces.IDropabled;
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
		private static var _dragSprite:Sprite;
		
		/**
		 * 拖动组件时呈现的Bitmap,放在dragSprite里
		 * 只要修改其bitmapData，就能呈现出不同的图案
		 */
		private static var _dragBitmap:Bitmap;
		
		/**
		 * 被拖放的组件
		 */
		private static var _dragComponent:IDragabled;
		
		static private var _dropComponent:IDropabled;
		
		/**
		 * 开始拖动组件时的坐标
		 */
		private static var _startPoint:Point;
		
		public function DragManager() {
			throw new Error('DragManager类不能实例化!');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function startDrag(_dragComponent:IDragabled):void {
			if (!_dragBitmap) {
				_dragBitmap = new Bitmap();
				_dragSprite = new Sprite();
				_dragSprite.addChild(_dragBitmap);
			}
			
			DragManager._dragComponent = _dragComponent;
			
			//获取组件拖动时的bitmapdata
			if (_dragBitmap.bitmapData) _dragBitmap.bitmapData.dispose();
			_dragBitmap.bitmapData = _dragComponent.dragBmd;
			
			const stage:Stage = UIManager.instance.stage;
			_startPoint = _dragComponent.parent.localToGlobal(new Point(_dragComponent.x, _dragComponent.y));
			_dragSprite.x = _startPoint.x;
			_dragSprite.y = _startPoint.y;
			stage.addChild(_dragSprite);
			
			_dragSprite.startDrag();
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
		private static function getAcceptContainer(pos:Point):IDropabled {
			const targets:Array = UIManager.instance.stage.getObjectsUnderPoint(pos);
			var l:int = targets.length;
			var con:IDropabled;
			while (--l > -1) {
				if (targets[l] is IDropabled) {
					con = targets[l] as IDropabled;
					//先判断一下，鼠标点是否点击到了容器上。
					//if (con.isMouseHitMe(pos)) {
						if (con.isDropAccept(_dragComponent)) {
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
			UIManager.instance.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			UIManager.instance.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			_dragSprite.stopDrag();
			playMotion();
		}
		
		/**
		 * 播放动画
		 */
		static private function playMotion():void {
			if (_dropComponent) {
				//拖拽成功
				//dragInitiator.dragSuccess();
				//如果成功拖放了，就直接移除拖放图案的托
				_dragSprite.parent.removeChild(_dragSprite);
				_dropComponent.addDragComponent(_dragComponent);
			}else {
				//拖拽失败
				//dragInitiator.dragFail();
				//如果组件不被容器所接受，那么播放失败动画
				var t:TweenLite = TweenLite.to(_dragSprite, .5, { x:_startPoint.x, y:_startPoint.y, ease:Linear.easeNone, 
					onComplete:function():void { t.kill(); _dragSprite.parent.removeChild(_dragSprite); }} );
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		static private function onMouseMoveHandler(e:MouseEvent):void {
			_dropComponent = getAcceptContainer(new Point(e.stageX, e.stageY));
		}
		
		static private function onMouseUpHandler(e:MouseEvent):void {
			stopDrag();
		}
	}

}