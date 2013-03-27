package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.flash.core.BaseButton;
	import org.libra.ui.flash.core.state.BaseCheckBoxState;
	import org.libra.ui.flash.core.state.ISelectState;
	import org.libra.ui.flash.events.CheckBoxEvent;
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
		
		private var selected:Boolean;
		
		private var group:JCheckBoxGroup;
		
		public function JCheckBox(theme:DefaultBtnTheme, x:int = 0, y:int = 0, text:String = '') { 
			super(theme, x, y, text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function isSelected():Boolean {
			return this.selected;
		}
		
		public function setSelected(val:Boolean):void {
			if (this.selected != val) {
				this.selected = val;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function setCheckBoxGroup(group:JCheckBoxGroup):void {
			if (this.group && this.group != group) this.group.removeCheckBox(this);
			this.group = group;
			this.group.append(this);
		}
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function initState():void {
			this.state = new BaseCheckBoxState();
			this.state.setResName((theme as DefaultBtnTheme).resName);
			this.addChildAt(this.state.getDisplayObject(), 0);
		}
		
		override protected function refreshState():void {
			(this.state as ISelectState).setSelected(selected);
			super.refreshState();
			if (selected) {
				if (this.group) this.group.setCheckBoxUnselected(this);
				dispatchEvent(new CheckBoxEvent(CheckBoxEvent.SELECTED));
			}
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.addEventListener(MouseEvent.CLICK, onClicked);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(MouseEvent.CLICK, onClicked);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		private function onClicked(e:MouseEvent):void {
			this.setSelected(!selected);
		}
	}

}