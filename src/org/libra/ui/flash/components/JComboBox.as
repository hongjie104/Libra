package org.libra.ui.flash.components {
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.theme.DefaultComboBoxTheme;
	import org.libra.utils.GraphicsUtil;
	
	/**
	 * <p>
	 * 下拉框
	 * </p>
	 *
	 * @class JComboBox
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/05/2012
	 * @version 1.0
	 * @see
	 */
	public class JComboBox extends Component {
		
		private var list:JList;
		
		private var listMask:Shape;
		
		private var content:JLabel;
		
		private var pressBtn:JButton;
		
		private var orientation:int;
		
		private var defaultText:String;
		
		/**
		 * 是否折叠着。。。
		 */
		private var fold:Boolean;
		
		private var unfoldTweenLite:TweenLite;
		
		private var foldTweenLite:TweenLite;
		
		private var theme:DefaultComboBoxTheme;
		
		/**
		 * 构造函数
		 * @param	orientation 下拉框方向。默认是4，向下，其他值：向上
		 * @see org.libra.ui.Constants
		 * @param	x
		 * @param	y
		 */
		public function JComboBox(theme:DefaultComboBoxTheme, orientation:int = 4, defaultText:String = '', x:int = 0, y:int = 0) { 
			super(x, y);
			this.theme = theme;
			this.orientation = orientation;
			this.defaultText = defaultText;
			this.setSize(theme.width, theme.height);
			fold = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setDataList(val:Vector.<Object>):void {
			list.setDataList(val);
		}
		
		public function getDataList():Vector.<Object> {
			return list.getDataList();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			
			content = new JLabel(theme.contentTheme, 0, 0, defaultText);
			pressBtn = new JButton(theme.pressBtnTheme, 0, 0);
			this.addChildAll(content, pressBtn);
			
			list = new JList();
			listMask = new Shape();
			GraphicsUtil.drawRect(listMask.graphics, 0, 0, 1, 1, 0, 0);
		}
		
		override protected function resize():void {
			content.setSize(actualWidth, actualHeight);
			pressBtn.setLocation(actualWidth - pressBtn.width - 2, (actualHeight - pressBtn.height) >> 1);
			list.setSize(actualWidth, 160);
			listMask.width = actualWidth;
			listMask.height = list.height;
		}
		
		/**
		 * 展开
		 */
		private function toUnfold():void {
			if (fold) {
				this.fold = false;
				this.addChild(list);
				this.addChild(listMask);
				list.mask = listMask;
				if (orientation == Constants.DOWN) {
					//加1，让下拉菜单和文本之间留出1像素的空隙，仅仅是为了美观。
					listMask.y = actualHeight + 1;
					list.setLocation(0, listMask.y - list.height);
					
				}else {
					listMask.y = 0 - 1 - listMask.height;
					list.setLocation(0, -1);
				}
				stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
				if (unfoldTweenLite) unfoldTweenLite.restart();
				else unfoldTweenLite = TweenLite.to(list, .2, { y:listMask.y } );
			}
		}
		
		/**
		 * 折叠
		 */
		private function toFold():void {
			if (!fold) {
				this.fold = true;
				stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
				if (foldTweenLite) foldTweenLite.restart();
				else foldTweenLite = TweenLite.to(list, .2, { y:orientation == Constants.DOWN ? actualHeight + 1 - list.height : -1, onComplete:function():void { 
						removeChild(list);
						removeChild(listMask);
					}} );
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.pressBtn.addEventListener(MouseEvent.CLICK, onPressClicked);
			this.list.addEventListener(Event.SELECT, onItemSelected);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.pressBtn.removeEventListener(MouseEvent.CLICK, onPressClicked);
			this.list.removeEventListener(Event.SELECT, onItemSelected);
		}
		
		private function onPressClicked(e:MouseEvent):void {
			fold ? toUnfold() : toFold();
			e.stopPropagation();
		}
		
		/**
		 * 下拉框点击事件
		 * @param	e
		 */
		private function onItemSelected(e:Event):void {
			const selectedItem:JListItem = list.getSelectedItem();
			this.content.text = selectedItem.getData();
			onPressClicked(null);
		}
		
		/**
		 * 展开时，侦听舞台鼠标抬起事件，收缩下拉框
		 * @param	e
		 */
		private function onStageMouseUp(e:MouseEvent):void {
			if (e.target == pressBtn) return;
			const p:Point = localToGlobal(new Point(list.x, list.y));
			if (!new Rectangle(p.x, p.y, list.width, list.height).contains(e.stageX, e.stageY)) this.toFold();
		}
		
	}

}