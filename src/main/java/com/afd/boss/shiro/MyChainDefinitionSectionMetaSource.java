/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.afd.boss.shiro;

import java.text.MessageFormat;
import java.util.List;

import org.apache.shiro.config.Ini;
import org.apache.shiro.config.Ini.Section;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.FactoryBean;

import com.afd.staff.model.TResource;
import com.afd.staff.service.ResourceService;

/**
 * url过滤实现
 * 
 * @author xuzunyuan
 * @date 2013年12月25日
 */
public class MyChainDefinitionSectionMetaSource implements
		FactoryBean<Ini.Section> {

	private static final Logger logger = LoggerFactory
			.getLogger(MyChainDefinitionSectionMetaSource.class);
	private static final String PREMISSION_FORMAT = "{0}=authc,perms[{1}]";

	private String filterChainDefinitions;
	private ResourceService resourceService;

	public ResourceService getResourceService() {
		return resourceService;
	}

	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}

	public String getFilterChainDefinitions() {
		return filterChainDefinitions;
	}

	/**
	 * 在这里增加数据库中定义的URL拦截定义
	 * 
	 * @param filterChainDefinitions
	 */
	public void setFilterChainDefinitions(String filterChainDefinitions) {
		this.filterChainDefinitions = filterChainDefinitions;

		StringBuilder sb = new StringBuilder();
		List<TResource> resources = resourceService.getAllUrl();
		for (TResource resource : resources) {
			String[] urls = resource.getUrlPattern().split(",");

			for (String url : urls) {
				sb.append("\n")
						.append(MessageFormat
								.format(MyChainDefinitionSectionMetaSource.PREMISSION_FORMAT,
										url, resource.getPermCode()));
			}
		}

		this.filterChainDefinitions = this.filterChainDefinitions
				+ sb.toString();

		logger.info("filterChainDefinitions:" + this.filterChainDefinitions);
	}

	@Override
	public Section getObject() throws Exception {
		Ini ini = new Ini();
		ini.load(filterChainDefinitions);
		Ini.Section section = ini.getSection(Ini.DEFAULT_SECTION_NAME);
		return section;
	}

	@Override
	public Class<?> getObjectType() {
		return this.getClass();
	}

	@Override
	public boolean isSingleton() {
		return true;
	}

}
