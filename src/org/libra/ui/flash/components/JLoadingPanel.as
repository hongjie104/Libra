package org.libra.ui.flash.components {
	import org.libra.ui.flash.interfaces.IContainer;
	import org.libra.ui.flash.theme.DefaultPanelTheme;
	
	/**
	 * <p>
	 * 进度条面板
	 * </p>
	 *
	 * @class JLoadingPanel
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class JLoadingPanel extends JPanel {
		
		public function JLoadingPanel(owner:IContainer, theme:DefaultPanelTheme, w:int = 300, h:int = 200, x:int = 0, y:int = 0) { 
			super(owner, theme, w, h, x, y, true);
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}