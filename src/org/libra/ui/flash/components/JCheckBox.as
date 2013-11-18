package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.log4a.Logger;
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
		private var _selected:Boolean;
		
		/**
		 * 所在的组，加入组之后，就是单选框了
		 * @private
		 */
		private var _group:JCheckBoxGroup;
		
		public function JCheckBox(x:int = 0, y:int = 0, skin:BtnSkin = null, text:String = null, font:JFont = null, filters:Array = null) { 
			super(x, y, skin ? skin : UIManager.instance.skin.checkBoxSkin, text, font ? font : JFont.FONT_LABEL, filters);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get selected():Boolean {
			return this._selected;
		}
		
		public function set selected(val:Boolean):void {
			if (this._selected != val) {
				this._selected = val;
				this.invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function setCheckBoxGroup(_group:JCheckBoxGroup):void {
			if (this._group && this._group != _group) this._group.removeCheckBox(this);
			this._group = _group;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set skinStr(value:String):void {
			const ary:Array = value.split('&');
			if (ary.length == 3) {
				this.skin = new BtnSkin(ary[0], ary[1], ary[2]);
			}else {
				this.skin = UIManager.instance.skin.checkBoxSkin;
				Logger.error('checkBox的皮肤配置格式有误:' + ary);
			}
		}
		
		override public function clone():Component {
			return new JCheckBox(x, y, _skin, _text, _font, _filters);
		}
		
		override public function toXML():XML {
			const xml:XML = super.toXML();
			if (this._selected) xml.@selected = true;
			return xml;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function initState():void {
			this._state = new BaseCheckBoxState(_loader);
			this._state.skin = _skin.skin;
			this.addChildAt(this._state.displayObject, 0);
			
			setTextLocation(18, 0);
		}
		
		override protected function refreshState():void {
			(this._state as ISelectState).selected = _selected;
			super.refreshState();
			if (_selected) {
				if (this._group) this._group.setCheckBoxUnselected(this);
				dispatchEvent(new Event(Event.SELECT));
			}
		}
		
		override protected function refreshStyle():void {
			this._state.skin = _skin.skin;
		}
		
		protected function toSelected():void {
			this._selected = true;
			this.invalidate(InvalidationFlag.STATE);
		}
		
		protected function toUnSelected():void {
			if (this._group) return;
			this._selected = false;
			this.invalidate(InvalidationFlag.STATE);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		private function onClicked(e:MouseEvent):void {
			_selected ? toUnSelected() : toSelected();
			if(!UIManager.UI_EDITOR)
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