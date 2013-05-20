/*
* Copyright (c) 2009 the original author or authors
* 
* Permission is hereby granted to use, modify, and distribute this file 
* in accordance with the terms of the license agreement accompanying it.
*/

package org.swiftsuspenders.injectionresults
{
	import org.swiftsuspenders.Injector;

	
	public class InjectClassResult extends InjectionResult
	{
		/*******************************************************************************************
		 *								private properties										   *
		 *******************************************************************************************/
		private var m_responseType : Class;//需要实例化的类
		
		
		/*******************************************************************************************
		 *								public methods											   *
		 *******************************************************************************************/
		public function InjectClassResult(responseType : Class)
		{
			m_responseType = responseType;//赋值
		}
		
		override public function getResponse(injector : Injector) : Object
		{
			return injector.instantiate(m_responseType);//通过注入器进行实例化，这样保证得到的实例是已经经过依赖注入的
		}
	}
}