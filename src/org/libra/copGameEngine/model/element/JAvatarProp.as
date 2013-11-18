package org.libra.copGameEngine.model.element {
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import org.libra.copGameEngine.component.JMultiBitmapDataRender;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JAvatarProp
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 09/04/2013
	 * @version 1.0
	 * @see
	 */
	public class JAvatarProp extends JMobileProp {
		
		/**
		 * 昵称滤镜
		 */
		public static const NAME_FONT_FILTER:Array = [new DropShadowFilter(0, 45, 0, 1, 2, 3, 10, 1)];
		
		/**
		 * 昵称
		 * @private
		 */
		protected var _nickName:TextField;
		
		/**
		 * 性别
		 * @private
		 */
		protected var _gender:int;
		
		public function JAvatarProp(width:int, height:int, bitmapDataRender:JMultiBitmapDataRender) {
			super(width, height, bitmapDataRender);
			
			_nickName = new TextField();
			_nickName.y = -20;
			_nickName.width = 60;
			_nickName.textColor = 0xffffff;
			_nickName.mouseEnabled = _nickName.mouseWheelEnabled = _nickName.tabEnabled = false;
			var tf:TextFormat = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			_nickName.defaultTextFormat = tf;
			this._nickName.filters = NAME_FONT_FILTER;
			this._sprite.addChild(_nickName);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get gender():int {
			return _gender;
		}
		
		override public function set name(value:String):void {
			super.name = value;
			_nickName.text = value;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}