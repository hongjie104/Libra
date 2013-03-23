package org.libra.ui.starling.theme {
	import com.google.analytics.debug.Panel;
	import flash.geom.Rectangle;
	import org.libra.ui.starling.textures.Scale9Texture;
	import org.libra.utils.HashMap;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * <p>
	 * 默认的主题
	 * </p>
	 *
	 * @class DefaultTheme
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/03/2012
	 * @version 1.0
	 * @see
	 */
	public final class DefaultTheme {
		
		public static const PANEL:PanelTheme = new PanelTheme('panelBg', new Rectangle(3, 3, 11, 6));
		
		public static const FRAME:PanelTheme = new PanelTheme('frameBg', new Rectangle(12, 60, 1, 1));
		
		public static const TOOL_TIP:PanelTheme = new PanelTheme('toolTipBg', new Rectangle(5, 4, 1, 20));
		
		public static const BTN:ButtonTheme = new ButtonTheme('btn');
		
		public static const BTN_CLOSE:ButtonTheme = new ButtonTheme('btnClose');
		
		public static const BTN_CHECK:ButtonTheme = new ButtonTheme('checkBtn');
		
		[Embed(source="../../../../../../asset/ui.png")]
		private var UI:Class;
		
		[Embed(source = "../../../../../../asset/ui.xml", mimeType = "application/octet-stream")]
		private var UIXML:Class;
		
		private static var instance:DefaultTheme;
		
		private var atlas:TextureAtlas;
		
		private var textureMap:HashMap;
		
		public function DefaultTheme(singleton:Singleton) {
			atlas = new TextureAtlas(Texture.fromBitmap(new UI()), XML(new UIXML()));
			textureMap = new HashMap();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function getTexture(name:String):Texture {
			var texture:Texture = this.textureMap.get(name) as Texture;
			if (texture) return texture;
			texture = this.atlas.getTexture(name);
			if (texture) textureMap.put(name, texture);
			return texture;
		}
		
		public function getScale9Texture(panelTheme:PanelTheme):Scale9Texture {
			var texture:Scale9Texture = this.textureMap.get(panelTheme.name) as Scale9Texture;
			if (texture) return texture;
			texture = new Scale9Texture(getTexture(panelTheme.name), panelTheme.scale9Grid);
			textureMap.put(panelTheme.name, texture);
			return texture;
		}
		
		public static function getInstance():DefaultTheme {
			return instance ||= new DefaultTheme(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}

final class Singleton { }