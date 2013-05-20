/*
 * Copyright (c) 2009-2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.swiftsuspenders
{
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.swiftsuspenders.injectionpoints.ConstructorInjectionPoint;
	import org.swiftsuspenders.injectionpoints.InjectionPoint;
	import org.swiftsuspenders.injectionpoints.MethodInjectionPoint;
	import org.swiftsuspenders.injectionpoints.NoParamsConstructorInjectionPoint;
	import org.swiftsuspenders.injectionpoints.PostConstructInjectionPoint;
	import org.swiftsuspenders.injectionpoints.PropertyInjectionPoint;
	import org.swiftsuspenders.injectionresults.InjectClassResult;
	import org.swiftsuspenders.injectionresults.InjectOtherRuleResult;
	import org.swiftsuspenders.injectionresults.InjectSingletonResult;
	import org.swiftsuspenders.injectionresults.InjectValueResult;
	
	/**
	 * Injector注入器,即IOCcontainer，相当于Spring里面的ApplicationContext
	 * 类似于工厂，通过注册类来获取实例，同时会添加实例的依赖
	 * 通过Injector获得的对象已经完成了依赖注入
	 */
	public class Injector
	{
		/*******************************************************************************************
		*								private properties										   *
		*******************************************************************************************/
		/**
		 * 注入点缓存
		 * 静态的缓存
		 * */
		private static var INJECTION_POINTS_CACHE : Dictionary = new Dictionary(true);
		
		
		/**
		 * 父注入器(Injector)对象
		 * */
		private var m_parentInjector : Injector;
		/**
		 * 注入器(Injector)对象的应用用程序域(ApplicationDomain)
		 * */
        private var m_applicationDomain:ApplicationDomain;
		
		/**
		 * [类的全名+#+注入名]与注入配置对象(InjectorConfig)的映射
		 * key是[类的全名+#+注入名]
		 * value是InjectionConfig对象
		 * 用来存储该注入器(Injector)所有的注入配置(InjectorConfig)
		 * */
		private var m_mappings : Dictionary;
		/**
		 * 注入描述对象字典,key为[class+name],value为InjectionConfig对象
		 * 
		 * */
		private var m_injecteeDescriptions : Dictionary;
		/**
		 * 已经注入过的对象映射字典
		 * 采用Dictionary的原因是Dictionary采用===来比较，是根据对象来比较而不是根据toString();
		 * 这样是将对象和对象的注入描述进行映射
		 * 
		 * */
		private var m_attendedToInjectees : Dictionary;
		/**
		 * 注入描述xml，在[Inject]元数据不支持时使用
		 * */
		private var m_xmlMetadata : XML;
		
		
		/*******************************************************************************************
		*								public methods											   *
		*******************************************************************************************/
		/**
		 * 构造函数
		 * @param xmlConfig - xml配置文件，可以通过外部xml来进行注入器(Injector)的注入的配置，弥补[Inject]无法使用情况,默认是null
		 * */
		public function Injector(xmlConfig : XML = null)
		{
			m_mappings = new Dictionary();//初始化m_mappings
			if (xmlConfig != null)//如果有配置文件
			{
				m_injecteeDescriptions = new Dictionary(true);//m_injecteeDescriptions注入描述字典对象新建为Injector对象的动态字典对象
			}
			else//如果没有配置文件
			{
				m_injecteeDescriptions = INJECTION_POINTS_CACHE;//m_injecteeDescriptions注入描述字典对象使用Injector的类的静态字典对象，这样多个注入器（Injector）共享同一个
			}
			m_attendedToInjectees = new Dictionary(true);//初始化m_attendedToInjectees对象
			m_xmlMetadata = xmlConfig;//初始化xml元数据对象
		}
		/**
		 * 将类映射到一个对象，这样在请求[class+name]的时候，就会返回指定的对象
		 * @param whenAskedFor - 请求的类
		 * @param useValue - 请求类时返回的对象
		 * @named named - 注入名，对类进一步区分，[whenAskedFor的全名+'#'+named]是映射的key
		 * 
		 * @return 返回一个结果策略为InjectValueResult的注入配置(InjectionConfig)对象
		 * 
		 * 
		 */
		public function mapValue(whenAskedFor : Class, useValue : Object, named : String = "") : *
		{
			var config : InjectionConfig = getMapping(whenAskedFor, named);//根据[class的全名+name]从m_mappings中获取一个注入配置(InjectionConfig)对象,
			//getMapping(whenAskedFor, named)方法会根据[class的全名+name]检测m_mappings中是否有相应的注入配置(InjectionConfig)对象
			//如果有直接从m_mappings返回
			//如果没有，则新建一个注入配置(InjectionConfig)对象，然后存储在m_mappings，然后返回
			config.setResult(new InjectValueResult(useValue));//设置获得的注入配置(InjectionConfig)对象注入结果(InjectionResult)策略，此处设置的是InjectValueResult策略。
			return config;//返回注入配置(InjectionConfig)对象
		}
		
		/**
		 * 将A类映射到B类，这样在请求A类+name的时候，就会返回指一个B类对象的实例
		 * @param whenAskedFor - 请求的类
		 * @param instaniateClass - 返回对象的类
		 * @named named - 注入名，对类进一步区分，[whenAskedFor的全名+'#'+named]是映射的key
		 * 
		 * @return 返回一个结果策略为InjectClassResult的注入配置(InjectionConfig)对象
		 */
		public function mapClass(
				whenAskedFor : Class, instantiateClass : Class, named : String = "") : *
		{
			var config : InjectionConfig = getMapping(whenAskedFor, named);//根据[class的全名+name]从m_mappings中获取一个注入配置(InjectionConfig)对象
			config.setResult(new InjectClassResult(instantiateClass));//设置获得的注入配置(InjectionConfig)对象注入结果(InjectionResult)策略，此处设置的是InjectClassResult策略。
			return config;//返回注入配置(InjectionConfig)对象
		}
		/**
		 * 设置A类到A类的单例映射，这样在通过[askforclass+name]请求对象时的时候，就会返回一个A类的单例对象
		 * @param whenAskedFor - 请求的类
		 * @named named - 注入名，对类进一步区分，[whenAskedFor的全名+'#'+named]是映射的key
		 * 
		 * @return 返回一个结果策略为InjectSingletonResult的注入配置(InjectionConfig)对象
		 */
		public function mapSingleton(whenAskedFor : Class, named : String = "") : *
		{
			return mapSingletonOf(whenAskedFor, whenAskedFor, named);//调用mapSingletonOf方法，mapSingletonOf可以设置A类到B类的单例映射
			//即请求[A类的全名+name]时，返回的是B类的单例对象
		}
		/**
		 * 设置A类到B类的单间映射，这样在通过[askforclass+name]请求对象时的时候，就会返回一个B类的单例对象
		 * @param whenAskedFor - 请求的类
		 * @param useSingletonOf - 返回对象的类
		 * @named named - 注入名，对类进一步区分，[whenAskedFor的全名+'#'+named]是映射的key
		 * 
		 * @return 返回一个结果策略为InjectSingletonResult的注入配置(InjectionConfig)对象
		 */
		public function mapSingletonOf(
			whenAskedFor : Class, useSingletonOf : Class, named : String = "") : *
		{
			var config : InjectionConfig = getMapping(whenAskedFor, named);//根据[class的全名+name]从m_mappings中获取一个注入配置(InjectionConfig)对象
			config.setResult(new InjectSingletonResult(useSingletonOf));//设置获得的注入配置(InjectionConfig)对象注入结果(InjectionResult)策略，此处设置的是InjectSingletonResult策略。
			return config;//返回注入配置(InjectionConfig)对象
		}
		/**
		 * 设置类到自定义规则的映射
		 * @param whenAskedFor - 请求的类
		 * @param useRule - 自定义的规则
		 * @named named - 注入名，对类进一步区分，[whenAskedFor的全名+'#'+named]是映射的key
		 * 
		 * @return 返回一个结果策略为InjectOtherRuleResult的注入配置(InjectionConfig)对象
		 * 在具体实现时会扩展InjectOtherRuleResult类
		 */
		public function mapRule(whenAskedFor : Class, useRule : *, named : String = "") : *
		{
			var config : InjectionConfig = getMapping(whenAskedFor, named);
			config.setResult(new InjectOtherRuleResult(useRule));
			return useRule;
		}
		/**
		 * 获得一个InjectionConfig注入配置对象
		 * */
		public function getMapping(whenAskedFor : Class, named : String = "") : InjectionConfig
		{
			var requestName : String = getQualifiedClassName(whenAskedFor);//获得wenAskedFor类的全名，即[包名::类名]
			//如trace(getQualifiedClassName(Sprite));
			//返回flash.display::Sprite
			var config : InjectionConfig = m_mappings[requestName + '#' + named];
			if (!config)
			{
				config = m_mappings[requestName + '#' + named] =
					new InjectionConfig(whenAskedFor, named);
			}
			return config;
			
		}
		
		/**
		 * 向目标注入
		 * @param - target 目标
		 * */
		public function injectInto(target : Object) : void
		{
			if (m_attendedToInjectees[target])//m_attendedToInjectee中是否有这个对象
			{
				return;//如果有则返回,说明已经注入过了
			}
			m_attendedToInjectees[target] = true;//如果没有，说明没有注入过，开始注入

			//get injection points or cache them if this target's class wasn't encountered before
			var targetClass : Class = getConstructor(target);//获取目标的类
			var injecteeDescription : InjecteeDescription =
					m_injecteeDescriptions[targetClass] || getInjectionPoints(targetClass);//获取目标类的InjecteeDescription对象，
			

			var injectionPoints : Array = injecteeDescription.injectionPoints;//获取注入点列表
			var length : int = injectionPoints.length;
			for (var i : int = 0; i < length; i++)//遍历注入点列表
			{
				var injectionPoint : InjectionPoint = injectionPoints[i];//针对每一个注入点
				injectionPoint.applyInjection(target, this);//向目标注入
			}

		}
		/**
		 * 实例化一个类，包括注入
		 * @param clazz，需要实例化的类
		 * */
		public function instantiate(clazz:Class):*
		{
			var injecteeDescription : InjecteeDescription = m_injecteeDescriptions[clazz];//查找要注入的类的注入描述
			if (!injecteeDescription)//如果没有
			{
				injecteeDescription = getInjectionPoints(clazz);//生成要注入类的注入描述
			}
			var injectionPoint : InjectionPoint = injecteeDescription.ctor;//获取要注入类的构造函数注入点
			var instance : * = injectionPoint.applyInjection(clazz, this);//应用构造函数注入点
			injectInto(instance);//对要注入类进行注入
			return instance;//返回注入的结果
		}
		/**
		 * 解除一个映射
		 * @param clazz，请求的类
		 * @param named：注入名
		 * */
		public function unmap(clazz : Class, named : String = "") : void
		{
			var mapping : InjectionConfig = getConfigurationForRequest(clazz, named);//根据请求查询相应的注入配置(InjectionConfig)
			if (!mapping)//如果没有找到
			{
				throw new InjectorError('Error while removing an injector mapping: ' +
					'No mapping defined for class ' + getQualifiedClassName(clazz) +
					', named "' + named + '"');//抛出异常
			}
			mapping.setResult(null);//如果找到，直接将该注入配置的返回策略(InjectionResult)设为null。个人认为应该还需要从mappings中删除
		}
		/**
		 * 根据请求查询是否有相应的注入配置
		 * @param clazz，请求的类
		 * @param named：注入名
		 * 
		 * @return 查询的结果
		 * */
		public function hasMapping(clazz : Class, named : String = '') : Boolean
		{
			var mapping : InjectionConfig = getConfigurationForRequest(clazz, named);////根据请求查询相应的注入配置(InjectionConfig)
			if (!mapping)//如果没有找到
			{
				return false;//返回false
			}
			return mapping.hasResponse(this);//如果找到，还需要检查这个注入配置是否有返回策略。
		}
		/**
		 * 从Ioc容器获得实例
		 * @param clazz，请求的类
		 * @param named：注入名
		 * 
		 * @return：返回请求的对象，该对象已经完成了依赖注入
		 * */
		public function getInstance(clazz : Class, named : String = '') : *
		{
			var mapping : InjectionConfig = getConfigurationForRequest(clazz, named);//获取InjectionConfig对象
			if (!mapping || !mapping.hasResponse(this))//如果没有映射或者映射没有设置返回策略
			{
				throw new InjectorError('Error while getting mapping response: ' +
					'No mapping defined for class ' + getQualifiedClassName(clazz) +
					', named "' + named + '"');//抛出异常
			}
			return mapping.getResponse(this);//根据注入配置的返回策略返回相应的值
		}
		
		/**
		 * 创建子入器
		 * @param applicationDomain
		 * @param named：注入名
		 * 
		 * @return：创建的子注入器		 
		 * * */
		public function createChildInjector(applicationDomain:ApplicationDomain=null) : Injector
		{
			var injector : Injector = new Injector();//新建一个注入器
            injector.setApplicationDomain(applicationDomain);//设置注入器的应用程序域
			injector.setParentInjector(this);//将子注入器的父注入器设为自身
			return injector;//返回新建的子注入器
		}
		/**
		 * 设置应用程序域
		 * @param applicationDomain
		 *  
		 * * */
        public function setApplicationDomain(applicationDomain:ApplicationDomain):void
        {
            m_applicationDomain = applicationDomain;//将m_applicationDomain赋值
        }
		/**
		 * 获得应用程序域
		 * @return 返回该注入器工作的应用程序域
		 *  
		 * * */
        public function getApplicationDomain():ApplicationDomain
        {
            return m_applicationDomain ? m_applicationDomain : ApplicationDomain.currentDomain;//如果m_applicationDomain不为null，返回m_applicationDomain
			//如果m_applicationDomain为null，返回当前的与
        }

		/**
		 * 设置父注入器
		 * @param parentInjector 父注入器	 
		 * * */
		public function setParentInjector(parentInjector : Injector) : void
		{
			//restore own map of worked injectees if parent injector is removed
			if (m_parentInjector && !parentInjector)//如果m_parentInjectoru不为空，即已经设置过父注入器了，且当前传入的父注入器也不为空，即需要替换父注入器
			{
				m_attendedToInjectees = new Dictionary(true);//清空已经住如果的对象的缓存
			}
			m_parentInjector = parentInjector;//将m_parentInjector赋值为新的父注入器
			//use parent's map of worked injectees
			if (parentInjector)//如果赋值的新注入器不为空
			{
				m_attendedToInjectees = parentInjector.attendedToInjectees;//将当前注入器的注入对象缓存设为父注入器的注入对象缓存。
			}
		}
		/**
		 * 获取父注入器
		 * @return parentInjector 父注入器	 
		 * * */
		public function getParentInjector() : Injector
		{
			return m_parentInjector;
		}
		/**
		 * 清除注入点缓存
		 * 将INJECTION_POINTS_CACHE重新赋值
		 * */
		public static function purgeInjectionPointsCache() : void
		{
			INJECTION_POINTS_CACHE = new Dictionary(true);//清空
		}
		
		
		/*******************************************************************************************
		*								internal methods										   *
		*******************************************************************************************/
		/**
		 * 根据请求，获取父注入器的有效注入配置
		 * @param whenAskedFor 请求的类
		 * @param named：注入名 
		 * 
		 * @return 查找到的注入配置
		 * * */
		internal function getAncestorMapping(
				whenAskedFor : Class, named : String = null) : InjectionConfig
		{
			var parent : Injector = m_parentInjector;//获得父注入器
			while (parent)//遍历所有的父注入器
			{
				var parentConfig : InjectionConfig =
					parent.getConfigurationForRequest(whenAskedFor, named, false);//从父注入器中查询相应的注入配置
				if (parentConfig && parentConfig.hasOwnResponse())//如果存在注入配置且该注入配置有返回策略
				{
					return parentConfig;//返回注入配置，查询解除
				}
				parent = parent.getParentInjector();//如果没找到，继续遍历上一个父注入器
			}
			return null;//如果都没有，返回null
		}
		/**
		 * 获得注入过的对象的缓存
		 * 
		 * @return 返回所有住如果的对象
		 * * */
		internal function get attendedToInjectees() : Dictionary
		{
			return m_attendedToInjectees;//返回 m_attendedToInjectees
		}

		
		/*******************************************************************************************
		*								private methods											   *
		*******************************************************************************************/
		
		/**
		 * 获取一个类的注入点
		 * @param clazz，需要获取注入点的类
		 * 返回一个InjecteeDescription对象来描述所有的注入点
		 * */
		private function getInjectionPoints(clazz : Class) : InjecteeDescription
		{
			var description : XML = describeType(clazz);//获取clazz的xml描述类型
			if (description.@name != 'Object' && description.factory.extendsClass.length() == 0)//如果name属性不是Object且description.factory.extendsClass的长度为0,即clazz是一个接口
			{
				throw new InjectorError('Interfaces can\'t be used as instantiatable classes.');//抛出异常，接口不能被注入
				/**
				 * 如果是一个接口，如IEventDispatcher
				 * 
					<type name="flash.events::IEventDispatcher" base="Class" isDynamic="true" isFinal="true" isStatic="true">
						<extendsClass type="Class"/>
						<extendsClass type="Object"/>
						<accessor name="prototype" access="readonly" type="*" declaredBy="Class"/>
						<factory type="flash.events::IEventDispatcher">
							<method name="willTrigger" declaredBy="flash.events::IEventDispatcher" returnType="Boolean" uri="flash.events:IEventDispatcher">
	 					    	<parameter index="1" type="String" optional="false"/>
							</method>
							<method name="dispatchEvent" declaredBy="flash.events::IEventDispatcher" returnType="Boolean" uri="flash.events:IEventDispatcher">
							  <parameter index="1" type="flash.events::Event" optional="false"/>
							</method>
	    					<method name="addEventListener" declaredBy="flash.events::IEventDispatcher" returnType="void" uri="flash.events:IEventDispatcher">
	      						<parameter index="1" type="String" optional="false"/>
	      						<parameter index="2" type="Function" optional="false"/>
	      						<parameter index="3" type="Boolean" optional="true"/>
	      						<parameter index="4" type="int" optional="true"/>
	      						<parameter index="5" type="Boolean" optional="true"/>
	    					</method>
	    					<method name="hasEventListener" declaredBy="flash.events::IEventDispatcher" returnType="Boolean" uri="flash.events:IEventDispatcher">
	      						<parameter index="1" type="String" optional="false"/>
	    					</method>
	    					<method name="removeEventListener" declaredBy="flash.events::IEventDispatcher" returnType="void" uri="flash.events:IEventDispatcher">
	      						<parameter index="1" type="String" optional="false"/>
	      						<parameter index="2" type="Function" optional="false"/>
	      						<parameter index="3" type="Boolean" optional="true"/>
	   					    </method>
						</factory>
					</type>
 				 * 以上为返回值factory.extendsClass为0
				 * 
				 * 如果是一个Object
				 * 
				 	<type name="Object" base="Class" isDynamic="true" isFinal="true" isStatic="true">
					  <extendsClass type="Class"/>
					  <extendsClass type="Object"/>
					  <constant name="length" type="int"/>
					  <accessor name="prototype" access="readonly" type="*" declaredBy="Class"/>
					  <factory type="Object"/>
					</type>
				 * factory.extendsClass为0且@name为Object
				 * 其他对象都不会
				 * 故这种方法可以判断是否为接口
				 * */
			}
			var injectionPoints : Array = [];//注入点列表
			var node : XML;//节点
			
			// This is where we have to wire in the XML...
			if(m_xmlMetadata)//如果有预先设置了，m_xmlMetadata
			{
				createInjectionPointsFromConfigXML(description);//调用createInjectionPointsFromConfigXML方法
				//传输这个类的description XML的目的在于需要清除所有的元数据标签，从而只从XML中进行配置
				addParentInjectionPoints(description, injectionPoints);//继续添加父类的注入点。因为元数据标签的消失，所以需要遍历所有的父类。
				//如果不使用m_xmlMetadata，元数据会自动被子类继承，则无需使用这一步
			}

			//get constructor injections
			var ctorInjectionPoint : InjectionPoint;//构造函数注入点
			node = description.factory.constructor[0];
			if (node)//如果有description.factory.constructor
			{
				ctorInjectionPoint = new ConstructorInjectionPoint(node, clazz, this);//新建一个有参数的构造函数注入点
			}
			else
			{
				ctorInjectionPoint = new NoParamsConstructorInjectionPoint();//构造函数注入点为NoParamsConstructorInjectionPoint对象，即无参数的构造函数注入点对象
			}
			var injectionPoint : InjectionPoint;//申明注入点
			//get injection points for variables
			for each (node in description.factory.*.
				(name() == 'variable' || name() == 'accessor').metadata.(@name == 'Inject'))//对于variable或者accessor结点中metadata的name是Inject的节点
			{
				injectionPoint = new PropertyInjectionPoint(node);//注入点为PropertyInjectionPoint对象，即属性注入点对象
				injectionPoints.push(injectionPoint);//在注入点队列中添加改注入点
			}
		
			//get injection points for methods
			
			for each (node in description.factory.method.metadata.(@name == 'Inject'))//遍历所有的Method节点中name为Inject的
			{
				
				injectionPoint = new MethodInjectionPoint(node, this);//注入点为MethodInjectionPoint对象，即方法注入点
				injectionPoints.push(injectionPoint);//在注入点队列中添加该注入点
			}
			
			//get post construct methods
			var postConstructMethodPoints : Array = [];//post Construct 方法注入点
			for each (node in description.factory.method.metadata.(@name == 'PostConstruct'))//遍历所有PostConstruct的方法
			{
				injectionPoint = new PostConstructInjectionPoint(node, this);//以node新建一个PostConstructInjectionPoint对象
				postConstructMethodPoints.push(injectionPoint);//将PostConstructInjectionPoint对象加入到postConstructMethodPoints postConstruct方法注入点列表中。
			}
			if (postConstructMethodPoints.length > 0)//如果有PostConstructInjectionPoint注册点
			{
				postConstructMethodPoints.sortOn("order", Array.NUMERIC);//根据order属性采用数值进排序
				injectionPoints.push.apply(injectionPoints, postConstructMethodPoints);//将排序后的postConstructMethodPoinst添加到注入点中
				
				/**
				 * 上面这种写法是将postConstructMethodPoints中的每一个值push到injectionPoints中,此时injectionPoints的长度是增加postConstructMethodPoints.length
				 * 如果直接injectionPoints.push(postConstructMethodPoints)就是将整个postConstructMethodPoints push进去,此时injectionPoints的长度是增加1
				 * */
				
			}

			var injecteeDescription : InjecteeDescription =
					new InjecteeDescription(ctorInjectionPoint, injectionPoints);//生成该类注入点描述对象
			m_injecteeDescriptions[clazz] = injecteeDescription;//在m_injecteeDescriptions中将该类和其注入点描述对象进行映射
			return injecteeDescription;//返回注入点描述文件
		}

		/**
		 * 根据请求获得相应的注入配置
		 * 
		 * @param clazz 请求的类
		 * @param named 注入名
		 * @param traverseAncestors 是否遍历父注入器
		 * 
		 * @return 返回找到的注入配置
		 * */
		
		private function getConfigurationForRequest(
			clazz : Class, named : String, traverseAncestors : Boolean = true) : InjectionConfig
		{
			var requestName : String = getQualifiedClassName(clazz);//获取类名
			var config:InjectionConfig = m_mappings[requestName + '#' + named];//获取映射
			
			if(!config && traverseAncestors &&
				m_parentInjector && m_parentInjector.hasMapping(clazz, named))//如果没有映射
			{
				config = getAncestorMapping(clazz, named);//从辅助器中进行遍历
			}
			return config;//返回映射
		}
		/**
		 * 从配置的XML中获取注入点
		 * 先擦出所有的元数据信息，然后再根据xml写入相应的元数据
		 * @param description 类的描述信息
		 * */
		private function createInjectionPointsFromConfigXML(description : XML) : void
		{
			var node : XML;
			//first, clear out all "Inject" metadata, we want a clean slate to have the result 
			//work the same in the Flash IDE and MXMLC
			for each (node in description..metadata.(@name=='Inject' || @name=='PostConstruct'))//遍历类的描述XML中所有的name为Inject和PostConstruct的节点
			{
				delete node.parent().metadata.(@name=='Inject' || @name=='PostConstruct')[0];//清空这些节点，应为现在要根据xml来配置注入点，所以要消除元数据注入点的干扰
			}
			
			//now, we create the new injection points based on the given xml file
			var className:String = description.factory.@type;//获取类名
			for each (node in m_xmlMetadata.type.(@name == className).children())//遍历配置XML中有关这个类的节点的所有子节点
			{
				var metaNode : XML = <metadata/>;//新建一个metadata节点
				if (node.name() == 'postconstruct')//如果name是postconstruct
				{
					metaNode.@name = 'PostConstruct';//新建节点的name设为PostConstruct
					if (node.@order.length())
					{
						metaNode.appendChild(<arg key='order' value={node.@order}/>);//添加postConstruct的数据
					}
				}
				else//如果不是postconstrut
				{
					metaNode.@name = 'Inject';//新建节点的name设为Inject
					if (node.@injectionname.length())//如果有注入名
					{
						metaNode.appendChild(<arg key='name' value={node.@injectionname}/>);//添加注入名
					}
					for each (var arg : XML in node.arg)
					{
						metaNode.appendChild(<arg key='name' value={arg.@injectionname}/>);//添加Inject数据
					}
				}
				var typeNode : XML;
				if (node.name() == 'constructor')//如果name为constuctor
				{
					typeNode = description.factory[0];//将整个节点赋值给typeNode
				}
				else//如果不是
				{
					typeNode = description.factory.*.(attribute('name') == node.@name)[0];//将同名的节点赋值给typeNode
					if (!typeNode)//如果也没有
					{
						throw new InjectorError('Error in XML configuration: Class "' + className +
							'" doesn\'t contain the instance member "' + node.@name + '"');//抛出异常
					}
				}
				typeNode.appendChild(metaNode);//添加元数据节点
			}
		}
		/**
		 * 添加父类的注入点
		 * 
		 * */
		private function addParentInjectionPoints(description : XML, injectionPoints : Array) : void
		{
			var parentClassName : String = description.factory.extendsClass.@type[0];//获取父类的类名
			if (!parentClassName)//如果没有则返回
			{
				return;
			}
			//如果有付烈
			var parentClass : Class = Class(getDefinitionByName(parentClassName));//通过反射获得父类
			var parentDescription : InjecteeDescription =
					m_injecteeDescriptions[parentClass] || getInjectionPoints(parentClass);//获得父类的注入点
			var parentInjectionPoints : Array = parentDescription.injectionPoints;

			injectionPoints.push.apply(injectionPoints, parentInjectionPoints);//点加到子类的注入点中。
		}
	}
}

import org.swiftsuspenders.injectionpoints.InjectionPoint;

/**
 * 注入员描述类
 * */
final class InjecteeDescription
{
	/**
	 * 构造函数注入点
	 * */
	public var ctor : InjectionPoint;
	/**
	 * 属性或方法注入点
	 * */
	public var injectionPoints : Array;

	public function InjecteeDescription(ctor : InjectionPoint, injectionPoints : Array)
	{
		this.ctor = ctor;//构造函数注入点
		this.injectionPoints = injectionPoints;//剩余的属性和方法注入点
	}
}