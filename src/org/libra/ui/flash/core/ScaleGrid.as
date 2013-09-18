package org.libra.ui.flash.core {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * <p>
	 * 九宫格参考，用于UI编辑器中
	 * </p>
	 *
	 * @class ScaleGrid
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 09/17/2013
	 * @version 1.0
	 * @see
	 */
	public class ScaleGrid extends Sprite {
		
		protected var $rect:Rectangle; 
		
		protected var $leftTopCell:Cell;
		
		protected var $topCell:Cell;
		
		protected var $rightTopCell:Cell;
		
		protected var $rightCell:Cell;
		
		protected var $rightBottomCell:Cell;
		
		protected var $bottomCell:Cell;
		
		protected var $leftBottomCell:Cell;
		
		protected var $leftCell:Cell;
		
		protected var $centerCell:Cell;
		
		protected var $dragCell:Cell;
		
		protected var $component:Component;
		
		public function ScaleGrid() {
			super();
			mouseEnabled = false;
			$rect = new Rectangle();
			$leftTopCell = new Cell();
			$topCell = new Cell();
			$rightTopCell = new Cell();
			$rightCell = new Cell();
			$rightBottomCell = new Cell();
			$bottomCell = new Cell();
			$leftBottomCell = new Cell();
			$leftCell = new Cell();
			$centerCell = new Cell(12, 12);
			
			this.addChild($leftTopCell);
			this.addChild($topCell);
			this.addChild($rightTopCell);
			this.addChild($rightCell);
			this.addChild($rightBottomCell);
			this.addChild($bottomCell);
			this.addChild($leftBottomCell);
			this.addChild($leftCell);
			this.addChild($centerCell);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set component(value:Component):void {
			if (value) {
				$component = value;
				setSize($component.width, $component.height);
				$component.addChild(this);
				$component.addEventListener(Event.RESIZE, onResize);
			}else {
				if ($component) {
					$component.removeChild(this);
					$component.removeEventListener(Event.RESIZE, onResize);
					$component = null;
				}
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function setSize(w:int, h:int):void {
			this.$rect.width = w;
			this.$rect.height = h;
			this.graphics.clear();
			this.graphics.lineStyle(1,0x00ff00);
			this.graphics.moveTo(0,0);
			this.graphics.lineTo(w,0);
			this.graphics.lineTo(w,h);
			this.graphics.lineTo(0,h);
			this.graphics.lineTo(0,0);
			
			this.$leftTopCell.x = 0 - ($leftTopCell.width >> 1);
			this.$leftTopCell.y = 0 - ($leftTopCell.height >> 1);
			this.$topCell.x = (w - $topCell.width) >> 1;
			this.$topCell.y = 0 - ($topCell.height >> 1);
			this.$rightTopCell.x = w - ($rightTopCell.width >> 1);
			this.$rightTopCell.y = 0 - ($rightTopCell.height >> 1);
			this.$rightCell.x = w - ($rightCell.width >> 1);
			this.$rightCell.y = (h - $rightCell.height) >> 1;
			this.$rightBottomCell.x = w - ($rightBottomCell.width >> 1);
			this.$rightBottomCell.y = h - ($rightBottomCell.height >> 1);
			this.$bottomCell.x = (w - $bottomCell.width) >> 1;
			this.$bottomCell.y = h - ($bottomCell.height >> 1);
			this.$leftBottomCell.x = 0 - ($leftBottomCell.width >> 1);
			this.$leftBottomCell.y = h - ($leftBottomCell.height >> 1);
			this.$leftCell.x = 0 - ($leftCell.width >> 1);
			this.$leftCell.y = (h - $leftCell.height) >> 1;
			this.$centerCell.x = (w - $centerCell.width) >> 1;
			this.$centerCell.y = (h - $centerCell.height) >> 1;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onResize(e:Event):void {
			setSize($component.width, $component.height);
		}
		
		private function onCellMouseDown(e:MouseEvent):void {
			switch(e.target) {
				case $centerCell:
					this.$dragCell = null;
					$component.startDrag(false, new Rectangle(0, 0, $component.parent.width - $component.width, $component.parent.height - $component.height));
					break;
				default:
					this.$dragCell = e.target as Cell;
					this.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
					break;
			}
			this.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseMove(evt:MouseEvent):void{
			if($dragCell){
				var p:Point = this.parent.globalToLocal(new Point(evt.stageX,evt.stageY));
				var vx:Number = this.x - p.x;
				var vy:Number = this.y - p.y;
				switch(this.$dragCell){
					case $leftTopCell:
						this.x = p.x; this.y = p.y;
						this.setSize($rect.width + vx, this.$rect.height + vy);
						break;
					case $topCell:
						this.y = p.y;
						this.setSize($rect.width, this.$rect.height + vy);
						break;
					case $rightTopCell:
						this.y = p.y;
						this.setSize(0 - vx, this.$rect.height + vy);
						break;
					case $rightCell:
						this.setSize(0 - vx, this.$rect.height);
						break;
					case $rightBottomCell:
						this.setSize(0 - vx, 0 - vy);
						break;
					case $bottomCell:
						this.setSize($rect.width, 0 - vy);
						break;
					case $leftBottomCell:
						this.x = p.x;
						this.setSize($rect.width + vx, 0 - vy);
						break;
					case $leftCell:
						this.x = p.x;
						this.setSize($rect.width + vx, $rect.height);
						break;
				}
			}
		}
		
		private function onMouseUp(evt:MouseEvent):void{
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			if(this.$dragCell) {
				this.$dragCell = null;
				//九宫格大小确定后，更新组件的坐标和大小
				this.$component.x += this.x;
				this.$component.y += this.y;
				this.$component.setSize($rect.width,$rect.height);
			}else {
				$component.stopDrag();
				$component.dispatchEvent(new Event(Event.SELECT));
			}
		}
		
		private function onAddToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			$leftTopCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$topCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$rightTopCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$rightCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$rightBottomCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$bottomCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$leftBottomCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$leftCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$centerCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
		}
		
		private function onRemoveFromStage(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			$leftTopCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$topCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$rightTopCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$rightCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$rightBottomCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$bottomCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$leftBottomCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$leftCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			$centerCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
		}
		
	}

}
import flash.display.Sprite;
import org.libra.utils.displayObject.GraphicsUtil;

final class Cell extends Sprite{
	
	private var $w:int;
	
	private var $h:int;
	
	public function Cell(w:int = 6, h:int = 6, color:int = 0x00ff00) {
		$w = w;
		$h = h;
		GraphicsUtil.drawRect(this.graphics, 0, 0, w, h, color);
	}
	
	override public function get width():Number {
		return $w;
	}
	
	override public function get height():Number {
		return $h;
	}
}