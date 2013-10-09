package org.libra.ui.starling.core {
	import starling.display.DisplayObjectContainer;
	import starling.textures.Texture;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IDragComponent
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/04/2012
	 * @version 1.0
	 * @see
	 */
	public interface IDragable {
		
		function set dragEnabled(val:Boolean):void;
		
		/**
		 * 被拖拽时呈现的纹理
		 * @return
		 */
		function getDragTexture():Texture;
		
		function get x():Number;
		
		function get y():Number;
		
		function get parent():DisplayObjectContainer;
	}
	
}