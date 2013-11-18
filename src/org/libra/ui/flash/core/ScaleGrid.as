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
		
		protected var _rect:Rectangle; 
		
		protected var _leftTopCell:Cell;
		
		protected var _topCell:Cell;
		
		protected var _rightTopCell:Cell;
		
		protected var _rightCell:Cell;
		
		protected var _rightBottomCell:Cell;
		
		protected var _bottomCell:Cell;
		
		protected var _leftBottomCell:Cell;
		
		protected var _leftCell:Cell;
		
		protected var _centerCell:Cell;
		
		protected var _dragCell:Cell;
		
		protected var _component:Component;
		
		public function ScaleGrid() {
			super();
			mouseEnabled = false;
			_rect = new Rectangle();
			_leftTopCell = new Cell();
			_topCell = new Cell();
			_rightTopCell = new Cell();
			_rightCell = new Cell();
			_rightBottomCell = new Cell();
			_bottomCell = new Cell();
			_leftBottomCell = new Cell();
			_leftCell = new Cell();
			_centerCell = new Cell(12, 12);
			
			this.addChild(_leftTopCell);
			this.addChild(_topCell);
			this.addChild(_rightTopCell);
			this.addChild(_rightCell);
			this.addChild(_rightBottomCell);
			this.addChild(_bottomCell);
			this.addChild(_leftBottomCell);
			this.addChild(_leftCell);
			this.addChild(_centerCell);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set component(value:Component):void {
			if (value) {
				_component = value;
				setSize(_component.width, _component.height);
				_component.addChild(this);
				_component.addEventListener(Event.RESIZE, onResize);
			}else {
				if (_component) {
					_component.removeChild(this);
					_component.removeEventListener(Event.RESIZE, onResize);
					_component = null;
				}
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function setSize(w:int, h:int):void {
			this._rect.width = w;
			this._rect.height = h;
			this.graphics.clear();
			this.graphics.lineStyle(1,0x00ff00);
			this.graphics.moveTo(0,0);
			this.graphics.lineTo(w,0);
			this.graphics.lineTo(w,h);
			this.graphics.lineTo(0,h);
			this.graphics.lineTo(0,0);
			
			this._leftTopCell.x = 0 - (_leftTopCell.width >> 1);
			this._leftTopCell.y = 0 - (_leftTopCell.height >> 1);
			this._topCell.x = (w - _topCell.width) >> 1;
			this._topCell.y = 0 - (_topCell.height >> 1);
			this._rightTopCell.x = w - (_rightTopCell.width >> 1);
			this._rightTopCell.y = 0 - (_rightTopCell.height >> 1);
			this._rightCell.x = w - (_rightCell.width >> 1);
			this._rightCell.y = (h - _rightCell.height) >> 1;
			this._rightBottomCell.x = w - (_rightBottomCell.width >> 1);
			this._rightBottomCell.y = h - (_rightBottomCell.height >> 1);
			this._bottomCell.x = (w - _bottomCell.width) >> 1;
			this._bottomCell.y = h - (_bottomCell.height >> 1);
			this._leftBottomCell.x = 0 - (_leftBottomCell.width >> 1);
			this._leftBottomCell.y = h - (_leftBottomCell.height >> 1);
			this._leftCell.x = 0 - (_leftCell.width >> 1);
			this._leftCell.y = (h - _leftCell.height) >> 1;
			this._centerCell.x = (w - _centerCell.width) >> 1;
			this._centerCell.y = (h - _centerCell.height) >> 1;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onResize(e:Event):void {
			setSize(_component.width, _component.height);
		}
		
		private function onCellMouseDown(e:MouseEvent):void {
			switch(e.target) {
				case _centerCell:
					this._dragCell = null;
					_component.startDrag(false, new Rectangle(0, 0, _component.parent.width - _component.width, _component.parent.height - _component.height));
					break;
				default:
					this._dragCell = e.target as Cell;
					this.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
					break;
			}
			this.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseMove(evt:MouseEvent):void{
			if(_dragCell){
				var p:Point = this.parent.globalToLocal(new Point(evt.stageX,evt.stageY));
				var vx:Number = this.x - p.x;
				var vy:Number = this.y - p.y;
				switch(this._dragCell){
					case _leftTopCell:
						this.x = p.x; this.y = p.y;
						this.setSize(_rect.width + vx, this._rect.height + vy);
						break;
					case _topCell:
						this.y = p.y;
						this.setSize(_rect.width, this._rect.height + vy);
						break;
					case _rightTopCell:
						this.y = p.y;
						this.setSize(0 - vx, this._rect.height + vy);
						break;
					case _rightCell:
						this.setSize(0 - vx, this._rect.height);
						break;
					case _rightBottomCell:
						this.setSize(0 - vx, 0 - vy);
						break;
					case _bottomCell:
						this.setSize(_rect.width, 0 - vy);
						break;
					case _leftBottomCell:
						this.x = p.x;
						this.setSize(_rect.width + vx, 0 - vy);
						break;
					case _leftCell:
						this.x = p.x;
						this.setSize(_rect.width + vx, _rect.height);
						break;
				}
			}
		}
		
		private function onMouseUp(evt:MouseEvent):void{
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			if(this._dragCell) {
				this._dragCell = null;
				//九宫格大小确定后，更新组件的坐标和大小
				this._component.x += this.x;
				this._component.y += this.y;
				this._component.setSize(_rect.width,_rect.height);
			}else {
				_component.stopDrag();
				_component.dispatchEvent(new Event(Event.SELECT));
			}
		}
		
		private function onAddToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			_leftTopCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_topCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_rightTopCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_rightCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_rightBottomCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_bottomCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_leftBottomCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_leftCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_centerCell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
		}
		
		private function onRemoveFromStage(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			_leftTopCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_topCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_rightTopCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_rightCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_rightBottomCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_bottomCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_leftBottomCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_leftCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
			_centerCell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouseDown);
		}
		
	}

}
import flash.display.Sprite;
import org.libra.utils.displayObject.GraphicsUtil;

final class Cell extends Sprite{
	
	private var _w:int;
	
	private var _h:int;
	
	public function Cell(w:int = 6, h:int = 6, color:int = 0x00ff00) {
		_w = w;
		_h = h;
		GraphicsUtil.drawRect(this.graphics, 0, 0, w, h, color);
	}
	
	override public function get width():Number {
		return _w;
	}
	
	override public function get height():Number {
		return _h;
	}
}