package org.libra.copGameEngine.model.element.animation {
	
	/**
	 * <p>
	 * 人物动作控制器
	 * </p>
	 *
	 * @class Action
	 * @author Eddie
	 * @qq 32968210
	 * @date 04/30/2013
	 * @version 1.0
	 * @see
	 */
	public class Action {
		
		/**
		 * 本类实例
		 */
		private static var instance:Action;
		
		/**
		 * 站立的动作
		 */
		private var stand:ActionInfo;
		
		/**
		 * Constructor
		 */
		public function Action(singleton:Singleton) {
			//{1:{head:{x:0,y:0:frame:0},body:{}}}
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function getInstance():Action {
			return instance ||= new Action(new Singleton);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}
}

final class Singleton{}