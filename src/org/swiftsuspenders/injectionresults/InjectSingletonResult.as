/*
* Copyright (c) 2009 the original author or authors
* 
* Permission is hereby granted to use, modify, and distribute this file 
* in accordance with the terms of the license agreement accompanying it.
*/

package org.swiftsuspenders.injectionresults
{
	import org.swiftsuspenders.Injector;

	public class InjectSingletonResult extends InjectionResult
	{
		/*******************************************************************************************
		 *								private properties										   *
		 *******************************************************************************************/
		private var m_responseType : Class;//需要实例化的类
		private var m_response : Object;//单例的引用
		
		
		/*******************************************************************************************
		 *								public methods											   *
		 *******************************************************************************************/
		public function InjectSingletonResult(responseType : Class)
		{
			m_responseType = responseType;//赋值
		}
		
		override public function getResponse(injector : Injector) : Object
		{
			return m_response ||= createResponse(injector);//通过此种方式实现单例模式，第一次会调用instantiate方法生成一个实例，
			//并对m_response进行赋值，以后值接返回m_response
		}
		
		
		/*******************************************************************************************
		 *								private methods											   *
		 *******************************************************************************************/
		private function createResponse(injector : Injector) : Object
		{
			return injector.instantiate(m_responseType);//创建一个实例，通过调用注入器获得需要返回的对象，这样保证返回的对象是已经完成注入过的对象。
		}
	}
}