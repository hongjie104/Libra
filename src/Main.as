package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		
		private var frame:JFrame;
		
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
			
			frame = new JFrame(400, 300, uiContainer, 350, 50);
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
			var btn0:JButton = new JButton(250, 50, '开关');
			btn0.setToolTipText('开关');
			panel.append(btn0);
			btn0.addEventListener(MouseEvent.CLICK, onCliked);
			
			var btn:JButton = new JButton(30, 60, '按钮');
			frame.append(btn);
			
			var checkBoxGroup:JCheckBoxGroup = new JCheckBoxGroup(30, 120, 0);
			checkBoxGroup.appendAllCheckBox(new JCheckBox(0, 0, '按钮0'), new JCheckBox(30, 90, '按钮1'), new JCheckBox(30, 90, '按钮2'));
			frame.append(checkBoxGroup);
			
			btn.setToolTipText('按钮按钮按钮按钮按钮按钮按钮按钮按钮按钮按钮按钮按钮按钮按钮按钮按钮按钮按钮按钮');
		}
		
		private function onCliked(e:MouseEvent):void {
			frame.showSwitch();
		}
		
	}
	
}