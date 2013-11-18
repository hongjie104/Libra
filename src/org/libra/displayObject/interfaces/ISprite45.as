package org.libra.displayObject.interfaces {
	
	/**
	 * <p>
	 * 斜视角45度坐标系中的可视对象
	 * </p>
	 *
	 * @class ISprite45
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/09/2012
	 * @version 1.0
	 * @see
	 */
	public interface ISprite45 {//extends ISprite {
		
		function get topX():int;
		
		function get topY():int;
		
		function set topX(val:int):void;
		
		function set topY(val:int):void;
		
		function get bottomX():int;
		
		function get bottomY():int;
		
	}
}