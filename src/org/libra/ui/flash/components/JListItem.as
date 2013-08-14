package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		
		private var $data:*;
		
		private var $selected:Boolean;
		
		private var $state:ISelectState;
		
		private var $label:JLabel;
		
		private var $curState:int;
		
		public function JListItem(x:int = 0, y:int = 0) { 
			super(x, y);
			this.mouseChildren = this.mouseEnabled = true;
			initStatue();
			this.setSize(100, 20);
			$selected = false;
			$curState = NORMAL;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set selected(val:Boolean):void {
			this.$selected = val;
			this.invalidate(InvalidationFlag.STATE);
		}
		
		public function get selected():Boolean {
			return this.$selected;
		}
		
		public function set data(data:*):void {
			this.$data = data;
			invalidate(InvalidationFlag.DATA);
		}
		
		public function get data():*{
			return this.$data;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function initStatue():void {
			$state = new BaseListItemState();
			this.addChild($state.displayObject);
		}
		
		override protected function init():void {
			super.init();
			$label = new JLabel(UIManager.getInstance().theme.labelTheme);
			this.append($label);
		}
		
		override protected function refreshData():void {
			$label.text = $data;
		}
		
		override protected function resize():void {
			this.$state.setSize($actualWidth, $actualHeight);
			$label.setSize($actualWidth, $actualHeight);
		}
		
		override protected function refreshState():void {
			this.$state.selected = this.$selected;
			$curState == NORMAL ? $state.toNormal() : $state.toMouseOver();
		}
		
		private function set curState(state:int):void {
			if ($curState != state) {
				$curState = state;
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