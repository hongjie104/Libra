package org.libra.ui.flash.core.state {
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import org.libra.ui.flash.theme.DefaultTheme;
	import org.libra.utils.displayObject.GraphicsUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseListItemState
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-03-2012
	 * @version 1.0
	 * @see
	 */
	public class BaseListItemState extends Shape implements ISelectState {
		
		private var $selected:Boolean;
		
		private var $width:int;
		
		private var $height:int;
		
		public function BaseListItemState() {
			super();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.ui.base.stateus.interfaces.ISelectStatus */
		
		public function set selected(val:Boolean):void {
			this.$selected = val;
			val ? toSelected() : toNormal();
		}
		
		public function toSelected():void {
			GraphicsUtil.drawRect(this.graphics, 0, 0, $width, $height, DefaultTheme.LIST_SELECTED);
		}
		
		public function setSize(w:int, h:int):void {
			this.$width = w;
			this.$height = h;
		}
		
		public function set resName(val:String):void {
			
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
		
		public function toNormal():void {
			$selected ? toSelected() : GraphicsUtil.drawRect(this.graphics, 0, 0, $width, $height, DefaultTheme.LIST_DEFAULT);
		}
		
		public function toMouseOver():void {
			GraphicsUtil.drawRect(this.graphics, 0, 0, $width, $height, DefaultTheme.LIST_ROLLOVER);
		}
		
		public function toMouseDown():void {
			
		}
		
		public function dispose():void {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}