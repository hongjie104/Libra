package org.libra.game {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.libra.game.interfaces.ILayer;
	import org.libra.game.interfaces.IMoveable;
	
	/**
	 * <p>
	 * 摄像机
	 * </p>
	 *
	 * @class Camera
	 * @author Eddie
	 * @qq 32968210
	 * @date 10-24-2011
	 * @version 1.0
	 * @see
	 */
	public class Camera {
		
		/**
		 * 所在的层
		 */
		private var layer:ILayer;
		
		/**
		 * 当前左上角坐标 
		 */
		private var position:Point;
		
		/**
		 * 追踪目标
		 */
		private var target:IMoveable;
		
		/**
		 * 屏幕大小 
		 */
		private var screenRect:Rectangle;
		
		/**
		 * 场景大小 
		 */
		private var sceneRect:Rectangle;
		
		/**
		 * 摄像机覆盖范围
		 */
		private var cameraRect:Rectangle;
		
		/**
		 * 
		 * @param	layer 可见层
		 * @param	screenRect 屏幕的大小
		 * @param	sceneRect 场景的大小
		 */
		public function Camera(layer:ILayer, screenRect:Rectangle, sceneRect:Rectangle) { 
			this.layer = layer;
			this.screenRect = screenRect;
			this.sceneRect = sceneRect;
			this.position = new Point();
			
			cameraRect = new Rectangle(0, 0, screenRect.width, screenRect.height);
		}
	
		/*-----------------------------------------------------------------------------------------
		   Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function getCameraRect():Rectangle {
			return cameraRect;
		}
		
		public function getSceneRect():Rectangle {
			return this.sceneRect;
		}
		
		public function render():void {
			if (target && target.isMoveing())
				updateTargetPosition();
			
			this.layer.x = -this.position.x;
			this.layer.y = -this.position.y;
		}
		
		public function setTarget(target:IMoveable):void {
			this.target = target;
			if (this.target) updateTargetPosition();
		}
		
		//public function setSceneRectWidth(w:int):void {
			//this.sceneRect.width = w;
			//if(this.target)
				//updateTargetPosition();
		//}
		
		/*-----------------------------------------------------------------------------------------
		   Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function updateTargetPosition():void {
			var x:int = target.x;
			var y:int = target.y;
			x -= screenRect.width >> 1;
			y -= screenRect.height >> 1;
			
			var w:int = sceneRect.right - screenRect.width;
			var h:int = sceneRect.bottom - screenRect.height;
			x = x < sceneRect.x ? sceneRect.x : x > w ? w : x;
			y = y < sceneRect.y ? sceneRect.y : y > h ? h : y;
			this.setPosition(x, y);
		}
		
		private function setPosition(x:int, y:int):void {
			this.position.x = x;
			this.position.y = y;
			this.cameraRect.x = x;
			this.cameraRect.y = y;
		}
		
		/*-----------------------------------------------------------------------------------------
		   Event Handlers
		-------------------------------------------------------------------------------------------*/
	
	}

}