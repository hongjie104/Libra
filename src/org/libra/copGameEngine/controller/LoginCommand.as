package org.libra.copGameEngine.controller {
	import org.libra.copGameEngine.events.LoginEvent;
	import org.libra.copGameEngine.view.login.Login;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class LoginCommand
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/28/2013
	 * @version 1.0
	 * @see
	 */
	
	public class LoginCommand extends Command {
		
		[Inject]
		public var event:LoginEvent;
		
		[Inject]
		public var login:Login;
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
        override public function execute():void {
			switch(event.subType) {
				case LoginEvent.SHOW:
					login.show();
					break;
			}
        }
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
    }
	
}