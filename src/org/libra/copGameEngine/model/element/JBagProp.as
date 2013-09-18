package org.libra.copGameEngine.model.element {
	import org.libra.copGameEngine.model.basic.JBitmapObject;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JBagProp
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class JBagProp extends JBitmapObject {
		
		protected var $count:int;
		
		public function JBagProp() {
			super(40, 40);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get count():int {
			return $count;
		}
		
		public function set count(value:int):void {
			$count = value;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}