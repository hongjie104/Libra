package org.libra.copGameEngine.view.login {
	import flash.events.MouseEvent;
	import org.libra.copGameEngine.events.LoginEvent;
	import org.libra.ui.flash.components.JButton;
	import org.libra.ui.flash.components.JPanel;
	import org.libra.ui.flash.components.JTextField;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.robotlegs.utilities.lazy.LibraMediatorActivator;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Login
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/28/2013
	 * @version 1.0
	 * @see
	 */
	public class Login extends JPanel {
		
		public var loginBtn:JButton;
		
		public var account:JTextField;
		
		public var password:JTextField;
		
		public function Login(owner:IContainer) {
			super(owner);
			new LibraMediatorActivator(this);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			const xml:XML = <JPanel width="300" height="200" x="13" y="1">
							  <JButton width="43" height="26" text="登录" textColor="16759090" textAlign="center" x="128" y="159" var="loginBtn"/>
							  <JLabel width="32" height="20" text="账号：" textColor="16777215" textAlign="left" x="53" y="70"/>
							  <JLabel width="32" height="20" text="密码：" textColor="16777215" textAlign="left" x="53" y="109"/>
							  <JTextField width="120" height="20" textColor="3355443" textAlign="left" x="109" y="68" var="account"/>
							  <JTextField width="120" height="20" textColor="3355443" textAlign="left" displayAsPassword="true" x="109" y="107" var="password"/>
							</JPanel>;
			this.createView(xml);
			this.defaultBtn = this.loginBtn;
		}
		
		override public function show():void {
			super.show();
			loginBtn.addEventListener(MouseEvent.CLICK, onLogin);
		}
		
		override public function close(tween:Boolean = true, destroy:Boolean = false):void {
			super.close(tween, destroy);
			loginBtn.removeEventListener(MouseEvent.CLICK, onLogin);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onLogin(e:MouseEvent):void {
			const a:String = account.text;
			if (a) {
				const p:String = this.password.text;
				if (p) {
					this.dispatchEvent(new LoginEvent(LoginEvent.LOGIN, a, p));
				}
			}
		}
	}

}