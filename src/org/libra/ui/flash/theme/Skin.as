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
		
		protected var $btnSkin:BtnSkin;
		
		protected var $closeBtnSkin:BtnSkin;
		
		protected var $checkBoxSkin:BtnSkin;
		
		protected var $vScrollDownBtnSkin:BtnSkin;
		
		protected var $vScrollUpBtnSkin:BtnSkin;
		
		protected var $hScrollRightBtnSkin:BtnSkin;
		
		protected var $hScrollLeftBtnSkin:BtnSkin;
		
		protected var $containerSkin:ContainerSkin;
		
		protected var $panelSkin:ContainerSkin;
		
		protected var $frameSkin:ContainerSkin;
		
		protected var $scrollBlockSkin:ScrollBlockSkin;
		
		protected var $progressBarSkin:ProgressBarSkin;
		
		public function Skin() {
			$btnSkin = new BtnSkin(43, 26, 'btn');
			$closeBtnSkin = new BtnSkin(21, 19, 'btnClose');
			$checkBoxSkin = new BtnSkin(54, 20, 'checkBox');
			$vScrollDownBtnSkin = new BtnSkin(16, 16, 'vScrollDownBtn');
			$vScrollUpBtnSkin = new BtnSkin(16, 16, 'vScrollUpBtn');
			$hScrollRightBtnSkin = new BtnSkin(16, 16, 'hScrollRightBtn');
			$hScrollLeftBtnSkin = new BtnSkin(16, 16, 'hScrollLeftBtn');
			$containerSkin = new ContainerSkin(null, null);
			$panelSkin = new ContainerSkin('PanelBg', new Rectangle(3, 3, 11, 6));
			$frameSkin = new ContainerSkin('frameBg', new Rectangle(12, 60, 1, 1));
			$scrollBlockSkin = new ScrollBlockSkin('vScrollThumb', 'vScrollBtnBg', new Rectangle(2, 2, 11, 1), 'hScrollThumb', 'hScrollBtnBg', new Rectangle(2, 2, 1, 11));
			$progressBarSkin = new ProgressBarSkin('progressBar', new Rectangle(5, 0, 1, 16), 'progressBarBg', new Rectangle(34, 0, 1, 18));
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get btnSkin():BtnSkin {
			return $btnSkin;
		}
		
		public function get checkBoxSkin():BtnSkin {
			return $checkBoxSkin;
		}
		
		public function get vScrollDownBtnSkin():BtnSkin {
			return $vScrollDownBtnSkin;
		}
		
		public function get vScrollUpBtnSkin():BtnSkin {
			return $vScrollUpBtnSkin;
		}
		
		public function get hScrollRightBtnSkin():BtnSkin {
			return $hScrollRightBtnSkin;
		}
		
		public function get hScrollLefttBtnSkin():BtnSkin {
			return $hScrollLeftBtnSkin;
		}
		
		public function get containerSkin():ContainerSkin {
			return $containerSkin;
		}
		
		public function get panelSkin():ContainerSkin {
			return $panelSkin;
		}
		
		public function get frameSkin():ContainerSkin {
			return $frameSkin;
		}
		
		public function get scrollBlockSkin():ScrollBlockSkin {
			return $scrollBlockSkin;
		}
		
		public function get progressBarSkin():ProgressBarSkin {
			return $progressBarSkin;
		}
		
		public function get closeBtnSkin():BtnSkin {
			return $closeBtnSkin;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}