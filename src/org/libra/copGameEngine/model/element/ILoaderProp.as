package org.libra.copGameEngine.model.element {
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ILoaderProp
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public interface ILoaderProp {
		
		function get url():String;
		
		function get doSthAfterLoad():Function;
		
		function set doSthAfterLoad(fun:Function):void;
		
		function get loaded():Boolean;
		
	}
	
}