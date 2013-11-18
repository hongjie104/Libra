package org.libra.ui.flash.theme {
	import flash.geom.Rectangle;
	/**
	 * <p>
	 * 默认的主题
	 * </p>
	 *
	 * @class Skin
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/26/2013
	 * @version 1.0
	 * @see
	 */
	public class Skin {
		
		public static var BACKGROUND:int = 0xCCCCCC;
		
		public static var BUTTON_FACE:int = 0xffffff;
		
		public static var DROPSHADOW:int = 0x000000;
		
		public static var LIST_DEFAULT:int = 0xFFFFFF;
		
		public static var LIST_SELECTED:int = 0xCCCCCC;
		
		public static var LIST_ROLLOVER:int = 0XDDDDDD;
		
		protected var _btnSkin:BtnSkin;
		
		protected var _closeBtnSkin:BtnSkin;
		
		protected var _checkBoxSkin:BtnSkin;
		
		protected var _vScrollDownBtnSkin:BtnSkin;
		
		protected var _vScrollUpBtnSkin:BtnSkin;
		
		protected var _hScrollRightBtnSkin:BtnSkin;
		
		protected var _hScrollLeftBtnSkin:BtnSkin;
		
		protected var _containerSkin:ContainerSkin;
		
		protected var _panelSkin:ContainerSkin;
		
		protected var _frameSkin:ContainerSkin;
		
		protected var _scrollBlockSkin:ScrollBlockSkin;
		
		protected var _progressBarSkin:ProgressBarSkin;
		
		public function Skin() {
			_btnSkin = new BtnSkin(43, 26, 'btn');
			_closeBtnSkin = new BtnSkin(21, 19, 'btnClose');
			_checkBoxSkin = new BtnSkin(54, 20, 'checkBox');
			_vScrollDownBtnSkin = new BtnSkin(16, 16, 'vScrollDownBtn');
			_vScrollUpBtnSkin = new BtnSkin(16, 16, 'vScrollUpBtn');
			_hScrollRightBtnSkin = new BtnSkin(16, 16, 'hScrollRightBtn');
			_hScrollLeftBtnSkin = new BtnSkin(16, 16, 'hScrollLeftBtn');
			_containerSkin = new ContainerSkin(null, null);
			_panelSkin = new ContainerSkin('PanelBg', new Rectangle(3, 3, 11, 6));
			_frameSkin = new ContainerSkin('frameBg', new Rectangle(12, 60, 1, 1));
			_scrollBlockSkin = new ScrollBlockSkin('vScrollThumb', 'vScrollBtnBg', new Rectangle(2, 2, 11, 1), 'hScrollThumb', 'hScrollBtnBg', new Rectangle(2, 2, 1, 11));
			_progressBarSkin = new ProgressBarSkin('progressBar', new Rectangle(5, 0, 1, 16), 'progressBarBg', new Rectangle(34, 0, 1, 18));
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get btnSkin():BtnSkin {
			return _btnSkin;
		}
		
		public function get checkBoxSkin():BtnSkin {
			return _checkBoxSkin;
		}
		
		public function get vScrollDownBtnSkin():BtnSkin {
			return _vScrollDownBtnSkin;
		}
		
		public function get vScrollUpBtnSkin():BtnSkin {
			return _vScrollUpBtnSkin;
		}
		
		public function get hScrollRightBtnSkin():BtnSkin {
			return _hScrollRightBtnSkin;
		}
		
		public function get hScrollLefttBtnSkin():BtnSkin {
			return _hScrollLeftBtnSkin;
		}
		
		public function get containerSkin():ContainerSkin {
			return _containerSkin;
		}
		
		public function get panelSkin():ContainerSkin {
			return _panelSkin;
		}
		
		public function get frameSkin():ContainerSkin {
			return _frameSkin;
		}
		
		public function get scrollBlockSkin():ScrollBlockSkin {
			return _scrollBlockSkin;
		}
		
		public function get progressBarSkin():ProgressBarSkin {
			return _progressBarSkin;
		}
		
		public function get closeBtnSkin():BtnSkin {
			return _closeBtnSkin;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}