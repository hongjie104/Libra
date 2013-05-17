package org.libra.tick {
	
	/**
	 * <p>
	 * 需要每帧被调用某方法的对象
	 * </p>
	 *
	 * @class ITickable
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/06/2012
	 * @version 1.0
	 */
	public interface ITickable {
		
		/**
		 * 每帧调用该方法
		 * @param	interval 距离上一次被调用该方法的时间间隔，单位毫秒
		 */
		function tick(interval:int):void;
		
		function get tickabled():Boolean;
		
		function set tickabled(value:Boolean):void;
		
	}
	
}