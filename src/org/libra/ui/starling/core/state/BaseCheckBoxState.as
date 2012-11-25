package org.libra.ui.starling.core.state {
	import org.libra.ui.starling.theme.ButtonTheme;
	import starling.display.DisplayObject;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseCheckBoxState
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/03/2012
	 * @version 1.0
	 * @see
	 */
	public class BaseCheckBoxState extends BaseButtonState implements ICheckBoxState {
		
		private var selected:Boolean;
		
		public function BaseCheckBoxState(theme:ButtonTheme) {
			super(theme);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function toMouseDown():void {
			if(!selected)
				super.toMouseDown();
		}
		
		override public function toMouseOver():void {
			if(!selected)
				super.toMouseOver();
		}
		
		override public function toMouseUp():void {
			if(!selected)
				super.toMouseUp();
		}
		
		override public function toNormal():void {
			if(!selected)
				super.toNormal();
		}
		
		/* INTERFACE org.libra.ui.starling.core.state.ICheckBoxState */
		
		public function setSelected(val:Boolean):void {
			if (selected != val) {
				this.selected = val;
				if(selected)
					super.toMouseDown();
			}
		}
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}