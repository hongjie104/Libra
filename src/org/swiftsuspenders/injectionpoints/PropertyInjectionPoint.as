/*
 * Copyright (c) 2009 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.swiftsuspenders.injectionpoints
{
	import org.swiftsuspenders.InjectionConfig;
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.InjectorError;

	/**
	 * 属性注入点
	 * */
	public class PropertyInjectionPoint extends InjectionPoint
	{
		/*******************************************************************************************
		*								private properties										   *
		*******************************************************************************************/
		
		private var _propertyName : String;//注入点名称
		private var _propertyType : String;//注入点的类型
		private var _injectionName : String;//注入名
		private var _namespace:Namespace = public;
		
		/*******************************************************************************************
		*								public methods											   *
		*******************************************************************************************/
		/**
		 * 构造函数
		 * */
		public function PropertyInjectionPoint(node : XML, injector : Injector = null)
		{
			super(node, null);//会调用initializeInjection（node）方法
		}
		/**
		 * 属性注入点应用注入函数
		 * @param target - 被注入的对此昂
		 * @param injector - injector对象，注入容器
		 * @return 返回被注入的对象
		 * */
		override public function applyInjection(target : Object, injector : Injector) : Object
		{
			var injectionConfig : InjectionConfig = injector.getMapping(Class(
					injector.getApplicationDomain().getDefinition(_propertyType)), _injectionName);//从injector中获取映射的InjectionConfig对象
			var injection : Object = injectionConfig.getResponse(injector);//从InjectionConfig对象中获取实例
//			
			if (injection == null)//如果injection为空
			{
				throw(new InjectorError(
						'Injector is missing a rule to handle injection into property "' +
						_propertyName + '" of object "' + target +
						'". Target dependency: "' + _propertyType + '", named "' + _injectionName +
						'"'));//抛出异常
			}
			
			target._namespace::[_propertyName] = injection;//具体注入，将target._propertyName赋值为injection
			return target;//返回target实际上target已经改变
		}


		/*******************************************************************************************
		*								protected methods										   *
		*******************************************************************************************/
		/**
		 * 通过xml初始化注入,初始化属性注入点
		 *  @param node - 是metadata name为 Inject的节点
		 * */
		override protected function initializeInjection(node : XML) : void
		{
			/**
			* _propertyType:属性类型
			* _propertyName:属性名称
			* _injectionName:注入名
			* 如：
			* [Inject(name='haha')]public var a:A;
			* A就是属性类型
			* a就是属性名称
			* haha就是注入名，就是在mapClass后面的最后一个参数
			* 改node的的值是<metadata name="Inject"/>
			* 其parent就包含了整个属性的类型描述
			* 如：
			<variable name="property" type="org.swiftsuspenders.support.types::Clazz">
			  <metadata name="Inject">
			    <arg key="name" value="haha"/>
			  </metadata>
			  <metadata name="__go_to_definition_help">
			    <arg key="pos" value="1312"/>
			  </metadata>
			</variable>
			* */
			var _parent:XML = node.parent();
			if("@uri" in _parent)	_namespace = new Namespace(_parent.@uri);
			_propertyType = _parent.@type.toString();//设置注入点的类型
			_propertyName = _parent.@name.toString();//设置注入点名称
			_injectionName = node.arg.attribute('value').toString();//设置注入名
		}
	}
}
