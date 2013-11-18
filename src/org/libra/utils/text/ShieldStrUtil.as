package org.libra.utils.text {
	import flash.utils.Dictionary;
	/**
	 * <p>
	 * 关键字过滤类
	 * </p>
	 *
	 * @class ShieldStr
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-16-2012
	 * @version 1.0
	 * @see
	 */
	public final class ShieldStrUtil {
		
		//目录
		private var indexDic:Dictionary;
		
		//二级内容
		private var contentDic:Dictionary;
		
		//替换源目标
		private var source:String = "*********************************";
		
		private static var _instance:ShieldStrUtil;
		
		public function ShieldStrUtil(singleton:Singleton) { 
			indexDic = new Dictionary();
			contentDic = new Dictionary();
			this.unCompress('妈的,2b,二逼');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		/**
		 * 解释文本txt中的串, 做单向链表
		 * indexDic是链表的根, 当作敏感字的第一层目录遍历
		 * 每项都存子项所代表汉字的数字值
		 * contentDic为第二部分, 链表的子项都在这里存
		 * 从链表的根开始找
		 * @param str 例如: 妈的,2b,二逼,傻逼,靠,2逼,妓女,鸭子,毛泽东,天安门事件,操你,处女,鸡,吾尔凯西,柴玲
		 *
		 */
		public function unCompress(str:String):void {
			var arr:Array = str.split(",");
			var code:Number;
			var pNode:SNode, node:SNode;
			while (arr.length) {
				str = arr.shift();
				pNode = null;
				for (var i:int = 0; i < str.length; i++) {
					code = str.charCodeAt(i);
					if (!i) { //第一个字
						if (indexDic[code]) {
							node = indexDic[code];
						} else {
							node = new SNode(code);
							indexDic[code] = node;
						}
					} else { //others
						if (contentDic[code] == undefined) {
							node = new SNode(code);
							contentDic[code] = node;
						} else {
							node = contentDic[code];
						}
						pNode.addChild(code);
					}
					pNode = node;
					if (i == str.length - 1)
						node.canEnd = true;
				}
			}
		}
		
		/**
		 * 屏蔽敏感字
		 * @param	string 输入的内容
		 * @return 屏蔽后的内容
		 */
		public function checkStr(string:String):String {
			var code:Number;
			var position:int = 0, length:int = 0;
			var node:SNode, pNode:SNode;
			var findHead:Boolean = false;
			for (var i:int; i < string.length; i++) {
				code = string.charCodeAt(i);
				if (code == 32)
					continue; //是否替换隔开敏感字的空格
				if (findHead) {
					node = checkNode(pNode, code);
					if (node) {
						if (node.canEnd)
							length = i - position + 1;
						pNode = node;
					} else {
						if (length) { //找到一个词
							string = replace(string, position, length);
						}
						i -= 1;
						findHead = false;
						length = 0;
						pNode = null;
					}
				} else {
					node = indexDic[code];
					if (node) {
						findHead = true;
						position = i;
						if (node.canEnd)
							++length;
						pNode = node;
					} else {
						continue;
					}
				}
			}
			if (length) { //处理尾部
				string = replace(string, position, length);
			}
			return string;
		}
		
		public static function get instance():ShieldStrUtil {
			return _instance ||= new ShieldStrUtil(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		private function checkNode(node:SNode, childCode:Number):SNode {
			if (node.childDic[childCode] != undefined) {
				return contentDic[childCode];
			} else {
				return null;
			}
		}
		
		private function replace(string:String, position:int, length:int):String {
			var str:String = '';
			str = str.concat(string.substr(0, position));
			str = str.concat(source.substr(0, length));
			str = str.concat(string.substr(position + length, string.length));
			return str;
		}
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
import flash.utils.Dictionary;
class SNode {
	
	//是否是敏感词组的结尾
	internal var canEnd:Boolean;
	
	internal var childDic:Dictionary;
	
	private var _code:Number;
	
	public function SNode(code:Number) {
		_code = code;
		childDic = new Dictionary();
	}
	
	/*-----------------------------------------------------------------------------------------
	Public methods
	-------------------------------------------------------------------------------------------*/
	
	public function get code():Number{
		return _code;
	}
	
	public function addChild(childCode:Number):void{
		childDic[childCode] = childCode;
	}
	
	/*-----------------------------------------------------------------------------------------
	Private methods
	-------------------------------------------------------------------------------------------*/
	
	/*-----------------------------------------------------------------------------------------
	Event Handlers
	-------------------------------------------------------------------------------------------*/
}
class Singleton{}