package org.libra.ui.flash.core {
	import flash.display.DisplayObject;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.interfaces.IDragable;
	import org.libra.ui.flash.interfaces.IDropable;
	import org.libra.utils.displayObject.GraphicsUtil;
	
	/**
	 * <p>
	 * 容器
	 * </p>
	 *
	 * @class Container
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class Container extends Component implements IDropable, IContainer {
		
		/**
		 * 子对象的集合
		 * @private
		 */
		protected var componentList:Vector.<Component>;
		
		/**
		 * 子对象的数量
		 * @private
		 */
		protected var $numComponent:int;
		
		/**
		 * 拖拽时,可放进该容器的控件集合
		 * @private
		 */
		private var dropAcceptList:Vector.<IDragable>;
		
		/**
		 * 构造函数
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 */
		public function Container(x:int = 0, y:int = 0) { 
			super(x, y);
			componentList = new Vector.<Component>();
			$numComponent = 0;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 判断是否包含某可视对象
		 * @param	child 可视对象
		 * @return 布尔值
		 */
		public function hasComponent(child:Component):Boolean {
			return this.componentList.indexOf(child) != -1;
		}
		
		/**
		 * 往容器里添加控件
		 * @param	child 控件
		 * @return 添加成功,返回被添加的控件;添加失败,返回null
		 */
		public function append(child:Component):Component {
			if (this.componentList.indexOf(child) == -1) {
				this.componentList[$numComponent++] = child;
				super.addChild(child);
				return child;
			}
			return null;
		}
		
		/**
		 * 往容器里添加控件到某一层
		 * @param	child 控件
		 * @param	index 控件所在的显示层
		 * @return 添加成功,返回被添加的控件;添加失败,返回null
		 */
		public function appendAt(child:Component, index:int):Component {
			if (append(child)) {
				this.setChildIndex(child, index);
				var tmp:Component = this.componentList[index];
				this.componentList[index] = child;
				this.componentList[$numComponent - 1] = tmp;
				return child;
			}
			return null;
		}
		
		/**
		 * 添加所有控件
		 * @param	...rest n个控件
		 */
		public function appendAll(...rest):void {
			for (var i:* in rest) this.append(rest[i]);
		}
		
		/**
		 * 移除某个控件
		 * @param	child 将要被移除的控件
		 * @param	destroy 移除后是否将控件销毁
		 * @default false
		 * @return 移除成功,返回被添加的控件;移除失败,返回null
		 */
		public function remove(child:Component, destroy:Boolean = false):Component {
			var index:int = this.componentList.indexOf(child);
			if (index == -1) return null;
			this.componentList.splice(index, 1);
			$numComponent--;
			super.removeChild(child);
			if(destroy)
				child.destroy();
			return child;
		}
		
		/**
		 * 移除某一特定显示层上的控件
		 * @param	index 显示层索引值
		 * @param	destroy 移除后是否将控件销毁
		 * @default false
		 * @return 移除成功,返回被添加的控件;移除失败,返回null
		 */
		public function removeAt(index:int, destroy:Boolean = false):Component {
			return index > -1 && index < numChildren ? this.remove(this.componentList[index], destroy) : null;
		}
		
		/**
		 * 移除n个控件
		 * @param	destroy 移除后是否将控件销毁
		 * @param	...rest n个将要被移除的控件
		 */
		public function removeAll(destroy:Boolean, ...rest):void { 
			for (var i:* in rest) this.remove(rest[i], destroy);
		}
		
		/**
		 * 清空所有的控件
		 * @param	destroy 移除后是否将控件销毁
		 */
		public function clear(destroy:Boolean = false):void {
			for (var i:* in this.componentList) {
				if (destroy) componentList[i].destroy();
				this.removeChild(componentList[i]);
			}
			componentList.length = 0;
			this.$numComponent = 0;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addChild(child:DisplayObject):DisplayObject {
			if (child is Component) throw new Error('组件不能使用addChild，请使用append');
			return super.addChild(child);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			if (child is Component) throw new Error('组件不能使用addChildAt，请使用appendAt');
			return super.addChildAt(child, index);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChild(child:DisplayObject):DisplayObject {
			if (child is Component) throw new Error('组件不能使用removeChild，请使用remove');
			return super.removeChild(child);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChildAt(index:int):DisplayObject {
			var child:DisplayObject = super.removeChildAt(index);
			if (child is Component) {
				var index:int = this.componentList.indexOf(child);
				if (index != -1) {
					this.componentList.splice(index, 1);
					$numComponent--;
				}
			}
			return child;
		}
		
		/**
		 * 将显示对象置于顶层显示
		 * @param	child 显示对象
		 */
		public function bringToTop(child:DisplayObject):void {
			if (this.contains(child)) {
				setChildIndex(child, this.numChildren - 1);	
			}
		}
		
		/**
		 * 将显示对象置于底层显示，如果设置了背景，
		 * 那么将显示对象置于背景的上一层，背景层永远在最底层
		 * @param	child 显示对象
		 */
		public function bringToBottom(child:DisplayObject):void {
			if (this.contains(child)) {
				var index:int = 0;
				if(background){
					if(background != child){
						index = 1;
					}
				}
				setChildIndex(child, index);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			GraphicsUtil.drawRect(this.graphics, 0, 0, w, h, 0xff0000, .0);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void {
			super.destroy();
			for (var i:* in this.componentList) {
				this.componentList[i].destroy();
			}
			this.componentList = null;
			$numComponent = 0;
		}
		
		/* INTERFACE org.libra.ui.interfaces.IDropable */
		
		/**
		 * 添加可以拖拽进该容器的控件
		 * @param	dragable 可以拖拽进该容器的控件
		 */
		public function addDropAccept(dragable:IDragable):void {
			if (!dropAcceptList) dropAcceptList = new Vector.<IDragable>();
			if(this.dropAcceptList.indexOf(dragable) == -1)
				dropAcceptList.push(dragable);
		}
		
		/**
		 * 移除可以拖拽进该容器的控件
		 * @param	dragEnabled 可以拖拽进该容器的控件
		 */
		public function removeDropAccept(dragEnabled:IDragable):void {
			if (this.dropAcceptList) {
				var index:int = this.dropAcceptList.indexOf(dragEnabled);
				if (index != -1) this.dropAcceptList.splice(index, 1);
			}
		}
		
		/**
		 * 判断控件是否可以被拖拽进该空气
		 * @param	dragEnabled 被拖拽的控件
		 * @return 布尔值
		 */
		public function isDropAccept(dragEnabled:IDragable):Boolean {
			return this.dropAcceptList ? this.dropAcceptList.indexOf(dragEnabled) != -1 : false;
		}
		
		/**
		 * 当拖拽成功后,调用该方法,将被拖拽的控件添加至容器中
		 * @param	dragEnabled 被拖拽的控件
		 */
		public function addDragComponent(dragEnabled:IDragable):void {
			dragEnabled.removeFromParent();
			this.append(dragEnabled as Component);
		}
		
		/**
		 * 获取子对象的数量
		 */
		public function get numComponent():int {
			return this.$numComponent;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}