package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.DefaultFrameTheme;
	import org.libra.ui.flash.theme.DefaultPanelTheme;
	import org.libra.ui.flash.theme.DefaultTheme;
	
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
		
		private var $msgLabel:JLabel;
		
		private var $okButton:JButton;
		
		private var $cancelButton:JButton;
		
		private var $yesButton:JButton;
		
		private var $noButton:JButton;
		
		private var $closeButton:JButton;
		
		private var $clickedHandler:Function;
		
		public function JAlert(owner:IContainer, theme:DefaultFrameTheme, w:int = 300, h:int = 200, resName:String = '', barHeight:int = 25) { 
			super(owner, theme, w, h, resName, true, barHeight);
			
			const uiTheme:DefaultTheme = UIManager.getInstance().theme;
			const btnY:int = h - uiTheme.btnTheme.height - 36;
			$okButton = new JButton(uiTheme.btnTheme, 0, btnY, OK_STR);
			$cancelButton = new JButton(uiTheme.btnTheme, 0, btnY, CANCEL_STR);
			$yesButton = new JButton(uiTheme.btnTheme, 0, btnY, YES_STR);
			$noButton = new JButton(uiTheme.btnTheme, 0, btnY, NO_STR);
			$closeButton = new JButton(uiTheme.btnTheme, 0, btnY, CLOSE_STR);
			$msgLabel = new JLabel(uiTheme.labelTheme, 0, 60);
			$msgLabel.width = w - 40;
			//最大四行，每行20像素
			$msgLabel.height = 80;
			$msgLabel.x = (w - $msgLabel.width) >> 1;
			$msgLabel.wordWrap = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function show(msg:String, finishHandler:Function = null, buttons:int = OK):void { 
			const alert:JAlert = new JAlert(UIManager.getInstance().uiContainer, UIManager.getInstance().theme.frameTheme, 260, 200);
			alert.$msgLabel.text = msg;
			alert.append(alert.$msgLabel);
			alert.$clickedHandler = finishHandler;
			
			const btnList:Vector.<JButton> = new Vector.<JButton>();
			if ((buttons & OK) == OK) {
				alert.append(alert.$okButton);
				btnList.push(alert.$okButton);
			}
			if ((buttons & CANCEL) == CANCEL) {
				alert.append(alert.$cancelButton);
				btnList.push(alert.$cancelButton);
			}
			if ((buttons & YES) == YES) {
				alert.append(alert.$yesButton);
				btnList.push(alert.$yesButton);
			}
			if ((buttons & NO) == NO) {
				alert.append(alert.$noButton);
				btnList.push(alert.$noButton);
			}
			if ((buttons & CLOSE) == CLOSE) {
				alert.append(alert.$closeButton);
				btnList.push(alert.$closeButton);
			}
			//所有按钮自动居中显示
			//各个按钮之间的水平间距
			const btnGapH:int = 20;
			const l:int = btnList.length;
			const btnW:int = UIManager.getInstance().theme.btnTheme.width;
			const startX:int = (alert.width - btnW * l - btnGapH * (l - 1)) >> 1;
			for (var i:int = 0; i < l; i += 1)
				btnList[i].x = startX + i * (btnW + btnGapH);
			
			alert.show();
		}
		
		override public function close(tween:Boolean = true, destroy:Boolean = false):void {
			super.close(tween, destroy);
			$clickedHandler = null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			$okButton.addEventListener(MouseEvent.CLICK, onOk);
			$cancelButton.addEventListener(MouseEvent.CLICK, onCancel);
			$yesButton.addEventListener(MouseEvent.CLICK, onYes);
			$noButton.addEventListener(MouseEvent.CLICK, onNo);
			$closeButton.addEventListener(MouseEvent.CLICK, onClose);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			$okButton.removeEventListener(MouseEvent.CLICK, onOk);
			$cancelButton.removeEventListener(MouseEvent.CLICK, onCancel);
			$yesButton.removeEventListener(MouseEvent.CLICK, onYes);
			$noButton.removeEventListener(MouseEvent.CLICK, onNo);
			$closeButton.removeEventListener(MouseEvent.CLICK, onClose);
		}
		
		private function onClose(e:MouseEvent):void {
			if ($clickedHandler != null)
				$clickedHandler(JAlert.CLOSE);
			this.close(true, true);
		}
		
		private function onNo(e:MouseEvent):void {
			if ($clickedHandler != null)
				$clickedHandler(JAlert.NO);
			close(true, true);
		}
		
		private function onYes(e:MouseEvent):void {
			if ($clickedHandler != null)
				$clickedHandler(JAlert.YES);
			close(true, true);
		}
		
		private function onCancel(e:MouseEvent):void {
			if ($clickedHandler != null)
				$clickedHandler(JAlert.CANCEL);
			close(true, true);
		}
		
		private function onOk(e:MouseEvent):void {
			if ($clickedHandler != null)
				$clickedHandler(JAlert.OK);
			close(true, true);
		}
	}

}