package org.libra.copGameEngine.view.login {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import org.libra.copGameEngine.events.LoaderEvent;
	import org.libra.copGameEngine.events.LoginEvent;
	import org.libra.copGameEngine.view.login.Login;
	import org.libra.ui.flash.components.JAlert;
	import org.robotlegs.mvcs.Mediator;
	
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class LoginMediator
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/28/2013
	 * @version 1.0
	 * @see
	 */
	
	public class LoginMediator extends Mediator {
		
		[Inject]
		public var view:Login;
		
		/**
		 * Constructor
		 */
		public function LoginMediator() {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		override public function onRegister():void {
			addViewListener(LoginEvent.LOGIN_EVENT, onLogin, LoginEvent);
		}
		
		override public function onRemove():void {
			eventMap.unmapListeners();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onLogin(e:LoginEvent):void {
			switch(e.subType) {
				case LoginEvent.LOGIN:
					const urlLoader:URLLoader = new URLLoader();
					urlLoader.addEventListener(Event.COMPLETE, onLoadPHP);
					const request:URLRequest = new URLRequest("http://family.apowo.com/index.php/Login/tryLogin");
					request.method = URLRequestMethod.POST;
					var vars:URLVariables = new URLVariables(); 
					vars.account = e.account; 
					vars.password = e.password; 
					request.data = vars; 
					urlLoader.load(request);
					break;
			}
		}
		
		private function onLoadPHP(e:Event):void {
			const urlLoader:URLLoader = e.target as URLLoader;
			urlLoader.removeEventListener(Event.COMPLETE, onLoadPHP);
			switch(int(urlLoader.data)) {
				case 1:
					//login ok
					JAlert.show('登录成功', function(r:int):void { 
							if (r == JAlert.OK) {
								view.close();
							}
						} );
					this.dispatch(new LoaderEvent(LoaderEvent.LOAD_CONFIG));
					break;
				case -1:
					//账号不存在
					JAlert.show('账号不存在');
					break;
				case -2:
					//账号被封
					JAlert.show('账号被封');
					break;
				case -3:
					//密码错误
					JAlert.show('密码错误');
					break;
			}
		}
	}
}