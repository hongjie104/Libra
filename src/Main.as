package {
	import adobe.utils.CustomActions;
	import com.greensock.loading.SWFLoader;
	import com.sociodox.theminer.TheMiner;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.libra.aStar.AStarTest;
	import org.libra.bmpEngine.JBitmap;
	import org.libra.bmpEngine.utils.JBitmapUtil;
	import org.libra.ui.base.Container;
	import org.libra.ui.components.JButton;
	import org.libra.ui.components.JCheckBox;
	import org.libra.ui.components.JCheckBoxGroup;
	import org.libra.ui.components.JComboBox;
	import org.libra.ui.components.JFrame;
	import org.libra.ui.components.JLabel;
	import org.libra.ui.components.JList;
	import org.libra.ui.components.JPanel;
	import org.libra.ui.components.JSlider;
	import org.libra.ui.components.JTextArea;
	import org.libra.ui.components.JTextField;
	import org.libra.ui.managers.UIManager;
	import org.libra.ui.utils.ResManager;
	import org.libra.utils.GraphicsUtil;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class Main extends Sprite {
		
		private var frame:JFrame;
		
		[Embed(source="../asset/walk.png")]
		private var BMP:Class;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
			// entry point
			this.addChild(new TheMiner(true));
			
			//开始加载ui资源
			var swfLoader:SWFLoader = new SWFLoader('../asset/UI.swf', { name:'UI', onComplete:onLoadUIComplete } );
			swfLoader.load();
		}
		
		/**
		 * UI资源加载完成
		 * @param	evt
		 */
		private function onLoadUIComplete(evt:Event):void {
			//初始化UI
			ResManager.getInstance().init();
			UIManager.getInstance().init(this.stage);
			//testUI();
			//testBmpEngine();
			//testAStar();
			//测试绘制菱形
			testDiamond();
		}
		
		private function testDiamond():void {
			var s:Shape = new Shape();
			var point:Vector.<Point> = new Vector.<Point>();
			point[0] = new Point()
			GraphicsUtil.drawDiamond(s.graphics,)
		}
		
		private function testAStar():void {
			var map:AStarTest = new AStarTest();
			//map.x = 60; map.y = 80;
			this.addChild(map);
		}
		
		private function testBmpEngine():void {
			var source:BitmapData = (new BMP() as Bitmap).bitmapData;
			
			for (var i:int = 0; i < 1; i += 1 ) {
				//var bmp:JBitmap = JBitmapUtil.createFromBitmap(67, source, 10, true);
				var bmp:JBitmap = JBitmapUtil.createFromBitmap(8, 64, source, 10, true);
				this.addChild(bmp);
				bmp.x = Math.random() * stage.stageWidth;
				bmp.y = Math.random() * stage.stageHeight;
			}
			
			//var source:MovieClip = new TestRole();
			//for (var i:int = 0; i < 100; i += 1 ) {
				//var bmp:JBitmap = JBitmapUtil.createFromMC(source);
				//this.addChild(bmp);
				//bmp.x = Math.random() * stage.stageWidth + 100;
				//bmp.y = Math.random() * stage.stageHeight + 100;
			//}
			
			//var bmdList:Vector.<BitmapData> = BitmapDataUtil.separateBitmapData(100, 130, source)[0];
			//var bitmap:JMultiBitmap = new JMultiBitmap(100, 130);
			//var render:RenderLayer = new RenderLayer();
			//var renderItem:RenderItem = new RenderItem(null, render);
			//bitmap.addLayer(render);
			//this.addChild(bitmap);
			//renderItem.setBmd(bmdList[0]);
			//var count:int = 0;
			//this.addEventListener(Event.ENTER_FRAME, function(evt:Event):void { 
					//if (count++ == 7) count = 0;
					//renderItem.setBmd(bmdList[count]);
				//} );
		}
		
		private function testUI():void {
			var uiContainer:Container = new Container();
			this.addChild(uiContainer);
			
			frame = new JFrame(uiContainer, 400, 300, 350, 50);
			frame.setCloseEnabled(false);
			frame.setDragBarEnabled(false);
			frame.show();
			
			var panel:JPanel = new JPanel(uiContainer, 300, 200, 50, 50);
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
			
			btn.setToolTipText('我是按钮ToolTip');
			
			var slider:JSlider = new JSlider(0, 280, 200);
			frame.append(slider);
			var sliderLabel:JLabel = new JLabel(330, 240, '0');
			frame.append(sliderLabel);
			slider.addEventListener(Event.CHANGE, function(evt:Event):void { sliderLabel.text = slider.getValue().toFixed(2); } );
			
			var textArea:JTextArea = new JTextArea(50, 160, '请输入：');
			textArea.setSize(200, 110);
			frame.append(textArea);
			var list:JList = new JList(240, 60);
			list.setSize(60, 100);
			frame.append(list);
			var data:Vector.<Object> = new Vector.<Object>();
			for (var i:int = 0; i < 100;i += 1)
				data[i] = 'item' + i;
			list.setDataList(data);
			
			var comboBox:JComboBox = new JComboBox(4, '下拉框', 50, 100);
			panel.append(comboBox);
			comboBox.setDataList(data);
		}
		
		private function onCliked(e:MouseEvent):void {
			frame.showSwitch();
		}
		
	}
	
}