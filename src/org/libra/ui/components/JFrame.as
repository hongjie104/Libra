package org.libra.ui.components {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.libra.ui.base.Container;
	import org.libra.ui.managers.UIManager;
	import org.libra.ui.utils.ResManager;
	import org.libra.utils.BitmapDataUtil;
	import org.libra.utils.GraphicsUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JFrame
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class JFrame extends JPanel {
		
		private var bar:Sprite;
		
		private var closeBtn:JButton;
		
		private var barHeight:int;
		
		private var dragBounds:Rectangle;
		
		private var title:JLabel;
		
		public function JFrame(w:int, h:int, parent:Container = null, x:int = 0, y:int = 0, barHeight:int = 25) { 
			this.barHeight = barHeight;
			super(w, h, parent, x, y);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			if (!this.dragBounds) this.dragBounds = new Rectangle();
			dragBounds.x = 40 - w;
			dragBounds.y = 0;
			var stage:Stage = UIManager.getInstance().getStage();
			dragBounds.width = stage.stageWidth + w - 80;
			dragBounds.height = stage.stageHeight - barHeight;
		}
		
		override public function toString():String {
			return 'JFrame';
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function draw():void {
			super.draw();
			bar = new Sprite();
			GraphicsUtil.drawRect(bar.graphics, 0, 0, $width, barHeight, 0, .0);
			this.addChild(bar);
			
			closeBtn = new JButton(0, 0, '', 'btnClose');
			closeBtn.setSize(21, 19);
			closeBtn.setLocation($width - closeBtn.width - 6, 6);
			this.append(closeBtn);
		}
		
		override protected function initBackground():void {
			this.setBackground(new Bitmap(BitmapDataUtil.getScaledBitmapData(ResManager.getInstance().getBitmapData('frameBg'), 
				$width, $height, new Rectangle(12, 60, 1, 1))));
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.bar.addEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
			this.bar.addEventListener(MouseEvent.MOUSE_UP, onBarMouseUp);
			this.closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClikced);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.bar.removeEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
			this.bar.removeEventListener(MouseEvent.MOUSE_UP, onBarMouseUp);
			this.closeBtn.removeEventListener(MouseEvent.CLICK, onCloseBtnClikced);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		private function onBarMouseUp(e:MouseEvent):void {
			this.stopDrag();
		}
		
		private function onBarMouseDown(e:MouseEvent):void {
			this.startDrag(false, dragBounds);
		}
		
		private function onCloseBtnClikced(e:MouseEvent):void {
			this.close();
		}
	}

}