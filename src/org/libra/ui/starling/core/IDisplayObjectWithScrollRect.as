package org.libra.ui.starling.core {
	import flash.geom.Rectangle;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IDisplayObjectWithScrollRect
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/27/2012
	 * @version 1.0
	 * @see
	 */
	public interface IDisplayObjectWithScrollRect {
		
		/**
		 * The scroll rectangle bounds of the display object. The display object
		 * is cropped to the size defined by the rectangle, and it scrolls
		 * within the rectangle when you change the x and y properties of the
		 * scrollRect object.
		 * 
		 * @see flash.display.DisplayObject#scrollRect
		 */
		function get scrollRect():Rectangle;
		
		/**
		 * @private
		 */
		function set scrollRect(value:Rectangle):void;
		
	}
	
}