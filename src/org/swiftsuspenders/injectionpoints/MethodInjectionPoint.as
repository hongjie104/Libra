/*
 * Copyright (c) 2009 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.swiftsuspenders.injectionpoints
{
	import flash.utils.getQualifiedClassName;

	import org.swiftsuspenders.InjectionConfig;
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.InjectorError;

	/**
	 * 方法注入点
	 * */
	public class MethodInjectionPoint extends InjectionPoint
	{
		/*******************************************************************************************
		*								private properties										   *
		*******************************************************************************************/
		/**
		 * 方法名
		 * */
		protected var methodName : String;
		/**
		 * 
		 * */
		protected var _parameterInjectionConfigs : Array;//该函数注入点参数注入配置
		protected var requiredParameters : int = 0;//如要的参数数
		
		
		/*******************************************************************************************
		*								public methods											   *
		*******************************************************************************************/
		public function MethodInjectionPoint(node : XML, injector : Injector = null)
		{
			super(node, injector);
		}
		/**
		 * 属性注入点应用注入函数
		 * @param target - 被注入的对此昂
		 * @param injector - injector对象，注入容器
		 * @return 返回被注入的对象
		 * */
		override public function applyInjection(target : Object, injector : Injector) : Object
		{
			var parameters : Array = gatherParameterValues(target, injector);//获取参数的值
			var method : Function = target[methodName];//获取需要注入的函数
			method.apply(target, parameters);//按照参数来调用函数
			return target;//返回目标，此时已经调用输入函数
		}


		/*******************************************************************************************
		*								protected methods										   *
		*******************************************************************************************/
		/**
		 * 通过xml初始化注入,初始化方法注入点
		 * @param node - 是metadata name为 Inject的节点
		 * */
		override protected function initializeInjection(node : XML) : void
		{
			var nameArgs : XMLList = node.arg.(@key == 'name');//获取参数名
			var methodNode : XML = node.parent();//获取父节点
			methodName = methodNode.@name.toString();//获取注入方法方法名
			gatherParameters(methodNode, nameArgs);//获取参数
		}
		/**
		 * 获取参数，实际是向_parameterInjectionConfigs赋值，包涵了该函数注入点的参数名
		 * @param node
		 * 如一个方法注入的xml描述如下
		 * <method name="setDependencies" declaredBy="org.swiftsuspenders.support.injectees::TwoParametersMethodInjectee" returnType="void">
			  <parameter index="1" type="org.swiftsuspenders.support.types::Clazz" optional="false"/>
			  <parameter index="2" type="org.swiftsuspenders.support.types::Interface" optional="false"/>
			  <metadata name="Inject">
			    <arg key="name" value="haha"/>
			  </metadata>
			  <metadata name="__go_to_definition_help">
			    <arg key="pos" value="1467"/>
			  </metadata>
			</method>
		 * 有两个参数，切optional都是false
		 * 一个类型是clazz，还有一个是Intrface,
		 * Inject的参数中name参数就是每个注入参数分别的注入名
		 * 如
		 * [Inject(name="haha",name="haha2")]
			public function setDependencies(dependency:Clazz, dependency2:Interface):void
			{
				m_dependency = dependency;
				m_dependency2 = dependency2;
			}
		 * 则此时dependency的注入名为haha，dependency2的注入名为haha2
		 * injector的映射此时就要有注入名的隐射，如：
		    var inj:Injector = new Injector();
		    inj.mapSingleton(Clazz,"haha");
			inj.mapClass(Interface,Clazz2,"haha2");
			inj.injectInto(injectee);
		 * */
		protected function gatherParameters(methodNode : XML, nameArgs : XMLList) : void
		{
			_parameterInjectionConfigs = [];//清空参数
			var i : int = 0;
			for each (var parameter : XML in methodNode.parameter)//便利parameter节点
			{
				var injectionName : String = '';//初始化注入名
				if (nameArgs[i])//如果nameArgs第i位有
				{
					injectionName = nameArgs[i].@value.toString();//注入名就是nameArgs[i]的value属性
					
				}
				var parameterTypeName : String = parameter.@type.toString();//参数类型名是param的type属性
				if (parameterTypeName == '*')//如果类型是*
				{
					if (parameter.@optional.toString() == 'false')//如果optional属性时false
					{
						//TODO: Find a way to trace name of affected class here
						throw new InjectorError('Error in method definition of injectee. ' +
							'Required parameters can\'t have type "*".')//抛出异常，取药的参数不能是*类型
					}
					else//如果optional是true
					{
						parameterTypeName = null;//类型的名称为null
					}
				}
				_parameterInjectionConfigs.push(
						new ParameterInjectionConfig(parameterTypeName, injectionName));//向参数注入配置中添加一个配置对象
				if (parameter.@optional.toString() == 'false')//如果optional属性时false
				{
					requiredParameters++;//需要的参数+1
				}
				i++;
			}
			
		}
		/**
		 * 获取参数的值
		 * @param target - 注入目标
		 * @param injector - Ioc容器
		 * 
		 * */
		protected function gatherParameterValues(target : Object, injector : Injector) : Array
		{
			var parameters : Array = [];//申明返回值
			var length : int = _parameterInjectionConfigs.length;//长度，就是参数诸如配置的长度
			for (var i : int = 0; i < length; i++)//遍历_parameterInjectionConfigs
			{
				var parameterConfig : ParameterInjectionConfig = _parameterInjectionConfigs[i];//获取第I个参数注入配置
				var config : InjectionConfig = injector.getMapping(Class(
						injector.getApplicationDomain().getDefinition(parameterConfig.typeName)),
						parameterConfig.injectionName);//从injector获得相应的注入配置，通过类和注入名来获取
				var injection : Object = config.getResponse(injector);//获得对象/
				//个人觉得直接用injector.getInstance()就可以了
				if (injection == null)//如果是空
				{
					if (i >= requiredParameters)//如果已经超出了需要的参数个数，即有可选参数
					{
						break;//直接跳出
					}//否则抛出异常
					throw(new InjectorError(
						'Injector is missing a rule to handle injection into target ' + target + 
						'. Target dependency: ' + getQualifiedClassName(config.request) + 
						', method: ' + methodName + ', parameter: ' + (i + 1)
					));
				}
				
				parameters[i] = injection;//将值加入返回的参数列表
			}
			return parameters;//返回参数的值
		}
	}
}

/**
 * 参数注入配置，包涵注入参数的类型和注入名，这样就可以从injector中getInstance(Class,name)获得需要注入的对象
 * */
final class ParameterInjectionConfig
{
	public var typeName : String;//类型名
	public var injectionName : String;//注入名

	public final function ParameterInjectionConfig(typeName : String, injectionName : String)
	{
		this.typeName = typeName;
		this.injectionName = injectionName;
	}
}