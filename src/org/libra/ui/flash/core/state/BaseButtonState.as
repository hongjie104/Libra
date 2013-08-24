package org.libra.ui.flash.core.state {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import org.libra.ui.utils.ResManager;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseButtonState
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class BaseButtonState extends Bitmap implements IButtonState {
		
		protected var $getBmd:Function;
		
		protected var $resName:String;
		
		protected var $actualWidth:int;
		
		protected var $actualHeight:int;
		
		public function BaseButtonState() {
			super();
			$getBmd = ResManager.getInstance().getBitmapData;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.ui.base.states.IStatus */
		
		public function set resName(val:String):void {
			this.$resName = val;
			toNormal();
		}
		
		public function setSize(w:int, h:int):void {
			$actualWidth = w;
			$actualHeight = h;
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
		
		public function toNormal():void {
			this.bitmapData = $getBmd($resName + '_normal');
		}
		
		public function toMouseOver():void {
			this.bitmapData = $getBmd($resName + '_over');
		}
		
		public function toMouseDown():void {
			this.bitmapData = $getBmd($resName + '_down');
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