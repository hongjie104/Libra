package org.libra.ui.flash {
	import org.libra.ui.flash.components.*;
	import org.libra.ui.flash.core.Container;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class UIClassMap
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 05/17/2013
	 * @version 1.0
	 * @see
	 */
	public final class UIClassMap {
		
		public static const UI_CLASS_MAP:Object = { "JButton": JButton, 'JCheckBox':JCheckBox, 'JCheckBoxGroup':JCheckBoxGroup, 'JComboBox':JComboBox, 
			'JCountDown':JCountDown, 'JFrame':JFrame, 'JImage':JImage, 'JLabel':JLabel, 'JList':JList, 'JListItem':JListItem, 'JPageCounter':JPageCounter, 'JPanel:':JPanel, 
			'JProgressBar':JProgressBar, 'JScrollBar':JScrollBar, 'JScrollBlock':JScrollBlock, 'JScrollSlider':JScrollSlider, 'JSlider':JSlider, 'JTextArea':JTextArea, 
			'JTextField':JTextField, 'Container':Container };
		
		public function UIClassMap() {
			throw new Error('UIClassMap无法实例化');
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