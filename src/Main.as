package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import org.libra.copGameEngine.MainContext;
	import org.libra.ui.flash.core.Container;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.DefaultTheme;
	import org.libra.ui.utils.ResManager;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public class Main extends Sprite {
		
		//private var frame:JFrame;
		
		//[Embed(source="../asset/walk.png")]
		//private var BMP:Class;
		
		//private var starling:Starling;
		private var loader:Loader;
		
		private var myContent:MainContext;
		
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
			//testUI();
			//testAutoCreateUI();
			//testBmpEngine();
			//testAStar();
			//测试绘制菱形
			//testDiamond();
			//testStarlingUI();
			//testMultiBitmap();
			testCopGame();
			
			//addChild(new SystemStatus());
		}
		
		private function testCopGame():void {
			Security.allowDomain('*');
			const uiContainer:Container = new Container();
			UIManager.getInstance().init(stage, uiContainer, new DefaultTheme());
			myContent = new MainContext(this);
		}
		
		//private function testAutoCreateUI():void {
			///*var xml:XML = <View>
			  //<Container x="20" y="-10">
			    //<JLabel text="yung" x="103" y="38" textColor="0xffffff" />
			    //<JLabel text="Lv.36" x="206" y="38" textColor="0xffffff" size="12"/>
			    //<JLabel text="银币" x="104" y="61" textColor="0xffffff" stroke="0x000000,0.5,2,2"/>
			    //<JLabel text="6万" x="136" y="61" textColor="0xffffff" stroke="0x000000,0.5,2,2" width="100"/>
			    //<JLabel text="金币" x="104" y="84" textColor="0xffff00" stroke="0x000000,0.5,2,2"/>
			    //<JLabel text="10" x="136" y="84" textColor="0xffffff" stroke="0x000000,0.5,2,2" width="50"/>
			    //<JLabel text="10" x="223" y="84" textColor="0xffffff" stroke="0x000000,0.5,2,2" width="50"/>
			    //<JLabel text="礼券" x="191" y="83" textColor="0xffff00" stroke="0x000000,0.5,2,2"/>
			    //<JLabel text="10/80" x="124" y="108" textColor="0xffffff" stroke="0x000000,0.5,2,2" width="50"/>
			    //<JButton text="按钮" x="183" y="110"/>
			  //</Container>
			//</View>;*/
			///*var xml:XML = <View>
			//<Container width="300" height="200">
			  //<JButton width="43" height="26" text="org.libra.ui.flash.components::JButton" textColor="16759090" textAlign="center"/>
			  //<JLabel width="120" height="20" text="org.libra.ui.flash.components::JLabel" textColor="16777215" textAlign="left"/>
			//</Container>
			//</View>;*/
			//var xml:XML = <View>
			     //<JButton width="43" height="26" toolTipText="这是按钮" text="org.libra.ui.flash.components::JButton" textColor="16759090" textAlign="center" x="110" y="105"/>
				 //<JTextField width="120" height="20" text="org.libra.ui.flash.components::JTextField" textColor="3355443" textAlign="left" displayAsPassword="true" x="60" y="71"/>
			//</View>;
			//
			//var uiContainer:Container = new Container();
			//uiContainer.setSize(stage.stageWidth, stage.stageHeight);
			//UIManager.getInstance().init(this.stage, uiContainer, new DefaultTheme());
			//var panel:JPanel = new JPanel(uiContainer, 300, 200, '', false, UIManager.getInstance().theme.panelTheme);
			//panel.createView(xml);
			//panel.show();
			//panel.x = panel.y = 50;
		//}
		
		//private function testStarlingUI():void {
			///*starling = new starling.core.Starling(Game, stage);
			//starling.start();
			//starling.showStats = true;
			//
			//starling.addEventListener(starling.events.Event.ROOT_CREATED, function(evt:starling.events.Event):void { UIManager.getInstance().init(this.stage, null, new DefaultTheme()); } );*/
		//}
		
		//private function testDiamond():void {
			//GraphicsUtil.drawDiamondNet(this.graphics, new Point(300), 20, 40);
		//}
		
		//private function testAStar():void {
			//var map:AStarTest = new AStarTest();
			//map.x = 60; map.y = 80;
			//this.addChild(map);
		//}
		
		/*private function testMultiBitmap():void {
			var source:BitmapData = (new BMP() as Bitmap).bitmapData;
			var w:int = source.width >> 3;
			var h:int = source.height >> 3;
			var bmdList:Vector.<BitmapData> = BitmapDataUtil.separateBitmapData(w, h, source)[0];
			
			for (var i:int = 0; i < 1100; i += 1) {
				var bitmap:JMultiBitmap = new JMultiBitmap(w, h);
				var layer:RenderLayer = new RenderLayer(w, h);
				var sprite:RenderMovieCelip = new RenderMovieCelip(bmdList);
				//sprite.frameRate = 12;
				sprite.play();
				layer.addItem(sprite);
				bitmap.addLayer(layer);
				this.addChild(bitmap);
				bitmap.x = MathUtil.random(0, stage.stageWidth);
				bitmap.y = MathUtil.random(0, stage.stageHeight);
				Tick.getInstance().addItem(bitmap);
				Tick.getInstance().addItem(sprite);
			}
		}*/
		
		//private function testBmpEngine():void {
			//var source:BitmapData = (new BMP() as Bitmap).bitmapData;
			//
			//var frameList:Vector.<BitmapFrame> = new Vector.<BitmapFrame>();
			//var rows:int = Math.ceil(64 / 8);
			//var bmdList:Vector.<Vector.<BitmapData>> = BitmapDataUtil.separateBitmapData(source.width / 8, source.height / rows, source);
			//var count:int = 0;
			//for (var k:* in bmdList) {
				//var bmdList1:Vector.<BitmapData> = bmdList[k];
				//for(var j:* in bmdList1)
				//frameList[count] = new BitmapFrame(count++, bmdList1[j]);
			//}
			//for (i = 0; i < 200; i += 1 ) {
				//var avatar:Avatar = new Avatar();
				//var animatable:BitmapAnimatable = new BitmapAnimatable(avatar.getBitmap());
				//animatable.setFrameList(frameList);
				//avatar.setAnimatable(animatable);
				//this.addChild(avatar);
				//avatar.x = Math.random() * stage.stageWidth;
				//avatar.y = Math.random() * stage.stageHeight;
			//}
			//
			//return;
			//
			//for (var i:int = 0; i < 1; i += 1 ) {
				//var bmp:JBitmap = JBitmapUtil.createFromBitmap(67, source, 10, true);
				//var bmp:JBitmap = JBitmapUtil.createFromBitmap(8, 64, source, 10, true);
				//this.addChild(bmp);
				//bmp.x = Math.random() * stage.stageWidth;
				//bmp.y = Math.random() * stage.stageHeight;
			//}
			//
			///*var source:MovieClip = new TestRole();
			//for (var i:int = 0; i < 100; i += 1 ) {
				//var bmp:JBitmap = JBitmapUtil.createFromMC(source);
				//this.addChild(bmp);
				//bmp.x = Math.random() * stage.stageWidth + 100;
				//bmp.y = Math.random() * stage.stageHeight + 100;
			//}*/
			//
			///*var bmdList:Vector.<BitmapData> = BitmapDataUtil.separateBitmapData(100, 130, source)[0];
			//var bitmap:JMultiBitmap = new JMultiBitmap(100, 130);
			//var render:RenderLayer = new RenderLayer();
			//var renderItem:RenderItem = new RenderItem(null, render);
			//bitmap.addLayer(render);
			//this.addChild(bitmap);
			//renderItem.bitmapData = bmdList[0];
			//var count:int = 0;
			//this.addEventListener(flash.events.Event.ENTER_FRAME, function(evt:flash.events.Event):void { 
					//if (count++ == 4) count = 0;
					//renderItem.bitmapData = bmdList[count];
				//} );*/
		//}
		
		/*private function testUI():void {
			var uiContainer:Container = new Container();
			this.addChild(uiContainer);
			
			UIManager.getInstance().init(this.stage, uiContainer, new DefaultTheme());
			
			frame = new JFrame(uiContainer, 400, 300, '', false, 25, UIManager.getInstance().theme.frameTheme);
			//frame.setCloseEnabled(false);
			//frame.setDragBarEnabled(false);
			frame.show();
			
			var panel:JPanel = new JPanel(uiContainer, 300, 200, '', false, UIManager.getInstance().theme.panelTheme);
			panel.show();
			
			
			var label:JLabel = new JLabel(UIManager.getInstance().theme.labelTheme, 40, 32, 'hello world!');
			var tf:JTextField = new JTextField(UIManager.getInstance().theme.textFieldTheme, 40, 50, '输入框');
			var pw:JTextField = new JTextField(UIManager.getInstance().theme.textFieldTheme, 40, 80, '密码输入框');
			pw.displayAsPassword = true;
			panel.appendAll(label, tf, pw);
			var btn0:JButton = new JButton(UIManager.getInstance().theme.btnTheme, 250, 50, '开关');
			btn0.toolTipText = '开关';
			panel.append(btn0);
			btn0.addEventListener(MouseEvent.CLICK, onCliked);
			
			var btn:JButton = new JButton(UIManager.getInstance().theme.btnTheme, 30, 60, '按钮');
			frame.append(btn);
			
			var checkBoxGroup:JCheckBoxGroup = new JCheckBoxGroup(30, 120, 0);
			checkBoxGroup.appendAllCheckBox(new JCheckBox(UIManager.getInstance().theme.checkBoxTheme, 0, 0, '按钮0'), 
				new JCheckBox(UIManager.getInstance().theme.checkBoxTheme, 30, 90, '按钮1'), new JCheckBox(UIManager.getInstance().theme.checkBoxTheme, 30, 90, '按钮2'));
			frame.append(checkBoxGroup);
			
			btn.toolTipText = '我是按钮ToolTip';
			
			var progressBar:JProgressBar = new JProgressBar(UIManager.getInstance().theme.progressBarTheme);
			frame.append(progressBar);
			
			var slider:JSlider = new JSlider(0, 280, 200);
			frame.append(slider);
			var sliderLabel:JLabel = new JLabel(UIManager.getInstance().theme.labelTheme, 330, 240, '0');
			frame.append(sliderLabel);
			slider.addEventListener(flash.events.Event.CHANGE, function(evt:flash.events.Event):void { sliderLabel.text = slider.value.toFixed(2); progressBar.setProgress(slider.value / 100); } );
			
			var textArea:JTextArea = new JTextArea(UIManager.getInstance().theme.textAreaTheme, 50, 160, '请输入：');
			frame.append(textArea);
			var list:JList = new JList(240, 60);
			list.setSize(60, 100);
			frame.append(list);
			
			var data:Vector.<Object> = new Vector.<Object>();
			for (var i:int = 0; i < 100;i += 1)
				data[i] = 'item' + i;
			list.dataList = data;
			
			var comboBox:JComboBox = new JComboBox(UIManager.getInstance().theme.comboBoxTheme, Constants.DOWN, '下拉框', 50, 100);
			panel.append(comboBox);
			comboBox.dataList = data;
			
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
		}*/
		
	}
	
}