package org.libra.copGameEngine.model.basic {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.libra.copGameEngine.component.IBitmapDataRender;
	import org.libra.displayObject.JSprite;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JContainerObject
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class JContainerObject extends JBitmapObject {
		
		protected var $container:JSprite;
		
		public function JContainerObject(bitmapDataRender:IBitmapDataRender = null) {
			super(bitmapDataRender);
			$container = new JSprite();
			$container.mouseChildren = $container.mouseEnabled = false;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get container():Sprite {
			return $container;
		}
		
		public function addChild(child:DisplayObject):DisplayObject {
			return $container.addChild(child);
		}
		
		public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			return $container.addChildAt(child, index);
		}
		
		public function removeChild(child:DisplayObject):DisplayObject {
			return $container.removeChild(child);
		}
		
		public function removeChildAt(index:int):DisplayObject {
			return $container.removeChildAt(index);
		}
		
		public function removeChildren(beginIndex:int = 0, endIndex:int = 2147483647):void {
			$container.removeChildren(beginIndex, endIndex);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}