package org.libra.lua
{
	import org.libra.utils.text.StringUtil;

	public final class LuaUtil
	{
		public function LuaUtil()
		{
		}
		
		public static function toAS3Object(tableStr:String):Object{
			tableStr = StringUtil.replace(tableStr,' ','');
			tableStr = StringUtil.replace(tableStr,'=',':');
			
			var strAry:Array = tableStr.split("");
			const l:int = tableStr.length;
			var counter:int = 0;
			for(var i:int = 0;i < l;i+=1){
				switch(tableStr.charAt(i)){
					case '{':
						if(tableStr.charAt(i + 1) != '{'){
							strAry.splice(1 + i + counter++, 0, '"');
						}
						break;
					case ":":
						strAry.splice(i + counter++, 0, '"');
						if(tableStr.charAt(i + 1) != '{'){
							strAry.splice(i + counter++ + 1, 0, '"');
						}
						break;
					case "}":
						if(tableStr.charAt(i - 1) != '}'){
							strAry.splice(i + counter++, 0, '"');	
						}
						break;
					case ",":
						if(tableStr.charAt(i - 1) != '}'){
							strAry.splice(i + counter++, 0, '"');	
						}
						if(tableStr.charAt(i + 1) != '{'){
							strAry.splice(i + counter++ + 1, 0, '"');
						}
						break;
				}
			}
			var s:String = strAry.join("");
			var key:int = 0;
			while(s.indexOf("{{") > -1){
				s = s.replace("{{",'{"' + key + '":{');
				key += 1;
			}
			while(s.indexOf("},{") > -1){
				s = s.replace("},{",'},"' + key + '":{');
				key += 1;
			}
			return JSON.parse(s);
		}
	}
}