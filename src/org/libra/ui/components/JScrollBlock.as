package org.libra.ui.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import org.libra.ui.base.Component;
	import org.libra.ui.Constants;
	import org.libra.ui.utils.ResManager;
	import org.libra.utils.BitmapDataUtil;
	
	/**
	 * <p>
	 * 滚动条中的滑块
	 * </p>
	 *
	 * @class JScrollBlock
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-03-2012
	 * @version 1.0
	 * @see
	 */
	public class JScrollBlock extends Component {
		
		/**
		 * 背景层
		 */
		private var back:Bitmap;
		
		/**
		 * 前景层
		 */
		private var fore:Bitmap;
		
		/**
		 * 方向。水平的还是垂直的
		 */
		private var orientation:int;
		
		public function JScrollBlock(orientation:int = 1, x:int = 0, y:int = 0) {
			super(x, y);
			this.orientation = orientation;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		public function updateBack():void {
			if (back.bitmapData) back.bitmapData.dispose();
			if (orientation == Constants.HORIZONTAL) {
				var source:BitmapData = ResManager.getInstance().getBitmapData('hScrollBtnBg');
				back.bitmapData = BitmapDataUtil.getScaledBitmapData(source, $width, $height, new Rectangle(2, 2, 1, 11));
			}else {
				source = ResManager.getInstance().getBitmapData('vScrollBtnBg');
				back.bitmapData = BitmapDataUtil.getScaledBitmapData(source, $width, $height, new Rectangle(2, 2, 11, 1));
			}
			fore.x = ($width - fore.width) >> 1;
			fore.y = ($height - fore.height) >> 1;
		}
		
		override public function setBounds(x:int, y:int, w:int, h:int):void {
			super.setBounds(x, y, w, h);
			updateBack();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function draw():void {
			super.draw();
			
			back = new Bitmap();
			this.addChild(back);
			fore = new Bitmap(ResManager.getInstance().getBitmapData(orientation == Constants.HORIZONTAL ? 'hScrollThumb' : 'vScrollThumb'));
			this.addChild(fore);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}