package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import org.libra.ui.base.Container;
	import org.libra.ui.components.JButton;
	import org.libra.ui.components.JFrame;
	import org.libra.ui.components.JLabel;
	import org.libra.ui.components.JPanel;
	import org.libra.ui.components.JTextField;
	import org.libra.ui.managers.UIManager;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
			// entry point
			
			UIManager.getInstance().init(this.stage);
			var uiContainer:Container = new Container();
			this.addChild(uiContainer);
			
			var frame:JFrame = new JFrame(400, 300, uiContainer, 50, 300);
			frame.show();
			
			var panel:JPanel = new JPanel(300, 200, uiContainer, 50, 50);
			panel.show();
			panel.append(new JLabel('hello world!', 40, 32));
			panel.append(new JTextField('input here', 40, 50));
			
			var btn:JButton = new JButton('btn', '按钮', 30, 30);
			frame.append(btn);
		}
		
	}
	
}