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
		
		protected var _tickabled:Boolean;
		
		protected var _bmdList:Vector.<BitmapData>;
		
		protected var _totalFrames:int;
		
		protected var _currentFrame:int;
		
		protected var _playing:Boolean;
		
		protected var _loop:int;
		
		/**
		 * 帧率
		 */
		protected var _frameRate:int;
		
		/**
		 * 每帧需要的毫秒数
		 */
		protected var _rateTimer:int;
		
		protected var _frameTimer:int;
		
		//protected var _changedSignal:Signal;
		
		public function RenderMovieClip(bmdList:Vector.<BitmapData>) {
			super(bmdList && bmdList.length ? bmdList[0] : null);
			this.bmdList = bmdList;
			_loop = -1;
			frameRate = 10;
			//_changedSignal = new Signal(int);
			_tickabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set bmdList(bmdList:Vector.<BitmapData>):void {
			this._bmdList = bmdList;
			_totalFrames = _bmdList && _bmdList.length ? _bmdList.length - 1 : 0;
			_currentFrame = 0;
			this._updated = true;
		}
		
		/**
		 * 指定播放头所处的帧的编号
		 */
		public function get currentFrame():int {
			return _currentFrame;
		}
		
		/**
		 * 实例中帧的总数
		 */
		public function get totalFrames():int {
			return _totalFrames;
		}
		
		public function get playing():Boolean {
			return _playing;
		}
		
		public function get loop():int {
			return _loop;
		}
		
		public function set loop(val:int):void {
			this._loop = val;
		}
		
		public function get frameRate():int {
			return _frameRate;
		}
		
		public function set frameRate(frameRate:int):void {
			this._frameRate = frameRate;
			this._rateTimer = 1000 / _frameRate;
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
			setCurrentFrame(_currentFrame + 1);
			stop();
		}
		
		/**
		 * 将播放头转到前一帧并停止
		 */
		public function prevFrame():void {
			setCurrentFrame(_currentFrame - 1);
			stop();
		}
		
		/**
		 * 移动播放头
		 */
		public function play():void {
			_playing = true;
		}
		
		/**
		 * 停止影片剪辑中的播放头
		 */
		public function stop():void {
			_playing = false;
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			if (_playing) {
				if (_loop == 0) {
					stop();
					return;
				}
				_frameTimer -= interval;
				while (_frameTimer < 0) {
					if (this._currentFrame == _totalFrames) {
						if (_loop > 0) _loop--;
						if (_loop == 0) {
							this._frameTimer = 0;
							stop();
							return;
						}else {
							this.setCurrentFrame(0);
						}
					}else {
						this.setCurrentFrame(_currentFrame + 1);
					}
					_frameTimer += _rateTimer;
				}
			}
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function get tickabled():Boolean {
			return _tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			_tickabled = value;
		}
		
		//public function get changedSignal():Signal {
			//return _changedSignal;
		//}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function setCurrentFrame(frame:int):void {
			if (_currentFrame != frame) {
				if(frame > this._totalFrames){
					frame = 0;
				}else if(frame < 0){
					frame = this._totalFrames;
				}
				_bitmapData = _bmdList[frame];
				_rect = _bitmapData.rect;
				_currentFrame = frame;
				_updated = true;
				//_changedSignal.dispatch(_currentFrame);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}