package org.libra.displayObject.interfaces {
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ISprite
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/09/2012
	 * @version 1.0
	 * @see
	 */
	public interface ISprite {
		
		function removeFromParent(dispose:Boolean = false):void;
		
		function dispose():void;
	}
	
}