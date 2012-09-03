package org.libra.utils {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * <p>
	 * 可视对象深度检测。从ASwing源码中copy来的
	 * </p>
	 *
	 * @class DepthUtil
	 */
	public final class DepthUtil {
		
		public function DepthUtil() {
			throw new Error("DepthUtil类不能实例化!");
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function bringToBottom(obj:DisplayObject):void{
			var parent:DisplayObjectContainer = obj.parent;
			if (parent) {
				if(parent.getChildIndex(obj) != 0){
					parent.setChildIndex(obj, 0);
				}
			}
		}
		
		public static function bringToTop(obj:DisplayObject):void{
			var parent:DisplayObjectContainer = obj.parent;
			if (parent) {
				var maxIndex:int = parent.numChildren - 1;
				if (parent.getChildIndex(obj) != maxIndex) { 
					parent.setChildIndex(obj, maxIndex);
				}
			}
		}
		
		public static function isTop(obj:DisplayObject):Boolean { 
			var parent:DisplayObjectContainer = obj.parent;
			if (parent) {
				return (parent.numChildren - 1) == parent.getChildIndex(obj);
			}
			return false;
		}
		
		public static function isBottom(obj:DisplayObject):Boolean { 
			var parent:DisplayObjectContainer = obj.parent;
			if (parent) {
				return parent.getChildIndex(obj) == 0;
			}
			return false;
		}
		
		public static function isJustBelow(obj:DisplayObject, aboveObj:DisplayObject):Boolean { 
			var parent:DisplayObjectContainer = obj.parent;
			if (parent) {
				if (aboveObj.parent != parent) {
					return false;
				}
				return parent.getChildIndex(obj) == parent.getChildIndex(aboveObj) - 1;
			}
			return false;
		}
		
		public static function isJustAbove(obj:DisplayObject, belowObj:DisplayObject):Boolean{
			return !isJustBelow(belowObj, obj);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}