package org.libra.flex.utils {
	import com.as3xls.xls.ExcelFile;
	import com.as3xls.xls.Sheet;
	
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	
	import mx.collections.ArrayCollection;
	
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
		
		public static function save(objAry:Array):void{
			//先获取列名
			var fieldList:Vector.<Field> = createFieldList(objAry[0]);
			
			/**生成表对象sheet**/
			var sheet:Sheet = new Sheet();
			/**获得表格的行数**/
			var rowCount:int = objAry.length;
			var colCount:int = fieldList.length;
			/**设置表格的行数(rowCount+1)，列数（myDg.columnCount）**/
			sheet.resize(rowCount + 1, colCount);
			/**循环设置列名的值**/
			for(var i:int = 0; i < colCount;i++){
				sheet.setCell(0, i, fieldList[i].name);
			}
			/**循环设置行的值**/
			for(i = 0; i < rowCount; i++) {
				for(var j:int = 0; j < colCount; j++){
					sheet.setCell(i + 1, j, objAry[i][fieldList[j].name]);	
				}
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
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private static function createFieldList(obj:*):Vector.<Field>{
			var fieldList:Vector.<Field> = new Vector.<Field>();
			var xml:XML = describeType(obj);
			//获取到对象getter的xmlList
			var accessorList:XMLList = xml.accessor;
			var accessorXML:XML;
			const l:int = accessorList.length();
			var name:String;
			var metadataXMlList:XMLList;
			var metadataXMlLength:int = 0;
			for(var i:int = 0;i < l;i++){
				accessorXML = accessorList[i];
				name = accessorXML.@name;
				metadataXMlList = accessorXML.metadata;
				metadataXMlLength = metadataXMlList.length();
				for(var j:int = 0; j < metadataXMlLength;j++){
					//该标签是要写入到xls中的
					if(metadataXMlList[j].@name.toString() == "XLSCol"){
						var field:Field = new Field();
						field.name = name;
						var args:XMLList = metadataXMlList[j].arg;
						for each(var arg:XML in args){
							if(arg.@key.toString() == "index"){
								field.index = int(arg.@value);
								break;
							}
						}
						fieldList.push(field);
						break;
					}
				}
			}
			fieldList.sort(function(a:Field, b:Field):int{return a.index - b.index;});
			return fieldList;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}

final class Field{
	
	public var name:String = '';
	
	public var index:int = 0;
	
	public function toString():String{
		return name + ':' + index;
	}
	
}