package org.libra.ui.flash.core {
	import flash.display.Sprite;
	import org.libra.utils.displayObject.GraphicsUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ScaleGridCell
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 12/03/2013
	 * @version 1.0
	 * @see
	 */
	public final class ScaleGridCell extends Sprite {
		
		private var _w:int;
		
		private var _h:int;
		
		public function ScaleGridCell(w:int = 6, h:int = 6, color:int = 0x00ff00) {
			super();
			_w = w;
			_h = h;
			GraphicsUtil.drawRect(this.graphics, 0, 0, w, h, color);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function get width():Number {
			return _w;
		}
		
		override public function get height():Number {
			return _h;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}