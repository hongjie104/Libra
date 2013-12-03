package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.BtnSkin;
	import org.libra.ui.flash.theme.ContainerSkin;
	import org.libra.ui.flash.theme.Skin;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Alert
	 * @author Eddie
	 * @qq 32968210
	 * @date 03/31/2013
	 * @version 1.0
	 * @see
	 */
	public class JAlert extends JFrame {
		
		public static const OK_STR:String = "OK";
		
		public static const CANCEL_STR:String = "Cancel";
		
		public static const YES_STR:String = "Yes";
		
		public static const NO_STR:String = "No";
		
		public static const CLOSE_STR:String = "Close";
		
		public static const OK:int = 1; //00001
		
		public static const CANCEL:int = 2; //00010
		
		public static const YES:int = 4; //00100
		
		public static const NO:int = 8; //01000
		
		public static const CLOSE:int = 16; //10000
		
		private var _msgLabel:JLabel;
		
		private var _okButton:JButton;
		
		private var _cancelButton:JButton;
		
		private var _yesButton:JButton;
		
		private var _noButton:JButton;
		
		private var _closeButton:JButton;
		
		private var _clickedHandler:Function;
		
		public function JAlert(owner:IContainer, w:int = 300, h:int = 200, resName:String = '', barHeight:int = 25, skin:ContainerSkin = null, closeBtnSkin:BtnSkin = null) { 
			super(owner, w, h, resName, true, barHeight, skin, closeBtnSkin);
			
			const uiSkin:Skin = UIManager.instance.skin;
			const btnY:int = h - uiSkin.btnSkin.height - 36;
			_okButton = new JButton(0, btnY, uiSkin.btnSkin, OK_STR);
			_cancelButton = new JButton(0, btnY, uiSkin.btnSkin, CANCEL_STR);
			_yesButton = new JButton(0, btnY, uiSkin.btnSkin, YES_STR);
			_noButton = new JButton(0, btnY, uiSkin.btnSkin, NO_STR);
			_closeButton = new JButton(0, btnY, uiSkin.btnSkin, CLOSE_STR);
			_msgLabel = new JLabel(0, 60);
			_msgLabel.width = w - 40;
			//最大四行，每行20像素
			_msgLabel.height = 80;
			_msgLabel.x = (w - _msgLabel.width) >> 1;
			_msgLabel.wordWrap = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function show(msg:String, finishHandler:Function = null, buttons:int = OK):void { 
			const alert:JAlert = new JAlert(UIManager.instance.uiContainer, 260, 200, '', 25, UIManager.instance.skin.frameSkin, UIManager.instance.skin.closeBtnSkin);
			alert.closeEnabled = false;
			alert._msgLabel.text = msg;
			alert.append(alert._msgLabel);
			alert._clickedHandler = finishHandler;
			
			const btnList:Vector.<JButton> = new Vector.<JButton>();
			if ((buttons & OK) == OK) {
				alert.append(alert._okButton);
				btnList.push(alert._okButton);
			}
			if ((buttons & CANCEL) == CANCEL) {
				alert.append(alert._cancelButton);
				btnList.push(alert._cancelButton);
			}
			if ((buttons & YES) == YES) {
				alert.append(alert._yesButton);
				btnList.push(alert._yesButton);
			}
			if ((buttons & NO) == NO) {
				alert.append(alert._noButton);
				btnList.push(alert._noButton);
			}
			if ((buttons & CLOSE) == CLOSE) {
				alert.append(alert._closeButton);
				btnList.push(alert._closeButton);
			}
			alert.defaultBtn = btnList.length ? btnList[0] : null;
			//所有按钮自动居中显示
			//各个按钮之间的水平间距
			const btnGapH:int = 20;
			const l:int = btnList.length;
			const btnW:int = UIManager.instance.skin.closeBtnSkin.width;
			const startX:int = (alert.width - btnW * l - btnGapH * (l - 1)) >> 1;
			for (var i:int = 0; i < l; i += 1)
				btnList[i].x = startX + i * (btnW + btnGapH);
			
			alert.show();
		}
		
		override public function close(tween:Boolean = true, dispose:Boolean = false):void {
			super.close(tween, dispose);
			_clickedHandler = null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			_okButton.addEventListener(MouseEvent.CLICK, onOk);
			_cancelButton.addEventListener(MouseEvent.CLICK, onCancel);
			_yesButton.addEventListener(MouseEvent.CLICK, onYes);
			_noButton.addEventListener(MouseEvent.CLICK, onNo);
			_closeButton.addEventListener(MouseEvent.CLICK, onClose);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			_okButton.removeEventListener(MouseEvent.CLICK, onOk);
			_cancelButton.removeEventListener(MouseEvent.CLICK, onCancel);
			_yesButton.removeEventListener(MouseEvent.CLICK, onYes);
			_noButton.removeEventListener(MouseEvent.CLICK, onNo);
			_closeButton.removeEventListener(MouseEvent.CLICK, onClose);
		}
		
		private function onClose(e:MouseEvent):void {
			if (_clickedHandler != null)
				_clickedHandler(JAlert.CLOSE);
			this.close(true, true);
		}
		
		private function onNo(e:MouseEvent):void {
			if (_clickedHandler != null)
				_clickedHandler(JAlert.NO);
			close(true, true);
		}
		
		private function onYes(e:MouseEvent):void {
			if (_clickedHandler != null)
				_clickedHandler(JAlert.YES);
			close(true, true);
		}
		
		private function onCancel(e:MouseEvent):void {
			if (_clickedHandler != null)
				_clickedHandler(JAlert.CANCEL);
			close(true, true);
		}
		
		private function onOk(e:MouseEvent):void {
			if (_clickedHandler != null)
				_clickedHandler(JAlert.OK);
			close(true, true);
		}
	}

}