package org.libra.ui.starling.core {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.libra.starling.ui.text.JFont;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseText
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/27/2012
	 * @version 1.0
	 * @see
	 */
	public class BaseText extends Component {
		
		private static var helpTextField:TextField = new TextField();
		
		private var text:String;
		
		private var htmlText:String;
		
		private var wordWrap:Boolean;
		
		private var textFilter:Array;
		
		private var textAlign:String;
		
		private var textX:int;
		
		private var textY:int;
		
		private var textImage:Image;
		
		private var textBmd:BitmapData;
		
		public function BaseText(x:int, y:int, widht:int, height:int, text:String = '') { 
			super(x, y, widht, height);
			this.setText(text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function getText():String {
			return this.text;
		}
		
		public function setText(val:String):void {
			this.text = val;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		public function appendText(text:String):void {
			this.text += text;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		public function getHtmlText():String {
			return this.htmlText;
		}
		
		public function setHtmlText(val:String):void {
			this.htmlText = val;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		public function appendHtmlText(text:String):void {
			this.htmlText += text;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		public function setFont(font:JFont):void {
			helpTextField.defaultTextFormat = font.getTextFormat();
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		public function setWordWrap(val:Boolean):void {
			this.wordWrap = val;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		public function setTextFilter(filter:Array):void {
			this.textFilter = filter;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		public function setTextAlign(val:String):void {
			this.textAlign = val;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		public function setTextLocation(x:int, y:int):void {
			this.textX = x;
			this.textY = y;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		override public function dispose():void {
			super.dispose();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function resize():void {
			super.resize();
			helpTextField.width = actualWidth;
			helpTextField.height = actualHeight;
			if (this.textBmd) textBmd.dispose();
			textBmd = new BitmapData(actualWidth, actualHeight, true, 0);
		}
		
		override protected function refreshText():void {
			helpTextField.wordWrap = this.wordWrap;
			helpTextField.filters = this.textFilter;
			
			var tf:TextFormat = helpTextField.defaultTextFormat;
			tf.align = this.textAlign;
			helpTextField.defaultTextFormat = tf;
			
			if (text) helpTextField.text = this.text;
			else if (htmlText) helpTextField.htmlText = this.htmlText;
			else {
				helpTextField.text = '';
			}
			
			this.textBmd.fillRect(textBmd.rect, 0x00000000);
			this.textBmd.draw(helpTextField, new Matrix(1, 0, 0, 1, 0, ((actualHeight - helpTextField.textHeight) >> 1) - 2));
			text = htmlText = '';
			var texture:Texture = Texture.fromBitmapData(textBmd, false, false, Starling.contentScaleFactor);
			if (this.textImage) {
				textImage.texture.dispose();
				textImage.texture = texture;
				textImage.readjustSize();
			}else {
				textImage = new Image(texture);
                textImage.touchable = false;
                addChild(textImage);
			}
			textImage.x = textX;
			textImage.y = textY;
		}
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}