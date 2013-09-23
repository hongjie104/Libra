package org.libra.ui.flash.interfaces {
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IDropable
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/02/2012
	 * @version 1.0
	 * @see
	 */
	public interface IDropabled {
		
		/**
		 * 添加可拖放至该容器的组件
		 * @param	dragable 可以拖拽的组件
		 */
		function addDropAccept(dragable:IDragabled):void;
		
		/**
		 * 移除可拖放至该容器的组件
		 * @param	dragable 可以拖拽的组件
		 */
		function removeDropAccept(dragable:IDragabled):void;
		
		/**
		 * 获取该组件是否可拖放至该容器
		 * @param	dragable 可以拖拽的组件
		 * @return true：可以拖放；false：不可以拖放
		 */
		function isDropAccept(dragable:IDragabled):Boolean;
		
		/**
		 * 当容器接纳了一个被拖放进来的组件后，执行该方法，默认是啥都不做。
		 * 子类应该重写改方法，比如把组件添加到容器啊什么的。
		 * @param	dragable 可以拖拽的组件
		 */
		function addDragComponent(dragable:IDragabled):void;
	}
	
}