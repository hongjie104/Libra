package org.libra.ui.flash.components {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.BtnSkin;
	import org.libra.ui.flash.theme.ContainerSkin;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.utils.displayObject.GraphicsUtil;
	
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
		
		protected var $bar:Sprite;
		
		protected var $closeBtn:JButton;
		
		protected var $barHeight:int;
		
		protected var $dragBounds:Rectangle;
		
		protected var $title:JLabel;
		
		protected var $closeEnabled:Boolean;
		
		protected var $closeBtnSkin:BtnSkin;
		
		protected var $dragBarEnabled:Boolean;
		
		public function JFrame(owner:IContainer, w:int = 300, h:int = 200, resName:String = '', model:Boolean = false, barHeight:int = 25, skin:ContainerSkin = null, closeBtnSkin:BtnSkin = null) {
 			super(owner, w, h, resName, model, skin ? skin : UIManager.getInstance().skin.frameSkin);
			this.$barHeight = barHeight;
			$closeBtnSkin = closeBtnSkin ? closeBtnSkin : UIManager.getInstance().skin.closeBtnSkin;
			closeEnabled = true;
			dragBarEnabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			if (!this.$dragBounds) this.$dragBounds = new Rectangle();
			$dragBounds.x = 40 - w;
			$dragBounds.y = 0;
			const stage:Stage = UIManager.getInstance().stage;
			$dragBounds.width = stage.stageWidth + w - 80;
			$dragBounds.height = stage.stageHeight - $barHeight;
			
			renderTitle();
		}
		
		public function set closeEnabled(bool:Boolean):void {
			if (this.$closeEnabled != bool) {
				this.$closeEnabled = bool;
				invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function set dragBarEnabled(bool:Boolean):void {
			if (this.$dragBarEnabled != bool) {
				this.$dragBarEnabled = bool;
				invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function set title(val:String):void {
			this.$title.text = val;
		}
		
		override public function clone():Component {
			return new JFrame($owner, $actualWidth, $actualHeight, $resName, $model, $barHeight, $skin, $closeBtnSkin);
		}
		
		override public function dispose():void {
			super.dispose();
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
			//面板的标题，默认距离顶部4个像素
			$title = new JLabel(0, 4, 'JFrame Title');
			$title.setSize($actualWidth, 20);
			$title.textAlign = 'center';
			this.append($title);
			
			$bar = new Sprite();
			GraphicsUtil.drawRect($bar.graphics, 0, 0, $actualWidth, $barHeight, 0, .0);
			this.addChild($bar);
			
			$closeBtn = new JButton(0, 0, $closeBtnSkin);
			$closeBtn.setLocation($actualWidth - $closeBtn.width - 6, 6);
			if($closeEnabled)
				this.append($closeBtn);
		}
		
		override protected function resize():void {
			super.resize();
			$closeBtn.setLocation($actualWidth - $closeBtn.width - 6, 6);
		}
		
		override protected function refreshState():void {
			$closeEnabled ? append($closeBtn) : remove($closeBtn);
			$dragBarEnabled ? addBarDragListeners() : removeBarDragListeners();
		}
		
		private function addBarDragListeners():void {
			this.$bar.addEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
			this.$bar.addEventListener(MouseEvent.MOUSE_UP, onBarMouseUp);
		}
		
		private function removeBarDragListeners():void {
			this.$bar.removeEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
			this.$bar.removeEventListener(MouseEvent.MOUSE_UP, onBarMouseUp);
		}
		
		private function renderTitle():void {
			if ($inited) {
				$title.width = $actualWidth;
				$title.textAlign = 'center';
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			if ($dragBarEnabled) addBarDragListeners();
			this.$closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClikced);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			if ($dragBarEnabled) removeBarDragListeners();
			this.$closeBtn.removeEventListener(MouseEvent.CLICK, onCloseBtnClikced);
		}
		
		private function onBarMouseUp(e:MouseEvent):void {
			this.stopDrag();
		}
		
		private function onBarMouseDown(e:MouseEvent):void {
			this.startDrag(false, $dragBounds);
		}
		
		private function onCloseBtnClikced(e:MouseEvent):void {
			this.close();
			if (!UIManager.UI_EDITOR) e.stopPropagation();
		}
	}

}