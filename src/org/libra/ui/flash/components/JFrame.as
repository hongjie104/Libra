package org.libra.ui.flash.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.invalidation.InvalidationFlag;
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
		
		private var closeEnabled:Boolean;
		
		private var dragBarEnabled:Boolean;
		
		public function JFrame(parent:IContainer, w:int = 300, h:int = 200, x:int = 0, y:int = 0, barHeight:int = 25) { 
			this.barHeight = barHeight;
			super(parent, w, h, x, y);
			closeEnabled = true;
			closeEnabled = true;
			dragBarEnabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			if (!this.dragBounds) this.dragBounds = new Rectangle();
			dragBounds.x = 40 - w;
			dragBounds.y = 0;
			const stage:Stage = UIManager.getInstance().stage;
			dragBounds.width = stage.stageWidth + w - 80;
			dragBounds.height = stage.stageHeight - barHeight;
			
			renderTitle();
		}
		
		public function setCloseEnabled(bool:Boolean):void {
			if (this.closeEnabled != bool) {
				this.closeEnabled = bool;
				invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function setDragBarEnabled(bool:Boolean):void {
			if (this.dragBarEnabled != bool) {
				this.dragBarEnabled = bool;
				invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function setTitle(val:String):void {
			this.title.text = val;
		}
		
		override public function destroy():void {
			super.destroy();
			removeBarDragListeners();
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters and setter
		-------------------------------------------------------------------------------------------*/
		
		override public function set width(value:Number):void {
			super.width = value;
			renderTitle();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			bar = new Sprite();
			GraphicsUtil.drawRect(bar.graphics, 0, 0, actualWidth, barHeight, 0, .0);
			this.addChild(bar);
			
			closeBtn = new JButton(0, 0, '', 'btnClose');
			closeBtn.setSize(21, 19);
			closeBtn.setLocation(actualWidth - closeBtn.width - 6, 6);
			if(closeEnabled)
				this.append(closeBtn);
			
			//面板的标题，默认距离顶部4个像素
			title = new JLabel(0, 4, 'JFrame Title');
			title.setSize(actualWidth, 20);
			title.textAlign = 'center';
			this.append(title);
		}
		
		override protected function resize():void {
			super.resize();
			closeBtn.setLocation(actualWidth - closeBtn.width - 6, 6);
		}
		
		override protected function refreshState():void {
			closeEnabled ? append(closeBtn) : remove(closeBtn);
			dragBarEnabled ? addBarDragListeners() : removeBarDragListeners();
		}
		
		override protected function initBackground():void {
			var bmd:BitmapData = BitmapDataUtil.getScale9BitmapData(ResManager.getInstance().getBitmapData('frameBg'), 
				actualWidth, actualHeight, new Rectangle(12, 60, 1, 1));
			if (this.background && this.background is Bitmap) {
				const bitmap:Bitmap = background as Bitmap;
				if (bitmap.bitmapData) bitmap.bitmapData.dispose();
				bitmap.bitmapData = bmd;
			}else {
				background = new Bitmap(bmd);
			}
			setBackground(background);
		}
		
		private function addBarDragListeners():void {
			this.bar.addEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
			this.bar.addEventListener(MouseEvent.MOUSE_UP, onBarMouseUp);
		}
		
		private function removeBarDragListeners():void {
			this.bar.removeEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
			this.bar.removeEventListener(MouseEvent.MOUSE_UP, onBarMouseUp);
		}
		
		private function renderTitle():void {
			if (inited) {
				title.width = actualWidth;
				title.textAlign = 'center';
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			if (dragBarEnabled) addBarDragListeners();
			this.closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClikced);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			if (dragBarEnabled) removeBarDragListeners();
			this.closeBtn.removeEventListener(MouseEvent.CLICK, onCloseBtnClikced);
		}
		
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