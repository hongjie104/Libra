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
		
		private var _list:JList;
		
		private var _listMask:Shape;
		
		private var _content:JLabel;
		
		private var _pressBtn:JButton;
		
		private var _orientation:int;
		
		private var _defaultText:String;
		
		/**
		 * 是否折叠着。。。
		 */
		private var _fold:Boolean;
		
		private var _unfoldTweenLite:TweenLite;
		
		private var _foldTweenLite:TweenLite;
		
		private var _pressBtnSkin:BtnSkin;
		
		/**
		 * 构造函数
		 * @param	orientation 下拉框方向。默认是4，向下，其他值：向上
		 * @see org.libra.ui.Constants
		 * @param	x
		 * @param	y
		 */
		public function JComboBox(x:int = 0, y:int = 0, defaultText:String = '', orientation:int = 4, pressBtnSkin:BtnSkin = null) { 
			super(x, y);
			this._orientation = orientation;
			this._defaultText = defaultText;
			this._pressBtnSkin = pressBtnSkin ? pressBtnSkin : (orientation == Constants.DOWN ? UIManager.instance.skin.vScrollDownBtnSkin : UIManager.instance.skin.vScrollUpBtnSkin);
			this.setSize(100, 20);
			_fold = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set dataList(val:Vector.<Object>):void {
			_list.dataList = val;
		}
		
		public function get dataList():Vector.<Object> {
			return _list.dataList;
		}
		
		public function set skin(value:BtnSkin):void {
			_pressBtnSkin = value;
			this.invalidate(InvalidationFlag.STYLE);
		}
		
		override public function clone():Component {
			return new JComboBox(x, y, _defaultText, _orientation, _pressBtnSkin);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void {
			super.init();
			
			_content = new JLabel(0, 0, _defaultText);
			_pressBtn = new JButton(0, 0, _pressBtnSkin);
			this.addChildAll(_content, _pressBtn);
			
			_list = new JList();
			_listMask = new Shape();
			GraphicsUtil.drawRect(_listMask.graphics, 0, 0, 1, 1, 0, 0);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			_content.setSize(_actualWidth, _actualHeight);
			_pressBtn.setLocation(_actualWidth - _pressBtn.width - 2, (_actualHeight - _pressBtn.height) >> 1);
			_list.setSize(_actualWidth, 160);
			_listMask.width = _actualWidth;
			_listMask.height = _list.height;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshStyle():void {
			_pressBtn.skin = _pressBtnSkin;
		}
		
		/**
		 * 展开
		 * @private
		 */
		private function toUnfold():void {
			if (_fold) {
				this._fold = false;
				this.addChild(_list);
				this.addChild(_listMask);
				_list.mask = _listMask;
				if (_orientation == Constants.DOWN) {
					//加1，让下拉菜单和文本之间留出1像素的空隙，仅仅是为了美观。
					_listMask.y = _actualHeight + 1;
					_list.setLocation(0, _listMask.y - _list.height);
					
				}else {
					_listMask.y = 0 - 1 - _listMask.height;
					_list.setLocation(0, -1);
				}
				stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
				if (_unfoldTweenLite) _unfoldTweenLite.restart();
				else _unfoldTweenLite = TweenLite.to(_list, .2, { y:_listMask.y } );
			}
		}
		
		/**
		 * 折叠
		 * @private
		 */
		private function toFold():void {
			if (!_fold) {
				this._fold = true;
				stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
				if (_foldTweenLite) _foldTweenLite.restart();
				else _foldTweenLite = TweenLite.to(_list, .2, { y:_orientation == Constants.DOWN ? _actualHeight + 1 - _list.height : -1, onComplete:function():void { 
						removeChild(_list);
						removeChild(_listMask);
					}} );
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this._pressBtn.addEventListener(MouseEvent.CLICK, onPressClicked);
			this._list.addEventListener(Event.SELECT, onItemSelected);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this._pressBtn.removeEventListener(MouseEvent.CLICK, onPressClicked);
			this._list.removeEventListener(Event.SELECT, onItemSelected);
		}
		
		private function onPressClicked(e:MouseEvent):void {
			_fold ? toUnfold() : toFold();
			if (!UIManager.UI_EDITOR) {
				if(e) e.stopPropagation();
			}
		}
		
		/**
		 * 下拉框点击事件
		 * @param	e
		 */
		private function onItemSelected(e:Event):void {
			this._content.text = _list.selectedItem.data;
			onPressClicked(null);
		}
		
		/**
		 * 展开时，侦听舞台鼠标抬起事件，收缩下拉框
		 * @param	e
		 */
		private function onStageMouseUp(e:MouseEvent):void {
			if (e.target == _pressBtn) return;
			const p:Point = localToGlobal(new Point(_list.x, _list.y));
			if (!new Rectangle(p.x, p.y, _list.width, _list.height).contains(e.stageX, e.stageY)) this.toFold();
		}
		
	}

}