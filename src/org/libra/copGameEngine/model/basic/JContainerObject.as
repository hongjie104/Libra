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
		
		protected var _container:JSprite;
		
		public function JContainerObject(bitmapDataRender:IBitmapDataRender = null) {
			super(bitmapDataRender);
			_container = new JSprite();
			_container.mouseChildren = _container.mouseEnabled = false;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get container():Sprite {
			return _container;
		}
		
		public function addChild(child:DisplayObject):DisplayObject {
			return _container.addChild(child);
		}
		
		public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			return _container.addChildAt(child, index);
		}
		
		public function removeChild(child:DisplayObject):DisplayObject {
			return _container.removeChild(child);
		}
		
		public function removeChildAt(index:int):DisplayObject {
			return _container.removeChildAt(index);
		}
		
		public function removeChildren(beginIndex:int = 0, endIndex:int = 2147483647):void {
			_container.removeChildren(beginIndex, endIndex);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}