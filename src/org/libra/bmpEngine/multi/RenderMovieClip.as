package org.libra.bmpEngine.multi {
	import flash.display.BitmapData;
	import org.libra.tick.ITickable;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class RenderMovieClip
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 04/03/2013
	 * @version 1.0
	 * @see
	 */
	public class RenderMovieClip extends RenderSprite implements ITickable {
		
		protected var $tickabled:Boolean;
		
		protected var $bmdList:Vector.<BitmapData>;
		
		protected var $totalFrames:int;
		
		protected var $currentFrame:int;
		
		protected var $playing:Boolean;
		
		protected var $loop:int;
		
		/**
		 * 帧率
		 */
		protected var $frameRate:int;
		
		/**
		 * 每帧需要的毫秒数
		 */
		protected var $rateTimer:int;
		
		protected var $frameTimer:int;
		
		//protected var $changedSignal:Signal;
		
		public function RenderMovieClip(bmdList:Vector.<BitmapData>) {
			super(bmdList && bmdList.length ? bmdList[0] : null);
			this.bmdList = bmdList;
			$loop = -1;
			frameRate = 10;
			//$changedSignal = new Signal(int);
			$tickabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set bmdList(bmdList:Vector.<BitmapData>):void {
			this.$bmdList = bmdList;
			$totalFrames = $bmdList && $bmdList.length ? $bmdList.length - 1 : 0;
			$currentFrame = 0;
			this.$updated = true;
		}
		
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
		
		public function get playing():Boolean {
			return $playing;
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
			this.$rateTimer = 1000 / $frameRate;
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
			$playing = true;
		}
		
		/**
		 * 停止影片剪辑中的播放头
		 */
		public function stop():void {
			$playing = false;
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			if ($playing) {
				if ($loop == 0) {
					stop();
					return;
				}
				$frameTimer -= interval;
				while ($frameTimer < 0) {
					if (this.$currentFrame == $totalFrames) {
						if ($loop > 0) $loop--;
						if ($loop == 0) {
							this.$frameTimer = 0;
							stop();
							return;
						}else {
							this.setCurrentFrame(0);
						}
					}else {
						this.setCurrentFrame($currentFrame + 1);
					}
					$frameTimer += $rateTimer;
				}
			}
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function get tickabled():Boolean {
			return $tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			$tickabled = value;
		}
		
		//public function get changedSignal():Signal {
			//return $changedSignal;
		//}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function setCurrentFrame(frame:int):void {
			if ($currentFrame != frame) {
				if(frame > this.$totalFrames){
					frame = 0;
				}else if(frame < 0){
					frame = this.$totalFrames;
				}
				$bitmapData = $bmdList[frame];
				$rect = $bitmapData.rect;
				$currentFrame = frame;
				$updated = true;
				//$changedSignal.dispatch($currentFrame);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}