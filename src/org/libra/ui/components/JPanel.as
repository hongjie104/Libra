package org.libra.ui.components {
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.libra.ui.base.Container;
	import org.libra.ui.utils.BitmapDataUtil;
	import org.libra.ui.utils.DepthUtil;
	
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
	public class JPanel extends Container {
		
		protected var owner:Container;
		protected var showing:Boolean;
		
		protected var defaultBtn:JButton;
		
		public function JPanel(w:int, h:int, owner:Container, x:int = 0, y:int = 0) { 
			super(x, y);
			this.setSize(w, h);
			this.owner = owner;
			showing = false;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		public function show():void {
			if (showing) return;
			this.owner.append(this);
			showing = true;
		}
		
		public function close():void {
			if (showing) {
				this.owner.remove(this);
				showing = false;
			}
		}
		
		override public function setSize(w:int, h:int):void {
			const OLD_W:int = $width;
			const OLD_H:int = $height;
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
		
		override protected function draw():void {
			super.draw();
			initBackground();
		}
		
		protected function initBackground():void {
			if (this.background) {
				if (this.background is Bitmap) (background as Bitmap).bitmapData.dispose();
			}
			this.setBackground(new Bitmap(BitmapDataUtil.getScaledBitmapData(new PanelBg(), 
				$width, $height, new Rectangle(3, 3, 11, 6))));
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
			DepthUtil.bringToTop(this);
		}
	}

}