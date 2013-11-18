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
		
		private var _account:String;
		
		private var _password:String;
		
		public function LoginEvent(subType:String, account:String = null, password:String = null) {
			super(LOGIN_EVENT, subType);
			_account = account;
			_password = password;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get account():String {
			return _account;
		}
		
		public function get password():String {
			return _password;
		}
		
		override public function clone():Event {
			return new LoginEvent(subType, _account, _password);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}