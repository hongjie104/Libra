/*
 * Copyright (c) 2010 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.swiftsuspenders.injectionresults
{
	import org.swiftsuspenders.InjectionConfig;
	import org.swiftsuspenders.Injector;

	//其他规则，复用其他InjectionConfig的返回策略，
	public class InjectOtherRuleResult extends InjectionResult
	{
		/*******************************************************************************************
		 *								private properties										   *
		 *******************************************************************************************/
		private var m_rule : InjectionConfig;//其他的注入配置
		
		
		/*******************************************************************************************
		 *								public methods											   *
		 *******************************************************************************************/
		public function InjectOtherRuleResult(rule : InjectionConfig)
		{
			m_rule = rule;//设置注入配置
		}
		
		override public function getResponse(injector : Injector) : Object
		{
			return m_rule.getResponse(injector);//调用其他的注入配置的返回策略
		}
	}
}