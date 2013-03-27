package org.libra.ui.flash.components {
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.interfaces.IPanel;
	import org.libra.ui.flash.managers.LayoutManager;
	import org.libra.ui.flash.theme.DefaultPanelTheme;
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
		
		private var closeTween:TweenLite;
		
		private var closeTweening:Boolean;
		
		/**
		 * 鼠标按下时，是否自动放到显示层的最上层
		 */
		private var autoUp:Boolean;
		
		public function JPanel(owner:IContainer, theme:DefaultPanelTheme, w:int = 300, h:int = 200, x:int = 0, y:int = 0, model:Boolean = false) { 
			super(x, y);
			this.theme = theme;
			this.setSize(w, h);
			this.owner = owner;
			this.model = model;
			closeTweening = showing = false;
			autoUp = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function isModel():Boolean {
			return model;
		}
		
		public function show():void {
			if (showing) return;
			this.owner.append(this);
			showing = true;
			LayoutManager.getInstance().addPanel(this);
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
		
		public function setAutoUp(bool:Boolean):void {
			this.autoUp = bool;
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
	}

}