/*
* Copyright (c) 2009 the original author or authors
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package org.swiftsuspenders
{
	import flash.utils.getQualifiedClassName;

	import org.swiftsuspenders.injectionresults.InjectionResult;

	public class InjectionConfig
	{
		/*******************************************************************************************
		 *								public properties										   *
		 *******************************************************************************************/
		public var request : Class;//请求的类
		public var injectionName : String;//注入名


		/*******************************************************************************************
		 *								private properties										   *
		 *******************************************************************************************/
		private var m_injector : Injector;//工作的注入器，如果设置了，在getResonse时优先在该注入器上工作。如果没有，则使用传入的注入器
		private var m_result : InjectionResult;//返回对象策略


		/*******************************************************************************************
		 *								public methods											   *
		 *******************************************************************************************/
		public function InjectionConfig(request : Class, injectionName : String)
		{
			this.request = request;
			this.injectionName = injectionName;
		}

		/**
		 * InjectionConfig对象获取反馈对象方法
		 * @param injector - 注入容器
		 * */
		public function getResponse(injector : Injector) : Object
		{	
			if (m_result)//如果有m_result
			{
				return m_result.getResponse(m_injector || injector);//如果有m_injector，以m_injecotor返回，不然以injector返回
			}
			//如果没有m_result，即没有设置策略
			var parentConfig : InjectionConfig =
				(m_injector || injector).getAncestorMapping(request, injectionName);//从m_injector或者injector中得到有效祖先的映射
			if (parentConfig)//如果有祖先映射
			{
				return parentConfig.getResponse(injector);//从祖先映射中获取对象并返回
			}
			
			return null;//如果啥都没有，返回null
		}
		
		/**
		 * 检查是否有可以返回结果
		 * @param injector - 注入容器
		 * @return 返回是否可以返回结果
		 * */
		public function hasResponse(injector : Injector) : Boolean
		{
			if (m_result)//如果有m_result
			{
				return true;//可以
			}
			var parentConfig : InjectionConfig =
				(m_injector || injector).getAncestorMapping(request, injectionName);//从m_injector或者injector的父注入器中查找有效注入配置
			return parentConfig != null;//如果有则会调用父注入器的有效注入配置
		}
		/**
		 * 检查是否有可以仅凭自身返回结果，不需要查找父注入器
		 * @return 返回是否可以仅凭自身就返回结果
		 * */
		public function hasOwnResponse() : Boolean
		{
			return m_result != null;//返回是否有m_result
		}
		/**
		 * 设置返回策略
		 * @param result - 返回的策略
		 * */
		public function setResult(result : InjectionResult) : void
		{
			if (m_result != null && result != null)//如果m_result不为空且当且设置的不为空，即要替换
			{
				trace('Warning: Injector already has a rule for type "' +
						getQualifiedClassName(request) + '", named "' + injectionName + '".\n ' +
						'If you have overwritten this mapping intentionally you can use ' +
						'"injector.unmap()" prior to your replacement mapping in order to ' +
						'avoid seeing this message.');//抛出警告，建议先调用unmap方法解除映射，然后再进行映射
			}
			m_result = result;//无论如何都会设置m_result
			
		}

		/**
		 * 设置工作的注入器环境
		 * @param injector - 设置的注入器
		 * */
		public function setInjector(injector : Injector) : void
		{
			m_injector = injector;//对m_injector赋值
		}
	}
}