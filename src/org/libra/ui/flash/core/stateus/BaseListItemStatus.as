package org.libra.ui.flash.core.stateus {
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import org.libra.ui.base.stateus.interfaces.ISelectStatus;
	import org.libra.ui.style.Style;
	import org.libra.utils.GraphicsUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseListItemStatus
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-03-2012
	 * @version 1.0
	 * @see
	 */
	public class BaseListItemStatus extends Shape implements ISelectStatus {
		
		private var selected:Boolean;
		private var $width:int;
		private var $height:int;
		
		public function BaseListItemStatus() {
			super();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.ui.base.stateus.interfaces.ISelectStatus */
		
		public function setSelected(val:Boolean):void {
			this.selected = val;
			val ? toSelected() : toNormal();
		}
		
		public function toSelected():void {
			GraphicsUtil.drawRect(this.graphics, 0, 0, $width, $height, Style.LIST_SELECTED);
		}
		
		public function setSize(w:int, h:int):void {
			this.$width = w;
			this.$height = h;
		}
		
		public function setResName(val:String):void {
			
		}
		
		public function getDisplayObject():DisplayObject {
			return this;
		}
		
		public function toNormal():void {
			selected ? toSelected() : GraphicsUtil.drawRect(this.graphics, 0, 0, $width, $height, Style.LIST_DEFAULT);
		}
		
		public function toMouseOver():void {
			GraphicsUtil.drawRect(this.graphics, 0, 0, $width, $height, Style.LIST_ROLLOVER);
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