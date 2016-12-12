package org.libra.flex.utils {
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;

	/**
	 * @name PopUpUtil
	 * @arguments 代替PopUpManager，用于弹出、关闭弹出窗口，并在此过程中调用PopUpEffector类产生的动画效果
	 * @author MoLice
	 * @private {object} effector PopUpEffect的实例
	 * @public {void} addPopUp() 使用PopUpManager.addPopUp弹出窗口
	 * @public {void} removePopUp() 使用PopUpManager.removePopUp关闭窗口
	 */
	public class PopUpUtil {
		private var effector:Object;
		
		private static var _instance:PopUpUtil;

		public function PopUpUtil() {
		}

		/**
		 * @name addPopUp
		 * @arguments 弹出窗口方法
		 * @param {IFlexDisplayObject} win 要弹出的可视对象，例如Panel、Label等
		 * @param {DisplayObject} 同PopUpManager.addPopUp()
		 * @param {Boolean} modal 是否加遮罩层，默认false
		 * @param {Number|String} type 动画类型，详见PopUpEffect类的说明
		 * @param {Point|String} position 弹出位置，可以是一个Point类的坐标，假如传入字符串"center"则在中央显示
		 * @param {String} childList 同PopUpManager.addPopUp()
		 */
		public function addPopUp(win:IFlexDisplayObject, parent:DisplayObject, modal:Boolean = false, type:* = 0, position:* = "center", childList:String =null):void {

			//创建一个PopUpEffector实例，使用type类型的动画在show（弹出）时修饰win
			this.effector = new PopUpEffector(win, true, type);

			//在parent上弹出win
			PopUpManager.addPopUp(win, parent, modal, childList);

			//定位win的弹出位置
			if (position is Point) {
				win.x=position.x;
				win.y=position.y;
			} else {
				PopUpManager.centerPopUp(win);
			}

			//播放动画
			this.effector.play();
		}

		/**
		 * @name removePopUp
		 * @arguments 关闭弹出窗口
		 * @param {IFlexDisplayObject} win 要关闭的窗口
		 * @param {Number|String} type 动画类型，详见PopUpEffect类的说明
		 */
		public function removePopUp(win:IFlexDisplayObject, type:*):void {
			//创建一个PopUpEffector实例，使用type类型的动画在hide（关闭）时修饰win
			this.effector=new PopUpEffector(win, false, type);

			//播放动画
			this.effector.play();
		}
		
		public static function get instance():PopUpUtil{
			return _instance ||= new PopUpUtil();
		}

	}
}
