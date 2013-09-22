package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.flash.core.BaseButton;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.core.state.BaseCheckBoxState;
	import org.libra.ui.flash.core.state.ISelectState;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.BtnSkin;
	import org.libra.ui.flash.theme.JFont;
	import org.libra.ui.invalidation.InvalidationFlag;
	
	/**
	 * <p>
	 * 勾选框
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
		
		/**
		 * 是否勾选上
		 * @private
		 */
		private var $selected:Boolean;
		
		/**
		 * 所在的组，加入组之后，就是单选框了
		 * @private
		 */
		private var $group:JCheckBoxGroup;
		
		public function JCheckBox(x:int = 0, y:int = 0, skin:BtnSkin = null, text:String = null, font:JFont = null, filters:Array = null) { 
			super(x, y, skin ? skin : UIManager.getInstance().skin.checkBoxSkin, text, font ? font : JFont.FONT_LABEL, filters);
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
		}
		
		override public function clone():Component {
			return new JCheckBox(x, y, $skin, $text, $font, $filters);
		}
		
		override public function toXML():XML {
			const xml:XML = super.toXML();
			if (this.$selected) xml.@selected = true;
			return xml;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function initState():void {
			this.$state = new BaseCheckBoxState($loader);
			this.$state.skin = $skin.skin;
			this.addChildAt(this.$state.displayObject, 0);
			
			setTextLocation(18, 0);
		}
		
		override protected function refreshState():void {
			(this.$state as ISelectState).selected = $selected;
			super.refreshState();
			if ($selected) {
				if (this.$group) this.$group.setCheckBoxUnselected(this);
				dispatchEvent(new Event(Event.SELECT));
			}
		}
		
		override protected function refreshStyle():void {
			this.$state.skin = $skin.skin;
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