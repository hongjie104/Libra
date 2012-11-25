package org.libra.ui.starling.component {
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.ui.starling.core.BaseButton;
	import org.libra.ui.starling.core.state.BaseCheckBoxState;
	import org.libra.ui.starling.core.state.ICheckBoxState;
	import org.libra.ui.starling.theme.ButtonTheme;
	
	/**
	 * <p>
	 * 选择框，比如单选框，复选框
	 * </p>
	 *
	 * @class JCheckBox
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/03/2012
	 * @version 1.0
	 * @see
	 */
	public class JCheckBox extends BaseButton {
		
		/**
		 * 选中状态
		 * @private
		 */
		static public const SELECTED:String = "selected";
		
		/**
		 * 当前是否被选中了
		 * @private
		 * @default false
		 */
		private var selected:Boolean;
		
		/**
		 * 选择按钮的族群
		 * 用来实现单选框
		 * @private
		 */
		private var group:JCheckBoxGroup;
		
		/**
		 * 构造函数
		 * @private
		 * @param	theme
		 * @param	widht
		 * @param	height
		 * @param	x
		 * @param	y
		 * @param	text
		 */
		public function JCheckBox(theme:ButtonTheme, widht:int, height:int, x:int = 0, y:int = 0, text:String = '') { 
			super(theme, widht, height, x, y, text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 当前是否被选中
		 * @return 布尔值
		 */
		public function isSelected():Boolean {
			return this.selected;
		}
		
		/**
		 * 设置当前是否被选择
		 * @param	val 布尔值
		 * @param	force 
		 */
		public function setSelected(val:Boolean, force:Boolean = false):void {
			if (this.selected != val) {
				//如果一个在JCheckBoxGroup中的已是选择状态的checkBox又被点击了
				//此时这个checkBox的选择状态不应该被改变
				if (!force) {
					if (group) {
						if (selected) return;
					}
				}
				this.selected = val;
				this.invalidate(InvalidationFlag.STATE);
				if (selected) this.dispatchEventWith(SELECTED);
			}
		}
		
		/**
		 * 设置组群，实现单选框的功能
		 * @param	group
		 */
		public function setCheckBoxGroup(group:JCheckBoxGroup):void {
			if (this.group && this.group != group) this.group.removeCheckBox(this);
			this.group = group;
			this.group.addChild(this);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function initState():void {
			state = new BaseCheckBoxState(theme);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshState():void {
			(this.state as ICheckBoxState).setSelected(selected);
			super.refreshState();
			if (selected) {
				if (this.group) this.group.setCheckBoxUnselected(this);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function changSelected():void {
			this.setSelected(!selected);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function invalidate(flag:int = -1):void {
			super.invalidate(flag);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
	}

}