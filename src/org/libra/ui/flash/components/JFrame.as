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
		
		protected var _bar:Sprite;
		
		protected var _closeBtn:JButton;
		
		protected var _barHeight:int;
		
		protected var _dragBounds:Rectangle;
		
		protected var _title:JLabel;
		
		protected var _closeEnabled:Boolean;
		
		protected var _closeBtnSkin:BtnSkin;
		
		protected var _dragBarEnabled:Boolean;
		
		public function JFrame(owner:IContainer, w:int = 300, h:int = 200, resName:String = '', model:Boolean = false, barHeight:int = 25, skin:ContainerSkin = null, closeBtnSkin:BtnSkin = null) {
 			super(owner, w, h, resName, model, skin ? skin : UIManager.instance.skin.frameSkin);
			this._barHeight = barHeight;
			_closeBtnSkin = closeBtnSkin ? closeBtnSkin : UIManager.instance.skin.closeBtnSkin;
			closeEnabled = true;
			dragBarEnabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			if (!this._dragBounds) this._dragBounds = new Rectangle();
			_dragBounds.x = 40 - w;
			_dragBounds.y = 0;
			const stage:Stage = UIManager.instance.stage;
			_dragBounds.width = stage.stageWidth + w - 80;
			_dragBounds.height = stage.stageHeight - _barHeight;
			
			renderTitle();
		}
		
		public function set closeEnabled(bool:Boolean):void {
			if (this._closeEnabled != bool) {
				this._closeEnabled = bool;
				invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function set dragBarEnabled(bool:Boolean):void {
			if (this._dragBarEnabled != bool) {
				this._dragBarEnabled = bool;
				invalidate(InvalidationFlag.STATE);
			}
		}
		
		public function set title(val:String):void {
			this._title.text = val;
		}
		
		override public function clone():Component {
			return new JFrame(_owner, _actualWidth, _actualHeight, _resName, _model, _barHeight, _skin, _closeBtnSkin);
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
			_title = new JLabel(0, 4, 'JFrame Title');
			_title.setSize(_actualWidth, 20);
			_title.textAlign = 'center';
			this.append(_title);
			
			_bar = new Sprite();
			GraphicsUtil.drawRect(_bar.graphics, 0, 0, _actualWidth, _barHeight, 0, .0);
			this.addChild(_bar);
			
			_closeBtn = new JButton(0, 0, _closeBtnSkin);
			_closeBtn.setLocation(_actualWidth - _closeBtn.width - 6, 6);
			if(_closeEnabled)
				this.append(_closeBtn);
		}
		
		override protected function resize():void {
			super.resize();
			_closeBtn.setLocation(_actualWidth - _closeBtn.width - 6, 6);
		}
		
		override protected function refreshState():void {
			_closeEnabled ? append(_closeBtn) : remove(_closeBtn);
			_dragBarEnabled ? addBarDragListeners() : removeBarDragListeners();
		}
		
		private function addBarDragListeners():void {
			this._bar.addEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
			this._bar.addEventListener(MouseEvent.MOUSE_UP, onBarMouseUp);
		}
		
		private function removeBarDragListeners():void {
			this._bar.removeEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
			this._bar.removeEventListener(MouseEvent.MOUSE_UP, onBarMouseUp);
		}
		
		private function renderTitle():void {
			if (_inited) {
				_title.width = _actualWidth;
				_title.textAlign = 'center';
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			if (_dragBarEnabled) addBarDragListeners();
			this._closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClikced);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			if (_dragBarEnabled) removeBarDragListeners();
			this._closeBtn.removeEventListener(MouseEvent.CLICK, onCloseBtnClikced);
		}
		
		private function onBarMouseUp(e:MouseEvent):void {
			this.stopDrag();
		}
		
		private function onBarMouseDown(e:MouseEvent):void {
			this.startDrag(false, _dragBounds);
		}
		
		private function onCloseBtnClikced(e:MouseEvent):void {
			this.close();
			if (!UIManager.UI_EDITOR) e.stopPropagation();
		}
	}

}