package {
	import com.greensock.loading.SWFLoader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import org.libra.aStar.AStarTest;
	import org.libra.bmpEngine.JBitmap;
	import org.libra.bmpEngine.utils.JBitmapUtil;
	import org.libra.game.components.animatable.BitmapAnimatable;
	import org.libra.game.components.animatable.BitmapFrame;
	import org.libra.game.objects.Avatar;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.components.JAlert;
	import org.libra.ui.flash.components.JButton;
	import org.libra.ui.flash.components.JCheckBox;
	import org.libra.ui.flash.components.JCheckBoxGroup;
	import org.libra.ui.flash.components.JComboBox;
	import org.libra.ui.flash.components.JCountDown;
	import org.libra.ui.flash.components.JFrame;
	import org.libra.ui.flash.components.JLabel;
	import org.libra.ui.flash.components.JList;
	import org.libra.ui.flash.components.JPageCounter;
	import org.libra.ui.flash.components.JPanel;
	import org.libra.ui.flash.components.JProgressBar;
	import org.libra.ui.flash.components.JSlider;
	import org.libra.ui.flash.components.JTextArea;
	import org.libra.ui.flash.components.JTextField;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.DefaultTheme;
	import org.libra.ui.utils.ResManager;
	import org.libra.utils.displayObject.BitmapDataUtil;
	import org.libra.utils.displayObject.GraphicsUtil;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class Main extends Sprite {
		
		private var frame:JFrame;
		
		[Embed(source="../asset/walk.png")]
		private var BMP:Class;
		
		private var starling:Starling;
		private var loader:Loader;
		
		public function Main():void {
			if (stage) init();
			else addEventListener(flash.events.Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:flash.events.Event = null):void {
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
			stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
			// entry point
			//this.addChild(new TheMiner(true));
			
			//开始加载ui资源
			//var swfLoader:SWFLoader = new SWFLoader('../asset/UI.swf', { name:'UI', onComplete:onLoadUIComplete } );
			//swfLoader.load();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onLoadUIComplete);
			loader.load(new URLRequest('../asset/UI.swf'));
		}
		
		/**
		 * UI资源加载完成
		 * @param	evt
		 */
		private function onLoadUIComplete(evt:flash.events.Event):void {
			//初始化UI
			ResManager.getInstance().init(loader);
			//UIManager.getInstance().init(this.stage, new DefaultTheme());
			testUI();
			//testBmpEngine();
			//testAStar();
			//测试绘制菱形
			//testDiamond();
			//testStarlingUI();
		}
		
		private function testStarlingUI():void {
			/*starling = new starling.core.Starling(Game, stage);
			starling.start();
			starling.showStats = true;
			
			starling.addEventListener(starling.events.Event.ROOT_CREATED, function(evt:starling.events.Event):void { UIManager.getInstance().init(this.stage, null, new DefaultTheme()); } );*/
		}
		
		private function testDiamond():void {
			GraphicsUtil.drawDiamondNet(this.graphics, new Point(300), 20, 40);
		}
		
		private function testAStar():void {
			var map:AStarTest = new AStarTest();
			//map.x = 60; map.y = 80;
			this.addChild(map);
		}
		
		private function testBmpEngine():void {
			var source:BitmapData = (new BMP() as Bitmap).bitmapData;
			
			var frameList:Vector.<BitmapFrame> = new Vector.<BitmapFrame>();
			var rows:int = Math.ceil(64 / 8);
			var bmdList:Vector.<Vector.<BitmapData>> = BitmapDataUtil.separateBitmapData(source.width / 8, source.height / rows, source);
			var count:int = 0;
			for (var k:* in bmdList) {
				var bmdList1:Vector.<BitmapData> = bmdList[k];
				for(var j:* in bmdList1)
				frameList[count] = new BitmapFrame(count++, bmdList1[j]);
			}
			for (i = 0; i < 5; i += 1 ) {
				var avatar:Avatar = new Avatar();
				var animatable:BitmapAnimatable = new BitmapAnimatable(avatar.getBitmap());
				animatable.setFrameList(frameList);
				avatar.setAnimatable(animatable);
				this.addChild(avatar);
				avatar.x = Math.random() * stage.stageWidth;
				avatar.y = Math.random() * stage.stageHeight;
			}
			
			return;
			
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
			
			UIManager.getInstance().init(this.stage, uiContainer, new DefaultTheme());
			
			frame = new JFrame(uiContainer, UIManager.getInstance().theme.frameTheme, 400, 300);
			//frame.setCloseEnabled(false);
			//frame.setDragBarEnabled(false);
			frame.show();
			
			var panel:JPanel = new JPanel(uiContainer, UIManager.getInstance().theme.panelTheme, 300, 200);
			panel.show();
			
			var label:JLabel = new JLabel(UIManager.getInstance().theme.labelTheme, 40, 32, 'hello world!');
			var tf:JTextField = new JTextField(UIManager.getInstance().theme.textFieldTheme, 40, 50, '输入框');
			var pw:JTextField = new JTextField(UIManager.getInstance().theme.textFieldTheme, 40, 80, '密码输入框');
			pw.displayAsPassword = true;
			panel.appendAll(label, tf, pw);
			var btn0:JButton = new JButton(UIManager.getInstance().theme.btnTheme, 250, 50, '开关');
			btn0.setToolTipText('开关');
			panel.append(btn0);
			btn0.addEventListener(MouseEvent.CLICK, onCliked);
			
			var btn:JButton = new JButton(UIManager.getInstance().theme.btnTheme, 30, 60, '按钮');
			frame.append(btn);
			
			var checkBoxGroup:JCheckBoxGroup = new JCheckBoxGroup(30, 120, 0);
			checkBoxGroup.appendAllCheckBox(new JCheckBox(UIManager.getInstance().theme.checkBoxTheme, 0, 0, '按钮0'), 
				new JCheckBox(UIManager.getInstance().theme.checkBoxTheme, 30, 90, '按钮1'), new JCheckBox(UIManager.getInstance().theme.checkBoxTheme, 30, 90, '按钮2'));
			frame.append(checkBoxGroup);
			
			btn.setToolTipText('我是按钮ToolTip');
			
			var progressBar:JProgressBar = new JProgressBar(UIManager.getInstance().theme.progressBarTheme);
			frame.append(progressBar);
			
			var slider:JSlider = new JSlider(0, 280, 200);
			frame.append(slider);
			var sliderLabel:JLabel = new JLabel(UIManager.getInstance().theme.labelTheme, 330, 240, '0');
			frame.append(sliderLabel);
			slider.addEventListener(flash.events.Event.CHANGE, function(evt:flash.events.Event):void { sliderLabel.text = slider.getValue().toFixed(2); progressBar.setProgress(slider.getValue() / 100); } );
			
			var textArea:JTextArea = new JTextArea(UIManager.getInstance().theme.textAreaTheme, 50, 160, '请输入：');
			frame.append(textArea);
			var list:JList = new JList(240, 60);
			list.setSize(60, 100);
			frame.append(list);
			var data:Vector.<Object> = new Vector.<Object>();
			for (var i:int = 0; i < 100;i += 1)
				data[i] = 'item' + i;
			list.setDataList(data);
			
			var comboBox:JComboBox = new JComboBox(UIManager.getInstance().theme.comboBoxTheme, Constants.DOWN, '下拉框', 50, 100);
			panel.append(comboBox);
			comboBox.setDataList(data);
			
			var pageCounter:JPageCounter = new JPageCounter(UIManager.getInstance().theme.pageCountTheme, 10, 3, 50, 50);
			frame.append(pageCounter);
			
			var cd:JCountDown = new JCountDown(UIManager.getInstance().theme.labelTheme, 100, 100, '剩余时间: ');
			frame.append(cd);
			cd.setLeftSecond(528);
		}
		
		private function onCliked(e:MouseEvent):void {
			//frame.showSwitch();
			JAlert.show('测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗测试弹窗', function(r:int):void { trace(r); }, JAlert.OK | JAlert.CANCEL | JAlert.YES );
			//trace(UIManager.getInstance().keyPoll.isUp(Keyboard.D));
		}
		
	}
	
}