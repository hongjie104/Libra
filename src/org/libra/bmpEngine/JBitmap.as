package org.libra.bmpEngine {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import org.libra.tick.ITickable;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JBitmap
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/06/2012
	 * @version 1.0
	 * @see
	 */
	public class JBitmap extends Sprite implements ITickable {
		
		protected var loops;
		
		/**
		 * 帧率
		 */
		protected var frameRate:int;
		
		/**
		 * 每帧需要的毫秒数
		 */
		protected var rateTimer:int;
		
		protected var frameTimer:int;
		
		protected var curFrame:int;
		
		protected var totalFrame:int;
		
		protected var playing:Boolean;
		
		protected var baseBitmap:Bitmap;
		
		public function JBitmap() {
			super();
			mouseChildren = mouseEnabled = false;
			loops = -1;
			totalFrame = curFrame = frameTimer = 0;
			baseBitmap = new Bitmap();
			this.addChild(baseBitmap);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 设置帧率
		 * @param	frameRate
		 */
		public function setFrameRate(frameRate:int):void {
			this.frameRate = frameRate;
			this.rateTimer = 1000 / frameRate;
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			if (loops == 0) return;
			frameTimer -= interval;
			while (frameTimer < 0) {
				if (this.curFrame >= totalFrame) {
					if (loops > 0)
						loops--;
					if (loops == 0) {
						this.frameTimer = 0;
						//movieEnd();
						return;
					}else {
						this.curFrame = 0;
						//this.doScript(curFrame);
						this.setBaseBmd(this.bitmapDataList ? this.bitmapDataList[curFrame] : null);
						curFrame += 1;
					}
				}else {
					//this.doScript(curFrame);
					this.setBaseBmd(this.bitmapDataList ? this.bitmapDataList[curFrame] : null);
					curFrame += 1;
				}
				frameTimer += rateTimer;
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function setBaseBmd(bmd:BitmapData):void {
			this.baseBitmap.bitmapData = bmd;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}