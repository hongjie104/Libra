package org.libra.copGameEngine.model.element {
	import org.libra.copGameEngine.model.basic.GameObject;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JMission
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class JMission extends GameObject {
		
		/**
		 * 没接的状态值
		 */
		public static const NOT_ACCEPTED:int = -1;
		
		/**
		 * 已接的状态值
		 */
		public static const ACCEPTED:int = 0;
		
		/**
		 * 已完成的状态值
		 */
		public static const COMPLETED:int = 1;
		
		/**
		 * 已提交的状态值
		 */
		public static const SUBMITED:int = 2;
		
		/**
		 * 任务类型:对话
		 */
		public static const DIALOG:int = 0;
		
		/**
		 * 任务类型:打怪
		 */
		public static const ATK:int = 1;
		
		/**
		 * 接受任务时的npc说话内容
		 * @private
		 */ 
		protected var _acceptInfo:String;
		
		/**
		 * 提交任务时的npc说话内容
		 * @private
		 */
		protected var _submitInfo:String;
		
		/**
		 * 前置任务的id
		 * @private
		 */
		protected var _prepMission:int;
		
		/**
		 * 接受任务的最小等级
		 * @private
		 */
		protected var _minLv:int;
		
		/**
		 * 接受任务的npc
		 * @private
		 */
		protected var _acceptNPC:int;
		
		/**
		 * 提交任务的npc
		 * @private
		 */
		protected var _submitNPC:int;
		
		/**
		 * 完成条件的类型。
		 * @private
		 */
		protected var _completeType:String;
		
		/**
		 * 完成条件的参数
		 * @private
		 */
		protected var _completeParam:String;
		
		/**
		 * 完成条件的值
		 * @private
		 */
		protected var _completeValue:int;
		
		
		/**
		 * 当前的值,比如当前杀了多少怪
		 * @private
		 */
		protected var _curCompleteValue:int;
		
		/**
		 * 任务的进度。
		 * @private
		 */
		protected var _status:int;
		
		/**
		 * 是否是主线任务
		 * @private
		 */
		protected var _main:Boolean;
		
		/**
		 * 主线任务的一个排序索引
		 * 如果不是主线任务，该值为0
		 * @private
		 */
		protected var _mainIndex:int;
		
		public function JMission() {
			super();
			_status = -1;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get acceptInfo():String {
			return _acceptInfo;
		}
		
		public function get submitInfo():String {
			return _submitInfo;
		}
		
		public function get prepMission():int {
			return _prepMission;
		}
		
		public function get minLv():int {
			return _minLv;
		}
		
		public function get acceptNPC():int {
			return _acceptNPC;
		}
		
		public function get submitNPC():int {
			return _submitNPC;
		}
		
		public function get completeType():String {
			return _completeType;
		}
		
		public function get completeParam():String {
			return _completeParam;
		}
		
		public function get completeValue():int {
			return _completeValue;
		}
		
		public function get curCompleteValue():int {
			return _curCompleteValue;
		}
		
		public function set curCompleteValue(value:int):void {
			_curCompleteValue = value;
		}
		
		public function get status():int {
			return _status;
		}
		
		public function set status(value:int):void {
			_status = value;
		}
		
		public function get main():Boolean {
			return _main;
		}
		
		public function get mainIndex():int {
			return _mainIndex;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}