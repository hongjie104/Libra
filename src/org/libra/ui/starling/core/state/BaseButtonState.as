package org.libra.ui.starling.core.state {
	import org.libra.ui.starling.theme.ButtonTheme;
	import org.libra.ui.starling.theme.DefaultTheme;
	import starling.display.DisplayObject;
	import starling.display.Image;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseButtonState
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/28/2012
	 * @version 1.0
	 * @see
	 */
	public class BaseButtonState implements IButtonState {
		
		protected var image:Image;
		
		protected var getTexture:Function;
		
		protected var theme:ButtonTheme;
		
		public function BaseButtonState(theme:ButtonTheme) {
			this.theme = theme;
			getTexture = DefaultTheme.instance.getTexture;
			image = new Image(getTexture(theme.normal));
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.starling.ui.core.state.IButtonState */
		
		public function toNormal():void {
			image.texture = getTexture(theme.normal);
		}
		
		public function toMouseDown():void {
			image.texture = getTexture(theme.down);
		}
		
		public function toMouseUp():void {
			image.texture = getTexture(theme.over);
		}
		
		public function toMouseOver():void {
			image.texture = getTexture(theme.over);
		}
		
		public function getDisplayObject():DisplayObject {
			return image;
		}
		
		public function setSize(width:int, height:int):void {
			image.width = width;
			image.height = height;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}