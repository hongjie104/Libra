package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import org.libra.ui.base.Container;
	import org.libra.ui.components.JButton;
	import org.libra.ui.components.JCheckBox;
	import org.libra.ui.components.JCheckBoxGroup;
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
			
			var frame:JFrame = new JFrame(400, 300, uiContainer, 200, 200);
			frame.show();
			
			var panel:JPanel = new JPanel(300, 200, uiContainer, 50, 50);
			panel.show();
			var label:JLabel = new JLabel(40, 32, 'hello world!');
			label.setSize(120, 20);
			var tf:JTextField = new JTextField(40, 50, '输入框');
			tf.setSize(120, 20);
			var pw:JTextField = new JTextField(40, 80, '密码输入框');
			pw.setSize(120, 20);
			pw.displayAsPassword = true;
			panel.appendAll(label, tf, pw);
			
			var btn:JButton = new JButton(30, 60, '按钮');
			frame.append(btn);
			
			var checkBoxGroup:JCheckBoxGroup = new JCheckBoxGroup(30, 90, 1);
			checkBoxGroup.appendAllCheckBox(new JCheckBox(0, 0, '按钮0'), new JCheckBox(30, 90, '按钮1'), new JCheckBox(30, 90, '按钮2'));
			frame.append(checkBoxGroup);
		}
		
	}
	
}