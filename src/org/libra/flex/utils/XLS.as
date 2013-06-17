package org.libra.flex.utils {
	import com.as3xls.xls.Cell;
	import com.as3xls.xls.ExcelFile;
	import com.as3xls.xls.Sheet;
	
	import flash.events.*;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import spark.components.DataGrid;
	import spark.components.gridClasses.GridColumn;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class XLS
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 06/15/2013
	 * @version 1.0
	 * @see
	 */
	public final class XLS {
		
		public function XLS() {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 导出Excel表格函数，参数为DataGrid
		 * @param	myDg
		 */
		public static function exportToExcel(myDg:DataGrid):void {
			var fields:Array = [];
			/**生成表对象sheet**/
			var sheet:Sheet = new Sheet();
			var dataProviderCollection:ArrayCollection = myDg.dataProvider as  ArrayCollection;
			/**获得表格的行数**/
			var rowCount:int = dataProviderCollection.length;
			/**设置表格的行数(rowCount+1)，列数（myDg.columnCount）**/
			sheet.resize(rowCount + 1, myDg.columnsLength);
			/**获得DateGrid列的内容**/
			var columns:Array = myDg.columns.toArray();
			/**循环设置列名的值**/
			var i:int = 0;
			for each (var field:GridColumn in columns) {
				fields.push(field.dataField);
				/**第一行的值,取值为myDg的headerText**/
				sheet.setCell(0, i, field.headerText.toString());
				i++;
			}
			/**循环设置行的值**/
			for(var r:int=0;r<rowCount;r++) {
				/**获得dataProviderCollection的每行Item的对象**/
				var record:Object = dataProviderCollection.getItemAt(r);
				/**调用回调函数写入sheet**/
				insertRecordInSheet(r + 1, sheet, record);
			}
			/**生成Excel文件**/
			var xls:ExcelFile = new ExcelFile();
			/**将sheet写入Excel文件中**/
			xls.sheets.addItem(sheet);
			/**将xls对象转换为ByteArray流对象**/
			var bytes: ByteArray = xls.saveToByteArray();
			/**生成新文件域**/
			var fr:FileReference = new FileReference();
			/**将bytes流对象保存到文件域**/
			fr.save(bytes, "SampleExport.xls");
			
			/**回调函数**/
			function insertRecordInSheet(row:int, sheet:Sheet, record:Object):void {
				var colCount:int = myDg.columnsLength;
				for (var c:int; c < colCount; c++) {
					var i:int = 0;
					for each(var field:String in fields) {
						for each (var value:String in record) {
							/**循环判断myDg列名域值record[field]与value是否相等**/
							if (field && record[field].toString() == value)
								/**写入表格中**/
								sheet.setCell(row, i, value);
						}
						i++;
					}
				} 
			}
		}
		
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}