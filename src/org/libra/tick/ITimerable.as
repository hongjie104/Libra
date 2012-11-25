package org.libra.tick {
	
	/**
	 * <p>
	 * 需要每隔一段时间被调用某方法的对象
	 * </p>
	 *
	 * @class ITimerable
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/06/2012
	 * @version 1.0
	 */
	public interface ITimerable {
		
		/**
		 * 每秒调用该方法
		 */
		function doAction():void;
	}
	
}