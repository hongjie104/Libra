package org.libra.utils {
	import flash.display.Graphics;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Graphics
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public final class GraphicsUtil {
		
		public function GraphicsUtil() {
			throw new Error('Graphics工具类不能实例化');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function drawRect(g:Graphics, x:int, y:int, w:int, h:int, color:int = 0xff0000, alpha:Number = 1.0, clear:Boolean = true):void { 
			if(clear)
				g.clear();
			g.beginFill(color, alpha);
			g.drawRect(x, y, w, h);
			g.endFill();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}