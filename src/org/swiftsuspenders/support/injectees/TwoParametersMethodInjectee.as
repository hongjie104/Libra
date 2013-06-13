/*
* Copyright (c) 2009 the original author or authors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

package org.swiftsuspenders.support.injectees
{
	import flash.display.Sprite;
	
	import org.swiftsuspenders.support.types.Clazz;
	import org.swiftsuspenders.support.types.Interface;

	public class TwoParametersMethodInjectee
	{
		private var m_dependency : Clazz;
		private var m_dependency2 : Interface;
		
		[Inject(name="haha",name="haha2")]
		public function setDependencies(dependency:Clazz, dependency2:Interface):void
		{
			m_dependency = dependency;
			m_dependency2 = dependency2;
		}
		[Inject(name="dada")]
		public function testInject(haha:Sprite):void{
			//trace("{{{{{{{{{{{{{{{{{{{{{{{{{inject",haha)
		}
		public function getDependency() : Clazz
		{
			return m_dependency;
		}
		public function getDependency2() : Interface
		{
			return m_dependency2;
		}
		
		public function TwoParametersMethodInjectee()
		{
		}
		[PostConstruct(order="2")]
		public function post2():void{
			//trace("post2");
		}
		[PostConstruct(order="1")]
		public function post1():void{
			//trace("post1");
		}
	}
}