package  {
	import org.libra.ui.flash.theme.Filter;
	import org.libra.ui.flash.theme.JFont;
	import org.libra.ui.starling.component.JButton;
	import org.libra.ui.starling.component.JCheckBox;
	import org.libra.ui.starling.component.JCheckBoxGroup;
	import org.libra.ui.starling.component.JFrame;
	import org.libra.ui.starling.component.JLabel;
	import org.libra.ui.starling.component.JPanel;
	import org.libra.ui.starling.component.JToolTip;
	import org.libra.ui.starling.core.Container;
	import org.libra.ui.starling.theme.DefaultTheme;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Game
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/01/2012
	 * @version 1.0
	 * @see
	 */
	public final class Game extends Sprite {
		
		public function Game() {
			super();
			
			var uiContainer:Container = new Container(800, 600);
			this.addChild(uiContainer);
			var panel:JPanel = new JPanel(uiContainer, DefaultTheme.PANEL, 200, 100, 50, 50);
			panel.show();
			panel.addChild(new JLabel(60, 20, 50, 50, '我是面板'));
			
			var btn:JButton = new JButton(DefaultTheme.BTN, 43, 26, 50, 50, '按钮');
			btn.setFont(JFont.FONT_BTN);
			btn.setTextFilter(Filter.BLACK);
			btn.setTextLocation(0, 2);
			btn.setToolTipText('按钮');
			//panel.addChild(btn);
			btn.setDragEnabled(true);
			
			panel.addDropAccept(btn);
			
			var label:JLabel = new JLabel(120, 20, 50, 80, '我是可拖拽的面板');
			label.setFont(JFont.FONT_LABEL);
			label.setTextFilter(Filter.BLACK);
			//panel.addChild(label);
			
			var frame:JFrame = new JFrame(uiContainer, DefaultTheme.FRAME, 400, 300, 50, 50);
			frame.show();
			frame.addChildAll(btn, label);
			
			var group:JCheckBoxGroup = new JCheckBoxGroup(100, 30, 50, 100);
			group.appendAllCheckBox(createRadioBtn('单选0'), 
				createRadioBtn('单选1'), 
				createRadioBtn('单选2'), 
				createRadioBtn('单选3'), 
				createRadioBtn('单选4'));
			frame.addChild(group);
			
			function createRadioBtn(text:String):JCheckBox {
				var radioBtn:JCheckBox = new JCheckBox(DefaultTheme.BTN_CHECK, 54, 20);
				radioBtn.setText(text);
				radioBtn.setFont(JFont.FONT_BTN);
				radioBtn.setTextFilter(Filter.BLACK);
				radioBtn.setTextLocation(0, 2);
				radioBtn.setToolTipText(text);
				return radioBtn;
			}
			
			/*var tooltip:JToolTip = JToolTip.getInstance();
			tooltip.setText('fdjifhewfewofghewriogdnhsfoiewfe');
			tooltip.x = 50; tooltip.y = 150;
			frame.addChild(tooltip);
			
			btn.addEventListener(Event.TRIGGERED, function(evt:Event):void {
					tooltip.setText((Math.random() * 99999999) + 'greioghrejgreiogre');
				} );*/
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}