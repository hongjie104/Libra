package org.libra.copGameEngine.model.element {
	import org.libra.copGameEngine.basic.JBitmapObject;
	import org.libra.copGameEngine.component.IBitmapDataRender;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JLoaderObject
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class JLoaderProp extends JBitmapObject {//implements ILoaderProp {
		
		private var $loaded:Boolean;
		
		private var $doSthAfterLoad:Function;
		
		private var $url:String;
		
		public function JLoaderProp(bitmapDataRender:IBitmapDataRender = null) {
			super(bitmapDataRender);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.copGameEngine.model.ILoaderObject */
		
		/*public function get url():String {
			return $url;
		}
		
		public function get doSthAfterLoad():Function {
			return $doSthAfterLoad;
		}
		
		public function set doSthAfterLoad(value:Function):void {
			$doSthAfterLoad = value;
		}
		
		public function get loaded():Boolean {
			return $loaded;
		}*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}