package org.libra.aStar {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.utils.GraphicsUtil;
	import org.libra.utils.MathUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class AStarTest
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-11-2012
	 * @version 1.0
	 * @see
	 */
	public final class AStarTest extends Sprite {
		
		private var cellSize:int;
		
		private var cols:int;
		
		private var rows:int;
		
		private var player:Sprite;
		
		private var path:Array;
		
		private var moveSpeed:int = 5;
		
		/**
		 * 速度的平方。
		 */
		private var moveSpeed2:int = 25;
		
		private var totalStep:int;
		
		private var step:int;
		
		public function AStarTest() {
			super();
			player = new Sprite();
			player.graphics.beginFill(0xff0000);
			player.graphics.drawCircle(0, 0, 5);
			player.graphics.endFill();
			this.addChild(player);
			
			cellSize = 20;
			cols = rows = 30;
			drawGrid();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSize(rows:int, cols:int):void {
			this.rows = rows;
			this.cols = cols;
			drawGrid();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function drawGrid():void {
			player.x = cellSize >> 1;
			player.y = cellSize >> 1;
			
			AStar.getInstance().setSize(cols, rows);
			handler = AStar.getInstance().getGrid().setWalkable;
			//随机生成200个障碍点
			for (var i:int = 0; i < 200; i++) { 
				handler(MathUtil.floor(Math.random() * cols),
					MathUtil.floor(Math.random() * rows), false);
			}
			
			var w:int = cols * cellSize;
			var h:int = rows * cellSize;
			var g:Graphics = this.graphics;
			GraphicsUtil.drawRect(g, 0, 0, w, h, 0, 0);
			g.lineStyle(1, 0);
			var tmp:int = cellSize;
			for (i = 0; i < rows; i += 1 ) {
				g.moveTo(0, tmp);
				g.lineTo(w, tmp);
				tmp += cellSize;
			}
			tmp = cellSize;
			for (i = 0; i < cols; i += 1 ) {
				g.moveTo(tmp, 0);
				g.lineTo(tmp, h);
				tmp += cellSize;
			}
			var handler:Function = AStar.getInstance().getGrid().isWalkable;
			for (var row:int = 0; row < rows; row += 1) {
				for (var col:int = 0; col < cols; col += 1 ) {
					if (!handler(col, row)) 
						GraphicsUtil.drawRect(g, col * cellSize, row * cellSize, cellSize, cellSize, 0xff0000, 1.0, false);
				}
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		private function onAddToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			this.addEventListener(MouseEvent.CLICK, onClicked);
		}
		
		private function onRemoveFromStage(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.removeEventListener(MouseEvent.CLICK, onClicked);
		}
		
		private function onClicked(e:MouseEvent):void {
			var grid:Grid = AStar.getInstance().getGrid();
			var startPosX:int = int(player.x / cellSize);
			var startPosY:int = int(player.y / cellSize);
			var startNode:Node = grid.getNode(startPosX, startPosY);
			if (!startNode) return;
			
			var endPosX:int = int(e.localX / cellSize);
			var endPosY:int = int(e.localY / cellSize);
			var endNode:Node = grid.getNode(endPosX, endPosY);
			if (!endNode) return;
			
			if(!endNode.walkable) {
				var replacer:Node = grid.findReplacer(startNode, endNode);
				if(replacer) {
					endPosX = replacer.x;
					endPosY = replacer.y;
				}
			}
			grid.setStartNode(startPosX, startPosY);
			grid.setEndNode(endPosX, endPosY);
			
			var aStar:AStar = AStar.getInstance();
			if (aStar.findPath()) { 
				//得到平滑路径
				aStar.floyd();
				//在路径中去掉起点节点，避免玩家对象走回头路
				aStar.floydPath.shift();
				
				path = aStar.floydPath;
				//path = aStar.path;
				totalStep = path.length;
				step = 0;
				if(totalStep)
					addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		private function onEnterFrame(e:Event):void {
			if (!path.length) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				return;
			}
			var targetX:Number = path[step].x * cellSize + (cellSize >> 1);//根据节点列号求得屏幕坐标
			var targetY:Number = path[step].y * cellSize + (cellSize >> 1);//根据节点行号求得屏幕坐标
			var dx:Number = targetX - player.x;
			var dy:Number = targetY - player.y;
			var dist:Number = dx * dx + dy * dy;
			
			//到达当前目的地
			if (dist < moveSpeed2) { 
				step += 1;
				//已到最后一个目的地，则停下
				if(step >= totalStep) {
					player.x = targetX;
					player.y = targetY;
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					return;
				}
				//未到最后一个目的地，则在step++后重头进行行走逻辑
				else {
					onEnterFrame(null);
				}
			}
			//行走
			else {
				var angle:Number = Math.atan2(dy, dx);
				var speedX:int = moveSpeed * Math.cos(angle);
				var speedY:int = moveSpeed * Math.sin(angle);
				player.x += speedX;
				player.y += speedY;
			}
		}
	}

}