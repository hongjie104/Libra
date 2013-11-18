package org.libra.ui.invalidation {
	/**
	 * <p>
	 * UI组件的渲染类别
	 * </p>
	 *
	 * @class InvalidationFlag
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/28/2012
	 * @version 1.0
	 * @see
	 */
	public final class InvalidationFlag {
		
		/**
		 * 所有
		 */
		public static const ALL:int = -1;
		
		/**
		 * 大小
		 */
		public static const SIZE:int = 0;
		
		/**
		 * 风格样式
		 */
		public static const STYLE:int = 1;
		
		/**
		 * 状态
		 */
		public static const STATE:int = 2;
		
		/**
		 * 数据
		 */
		public static const DATA:int = 3;
		
		/**
		 * 文本
		 */
		public static const TEXT:int = 4;
		
		/**
		 * 以bool值记录当前需要渲染的类别，
		 * 当完成所有渲染后，在reset方法中被重置
		 * @private
		 * @default [false, false, false, false, false]
		 */
		private var _invalidationList:Array;
		
		private var _length:int;
		
		/**
		 * 构造函数
		 * @private
		 */
		public function InvalidationFlag() {
			_invalidationList = [false, false, false, false, false];
			_length = 5;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 设置需要渲染的类别
		 * @param	val
		 */
		public function setInvalid(invalidationFlag:int):void {
			if(invalidationFlag > -1)
				this._invalidationList[invalidationFlag] = true;
			else {
				for (var i:int = 0; i < _length; i += 1) 
					this._invalidationList[i] = true;
			}
		}
		
		/**
		 * 判断当前需要渲染的类别
		 * @param	val 
		 * @return 布尔值
		 */
		public function isInvalid(invalidationFlag:int):Boolean {
			return this._invalidationList[invalidationFlag];
		}
		
		/**
		 * 重置，将所有渲染类别设置为不需要渲染
		 */
		public function reset():void {
			for (var i:int = 0; i < _length; i += 1) 
				this._invalidationList[i] = false;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
