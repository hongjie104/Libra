package org.libra.ui.flash.core {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import org.libra.displayObject.JSprite;
	import org.libra.ui.flash.components.JToolTip;
	import org.libra.ui.flash.interfaces.IComponent;
	import org.libra.ui.flash.interfaces.IDragabled;
	import org.libra.ui.flash.interfaces.IPanel;
	import org.libra.ui.flash.managers.DragManager;
	import org.libra.ui.flash.managers.ToolTipManager;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.utils.displayObject.GraphicsUtil;
	
	/**
	 * <p>
	 * 所有组件的父类
	 * </p>
	 *
	 * @class Component
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-30-2012
	 * @version 1.0
	 * @see
	 */
	public class Component extends JSprite implements IComponent, IDragabled {
		
		/**
		 * 宽度
		 * @private
		 */
		protected var _actualWidth:Number;
		
		/**
		 * 高度
		 * @private
		 */
		protected var _actualHeight:Number;
		
		/**
		 * @private
		 */
		protected var _enabled:Boolean;
		
		/**
		 * 是否已经绘制过了。
		 * 绘制方法只调用一次
		 * 在每次被添加到舞台上调用。
		 * @private
		 */
		protected var _inited:Boolean;
		
		/**
		 * 背景，永远在最底层
		 * @private
		 */
		protected var _background:DisplayObject;
		
		/**
		 * 遮罩
		 * @private
		 */
		protected var _mask:Shape;
		
		/**
		 * @private
		 */
		private var _dragabled:Boolean;
		
		/**
		 * @private
		 */
		protected var _toolTipText:String;
		
		/**
		 * 渲染队列的引用
		 * 渲染队列是单例
		 * @private
		 */
		protected var _validationQueue:ValidationQueue;
		
		/**
		 * @private
		 */
		private var _invalidationFlag:InvalidationFlag;
		
		/**
		 * 加载资源库的loader
		 * @private
		 */
		protected var _loader:Loader;
		
		/**
		 * 九宫格参考，用于UI编辑器中
		 * @private
		 */
		private var _scaleGrid:ScaleGrid;
		
		protected var _id:String;
		
		/**
		 * 绘制边框的Shape
		 * @private
		 */
		private var _border:Shape;
		
		/**
		 * 边框的颜色
		 * @private
		 */
		private var _borderColor:int;
		
		public function Component(x:int = 0, y:int = 0) { 
			super();
			
			//取消flash默认的焦点边框
			this.focusRect = false;
			this._enabled = true;
			setLocation(x, y);
			//<0,默认不要边框
			_borderColor = -1;
			_invalidationFlag = new InvalidationFlag();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 设置可是对象的层次
		 * 先判断所设之层是否和原层一样，若不一样再使用setChildIndex方法。
		 * 避免多余的重绘。
		 * @param	child
		 * @param	index
		 */
		override public function setChildIndex(child:DisplayObject, index:int):void {
			if (index >= this.numChildren) {
				index = this.numChildren - 1;
			}
			super.setChildIndex(child, index);
		}
		
		/**
		 * 如果index为0，要确保背景在最底层
		 * @param	child
		 * @param	index
		 * @return 被添加的可视对象
		 */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			if (index == 0 && this._background) {
				index = child == _background ? 0 : 1;
			}
			return super.addChildAt(child, index);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeFromParent(dispose:Boolean = false):void { 
            if (parent) {
				if (parent is Container) {
					(parent as Container).remove(this, dispose);
				}else {
					parent.removeChild(this);
					if(dispose)
						this.dispose();	
				}
			}
        }
		
		/**
		 * 设置控件坐标
		 * @param	x
		 * @param	y
		 */
		public function setLocation(x:int = 0, y:int = 0):void { 
			this.x = x;
			this.y = y;
		}
		
		/**
		 * 设置控件的大小
		 * @param	w
		 * @see #width
		 * @param	h
		 * @see #height
		 */
		public function setSize(w:int, h:int):void {
			if (_actualWidth != w || _actualHeight != h) {
				this._actualWidth = w;
				this._actualHeight = h;
				if (_scaleGrid) {
					dispatchEvent(new Event(Event.RESIZE));
				}
				if (this._borderColor > -1) {
					this.borderColor = _borderColor;
				}
				invalidate(InvalidationFlag.SIZE);
				if (UIManager.UI_EDITOR) {
					GraphicsUtil.drawRect(this.graphics, 0, 0, w, h, 0xff0000, .0);
				}
			}
		}
		
		/**
		 * 设置控件坐标和大小
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 * @param	w 宽度
		 * @see     #width
		 * @param	h 高度
		 * @see     #height
		 */
		public function setBounds(x:int, y:int, w:int, h:int):void {
			this.x = x;
			this.y = y;
			setSize(w, h);
		}
		
		/**
		 * 设置该控件是否可用
		 * @param	val
		 */
		public function set enabled(val:Boolean):void {
			this._enabled = val;
			this.tabEnabled = this.mouseChildren = this.mouseEnabled = val;
			invalidate(InvalidationFlag.STATE);
		}
		
		/**
		 * 获取该控件是否可用
		 * @return 布尔值
		 */
		public function get enabled():Boolean {
			return this._enabled;
		}
		
		/**
		 * 设置tip里的文本
		 * @param	text 文本内容
		 */
		public function set toolTipText(text:String):void {
			this._toolTipText = text;
			ToolTipManager.instance.setToolTip(this, text ? JToolTip.instance : null);
		}
		
		public function get toolTipText():String {
			return _toolTipText;
		}
		
		/**
		 * 初始化Tip,当该控件要显示Tip时被ToolTipManager调用
		 * @see org.libra.ui.flash.managers.ToolTipManager
		 */
		public function initToolTip():void {
			JToolTip.instance.text = this._toolTipText;
		}
		
		/**
		 * 设置背景
		 * @param	bg 一个可视对象
		 */
		public function set background(bg:DisplayObject):void {
			if (this._background && _background.parent == this) this.removeChild(this._background);
			this._background = bg;
			super.addChildAt(_background, 0);
		}
		
		/**
		 * 设置遮罩
		 * @param	rect 遮罩的范围
		 */
		public function setMask(rect:Rectangle = null):void {
			if (rect) {
				if (!this._mask) this._mask = new Shape();
				GraphicsUtil.drawRect(_mask.graphics, rect.x, rect.y, rect.width, rect.height);
				this.addChild(_mask);
				this.mask = _mask;
			}else {
				if (_mask.parent) _mask.parent.removeChild(_mask);
				this.mask = null;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void {
			dragabled = false;
			super.dispose();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String {
			if (name.indexOf('instance') == -1) return name;
			name = getQualifiedClassName(this);
			return name;
			//return name ||= getQualifiedClassName(this);
		}
		
		/**
		 * 克隆一个对象，主要用于UI编辑器
		 * @return
		 */
		public function clone():Component {
			return new Component(this.x, this.y);
		}
		
		/**
		 * 生成xml
		 * 在自动创建ui时调用，得到xml配置文件
		 * @return
		 */
		public function toXML():XML {
			const tmpAry:Array = getQualifiedClassName(this).split('::');
			return new XML('<' + tmpAry[tmpAry.length - 1] + ' ' + 
							(x ? 'x="' + x + '" ' : '') + 
							(y ? 'y="' + y + '" ' : '') + 
							(_actualWidth ? 'width="' + _actualWidth + '" ' : '') + 
							(_actualHeight ? 'height="' + _actualHeight + '" ' : '') + 
							(_enabled ? '' : 'enabled="false" ') + 
							(_toolTipText ? 'toolTipText="' + _toolTipText + '" ' : '') + 
						   '/>');
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispatchEvent(event:Event):Boolean {
			return this.hasEventListener(event.type) ? super.dispatchEvent(event) : false;
		}
		
		/**
		 * 强制性地发出事件，不管是否有此类事件的监听
		 * @param	event
		 * @return
		 */
		public function dispatchEventForce(event:Event):Boolean {
			return super.dispatchEvent(event);
		}
		
		/**
		 * 添加所有的可视对象
		 * @param	...rest N个可视对象
		 */
		public function addChildAll(...rest):void {
			var l:int = rest.length;
			for (var i:int = 0; i < l; i += 1)
				this.addChild(rest[i]);
		}
		
		/**
		 * 被validationQueue调用,根据标记的待更新标签进行更新
		 */
		public function validate():void {
			draw();
			this._invalidationFlag.reset();
		}
		
		public function getRoot():IPanel {
			var p:DisplayObjectContainer = this.parent;
			while (p && !(p is IPanel)) {
				p = p.parent;
			}
			return p ? p as IPanel : null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters and setters
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 获取控件的宽度
		 */
		override public function get width():Number {
			return _actualWidth;
		}
		
		/**
		 * 设置控件的宽度
		 */
		override public function set width(value:Number):void {
			setSize(value, _actualHeight);
		}
		
		/**
		 * 获取控件的高度
		 */
		override public function get height():Number {
			return _actualHeight;
		}
		
		/**
		 * 设置控件的高度
		 */
		override public function set height(value:Number):void {
			setSize(_actualWidth, value);
		}
		
		/* INTERFACE org.libra.ui.interfaces.IDragable */
		
		/**
		 * 设置是否可以被拖拽
		 * 当可以被拖拽时,响应鼠标按下事件,触发拖拽事件
		 * @param	val
		 */
		public function set dragabled(val:Boolean):void {
			if (this._dragabled != val) {
				this._dragabled = val;
				if (_dragabled) this.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
				else this.removeEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
			}
		}
		
		/**
		 * 获取被拖拽时需要显示的BitmapData
		 * @return
		 */
		public function get dragBmd():BitmapData {
			var bmd:BitmapData = new BitmapData(_actualWidth, _actualHeight, true, 0);
			bmd.draw(this);
			return bmd;
		}
		
		/**
		 * 控件的图片资源是否从所在根容器的loader中获得
		 */
		public function get useRootLoader():Boolean {
			return false;
		}
		
		public function set useRootLoader(val:Boolean):void {
			const root:IPanel = getRoot();
			_loader = root ? root.loader : null;
		}
		
		/**
		 * 是否显示九宫格参考，主要用在UI编辑器中
		 */
		public function set showScaleGrid(val:Boolean):void {
			if (val) {
				if (!_scaleGrid) _scaleGrid = new ScaleGrid();
				_scaleGrid.component = this;
			}else {
				_scaleGrid.component = null;
			}
		}
		
		public function get id():String {
			return _id;
		}
		
		public function set id(value:String):void {
			_id = value;
		}
		
		public function set borderColor(value:int):void {
			this._borderColor = value;
			if (value > -1) {
				if (!_border) _border = new Shape();
				GraphicsUtil.lineRect(_border.graphics, 0, 0, _actualWidth, _actualHeight, value);
				if (!_border.parent) addChild(_border);
			}else {
				_border.graphics.clear();
				removeChild(_border);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 通知validationQueue该控件需要更新哪一部分内容
		 * 并且将该控件放进validationQueue的待更新列表中等待被更新
		 * @private
		 * @param	flag
		 * @see org.libra.ui.invalidation.InvalidationFlag
		 */
		protected function invalidate(_invalidationFlag:int = -1):void {
			this._invalidationFlag.setInvalid(_invalidationFlag);
			if(_inited)
				_validationQueue.addControl(this, false);
		}
		
		/**
		 * 添加到舞台上时，调用该方法
		 * 在这个方法中，将实例化一些可视对象变量。
		 * 以免在添加到舞台之前，就大量实例化暂时没有用到的对象。
		 * @private
		 */
		protected function init():void {
			_inited = true;
			_validationQueue = ValidationQueue.instance;
			this.invalidate();
			_loader = null;
		}
		
		/**
		 * 渲染组件
		 * 主要作用是重新布局。
		 * 比如当宽度或者高度改变时，重新绘制下组件
		 * @private
		 */
		protected function draw():void {
			if (this._invalidationFlag.isInvalid(InvalidationFlag.SIZE))
				resize();
			if (this._invalidationFlag.isInvalid(InvalidationFlag.TEXT))
				refreshText();
			if (this._invalidationFlag.isInvalid(InvalidationFlag.DATA))
				refreshData();
			if (this._invalidationFlag.isInvalid(InvalidationFlag.STATE))
				refreshState();
			if (this._invalidationFlag.isInvalid(InvalidationFlag.STYLE))
				refreshStyle();
		}
		
		/**
		 * 更新控件的文本内容
		 * @private
		 */
		protected function refreshText():void { }
		
		/**
		 * 更新控件的表现风格
		 * 一般很少用到
		 * @private
		 */
		protected function refreshStyle():void { }
		
		/**
		 * 更新控件的状态
		 * @private
		 */
		protected function refreshState():void { }
		
		/**
		 * 更新控件里的数据内容
		 * @private
		 */
		protected function refreshData():void { }
		
		/**
		 * 更新控件大小
		 * @private
		 */
		protected function resize():void { }
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 添加到舞台事件
		 * @private
		 * @param	e
		 */
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			if (!_inited) init();
		}
		
		/**
		 * 开始拖拽
		 * @private
		 * @param	e
		 */
		private function onStartDrag(e:MouseEvent):void {
			DragManager.startDrag(this);
		}
	}

}