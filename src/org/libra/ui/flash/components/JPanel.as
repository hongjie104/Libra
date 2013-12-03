package org.libra.ui.flash.components {
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import org.libra.log4a.Logger;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.interfaces.IPanel;
	import org.libra.ui.flash.managers.LayoutManager;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.ContainerSkin;
	import org.libra.URI;
	import org.libra.utils.displayObject.DepthUtil;
	import org.libra.utils.ReflectUtil;
	
	
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JPanel
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class JPanel extends Container implements IPanel {
		
		protected var _owner:IContainer;
		
		/**
		 * 当该面试显示时，其他面板是否需要是不能响应鼠标事件
		 * @private
		 * @default false
		 */
		protected var _model:Boolean;
		
		protected var _showing:Boolean;
		
		protected var _defaultBtn:JButton;
		
		protected var _closeTween:TweenLite;
		
		protected var _closeTweening:Boolean;
		
		/**
		 * 面板独有的资源库名，如果面板没有独有的资源库，那么resName就为空字符串
		 * @private
		 * @default ''
		 */
		protected var _resName:String;
		
		/**
		 * 是否加载了资源库
		 * @private
		 * @default false
		 */
		protected var _loaded:Boolean;
		
		/**
		 * 鼠标按下时，是否自动放到显示层的最上层
		 * @private
		 * @default true
		 */
		protected var _autoUp:Boolean;
		
		/**
		 * 是不是全屏的面板,默认值是false
		 * @private
		 * @default false
		 */
		protected var _fullScreen:Boolean;
		
		/**
		 * 打开面板时是否要自动居中显示，默认值true
		 * @private
		 * @default true
		 */
		protected var _autoCenter:Boolean;
		
		protected var _activated:Boolean;
		
		public function JPanel(owner:IContainer, w:int = 300, h:int = 200, resName:String = '', model:Boolean = false, skin:ContainerSkin = null) { 
			super(0, 0, skin ? skin : UIManager.instance.skin.panelSkin);
			this.setSize(w, h);
			this._owner = owner;
			this._model = model;
			this._resName = resName;
			_closeTweening = _showing = false;
			_autoCenter = _autoUp = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get model():Boolean {
			return _model;
		}
		
		public function show():void {
			if (this._resName && !_loaded) {
				//加载独有的资源库去
				UIManager.instance.showLoading();
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onResLoaded);
				_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onResLoadProgress);
				_loader.load(new URLRequest(URI.UI_URL + this._resName + '.swf'));
			}else {
				if (_showing) return;
				this._owner.append(this);
				_showing = true;
				LayoutManager.instance.addPanel(this);
				UIManager.instance.keyPoll.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			}
		}
		
		public function close(tween:Boolean = true, dispose:Boolean = false):void {
			if (_showing) {
				if (tween) {
					if (!_closeTweening) {
						if (_closeTween) _closeTween.restart();
						else _closeTween = TweenLite.to(this, .5, { alpha:.0, onStart:function():void { _closeTweening = true; }, 
							onComplete:function():void { _closeTweening = false; close(false, dispose); } } );
					}
				}else {
					LayoutManager.instance.removePanel(this);
					removeFromParent(dispose);
					UIManager.instance.keyPoll.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				}
			}
		}
		
		override public function removeFromParent(dispose:Boolean = false):void {
			alpha = 1.0;
			_showing = false;
			super.removeFromParent(dispose);
		}
		
		public function showSwitch():void {
			_showing ? close() : show();
		}
		
		/* INTERFACE org.libra.ui.flash.interfaces.IPanel */
		
		public function get loader():Loader {
			return _loader;
		}
		
		public function get showing():Boolean {
			return this._showing;
		}
		
		public function set defaultBtn(btn:JButton):void {
			if (btn) {
				if (this.hasComponent(btn)) {
					this._defaultBtn = btn;
				}
			}else {
				this._defaultBtn = null;
			}
		}
		
		public function get defaultBtn():JButton {
			return this._defaultBtn;
		}
		
		public function get autoUp():Boolean {
			return _autoUp;
		}
		
		public function set autoUp(value:Boolean):void {
			_autoUp = value;
		}
		
		public function get fullScreen():Boolean {
			return _fullScreen;
		}
		
		public function get autoCenter():Boolean {
			return _autoCenter;
		}
		
		public function set autoCenter(val:Boolean):void{
			_autoCenter = val;
		}
		
		public function get activated():Boolean {
			return _activated;
		}
		
		public function set activated(value:Boolean):void {
			_activated = value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set skinStr(value:String):void {
			const ary:Array = value.split('&');
			if (ary.length == 5) {
				this.skin = new ContainerSkin(ary[0], new Rectangle(Number(ary[1]), Number(ary[2]), Number(ary[3]), Number(ary[4])));
			}else {
				this.skin = UIManager.instance.skin.panelSkin;
				Logger.error('Panel的皮肤配置格式有误:' + ary);
			}
		}
		
		override public function clone():Component {
			return new JPanel(this._owner, _actualWidth, _actualHeight, _resName, _model, _skin);
		}
		
		override public function toXML():XML {
			const xml:XML = super.toXML();
			if (this._id.indexOf('component') == -1) {
				xml["@var"] = this._id;
			}
			for (var i:int = 0; i < _numComponent; i += 1) {
				if (_componentList[i].id) {
					var tmpXML:XML = this._componentList[i].toXML();
					if(_componentList[i].id.indexOf('component') == -1){
						tmpXML["@var"] = _componentList[i].id;
					}
					xml.appendChild(tmpXML);
				}
			}
			return xml;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			if (_loader) {
				_loader.unloadAndStop();
				_loader = null;
			}
		}
		
		protected function getBmdFromLoader(bmdName:String):BitmapData {
			var c:Class = ReflectUtil.getDefinitionByNameFromLoader(bmdName, _loader) as Class;
			return c ? new c() : null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		/**
		 * 鼠标按钮按下时，将面板放置顶层
		 * @param	e
		 */
		protected function onMouseDown(e:MouseEvent):void {
			if(_autoUp) DepthUtil.bringToTop(this);
		}
		
		protected function onResLoadProgress(e:ProgressEvent):void {
			UIManager.instance.setLoadingProgress(e.bytesLoaded / e.bytesTotal);
		}
		
		protected function onResLoaded(e:Event):void {
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onResLoaded);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onResLoadProgress);
			_loaded = true;
			UIManager.instance.closeLoading();
			show();
		}
		
		protected function onKeyUp(e:KeyboardEvent):void {
			if (this._activated) {
				if (e.keyCode == Keyboard.ENTER) {
					if (this._defaultBtn) _defaultBtn.doClick();
				}
			}
		}
	}

}