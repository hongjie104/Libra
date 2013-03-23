package org.libra.game.components.animatable {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import org.libra.game.interfaces.IAnimatable;
	import org.libra.utils.MathUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BitmapAnimatable
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/13/2012
	 * @version 1.0
	 * @see
	 */
	public class BitmapAnimatable implements IAnimatable {
		
		protected var frameList:Vector.<BitmapFrame>;
		
		private var bitmap:Bitmap;
		
		/**
		 * 循环次数，默认是-1，无限循环
		 */
		protected var loops:int;
		
		/**
		 * 帧率
		 */
		protected var frameRate:int;
		
		/**
		 * 每帧需要的毫秒数，理论上的值
		 */
		protected var rateTimer:int;
		
		/**
		 * 在Tick方法中，frameTimer减去每帧间隔时间internal
		 * 如果小于0,说明间隔时间大于每帧需要的时间,也就是需要渲染图片了.
		 * 渲染完毕后，再加上理论上的每帧需要的毫秒数，如果还是小于0，说明还需要渲染一次
		 */
		protected var frameTimer:int;
		
		/**
		 * 当前播放到第几帧
		 */
		protected var curFrame:int;
		
		/**
		 * 总共的帧数
		 */
		protected var numFrame:int;
		
		/**
		 * 是否在播放中
		 */
		protected var playing:Boolean;
		
		public function BitmapAnimatable(bitmap:Bitmap, frameRate:int = 10) {
			this.bitmap = bitmap;
			
			this.setFrameRate(frameRate);
			loops = -1;
			numFrame = curFrame = frameTimer = 0;
			playing = true;
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
		
		public function gotoAndPlay(target:*):void {
			gotoFrame(target);
			play();
		}
		
		public function play():void {
			playing = true;
		}
		
		public function gotoAndStop(target:*):void {
			gotoFrame(target);
			stop();
		}
		
		public function stop():void {
			frameTimer = 0;
			playing = false;
		}
		
		public function isPlaying():Boolean {
			return this.playing;
		}
		
		/**
		 * 添加一个函数到某帧执行，如果位于frame指定的帧上已经添加了fun指定的函数，即使参数不同，也不会重复添加，将返回flase
		 * @param	target 执行该函数的帧索引或者标签，索引时从0开始到(包含)numFrame - 1，如果是就标签必须存在
		 * @param	fun  目标函数,如果目标函数时控制语句: stop,play,gotoAndStop,gotoAndPlay 将被克隆函数copy.duplicate,clone等复制给新对象，其它函数一律不会复制到新对象
		 * @param	args  执行函数需要的参数
		 * @param   disposableEnable  该函数是否为一次性的，执行后就即刻自动删除
		 */
		public function addFrameAction(target:Object, fun:Function, args:Array = null, disposableEnable:Boolean = false):void { 
			var frame:int = getFrame(target);
			frame = MathUtil.max(0, MathUtil.min(frame, numFrame - 1));
			var bitmapFrame:BitmapFrame = this.frameList[frame];
			bitmapFrame.addFun(fun, args, disposableEnable);
		}
		
		/**
		 * 移除已经添加到位于frame参数指定的帧上的fun函数
		 * @param	frame  函数位于的帧
		 * @param	fun  要删除的函数
		 */
		public function removeFrameAction(target:*, fun:Function):void {
			var frame:int = getFrame(target);
			frame = MathUtil.max(0, MathUtil.min(frame, numFrame - 1));
			var bitmapFrame:BitmapFrame = this.frameList[frame];
			bitmapFrame.removeFun(fun);
 		}
		
		public function setFrameList(frameList:Vector.<BitmapFrame>):void {
			this.frameList = frameList;
			this.numFrame = this.frameList.length;
			setCurFrame(0);
		}
		
		public function setLoops(val:int):void {
			this.loops = val;
		}
		
		/* INTERFACE org.libra.game.interfaces.IAnimatable */
		
		public function update(interval:int):void {
			if (playing) {
				if (loops == 0) return;
				frameTimer -= interval;
				while (frameTimer < 0) {
					if (this.curFrame >= numFrame - 1) {
						if (loops > 0) loops--;
						if (loops == 0) {
							this.frameTimer = 0;
							//dispatchEvent(new Event(Event.COMPLETE));
							return;
						}else {
							this.setCurFrame(0);
						}
					}else {
						this.setCurFrame(curFrame + 1);
					}
					frameTimer += rateTimer;
				}
			}
		}
		
		public function dispose():void {
			this.bitmap.bitmapData = null;
			for (var i:* in this.frameList) {
				frameList[i].dispose();
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function setCurFrame(curFrame:int):void {
			this.curFrame = MathUtil.max(0, MathUtil.min(curFrame, numFrame - 1));
			var frame:BitmapFrame = this.frameList[curFrame];
			frame.doFun();
			this.bitmap.bitmapData = frame.getBmd();
			this.bitmap.x = frame.x;
			this.bitmap.y = frame.y;
		}
		
		/**
		 * 跳转到某一帧
		 * @param	target 只能是帧数，int类型或者帧标签，String类型
		 */
		private function gotoFrame(target:*):void {
			setCurFrame(getFrame(target));
		}
		
		private function getFrame(target:*):int {
			var frame:int = -1;
			if (isNaN(target)) {
				var label:String = target;
				var l:int = frameList.length;
				for (var i:int = 0; i < l; i += 1) { 
					if (frameList[i].getLabel() == label) {
						frame = i;
						break;
					}
				}
			}else {
				frame = int(target);
			}
			if (frame == -1) {
				throw new Error('target不能为-1或者不存在' + target + '帧标签');
				return - 1;
			}
			return frame;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}