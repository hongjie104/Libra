package org.libra.ui.flash.theme {
	import flash.geom.Rectangle;
	/**
	 * <p>
	 * 默认的主题
	 * </p>
	 *
	 * @class DefaultTheme
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/26/2013
	 * @version 1.0
	 * @see
	 */
	public class DefaultTheme {
		
		public static var BACKGROUND:int = 0xCCCCCC;
		
		public static var BUTTON_FACE:int = 0xffffff;
		
		public static var DROPSHADOW:int = 0x000000;
		
		public static var LIST_DEFAULT:int = 0xFFFFFF;
		
		public static var LIST_SELECTED:int = 0xCCCCCC;
		
		public static var LIST_ROLLOVER:int = 0XDDDDDD;
		
		protected var $btnTheme:DefaultBtnTheme;
		
		protected var $checkBoxTheme:DefaultBtnTheme;
		
		protected var $vScrollDownBtnTheme:DefaultBtnTheme;
		
		protected var $vScrollUpBtnTheme:DefaultBtnTheme;
		
		protected var $hScrollRightBtnTheme:DefaultBtnTheme;
		
		protected var $hScrollLeftBtnTheme:DefaultBtnTheme;
		
		protected var $labelTheme:DefaultTextTheme;
		
		protected var $textAreaTheme:DefaultTextTheme;
		
		protected var $textFieldTheme:DefaultTextTheme;
		
		protected var $panelTheme:DefaultPanelTheme;
		
		protected var $frameTheme:DefaultFrameTheme;
		
		protected var $scrollBlockTheme:DefaultScrollBlockTheme;
		
		protected var $comboBoxTheme:DefaultComboBoxTheme; 
		
		protected var $progressBarTheme:DefaultProgressBarTheme;
		
		protected var $pageCounterTheme:DefaultPageCounterTheme;
		
		public function DefaultTheme() {
			$btnTheme = new DefaultBtnTheme(43, 26, JFont.FONT_BTN, Filter.BLACK, 'btn');
			$checkBoxTheme = new DefaultBtnTheme(54, 20, JFont.FONT_BTN, Filter.BLACK, 'checkBtn');
			$vScrollDownBtnTheme = new DefaultBtnTheme(16, 16, JFont.FONT_BTN, Filter.BLACK, 'vScrollDownBtn');
			$vScrollUpBtnTheme = new DefaultBtnTheme(16, 16, JFont.FONT_BTN, Filter.BLACK, 'vScrollUpBtn');
			$hScrollRightBtnTheme = new DefaultBtnTheme(16, 16, JFont.FONT_BTN, Filter.BLACK, 'hScrollRightBtn');
			$hScrollLeftBtnTheme = new DefaultBtnTheme(16, 16, JFont.FONT_BTN, Filter.BLACK, 'hScrollLeftBtn');
			$labelTheme = new DefaultTextTheme(120, 20, JFont.FONT_LABEL, Filter.BLACK);
			$textAreaTheme = new DefaultTextTheme(200, 100, JFont.FONT_LABEL, Filter.BLACK);
			$textFieldTheme = new DefaultTextTheme(120, 20, JFont.FONT_INPUT, Filter.BLACK);
			$panelTheme = new DefaultPanelTheme('PanelBg', new Rectangle(3, 3, 11, 6));
			$frameTheme = new DefaultFrameTheme('frameBg', new Rectangle(12, 60, 1, 1));
			$scrollBlockTheme = new DefaultScrollBlockTheme('vScrollThumb', 'vScrollBtnBg', new Rectangle(2, 2, 11, 1), 'hScrollThumb', 'hScrollBtnBg', new Rectangle(2, 2, 1, 11));
			$comboBoxTheme = new DefaultComboBoxTheme($labelTheme, $vScrollDownBtnTheme);
			$progressBarTheme = new DefaultProgressBarTheme('progressBar', new Rectangle(5, 0, 1, 16), 'progressBarBg', new Rectangle(34, 0, 1, 18));
			$pageCounterTheme = new DefaultPageCounterTheme($hScrollLeftBtnTheme, $hScrollRightBtnTheme, $labelTheme);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get btnTheme():DefaultBtnTheme {
			return $btnTheme;
		}
		
		public function get checkBoxTheme():DefaultBtnTheme {
			return $checkBoxTheme;
		}
		
		public function get vScrollDownBtnTheme():DefaultBtnTheme {
			return $vScrollDownBtnTheme;
		}
		
		public function get vScrollUpBtnTheme():DefaultBtnTheme {
			return $vScrollUpBtnTheme;
		}
		
		public function get hScrollRightBtnTheme():DefaultBtnTheme {
			return $hScrollRightBtnTheme;
		}
		
		public function get hScrollLefttBtnTheme():DefaultBtnTheme {
			return $hScrollLeftBtnTheme;
		}
		
		public function get labelTheme():DefaultTextTheme {
			return $labelTheme;
		}
		
		public function get textAreaTheme():DefaultTextTheme {
			return $textAreaTheme;
		}
		
		public function get textFieldTheme():DefaultTextTheme {
			return $textFieldTheme;
		}
		
		public function get panelTheme():DefaultPanelTheme {
			return $panelTheme;
		}
		
		public function get frameTheme():DefaultFrameTheme {
			return $frameTheme;
		}
		
		public function get scrollBlockTheme():DefaultScrollBlockTheme {
			return $scrollBlockTheme;
		}
		
		public function get comboBoxTheme():DefaultComboBoxTheme {
			return $comboBoxTheme
		}
		
		public function get progressBarTheme():DefaultProgressBarTheme {
			return $progressBarTheme;
		}
		
		public function get pageCountTheme():DefaultPageCounterTheme {
			return $pageCounterTheme;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}