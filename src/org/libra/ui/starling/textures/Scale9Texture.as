package org.libra.ui.starling.textures {
	import flash.geom.Rectangle;
	import starling.textures.Texture;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Scale9Texture
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/03/2012
	 * @version 1.0
	 * @see
	 */
	public class Scale9Texture {
		
		private var texture:Texture;
		
		private var scale9Grid:Rectangle;
		
		private var topLeft:Texture;
		
		private var topCenter:Texture;
		
		private var topRight:Texture;
		
		private var middleLeft:Texture;
		
		private var middleCenter:Texture;
		
		private var middleRight:Texture;
		
		private var bottomLeft:Texture;
		
		private var bottomCenter:Texture;
		
		private var bottomRight:Texture;
		
		public function Scale9Texture(texture:Texture, scale9Grid:Rectangle) { 
			this.texture = texture;
			this.scale9Grid = scale9Grid;
			
			const textureFrame:Rectangle = this.texture.frame;
			const leftWidth:Number = this.scale9Grid.x;
			const centerWidth:Number = this.scale9Grid.width;
			const rightWidth:Number = textureFrame.width - this.scale9Grid.width - this.scale9Grid.x;
			const topHeight:Number = this.scale9Grid.y;
			const middleHeight:Number = this.scale9Grid.height;
			const bottomHeight:Number = textureFrame.height - this.scale9Grid.height - this.scale9Grid.y;

			const regionLeftWidth:Number = leftWidth + textureFrame.x;
			const regionTopHeight:Number = topHeight + textureFrame.y;
			const regionRightWidth:Number = rightWidth - (textureFrame.width - this.texture.width) - textureFrame.x;
			const regionBottomHeight:Number = bottomHeight - (textureFrame.height - this.texture.height) - textureFrame.y;

			const hasLeftFrame:Boolean = regionLeftWidth != leftWidth;
			const hasTopFrame:Boolean = regionTopHeight != topHeight;
			const hasRightFrame:Boolean = regionRightWidth != rightWidth;
			const hasBottomFrame:Boolean = regionBottomHeight != bottomHeight;

			const topLeftRegion:Rectangle = new Rectangle(0, 0, regionLeftWidth, regionTopHeight);
			const topLeftFrame:Rectangle = (hasLeftFrame || hasTopFrame) ? new Rectangle(textureFrame.x, textureFrame.y, leftWidth, topHeight) : null;
			this.topLeft = Texture.fromTexture(this.texture, topLeftRegion, topLeftFrame);

			const topCenterRegion:Rectangle = new Rectangle(regionLeftWidth, 0, centerWidth, regionTopHeight);
			const topCenterFrame:Rectangle = hasTopFrame ? new Rectangle(0, textureFrame.y, centerWidth, topHeight) : null;
			this.topCenter = Texture.fromTexture(this.texture, topCenterRegion, topCenterFrame);

			const topRightRegion:Rectangle = new Rectangle(regionLeftWidth + centerWidth, 0, regionRightWidth, regionTopHeight);
			const topRightFrame:Rectangle = (hasTopFrame || hasRightFrame) ? new Rectangle(0, textureFrame.y, rightWidth, topHeight) : null;
			this.topRight = Texture.fromTexture(this.texture, topRightRegion, topRightFrame);

			const middleLeftRegion:Rectangle = new Rectangle(0, regionTopHeight, regionLeftWidth, middleHeight);
			const middleLeftFrame:Rectangle = hasLeftFrame ? new Rectangle(textureFrame.x, 0, leftWidth, middleHeight) : null;
			this.middleLeft = Texture.fromTexture(this.texture, middleLeftRegion, middleLeftFrame);

			const middleCenterRegion:Rectangle = new Rectangle(regionLeftWidth, regionTopHeight, centerWidth, middleHeight);
			this.middleCenter = Texture.fromTexture(this.texture, middleCenterRegion);

			const middleRightRegion:Rectangle = new Rectangle(regionLeftWidth + centerWidth, regionTopHeight, regionRightWidth, middleHeight);
			const middleRightFrame:Rectangle = hasRightFrame ? new Rectangle(0, 0, rightWidth, middleHeight) : null;
			this.middleRight = Texture.fromTexture(this.texture, middleRightRegion, middleRightFrame);

			const bottomLeftRegion:Rectangle = new Rectangle(0, regionTopHeight + middleHeight, regionLeftWidth, regionBottomHeight);
			const bottomLeftFrame:Rectangle = (hasLeftFrame || hasBottomFrame) ? new Rectangle(textureFrame.x, 0, leftWidth, bottomHeight) : null;
			this.bottomLeft = Texture.fromTexture(this.texture, bottomLeftRegion, bottomLeftFrame);

			const bottomCenterRegion:Rectangle = new Rectangle(regionLeftWidth, regionTopHeight + middleHeight, centerWidth, regionBottomHeight);
			const bottomCenterFrame:Rectangle = hasBottomFrame ? new Rectangle(0, 0, centerWidth, bottomHeight) : null;
			this.bottomCenter = Texture.fromTexture(this.texture, bottomCenterRegion, bottomCenterFrame);

			const bottomRightRegion:Rectangle = new Rectangle(regionLeftWidth + centerWidth, regionTopHeight + middleHeight, regionRightWidth, regionBottomHeight);
			const bottomRightFrame:Rectangle = (hasBottomFrame || hasRightFrame) ? new Rectangle(0, 0, rightWidth, bottomHeight) : null;
			this.bottomRight = Texture.fromTexture(this.texture, bottomRightRegion, bottomRightFrame);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		public function getTopLeft():Texture {
			return this.topLeft;
		}
		
		public function getTopCenter():Texture {
			return this.topCenter;
		}
		
		public function getTopRight():Texture {
			return this.topRight;
		}
		
		public function getMiddleLeft():Texture {
			return this.middleLeft;
		}
		
		public function getMiddleCenter():Texture {
			return this.middleCenter;
		}
		
		public function getMiddleRight():Texture {
			return this.middleRight;
		}
		
		public function getBottomLeft():Texture {
			return this.bottomLeft;
		}
		
		public function getBottomCenter():Texture {
			return this.bottomCenter;
		}
		
		public function getBottomRight():Texture {
			return this.bottomRight;
		}
		
		public function get frame():Rectangle {
			return this.texture ? texture.frame : null;
		}
		
		public function getScale9Grid():Rectangle {
			return this.scale9Grid;
		}
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}