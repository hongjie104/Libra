package org.libra.ui.flash.core {
	import flash.display.DisplayObject;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.interfaces.IDragable;
	import org.libra.ui.flash.interfaces.IDropable;
	import org.libra.utils.GraphicsUtil;
	
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
		
		protected var componentList:Vector.<Component>;
		
		protected var numComponent:int;
		
		private var dropAcceptList:Vector.<IDragable>;
		
		public function Container(x:int = 0, y:int = 0) { 
			super(x, y);
			componentList = new Vector.<Component>();
			numComponent = 0;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function hasComponent(child:Component):Boolean {
			return this.componentList.indexOf(child) != -1;
		}
		
		public function append(child:Component):Component {
			if (this.componentList.indexOf(child) == -1) {
				this.componentList[numComponent++] = child;
				super.addChild(child);
				return child;
			}
			return null;
		}
		
		public function appendAt(child:Component, index:int):Component {
			if (append(child)) {
				this.setChildIndex(child, index);
				var tmp:Component = this.componentList[index];
				this.componentList[index] = child;
				this.componentList[numComponent - 1] = tmp;
				return child;
			}
			return null;
		}
		
		public function appendAll(...rest):void {
			for (var i:* in rest) this.append(rest[i]);
		}
		
		public function remove(child:Component, destroy:Boolean = false):Component {
			var index:int = this.componentList.indexOf(child);
			if (index == -1) return null;
			this.componentList.splice(index, 1);
			numComponent--;
			super.removeChild(child);
			if(destroy)
				child.destroy();
			return child;
		}
		
		public function removeAt(index:int, destroy:Boolean = false):Component {
			return index > -1 && index < numChildren ? this.remove(this.componentList[index], destroy) : null;
		}
		
		public function removeAll(destroy:Boolean, ...rest):void { 
			for (var i:* in rest) this.remove(rest[i], destroy);
		}
		
		public function clear(destroy:Boolean = false):void {
			for (var i:* in this.componentList) {
				if (destroy) componentList[i].destroy();
				this.removeChild(componentList[i]);
			}
			componentList.length = 0;
			this.numComponent = 0;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			if (child is Component) throw new Error('组件不能使用addChild，请使用append');
			return super.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			if (child is Component) throw new Error('组件不能使用addChildAt，请使用appendAt');
			return super.addChildAt(child, index);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			if (child is Component) throw new Error('组件不能使用removeChild，请使用remove');
			return super.removeChild(child);
		}
		
		override public function removeChildAt(index:int):DisplayObject {
			var child:DisplayObject = super.removeChildAt(index);
			if (child is Component) {
				var index:int = this.componentList.indexOf(child);
				if (index != -1) {
					this.componentList.splice(index, 1);
					numComponent--;
				}
			}
			return child;
		}
		
		public function getNumComponent():int {
			return this.numComponent;
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
		
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			GraphicsUtil.drawRect(this.graphics, 0, 0, w, h, 0xff0000, .0);
		}
		
		override public function destroy():void {
			super.destroy();
			for (var i:* in this.componentList) {
				this.componentList[i].destroy();
			}
			this.componentList = null;
			numComponent = 0;
		}
		
		/* INTERFACE org.libra.ui.interfaces.IDropable */
		
		public function addDropAccept(dragable:IDragable):void {
			if (!dropAcceptList) dropAcceptList = new Vector.<IDragable>();
			if(this.dropAcceptList.indexOf(dragable) == -1)
				dropAcceptList.push(dragable);
		}
		
		public function removeDropAccept(dragEnabled:IDragable):void {
			if (this.dropAcceptList) {
				var index:int = this.dropAcceptList.indexOf(dragEnabled);
				if (index != -1) this.dropAcceptList.splice(index, 1);
			}
		}
		
		public function isDropAccept(dragEnabled:IDragable):Boolean {
			return this.dropAcceptList ? this.dropAcceptList.indexOf(dragEnabled) != -1 : false;
		}
		
		public function addDragComponent(dragEnabled:IDragable):void {
			dragEnabled.removeFromParent();
			this.append(dragEnabled as Component);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}