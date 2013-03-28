package org.libra.ui.flash.components {
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import org.libra.log4a.Logger;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.interfaces.IPanel;
	import org.libra.ui.flash.managers.LayoutManager;
	import org.libra.ui.flash.theme.DefaultPanelTheme;
	import org.libra.ui.URI;
	import org.libra.ui.utils.ResManager;
	import org.libra.utils.BitmapDataUtil;
	import org.libra.utils.DepthUtil;
	
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
		
		protected var owner:IContainer;
		
		protected var theme:DefaultPanelTheme;
		
		/**
		 * 当该面试显示时，其他面板是否需要是不能响应鼠标事件
		 * @private
		 * @default false
		 */
		protected var model:Boolean;
		
		protected var showing:Boolean;
		
		protected var defaultBtn:JButton;
		
		protected var closeTween:TweenLite;
		
		protected var closeTweening:Boolean;
		
		/**
		 * 面板独有的资源库名，如果面板没有独有的资源库，那么resName就为空字符串
		 * @private
		 * @default ''
		 */
		protected var resName:String;
		
		/**
		 * 加载资源库的Loader
		 * @private
		 */
		protected var loader:Loader;
		
		/**
		 * 是否加载了资源库
		 * @private
		 * @default false
		 */
		protected var loaded:Boolean;
		
		/**
		 * 鼠标按下时，是否自动放到显示层的最上层
		 * @private
		 * @default true
		 */
		protected var autoUp:Boolean;
		
		/**
		 * 是不是全屏的面板,默认值是false
		 * @private
		 * @default false
		 */
		protected var fullScreen:Boolean;
		
		/**
		 * 打开面板时是否要自动居中显示，默认值true
		 * @private
		 * @default true
		 */
		protected var autoCenter:Boolean;
		
		public function JPanel(owner:IContainer, theme:DefaultPanelTheme, w:int = 300, h:int = 200, resName:String = '', model:Boolean = false) { 
			super();
			this.theme = theme;
			this.setSize(w, h);
			this.owner = owner;
			this.model = model;
			this.resName = resName;
			closeTweening = showing = false;
			autoCenter = autoUp = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function isModel():Boolean {
			return model;
		}
		
		public function isFullScreen():Boolean {
			return this.fullScreen;
		}
		
		public function isAutoCenter():Boolean {
			return autoCenter;
		}
		
		public function show():void {
			if (this.resName && !loaded) {
				//加载独有的资源库去
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onResLoaded);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onResLoadProgress);
				loader.load(new URLRequest(URI.RES_URL + this.resName + '.swf'));
			}else {
				if (showing) return;
				this.owner.append(this);
				showing = true;
				LayoutManager.getInstance().addPanel(this);
			}
		}
		
		public function close(tween:Boolean = true):void {
			if (showing) {
				if (tween) {
					if (!closeTweening) {
						if (closeTween) closeTween.restart();
						else closeTween = TweenLite.to(this, .5, { alpha:.0, onStart:function():void { closeTweening = true; }, 
							onComplete:function():void { closeTweening = false; close(false); } } );
					}
				}else {
					removeFromParent();
					LayoutManager.getInstance().removePanel(this);
				}
			}
		}
		
		override public function removeFromParent(destroy:Boolean = false):void {
			alpha = 1.0;
			showing = false;
			super.removeFromParent(destroy);
		}
		
		public function showSwitch():void {
			showing ? close() : show();
		}
		
		public function isShowing():Boolean {
			return this.showing;
		}
		
		override public function setSize(w:int, h:int):void {
			const OLD_W:int = actualWidth;
			const OLD_H:int = actualHeight;
			super.setSize(w, h);
			if (OLD_W != 0 && OLD_H != 0) {
				initBackground();	
			}
		}
		
		public function setDefaultBtn(btn:JButton):void {
			if (btn) {
				if (this.hasComponent(btn)) {
					this.defaultBtn = btn;
				}
			}else {
				this.defaultBtn = null;
			}
		}
		
		public function getDefaultBtn():JButton {
			return this.defaultBtn;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			initBackground();
			if (loader) {
				loader.unloadAndStop();
				loader = null;
			}
		}
		
		protected function initBackground():void {
			var bmd:BitmapData = BitmapDataUtil.getScale9BitmapData(ResManager.getInstance().getBitmapData(theme.resName), 
				actualWidth, actualHeight, theme.scale9Rect);
			if (this.background && this.background is Bitmap) {
				const bitmap:Bitmap = background as Bitmap;
				if (bitmap.bitmapData) bitmap.bitmapData.dispose();
				bitmap.bitmapData = bmd;
			}else {
				background = new Bitmap(bmd);
			}
			this.setBackground(background);
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		/**
		 * 从loader中获取资源类
		 * @private
		 * @param	className 资源类名
		 * @return  类
		 */
		protected function getDefinitionByName(className:String):Object {
			try {
				return loader.contentLoaderInfo.applicationDomain.hasDefinition(className) ? loader.contentLoaderInfo.applicationDomain.getDefinition(className) : null;
			}catch (e:Error) {
				Logger.error(toString() + '里的独有资源中获取' + className + '时出错了');
			}
			return null;
        }
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 鼠标按钮按下时，将面板放置顶层
		 * @param	e
		 */
		protected function onMouseDown(e:MouseEvent):void {
			if(autoUp) DepthUtil.bringToTop(this);
		}
		
		private function onResLoadProgress(e:ProgressEvent):void {
			
		}
		
		private function onResLoaded(e:Event):void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onResLoaded);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onResLoadProgress);
			loaded = true;
			show();
		}
	}

}