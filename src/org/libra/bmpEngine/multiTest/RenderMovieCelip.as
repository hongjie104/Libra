package org.libra.bmpEngine.multiTest {
	import flash.display.BitmapData;
	import org.libra.tick.ITickable;
	import org.libra.utils.MathUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class RenderMovieCelip
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 04/03/2013
	 * @version 1.0
	 * @see
	 */
	public class RenderMovieCelip extends RenderSprite implements ITickable {
		
		protected var bmdList:Vector.<BitmapData>;
		
		protected var $totalFrames:int;
		
		protected var $currentFrame:int;
		
		protected var playing:Boolean;
		
		protected var $loop:int;
		
		/**
		 * 帧率
		 */
		protected var $frameRate:int;
		
		/**
		 * 每帧需要的毫秒数
		 */
		protected var rateTimer:int;
		
		protected var frameTimer:int;
		
		public function RenderMovieCelip(bmdList:Vector.<BitmapData>) {
			super(bmdList[0]);
			this.bmdList = bmdList;
			$totalFrames = bmdList.length - 1;
			$currentFrame = 0;
			$loop = -1;
			frameRate = 10;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 指定播放头所处的帧的编号
		 */
		public function get currentFrame():int {
			return $currentFrame;
		}
		
		/**
		 * 实例中帧的总数
		 */
		public function get totalFrames():int {
			return $totalFrames;
		}
		
		public function get isPlaying():Boolean {
			return playing;
		}
		
		public function get loop():int {
			return $loop;
		}
		
		public function set loop(val:int):void {
			this.$loop = val;
		}
		
		public function get frameRate():int {
			return $frameRate;
		}
		
		public function set frameRate(frameRate:int):void {
			this.$frameRate = frameRate;
			this.rateTimer = 1000 / $frameRate;
		}
		
		/**
		 * 从指定帧开始播放
		 * @param	frame
		 */
		public function gotoAndPlay(frame:int):void {
			this.setCurrentFrame(frame);
			play();
		}
		
		/**
		 * 将播放头移到指定帧并停在那里
		 * @param	frame
		 */
		public function gotoAndStop(frame:int):void {
			this.setCurrentFrame(frame);
			stop();
		}
		
		/**
		 * 将播放头转到下一帧并停止
		 */
		public function nextFrame():void {
			setCurrentFrame($currentFrame + 1);
			stop();
		}
		
		/**
		 * 将播放头转到前一帧并停止
		 */
		public function prevFrame():void {
			setCurrentFrame($currentFrame - 1);
			stop();
		}
		
		/**
		 * 移动播放头
		 */
		public function play():void {
			playing = true;
		}
		
		/**
		 * 停止影片剪辑中的播放头
		 */
		public function stop():void {
			playing = false;
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			
			/*if ($loop == 0) return;
			//if (useDefaultBmd) {
				
			//}else {
				
				while (frameTimer < 0) {
					if (this.curFrame >= totalFrame) {
						if ($loop > 0)
							$loop--;
						if ($loop == 0) {
							this.frameTimer = 0;
							this.doScript(curFrame);
							movieEnd();
							return;
						}else {
							this.curFrame = 0;
							this.doScript(curFrame);
							this.setBaseBitmapData(this.bitmapDataList ? this.bitmapDataList[curFrame] : null);
							curFrame += 1;
						}
					}else {
						this.doScript(curFrame);
						this.setBaseBitmapData(this.bitmapDataList ? this.bitmapDataList[curFrame] : null);
						curFrame += 1;
					}
					frameTimer += rateTimer;
				}
				//super.tick(interval);
			//}*/
			
			//if (playing) {
				//frameTimer -= interval;
				//while (frameTimer < 0) {
					//frameTimer += rateTimer;
					//setCurrentFrame($currentFrame + 1);
				//}
			//}
			
			if (playing) {
				if ($loop == 0) {
					stop();
					return;
				}
				frameTimer -= interval;
				while (frameTimer < 0) {
					if (this.$currentFrame == $totalFrames) {
						if ($loop > 0) $loop--;
						if ($loop == 0) {
							this.frameTimer = 0;
							stop();
							return;
						}else {
							this.setCurrentFrame(0);
						}
					}else {
						this.setCurrentFrame($currentFrame + 1);
					}
					frameTimer += rateTimer;
				}
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		//private function setCurrentFrame(frame:int):void {
			//if ($currentFrame != frame) {
				//frame = MathUtil.max(0, frame);
				//if (frame > $totalFrames) {
					//if ($loop > 0) {
						//$loop--;
						//if ($loop) {
							//$currentFrame = frame % $totalFrames;
						//}else {
							//$currentFrame = $totalFrames;
							//stop();
						//}
					//}else {
						//$currentFrame = frame % $totalFrames;
					//}
				//}else {
					//$currentFrame = frame;
				//}
				//this.$bitmapData = this.bmdList[$currentFrame];
				//$updated = true;
			//}
		//}
		
		private function setCurrentFrame(frame:int):void {
			if ($currentFrame != frame) {
				$bitmapData = bmdList[frame];
				$currentFrame = frame;
				$updated = true;
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}