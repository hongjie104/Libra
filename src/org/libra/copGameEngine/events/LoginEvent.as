package org.libra.copGameEngine.events {
	import flash.events.Event;
	import org.libra.events.BaseEvent;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class LoginEvent
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/28/2013
	 * @version 1.0
	 * @see
	 */
	public class LoginEvent extends BaseEvent {
		
		public static const LOGIN_EVENT:String = 'loginEvent';
		
		public static const LOGIN:String = 'login';
		
		static public const SHOW:String = "show";
		
		private var $account:String;
		
		private var $password:String;
		
		public function LoginEvent(subType:String, account:String = null, password:String = null) {
			super(LOGIN_EVENT, subType);
			$account = account;
			$password = password;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get account():String {
			return $account;
		}
		
		public function get password():String {
			return $password;
		}
		
		override public function clone():Event {
			return new LoginEvent(subType, $account, $password);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}