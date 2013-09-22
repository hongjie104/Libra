package org.libra.ui.flash.components {
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
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
		
		protected var $owner:IContainer;
		
		/**
		 * 当该面试显示时，其他面板是否需要是不能响应鼠标事件
		 * @private
		 * @default false
		 */
		protected var $model:Boolean;
		
		protected var $showing:Boolean;
		
		protected var $defaultBtn:JButton;
		
		protected var $closeTween:TweenLite;
		
		protected var $closeTweening:Boolean;
		
		/**
		 * 面板独有的资源库名，如果面板没有独有的资源库，那么resName就为空字符串
		 * @private
		 * @default ''
		 */
		protected var $resName:String;
		
		/**
		 * 是否加载了资源库
		 * @private
		 * @default false
		 */
		protected var $loaded:Boolean;
		
		/**
		 * 鼠标按下时，是否自动放到显示层的最上层
		 * @private
		 * @default true
		 */
		protected var $autoUp:Boolean;
		
		/**
		 * 是不是全屏的面板,默认值是false
		 * @private
		 * @default false
		 */
		protected var $fullScreen:Boolean;
		
		/**
		 * 打开面板时是否要自动居中显示，默认值true
		 * @private
		 * @default true
		 */
		protected var $autoCenter:Boolean;
		
		protected var $activated:Boolean;
		
		public function JPanel(owner:IContainer, w:int = 300, h:int = 200, resName:String = '', model:Boolean = false, skin:ContainerSkin = null) { 
			super(0, 0, skin ? skin : UIManager.getInstance().skin.panelSkin);
			this.setSize(w, h);
			this.$owner = owner;
			this.$model = model;
			this.$resName = resName;
			$closeTweening = $showing = false;
			$autoCenter = $autoUp = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get model():Boolean {
			return $model;
		}
		
		public function show():void {
			if (this.$resName && !$loaded) {
				//加载独有的资源库去
				UIManager.getInstance().showLoading();
				$loader = new Loader();
				$loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onResLoaded);
				$loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onResLoadProgress);
				$loader.load(new URLRequest(URI.UI_URL + this.$resName + '.swf'));
			}else {
				if ($showing) return;
				this.$owner.append(this);
				$showing = true;
				LayoutManager.getInstance().addPanel(this);
				UIManager.getInstance().keyPoll.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			}
		}
		
		public function close(tween:Boolean = true, destroy:Boolean = false):void {
			if ($showing) {
				if (tween) {
					if (!$closeTweening) {
						if ($closeTween) $closeTween.restart();
						else $closeTween = TweenLite.to(this, .5, { alpha:.0, onStart:function():void { $closeTweening = true; }, 
							onComplete:function():void { $closeTweening = false; close(false, destroy); } } );
					}
				}else {
					LayoutManager.getInstance().removePanel(this);
					removeFromParent(destroy);
					UIManager.getInstance().keyPoll.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				}
			}
		}
		
		override public function removeFromParent(destroy:Boolean = false):void {
			alpha = 1.0;
			$showing = false;
			super.removeFromParent(destroy);
		}
		
		public function showSwitch():void {
			$showing ? close() : show();
		}
		
		/* INTERFACE org.libra.ui.flash.interfaces.IPanel */
		
		public function get loader():Loader {
			return $loader;
		}
		
		public function get showing():Boolean {
			return this.$showing;
		}
		
		public function set defaultBtn(btn:JButton):void {
			if (btn) {
				if (this.hasComponent(btn)) {
					this.$defaultBtn = btn;
				}
			}else {
				this.$defaultBtn = null;
			}
		}
		
		public function get defaultBtn():JButton {
			return this.$defaultBtn;
		}
		
		public function get autoUp():Boolean {
			return $autoUp;
		}
		
		public function set autoUp(value:Boolean):void {
			$autoUp = value;
		}
		
		public function get fullScreen():Boolean {
			return $fullScreen;
		}
		
		public function get autoCenter():Boolean {
			return $autoCenter;
		}
		
		public function set autoCenter(val:Boolean):void{
			$autoCenter = val;
		}
		
		public function get activated():Boolean {
			return $activated;
		}
		
		public function set activated(value:Boolean):void {
			$activated = value;
		}
		
		override public function clone():Component {
			return new JPanel(this.$owner, $actualWidth, $actualHeight, $resName, $model, $skin);
		}
		
		override public function toXML():XML {
			const xml:XML = super.toXML();
			if (this.$id.indexOf('component') == -1) {
				xml["@var"] = this.$id;
			}
			for (var i:int = 0; i < $numComponent; i += 1) {
				var tmpXML:XML = this.$componentList[i].toXML();
				if($componentList[i].id.indexOf('component') == -1){
					tmpXML["@var"] = $componentList[i].id;
				}
				xml.appendChild(tmpXML);
			}
			return xml;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			if ($loader) {
				$loader.unloadAndStop();
				$loader = null;
			}
		}
		
		protected function getBmdFromLoader(bmdName:String):BitmapData {
			var c:Class = ReflectUtil.getDefinitionByNameFromLoader(bmdName, $loader) as Class;
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
			if($autoUp) DepthUtil.bringToTop(this);
		}
		
		protected function onResLoadProgress(e:ProgressEvent):void {
			UIManager.getInstance().setLoadingProgress(e.bytesLoaded / e.bytesTotal);
		}
		
		protected function onResLoaded(e:Event):void {
			$loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onResLoaded);
			$loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onResLoadProgress);
			$loaded = true;
			UIManager.getInstance().closeLoading();
			show();
		}
		
		protected function onKeyUp(e:KeyboardEvent):void {
			if (this.$activated) {
				if (e.keyCode == Keyboard.ENTER) {
					if (this.$defaultBtn) $defaultBtn.doClick();
				}
			}
		}
	}

}