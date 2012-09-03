package org.libra.ui.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.base.BaseButton;
	import org.libra.ui.base.stateus.BaseCheckBoxStatus;
	import org.libra.ui.base.stateus.interfaces.ISelectStatus;
	import org.libra.ui.events.CheckBoxEvent;
	
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
		
		public function JCheckBox(x:int = 0, y:int = 0, text:String = '', resName:String = 'checkBtn') { 
			super(x, y, text, resName);
			this.setSize(54, 20);
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
				(this.status as ISelectStatus).setSelected(selected);
				if (selected) {
					if (this.group) this.group.setCheckBoxUnselected(this);
					dispatchEvent(new CheckBoxEvent(CheckBoxEvent.SELECTED));
				}
				this.invalidate();
			}
		}
		
		public function setCheckBoxGroup(group:JCheckBoxGroup):void {
			if (this.group && this.group != group) this.group.removeCheckBox(this);
			this.group = group;
		}
		
		override public function toString():String {
			return 'JCheckBox';
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function initStatus():void {
			this.status = new BaseCheckBoxStatus();
			this.status.setResName(resName);
			this.addChild(this.status.getDisplayObject());
		}
		
		override protected function render():void {
			super.render();
			if (selected) (this.status as ISelectStatus).toSelected();
		}
		
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			setTextLocation(0, h - 18);
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