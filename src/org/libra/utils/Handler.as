package org.libra.utils {
	/**
	 * <p>
	 * 带参函数执行器
	 * </p>
	 *
	 * @class Handler
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/14/2013
	 * @version 1.0
	 * @see
	 */
	public final class Handler {
		
		public var caller:*;
		
		public var handler:*;
		
		public var para:Array;
		
		/**
		 * 函数执行器
		 * 
		 * @param handler	函数（可以使用字符串进行反射，参考ReflectUtil.eval）
		 * @param para	参数数组
		 * @param caller	调用者
		 * 
		 */
		public function Handler(handler:*= null, para:Array = null, caller:*= null) {
			this.handler = handler;
			this.para = para;
			this.caller = caller;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 调用
		 * @return 
		 * 
		 */
		public function call(...params):* {
			var h:*;
			if (this.handler is String)
				h = ReflectUtil.eval(this.handler.toString());
			else
				h = this.handler;
			
			if (h is Function) {
				if (params && params.length > 0)
					return h.apply(this.caller, params);
				else
					return h.apply(this.caller, this.para);
			}
			else
				return h;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}