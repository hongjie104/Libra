package org.libra.copGameEngine.model.element.animation {
	/**
	 * <p>
	 * 一帧动作的信息
	 * </p>
	 *
	 * @class FrameInfo
	 * @author Eddie
	 * @qq 32968210
	 * @date 04/30/2013
	 * @version 1.0
	 * @see
	 */
	public final class FrameInfo {
		
		private var $head:FrameVO;
		
		private var $body:FrameVO;
		
		private var $arm:FrameVO;
		
		private var $leg:FrameVO;
		
		private var $duration:int;
		
		public function FrameInfo(head:Object, body:Object, arm:Object, leg:Object, duration:int = 200) {
			this.$head = new FrameVO(head.offset[0], head.offset[1], head.frame);
			this.$body = new FrameVO(body.offset[0], body.offset[1], body.frame);
			this.$arm = new FrameVO(arm.offset[0], arm.offset[1], arm.frame);
			this.$leg = new FrameVO(leg.offset[0], leg.offset[1], leg.frame);
			this.$duration = duration;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		public function get head():FrameVO {
			return this.$head;
		}
		
		public function get body():FrameVO {
			return this.$body;
		}
		
		public function get arm():FrameVO {
			return this.$arm;
		}
		
		public function get leg():FrameVO {
			return this.$leg;
		}
		
		public function get duration():int {
			return this.$duration;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}