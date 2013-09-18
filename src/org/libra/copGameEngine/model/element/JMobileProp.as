package org.libra.copGameEngine.model.element {
	import com.adobe.errors.IllegalStateError;
	import flash.geom.Point;
	import org.libra.aStar.Node;
	import org.libra.copGameEngine.component.IBitmapDataRender;
	import org.libra.copGameEngine.component.JMultiBitmapDataRender;
	import org.libra.copGameEngine.constants.Direction;
	import org.libra.utils.displayObject.Display45Util;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JMobileProp
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 09/04/2013
	 * @version 1.0
	 * @see
	 */
	public class JMobileProp extends JAnimationProp {
		
		protected var $movePath:Vector.<Node>;
		
		protected var $moveSpeed:int = 5;
		
		/**
		 * 速度的平方。
		 */
		protected var $moveSpeed2:int = 25;
		
		protected var $totalMoveStep:int;
		
		protected var $curMoveStep:int;
		
		protected var $moveing:Boolean;
		
		protected var $dir:int;
		
		public function JMobileProp(width:int, height:int, bitmapDataRender:JMultiBitmapDataRender) {
			super(width, height, bitmapDataRender);
			$dir = Direction.RIGHT_DOWN;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function startMove(path:Vector.<Node>):void {
			$movePath = path;
			$totalMoveStep = path.length;
			$curMoveStep = 0;
			$moveing = true;
		}
		
		public function stopMove():void { 
			$moveing = false;
		}
		
		override public function tick(interval:int):void {
			super.tick(interval);
			if ($moveing) {
				move();
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function move():void { 
			if ($movePath.length) {
				//const targetX:Number = $movePath[step].x * cellSize + (cellSize >> 1);//根据节点列号求得屏幕坐标
				//const targetY:Number = $movePath[step].y * cellSize + (cellSize >> 1);//根据节点行号求得屏幕坐标
				const p:Point = Display45Util.getItemPos($movePath[$curMoveStep].y, $movePath[$curMoveStep].x);
				const targetX:Number = p.x;
				const targetY:Number = p.y;
				const dx:Number = targetX - this.$bitmap.x;
				const dy:Number = targetY - this.$bitmap.y;
				const dist:Number = dx * dx + dy * dy;
				
				//到达当前目的地
				if (dist < $moveSpeed2) { 
					$curMoveStep += 1;
					//已到最后一个目的地，则停下
					if($curMoveStep >= $totalMoveStep) {
						$bitmap.x = targetX;
						$bitmap.y = targetY;
						stopMove();
						return;
					}
					//未到最后一个目的地，则在step++后重头进行行走逻辑
					else {
						move();
					}
				}
				//行走
				else {
					var angle:Number = Math.atan2(dy, dx);
					var speedX:int = $moveSpeed * Math.cos(angle);
					var speedY:int = $moveSpeed * Math.sin(angle);
					$bitmap.x += speedX;
					$bitmap.y += speedY;
				}
			}else {
				stopMove();
			}
		}
		
		public function get dir():int {
			return $dir;
		}
		
		public function set dir(value:int):void {
			$dir = value;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}