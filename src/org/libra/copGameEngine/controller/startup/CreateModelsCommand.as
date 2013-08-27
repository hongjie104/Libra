package org.libra.copGameEngine.controller.startup {
	import org.libra.copGameEngine.controller.LoaderCommand;
	import org.libra.copGameEngine.controller.SocketCommand;
	import org.libra.copGameEngine.events.LoaderEvent;
	import org.libra.copGameEngine.events.SocketEvent;
	import org.libra.copGameEngine.model.LoaderManager;
	import org.libra.copGameEngine.service.SocketService;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JCreateModelsCommand
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class CreateModelsCommand extends Command {
		
		public function CreateModelsCommand() {
			super();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function execute():void {
			this.injector.mapSingleton(SocketService);
			//this.injector.mapSingleton(UserManager);
			this.injector.mapSingleton(LoaderManager);
			//this.injector.mapSingleton(RoomManager);
			//this.injector.mapSingleton(CreateUserManager);
			
			this.commandMap.mapEvent(SocketEvent.SOCKET_EVENT, SocketCommand);
			//this.commandMap.mapEvent(UserEvent.USER_COMMAND, UserCommand);
			this.commandMap.mapEvent(LoaderEvent.LOADER_EVENT, LoaderCommand);
			//signalCommandMap.mapSignal(signalBus.ROOM_SIGNAL, RoomCommand);
			//signalCommandMap.mapSignal(signalBus.CREATE_USER_SIGNAL, CreateUserCommand);		
        }
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}