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
		
		protected var _movePath:Vector.<Node>;
		
		protected var _moveSpeed:int = 5;
		
		/**
		 * 速度的平方。
		 */
		protected var _moveSpeed2:int = 25;
		
		protected var _totalMoveStep:int;
		
		protected var _curMoveStep:int;
		
		protected var _moveing:Boolean;
		
		protected var _dir:int;
		
		public function JMobileProp(width:int, height:int, bitmapDataRender:JMultiBitmapDataRender) {
			super(width, height, bitmapDataRender);
			_dir = Direction.RIGHT_DOWN;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function startMove(path:Vector.<Node>):void {
			_movePath = path;
			_totalMoveStep = path.length;
			_curMoveStep = 0;
			_moveing = true;
		}
		
		public function stopMove():void { 
			_moveing = false;
		}
		
		override public function tick(interval:int):void {
			super.tick(interval);
			if (_moveing) {
				move();
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function move():void { 
			if (_movePath.length) {
				//const targetX:Number = _movePath[step].x * cellSize + (cellSize >> 1);//根据节点列号求得屏幕坐标
				//const targetY:Number = _movePath[step].y * cellSize + (cellSize >> 1);//根据节点行号求得屏幕坐标
				const p:Point = Display45Util.getItemPos(_movePath[_curMoveStep].y, _movePath[_curMoveStep].x);
				const targetX:Number = p.x;
				const targetY:Number = p.y;
				const dx:Number = targetX - this._bitmap.x;
				const dy:Number = targetY - this._bitmap.y;
				const dist:Number = dx * dx + dy * dy;
				
				//到达当前目的地
				if (dist < _moveSpeed2) { 
					_curMoveStep += 1;
					//已到最后一个目的地，则停下
					if(_curMoveStep >= _totalMoveStep) {
						_bitmap.x = targetX;
						_bitmap.y = targetY;
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
					var speedX:int = _moveSpeed * Math.cos(angle);
					var speedY:int = _moveSpeed * Math.sin(angle);
					_bitmap.x += speedX;
					_bitmap.y += speedY;
				}
			}else {
				stopMove();
			}
		}
		
		public function get dir():int {
			return _dir;
		}
		
		public function set dir(value:int):void {
			_dir = value;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}