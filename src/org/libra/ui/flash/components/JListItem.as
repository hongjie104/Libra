package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.flash.core.state.BaseListItemState;
	import org.libra.ui.flash.core.state.ISelectState;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.invalidation.InvalidationFlag;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JListItem
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-03-2012
	 * @version 1.0
	 * @see
	 */
	public class JListItem extends Container {
		
		private static const NORMAL:int = 0;
		
		private static const MOUSE_OVER:int = 1;
		
		private var _data:*;
		
		private var _selected:Boolean;
		
		private var _state:ISelectState;
		
		private var _label:JLabel;
		
		private var _curState:int;
		
		public function JListItem(x:int = 0, y:int = 0) { 
			super(x, y);
			this.mouseChildren = this.mouseEnabled = true;
			initStatue();
			this.setSize(100, 20);
			_selected = false;
			_curState = NORMAL;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set selected(val:Boolean):void {
			this._selected = val;
			this.invalidate(InvalidationFlag.STATE);
		}
		
		public function get selected():Boolean {
			return this._selected;
		}
		
		public function set data(data:*):void {
			this._data = data;
			invalidate(InvalidationFlag.DATA);
		}
		
		public function get data():*{
			return this._data;
		}
		
		override public function clone():Component {
			return new JListItem(x, y);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function initStatue():void {
			_state = new BaseListItemState();
			this.addChild(_state.displayObject);
		}
		
		override protected function init():void {
			super.init();
			_label = new JLabel();
			this.append(_label);
		}
		
		override protected function refreshData():void {
			_label.text = _data;
		}
		
		override protected function resize():void {
			this._state.setSize(_actualWidth, _actualHeight);
			_label.setSize(_actualWidth, _actualHeight);
		}
		
		override protected function refreshState():void {
			this._state.selected = this._selected;
			_curState == NORMAL ? _state.toNormal() : _state.toMouseOver();
		}
		
		private function set curState(state:int):void {
			if (_curState != state) {
				_curState = state;
				invalidate(InvalidationFlag.STATE);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		private function onMouseRoll(e:MouseEvent):void {
			curState = e.type == MouseEvent.ROLL_OVER ? MOUSE_OVER : NORMAL;
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.addEventListener(MouseEvent.ROLL_OVER, onMouseRoll);
			this.addEventListener(MouseEvent.ROLL_OUT, onMouseRoll);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(MouseEvent.ROLL_OVER, onMouseRoll);
			this.removeEventListener(MouseEvent.ROLL_OUT, onMouseRoll);
		}
		
	}

}