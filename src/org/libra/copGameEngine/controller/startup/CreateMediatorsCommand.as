package org.libra.copGameEngine.controller.startup {
	import flash.display.DisplayObject;
	import org.libra.copGameEngine.controller.LoginCommand;
	import org.libra.copGameEngine.events.LoginEvent;
	import org.libra.copGameEngine.view.login.Login;
	import org.libra.copGameEngine.view.login.LoginMediator;
	import org.libra.copGameEngine.view.scene.BaseScene;
	import org.libra.copGameEngine.view.scene.IScene;
	import org.libra.copGameEngine.view.scene.SceneMediator;
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.managers.UIManager;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class CreateMediatorsCommand
	 * @author Eddie
	 * @date 20-11-2011
	 * @version 1.0
	 * @see
	 */
	
	public class CreateMediatorsCommand extends Command {
		
		private var scene:IScene;
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
        override public function execute():void {
			this.mediatorMap.mapView(BaseScene, SceneMediator, IScene);
			this.mediatorMap.mapView(Login, LoginMediator);
			/*this.mediatorMap.mapView(BattlePanel, BattleMediator);
			this.mediatorMap.mapView(DramaPanel, DramaMediator);
			this.mediatorMap.mapView(TestFrame, TestMediator);
			this.mediatorMap.mapView(DebugFrame, DebugMediator);*/
			
			this.scene = new BaseScene();
			
			const uiLayer:IContainer = UIManager.getInstance().uiContainer;
			this.injector.mapValue(Login, new Login(uiLayer));
			/*this.injector.mapValue(BattlePanel, new BattlePanel(uiLayer));
			this.injector.mapValue(DramaPanel, new DramaPanel(uiLayer));
			this.injector.mapValue(TestFrame, new TestFrame(uiLayer));
			this.injector.mapValue(DebugFrame, new DebugFrame(uiLayer));*/
			
			commandMap.mapEvent(LoginEvent.LOGIN_EVENT, LoginCommand, LoginEvent);
			/*commandMap.mapEvent(BattleEvent.BATTLE_COMMAND, BattleCommand, BattleEvent);
			commandMap.mapEvent(TestEvent.SHOW, TestCommand, TestEvent);
			commandMap.mapEvent(TestEvent.APPEND_SERVER_MSG, TestCommand, TestEvent);
			commandMap.mapEvent(DebugEvent.SHOW, DebugCommand, DebugEvent);
			*/
			this.contextView.addChild(this.scene as DisplayObject);
			this.contextView.addChild(uiLayer as DisplayObject);
			//scene.addActionListener();
        }
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
    }
	
}