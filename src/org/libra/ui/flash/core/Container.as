package org.libra.ui.flash.core {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import org.libra.log4a.Logger;
	import org.libra.ui.flash.interfaces.IComponent;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.interfaces.IDragabled;
	import org.libra.ui.flash.interfaces.IDropabled;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.ContainerSkin;
	import org.libra.ui.flash.UIClassMap;
	import org.libra.utils.asset.AssetsStorage;
	import org.libra.utils.displayObject.BitmapDataUtil;
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
	public class Container extends Component implements IDropabled, IContainer {
		
		protected var _viewClassMap:Object = {};
		
		/**
		 * 子对象的集合
		 * @private
		 */
		protected var _componentList:Vector.<IComponent>;
		
		/**
		 * 子对象的数量
		 * @private
		 */
		protected var _numComponent:int;
		
		/**
		 * 拖拽时,可放进该容器的控件集合
		 * @private
		 */
		private var _dropAcceptList:Vector.<IDragabled>;
		
		protected var _skin:ContainerSkin;
		
		/**
		 * 构造函数
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 */
		public function Container(x:int = 0, y:int = 0, skin:ContainerSkin = null) { 
			super(x, y);
			_componentList = new Vector.<IComponent>();
			_numComponent = 0;
			this._skin = skin ? skin : UIManager.instance.skin.containerSkin;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 判断是否包含某可视对象
		 * @param	child 可视对象
		 * @return 布尔值
		 */
		public function hasComponent(child:IComponent):Boolean {
			return this._componentList.indexOf(child) != -1;
		}
		
		/**
		 * 往容器里添加控件
		 * @param	child 控件
		 * @return 添加成功,返回被添加的控件;添加失败,返回null
		 */
		public function append(child:IComponent):IComponent {
			if (this._componentList.indexOf(child) == -1) {
				this._componentList[_numComponent++] = child;
				super.addChild(child as DisplayObject);
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
		public function appendAt(child:IComponent, index:int):IComponent {
			if (append(child)) {
				this.setChildIndex(child as DisplayObject, index);
				const tmp:IComponent = this._componentList[index];
				this._componentList[index] = child;
				this._componentList[_numComponent - 1] = tmp;
				return child;
			}
			return null;
		}
		
		/**
		 * 添加所有控件
		 * @param	...rest n个控件
		 */
		public function appendAll(...rest):void {
			for each(var i:IComponent in rest) this.append(i);
		}
		
		/**
		 * 移除某个控件
		 * @param	child 将要被移除的控件
		 * @param	destroy 移除后是否将控件销毁
		 * @default false
		 * @return 移除成功,返回被添加的控件;移除失败,返回null
		 */
		public function remove(child:IComponent, destroy:Boolean = false):IComponent {
			var index:int = this._componentList.indexOf(child);
			if (index == -1) return null;
			this._componentList.splice(index, 1);
			_numComponent--;
			super.removeChild(child as DisplayObject);
			if(destroy)
				child.dispose();
			return child;
		}
		
		/**
		 * 移除某一特定显示层上的控件
		 * @param	index 显示层索引值
		 * @param	destroy 移除后是否将控件销毁
		 * @default false
		 * @return 移除成功,返回被添加的控件;移除失败,返回null
		 */
		public function removeAt(index:int, destroy:Boolean = false):IComponent {
			return index > -1 && index < numChildren ? this.remove(this._componentList[index], destroy) : null;
		}
		
		/**
		 * 移除n个控件
		 * @param	destroy 移除后是否将控件销毁
		 * @param	...rest n个将要被移除的控件
		 */
		public function removeAll(destroy:Boolean, ...rest):void { 
			for each(var i:IComponent in rest) this.remove(i, destroy);
		}
		
		/**
		 * 清空所有的控件
		 * @param	dispose 移除后是否将控件销毁
		 */
		public function clear(dispose:Boolean = false):void {
			for each(var i:IComponent in this._componentList) {
				if (dispose) _componentList[i].dispose();
				this.removeChild(_componentList[i] as DisplayObject);
			}
			_componentList.length = 0;
			this._numComponent = 0;
		}
		
		public function get componentList():Vector.<IComponent> {
			return _componentList;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addChild(child:DisplayObject):DisplayObject {
			if (child is IComponent) throw new Error('组件不能使用addChild，请使用append');
			return super.addChild(child);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			if (child is IComponent) throw new Error('组件不能使用addChildAt，请使用appendAt');
			return super.addChildAt(child, index);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChild(child:DisplayObject):DisplayObject {
			if (child is IComponent) throw new Error('组件不能使用removeChild，请使用remove');
			return super.removeChild(child);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChildAt(index:int):DisplayObject {
			var child:DisplayObject = super.removeChildAt(index);
			if (child is IComponent) {
				var index:int = this._componentList.indexOf(child);
				if (index != -1) {
					this._componentList.splice(index, 1);
					_numComponent--;
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
				if(_background){
					if(_background != child){
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
			if (_actualWidth != w || _actualHeight != h) {
				super.setSize(w, h);
				GraphicsUtil.drawRect(this.graphics, 0, 0, w, h, 0xff0000, .0);
			}
		}
		
		override public function dispose():void {
			super.dispose();
			for each(var i:IComponent in this._componentList) {
				i.dispose();
			}
			this._componentList = null;
			_numComponent = 0;
		}
		
		/* INTERFACE org.libra.ui.interfaces.IDropable */
		
		/**
		 * 添加可以拖拽进该容器的控件
		 * @param	dragable 可以拖拽进该容器的控件
		 */
		public function addDropAccept(dragable:IDragabled):void {
			if (!_dropAcceptList) _dropAcceptList = new Vector.<IDragabled>();
			if(this._dropAcceptList.indexOf(dragable) == -1)
				_dropAcceptList.push(dragable);
		}
		
		/**
		 * 移除可以拖拽进该容器的控件
		 * @param	dragEnabled 可以拖拽进该容器的控件
		 */
		public function removeDropAccept(dragEnabled:IDragabled):void {
			if (this._dropAcceptList) {
				var index:int = this._dropAcceptList.indexOf(dragEnabled);
				if (index != -1) this._dropAcceptList.splice(index, 1);
			}
		}
		
		/**
		 * 判断控件是否可以被拖拽进该空气
		 * @param	dragEnabled 被拖拽的控件
		 * @return 布尔值
		 */
		public function isDropAccept(dragEnabled:IDragabled):Boolean {
			return this._dropAcceptList ? this._dropAcceptList.indexOf(dragEnabled) != -1 : false;
		}
		
		/**
		 * 当拖拽成功后,调用该方法,将被拖拽的控件添加至容器中
		 * @param	dragEnabled 被拖拽的控件
		 */
		public function addDragComponent(dragEnabled:IDragabled):void {
			dragEnabled.removeFromParent();
			this.append(dragEnabled as IComponent);
		}
		
		/**
		 * 获取子对象的数量
		 */
		public function get numComponent():int {
			return this._numComponent;
		}
		
		public function set skin(val:ContainerSkin):void {
			initBackground();
		}
		
		/**
		 * UI编辑器导出的皮肤配置进行赋值
		 */
		public function set skinStr(val:String):void {
			const ary:Array = val.split('&');
			if (ary.length == 5) {
				this.skin = new ContainerSkin(ary[0], new Rectangle(Number(ary[1]), Number(ary[2]), Number(ary[3]), Number(ary[4])));
			}else {
				this.skin = UIManager.instance.skin.containerSkin;
				Logger.error('容器的皮肤配置格式有误:' + ary);
			}
		}
		
		public function createView(xml:XML):void {
			createComps(xml);
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		override public function clone():Component {
			return new Container(x, y, _skin);
		}
		
		override public function toXML():XML {
			const xml:XML = super.toXML();
			if (_skin) {
				xml.@skinStr = this._skin.skin + '&' + this._skin.scale9Rect.x + '&' + this._skin.scale9Rect.y + '&' + this._skin.scale9Rect.width + '&' + this._skin.scale9Rect.height;
			}
			return xml;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			initBackground();
		}
		
		override protected function resize():void {
			initBackground();
		}
		
		protected function initBackground():void {
			if (_skin && _skin.skin) {
				var bmd:BitmapData = BitmapDataUtil.getScale9BitmapData(AssetsStorage.instance.getBitmapData(_skin.skin), 
					_actualWidth, _actualHeight, _skin.scale9Rect);
				if (this._background && this._background is Bitmap) {
					const bitmap:Bitmap = _background as Bitmap;
					if (bitmap.bitmapData) bitmap.bitmapData.dispose();
					bitmap.bitmapData = bmd;
				}else {
					background = new Bitmap(bmd);
				}
			}
		}
		
		protected function createComps(xml:XML, root:Boolean = true):IComponent {
			var comp:IComponent = root ? this : getCompsInstance(xml.name());
			for each (var attrs:XML in xml.attributes()) {
				var prop:String = attrs.name().toString();
				var value:String = attrs;
				if (Object(comp).hasOwnProperty(prop)) {
					comp[prop] = (value == "true" ? true : (value == "false" ? false : value))
				} else if (prop == "var" && hasOwnProperty(value)) {
					this[value] = comp;
				}
			}
			if (comp is IContainer) {
				var container:IContainer = comp as IContainer;
				for (var j:int = 0, n:int = xml.children().length(); j < n; j++) { 
					var child:IComponent = createComps(xml.children()[j], false);
					if (child) {
						container.append(child);
					}
				}
			}
			return comp;
		}
		
		private function getCompsInstance(name:String):IComponent {
			var compClass:Class = _viewClassMap[name] || UIClassMap.UI_CLASS_MAP[name];
			if (compClass != null) {
				return new compClass();
			}
			return null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}