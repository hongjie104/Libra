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
		protected var $nickName:TextField;
		
		/**
		 * 性别
		 * @private
		 */
		protected var $gender:int;
		
		public function JAvatarProp(width:int, height:int, bitmapDataRender:JMultiBitmapDataRender) {
			super(width, height, bitmapDataRender);
			
			$nickName = new TextField();
			$nickName.y = -20;
			$nickName.width = 60;
			$nickName.textColor = 0xffffff;
			$nickName.mouseEnabled = $nickName.mouseWheelEnabled = $nickName.tabEnabled = false;
			var tf:TextFormat = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			$nickName.defaultTextFormat = tf;
			this.$nickName.filters = NAME_FONT_FILTER;
			this.$sprite.addChild($nickName);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get gender():int {
			return $gender;
		}
		
		override public function set name(value:String):void {
			super.name = value;
			$nickName.text = value;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}