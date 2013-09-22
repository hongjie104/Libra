package org.libra.ui.flash.components {
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.BtnSkin;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.utils.displayObject.GraphicsUtil;
	
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
		
		private var $list:JList;
		
		private var $listMask:Shape;
		
		private var $content:JLabel;
		
		private var $pressBtn:JButton;
		
		private var $orientation:int;
		
		private var $defaultText:String;
		
		/**
		 * 是否折叠着。。。
		 */
		private var $fold:Boolean;
		
		private var $unfoldTweenLite:TweenLite;
		
		private var $foldTweenLite:TweenLite;
		
		private var $pressBtnSkin:BtnSkin;
		
		/**
		 * 构造函数
		 * @param	orientation 下拉框方向。默认是4，向下，其他值：向上
		 * @see org.libra.ui.Constants
		 * @param	x
		 * @param	y
		 */
		public function JComboBox(x:int = 0, y:int = 0, defaultText:String = '', orientation:int = 4, pressBtnSkin:BtnSkin = null) { 
			super(x, y);
			this.$orientation = orientation;
			this.$defaultText = defaultText;
			this.$pressBtnSkin = pressBtnSkin ? pressBtnSkin : (orientation == Constants.DOWN ? UIManager.getInstance().skin.vScrollDownBtnSkin : UIManager.getInstance().skin.vScrollUpBtnSkin);
			this.setSize(100, 20);
			$fold = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set dataList(val:Vector.<Object>):void {
			$list.dataList = val;
		}
		
		public function get dataList():Vector.<Object> {
			return $list.dataList;
		}
		
		public function set skin(value:BtnSkin):void {
			$pressBtnSkin = value;
			this.invalidate(InvalidationFlag.STYLE);
		}
		
		override public function clone():Component {
			return new JComboBox(x, y, $defaultText, $orientation, $pressBtnSkin);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void {
			super.init();
			
			$content = new JLabel(0, 0, $defaultText);
			$pressBtn = new JButton(0, 0, $pressBtnSkin);
			this.addChildAll($content, $pressBtn);
			
			$list = new JList();
			$listMask = new Shape();
			GraphicsUtil.drawRect($listMask.graphics, 0, 0, 1, 1, 0, 0);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			$content.setSize($actualWidth, $actualHeight);
			$pressBtn.setLocation($actualWidth - $pressBtn.width - 2, ($actualHeight - $pressBtn.height) >> 1);
			$list.setSize($actualWidth, 160);
			$listMask.width = $actualWidth;
			$listMask.height = $list.height;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshStyle():void {
			$pressBtn.skin = $pressBtnSkin;
		}
		
		/**
		 * 展开
		 * @private
		 */
		private function toUnfold():void {
			if ($fold) {
				this.$fold = false;
				this.addChild($list);
				this.addChild($listMask);
				$list.mask = $listMask;
				if ($orientation == Constants.DOWN) {
					//加1，让下拉菜单和文本之间留出1像素的空隙，仅仅是为了美观。
					$listMask.y = $actualHeight + 1;
					$list.setLocation(0, $listMask.y - $list.height);
					
				}else {
					$listMask.y = 0 - 1 - $listMask.height;
					$list.setLocation(0, -1);
				}
				stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
				if ($unfoldTweenLite) $unfoldTweenLite.restart();
				else $unfoldTweenLite = TweenLite.to($list, .2, { y:$listMask.y } );
			}
		}
		
		/**
		 * 折叠
		 * @private
		 */
		private function toFold():void {
			if (!$fold) {
				this.$fold = true;
				stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
				if ($foldTweenLite) $foldTweenLite.restart();
				else $foldTweenLite = TweenLite.to($list, .2, { y:$orientation == Constants.DOWN ? $actualHeight + 1 - $list.height : -1, onComplete:function():void { 
						removeChild($list);
						removeChild($listMask);
					}} );
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.$pressBtn.addEventListener(MouseEvent.CLICK, onPressClicked);
			this.$list.addEventListener(Event.SELECT, onItemSelected);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.$pressBtn.removeEventListener(MouseEvent.CLICK, onPressClicked);
			this.$list.removeEventListener(Event.SELECT, onItemSelected);
		}
		
		private function onPressClicked(e:MouseEvent):void {
			$fold ? toUnfold() : toFold();
			if (UIManager.stopPropagation) {
				if(e) e.stopPropagation();
			}
		}
		
		/**
		 * 下拉框点击事件
		 * @param	e
		 */
		private function onItemSelected(e:Event):void {
			this.$content.text = $list.selectedItem.data;
			onPressClicked(null);
		}
		
		/**
		 * 展开时，侦听舞台鼠标抬起事件，收缩下拉框
		 * @param	e
		 */
		private function onStageMouseUp(e:MouseEvent):void {
			if (e.target == $pressBtn) return;
			const p:Point = localToGlobal(new Point($list.x, $list.y));
			if (!new Rectangle(p.x, p.y, $list.width, $list.height).contains(e.stageX, e.stageY)) this.toFold();
		}
		
	}

}