package org.libra.copGameEngine.controller.startup {
	import flash.display.DisplayObject;
	import org.libra.copGameEngine.view.scene.BaseScene;
	import org.libra.copGameEngine.view.scene.IScene;
	import org.libra.copGameEngine.view.scene.SceneMediator;
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
			this.mediatorMap.mapView(BaseScene, SceneMediator);
			/*this.mediatorMap.mapView(LoginFrame, LoginMediator);
			this.mediatorMap.mapView(BattlePanel, BattleMediator);
			this.mediatorMap.mapView(DramaPanel, DramaMediator);
			this.mediatorMap.mapView(TestFrame, TestMediator);
			this.mediatorMap.mapView(DebugFrame, DebugMediator);*/
			
			this.scene = new BaseScene();
			
			/*var uiLayer:DisplayObjectContainer = scene.getUILayer();
			this.injector.mapValue(LoginFrame, new LoginFrame(uiLayer));
			this.injector.mapValue(BattlePanel, new BattlePanel(uiLayer));
			this.injector.mapValue(DramaPanel, new DramaPanel(uiLayer));
			this.injector.mapValue(TestFrame, new TestFrame(uiLayer));
			this.injector.mapValue(DebugFrame, new DebugFrame(uiLayer));
			
			commandMap.mapEvent(LoginGameEvent.LOGIN_COMMAND, LoginCommand, LoginGameEvent);
			commandMap.mapEvent(BattleEvent.BATTLE_COMMAND, BattleCommand, BattleEvent);
			commandMap.mapEvent(TestEvent.SHOW, TestCommand, TestEvent);
			commandMap.mapEvent(TestEvent.APPEND_SERVER_MSG, TestCommand, TestEvent);
			commandMap.mapEvent(DebugEvent.SHOW, DebugCommand, DebugEvent);
			*/
			this.contextView.addChild(this.scene as DisplayObject);
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