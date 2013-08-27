package org.libra.ui.flash.core {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import org.libra.displayObject.JSprite;
	import org.libra.ui.flash.components.JToolTip;
	import org.libra.ui.flash.interfaces.IComponent;
	import org.libra.ui.flash.interfaces.IDragable;
	import org.libra.ui.flash.managers.DragManager;
	import org.libra.ui.flash.managers.ToolTipManager;
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
	public class Component extends JSprite implements IComponent, IDragable {
		
		/**
		 * 宽度
		 * @private
		 */
		protected var $actualWidth:Number;
		
		/**
		 * 高度
		 * @private
		 */
		protected var $actualHeight:Number;
		
		/**
		 * @private
		 */
		protected var $enabled:Boolean;
		
		/**
		 * 是否已经绘制过了。
		 * 绘制方法只调用一次
		 * 在每次被添加到舞台上调用。
		 * @private
		 */
		protected var $inited:Boolean;
		
		/**
		 * 背景，永远在最底层
		 * @private
		 */
		protected var $background:DisplayObject;
		
		/**
		 * 遮罩
		 * @private
		 */
		protected var $mask:Shape;
		
		/**
		 * @private
		 */
		private var $dragEnabled:Boolean;
		
		/**
		 * @private
		 */
		protected var $toolTipText:String;
		
		/**
		 * 渲染队列的引用
		 * 渲染队列是单例
		 * @private
		 */
		protected var $validationQueue:ValidationQueue;
		
		/**
		 * @private
		 */
		private var $invalidationFlag:InvalidationFlag;
		
		public function Component(x:int = 0, y:int = 0) { 
			super();
			
			//取消flash默认的焦点边框
			this.focusRect = false;
			this.$enabled = true;
			setLocation(x, y);
			
			$invalidationFlag = new InvalidationFlag();
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
			if (index == 0 && this.$background) {
				index = child == $background ? 0 : 1;
			}
			return super.addChildAt(child, index);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeFromParent(destroy:Boolean = false):void { 
            if (parent) {
				if (parent is Container) {
					(parent as Container).remove(this, destroy);
				}else {
					parent.removeChild(this);
					if(destroy)
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
			if ($actualWidth != w || $actualHeight != h) {
				this.$actualWidth = w;
				this.$actualHeight = h;
				invalidate(InvalidationFlag.SIZE);
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
			this.$enabled = val;
			this.tabEnabled = this.mouseChildren = this.mouseEnabled = val;
			invalidate(InvalidationFlag.STATE);
		}
		
		/**
		 * 获取该控件是否可用
		 * @return 布尔值
		 */
		public function get enabled():Boolean {
			return this.$enabled;
		}
		
		/**
		 * 设置tip里的文本
		 * @param	text 文本内容
		 */
		public function set toolTipText(text:String):void {
			this.$toolTipText = text;
			ToolTipManager.getInstance().setToolTip(this, text ? JToolTip.getInstance() : null);
		}
		
		public function get toolTipText():String {
			return $toolTipText;
		}
		
		/**
		 * 初始化Tip,当该控件要显示Tip时被ToolTipManager调用
		 * @see org.libra.ui.flash.managers.ToolTipManager
		 */
		public function initToolTip():void {
			JToolTip.getInstance().text = this.$toolTipText;
		}
		
		/**
		 * 设置背景
		 * @param	bg 一个可视对象
		 */
		public function set background(bg:DisplayObject):void {
			if (this.$background && $background.parent == this) this.removeChild(this.$background);
			this.$background = bg;
			super.addChildAt($background, 0);
		}
		
		/**
		 * 设置遮罩
		 * @param	rect 遮罩的范围
		 */
		public function setMask(rect:Rectangle = null):void {
			if (rect) {
				if (!this.$mask) this.$mask = new Shape();
				GraphicsUtil.drawRect($mask.graphics, rect.x, rect.y, rect.width, rect.height);
				this.addChild($mask);
				this.mask = $mask;
			}else {
				if ($mask.parent) $mask.parent.removeChild($mask);
				this.mask = null;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void {
			dragEnabled = false;
			super.dispose();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String {
			return getQualifiedClassName(this);
		}
		
		/**
		 * 生成xml
		 * 在自动创建ui时调用，得到xml配置文件
		 * @return
		 */
		public function toXML():XML {
			const tmpAry:Array = toString().split('::');
			return new XML('<' + tmpAry[tmpAry.length - 1] + ' ' + 
							(x ? 'x="' + x + '" ' : '') + 
							(y ? 'y="' + y + '" ' : '') + 
							($actualWidth ? 'width="' + $actualWidth + '" ' : '') + 
							($actualHeight ? 'height="' + $actualHeight + '" ' : '') + 
							($enabled ? '' : 'enabled="false" ') + 
							($toolTipText ? 'toolTipText="' + $toolTipText + '" ' : '') + 
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
		
		/* INTERFACE org.libra.ui.interfaces.IDragable */
		
		/**
		 * 设置是否可以被拖拽
		 * 当可以被拖拽时,响应鼠标按下事件,触发拖拽事件
		 * @param	val
		 */
		public function set dragEnabled(val:Boolean):void {
			if (this.$dragEnabled != val) {
				this.$dragEnabled = val;
				if ($dragEnabled) this.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
				else this.removeEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
			}
		}
		
		/**
		 * 获取被拖拽时需要显示的BitmapData
		 * @return
		 */
		public function get dragBmd():BitmapData {
			var bmd:BitmapData = new BitmapData($actualWidth, $actualHeight, true, 0);
			bmd.draw(this);
			return bmd;
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
			this.$invalidationFlag.reset();
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters and setters
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 获取控件的宽度
		 */
		override public function get width():Number {
			return $actualWidth;
		}
		
		/**
		 * 设置控件的宽度
		 */
		override public function set width(value:Number):void {
			setSize(value, $actualHeight);
		}
		
		/**
		 * 获取控件的高度
		 */
		override public function get height():Number {
			return $actualHeight;
		}
		
		/**
		 * 设置控件的高度
		 */
		override public function set height(value:Number):void {
			setSize($actualWidth, value);
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
		protected function invalidate($invalidationFlag:int = -1):void {
			this.$invalidationFlag.setInvalid($invalidationFlag);
			if($inited)
				$validationQueue.addControl(this, false);
		}
		
		/**
		 * 添加到舞台上时，调用该方法
		 * 在这个方法中，将实例化一些可视对象变量。
		 * 以免在添加到舞台之前，就大量实例化暂时没有用到的对象。
		 * @private
		 */
		protected function init():void {
			$inited = true;
			$validationQueue = ValidationQueue.getInstance();
			this.invalidate();
		}
		
		/**
		 * 渲染组件
		 * 主要作用是重新布局。
		 * 比如当宽度或者高度改变时，重新绘制下组件
		 * @private
		 */
		protected function draw():void {
			if (this.$invalidationFlag.isInvalid(InvalidationFlag.SIZE))
				resize();
			if (this.$invalidationFlag.isInvalid(InvalidationFlag.TEXT))
				refreshText();
			if (this.$invalidationFlag.isInvalid(InvalidationFlag.DATA))
				refreshData();
			if (this.$invalidationFlag.isInvalid(InvalidationFlag.STATE))
				refreshState();
			if (this.$invalidationFlag.isInvalid(InvalidationFlag.STYLE))
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
			if (!$inited) init();
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