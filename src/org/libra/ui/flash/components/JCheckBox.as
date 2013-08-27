package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.flash.core.BaseButton;
	import org.libra.ui.flash.core.state.BaseCheckBoxState;
	import org.libra.ui.flash.core.state.ISelectState;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.DefaultBtnTheme;
	import org.libra.ui.invalidation.InvalidationFlag;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JCheckBox
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/01/2012
	 * @version 1.0
	 * @see
	 */
	public class JCheckBox extends BaseButton {
		
		private var $selected:Boolean;
		
		private var $group:JCheckBoxGroup;
		
		public function JCheckBox(theme:DefaultBtnTheme = null, x:int = 0, y:int = 0, text:String = '') { 
			super(theme ? theme : UIManager.getInstance().theme.checkBoxTheme, x, y, text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get selected():Boolean {
			return this.$selected;
		}
		
		public function set selected(val:Boolean):void {
			if (this.$selected != val) {
				this.$selected = val;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function setCheckBoxGroup($group:JCheckBoxGroup):void {
			if (this.$group && this.$group != $group) this.$group.removeCheckBox(this);
			this.$group = $group;
			this.$group.append(this);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function initState():void {
			this.$state = new BaseCheckBoxState();
			this.$state.resName = ($theme as DefaultBtnTheme).resName;
			this.addChildAt(this.$state.displayObject, 0);
			
			setTextLocation(18, 0);
		}
		
		override protected function refreshState():void {
			(this.$state as ISelectState).selected = $selected;
			super.refreshState();
			if ($selected) {
				if (this.$group) this.$group.setCheckBoxUnselected(this);
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		protected function toSelected():void {
			this.$selected = true;
			this.invalidate(InvalidationFlag.STATE);
		}
		
		protected function toUnSelected():void {
			if (this.$group) return;
			this.$selected = false;
			this.invalidate(InvalidationFlag.STATE);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		private function onClicked(e:MouseEvent):void {
			$selected ? toUnSelected() : toSelected();
			if(UIManager.stopPropagation)
				e.stopPropagation();
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.addEventListener(MouseEvent.CLICK, onClicked);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(MouseEvent.CLICK, onClicked);
		}
	}

}