package org.libra.ui.base {
	import flash.display.DisplayObject;
	import org.libra.ui.interfaces.IContainer;
	import org.libra.ui.interfaces.IDragEnabled;
	import org.libra.ui.interfaces.IDropEnabled;
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
	public class Container extends Component implements IDropEnabled, IContainer {
		
		protected var componentList:Vector.<Component>;
		
		protected var numComponent:int;
		
		private var dropAcceptableList:Vector.<IDragEnabled>;
		
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
		
		public function remove(child:Component, dispose:Boolean = false):Component {
			var index:int = this.componentList.indexOf(child);
			if (index == -1) return null;
			this.componentList.splice(index, 1);
			numComponent--;
			super.removeChild(child);
			if(dispose)
				child.dispose();
			return child;
		}
		
		public function removeAt(index:int, dispose:Boolean = false):Component {
			return index > -1 && index < numChildren ? this.remove(this.componentList[index], dispose) : null;
		}
		
		public function removeAll(dispose:Boolean, ...rest):void { 
			for (var i:* in rest) this.remove(rest[i], dispose);
		}
		
		public function clear(dispose:Boolean = false):void {
			for (var i:* in this.componentList) {
				if (dispose) componentList[i].dispose();
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
		
		override public function dispose():void {
			super.dispose();
			for (var i:* in this.componentList) {
				this.componentList[i].dispose();
			}
			this.componentList = null;
			numComponent = 0;
		}
		
		override public function toString():String {
			return 'container';
		}
		
		/* INTERFACE org.libra.ui.interfaces.IDropEnabled */
		
		public function addDropAcceptEnabled(dragable:IDragEnabled):void {
			if (!dropAcceptableList) dropAcceptableList = new Vector.<IDragEnabled>();
			if(this.dropAcceptableList.indexOf(dragable) == -1)
				dropAcceptableList.push(dragable);
		}
		
		public function removeDropAcceptEnabled(dragEnabled:IDragEnabled):void {
			if (this.dropAcceptableList) {
				var index:int = this.dropAcceptableList.indexOf(dragEnabled);
				if (index != -1) this.dropAcceptableList.splice(index, 1);
			}
		}
		
		public function isDropAcceptEnabled(dragEnabled:IDragEnabled):Boolean {
			return this.dropAcceptableList ? this.dropAcceptableList.indexOf(dragEnabled) != -1 : false;
		}
		
		public function addDragEnabled(dragEnabled:IDragEnabled):void {
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