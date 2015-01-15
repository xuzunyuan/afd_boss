/**
 * Copyright (c)2013-2014 by www.afd.com. All rights reserved.
 * 
 */
package com.afd.staff.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.afd.boss.util.StaticCacheHolder;
import com.afd.staff.constants.TResource$Type;
import com.afd.staff.dao.TResourceMapper;
import com.afd.staff.model.TResource;
import com.afd.staff.model.TResourceExample;
import com.afd.staff.model.extend.TResourceExtend;
import com.afd.staff.service.ResourceService;

/**
 * 资源服务
 * 
 * @author xuzunyuan
 * @date 2013年12月25日
 */
@Service("resourceService")
public class ResourceServiceImpl implements ResourceService {
	@Autowired
	private TResourceMapper resourceMapper;

	@Override
	public List<TResource> getAllUrl() {
		TResourceExample example = new TResourceExample();

		example.createCriteria().andStatusEqualTo(true)
				.andTypeEqualTo(TResource$Type.URL);

		return resourceMapper.selectByExample(example);
	}

	@Override
	public List<TResource> getAllFolder() {
		// 首先从缓存中读取，取不到则读取数据库
		List<TResource> resources = null;

		resources = StaticCacheHolder.getInstance().getCache(
				StaticCacheHolder.KEY_ALL_FOLDER);
		if (resources != null)
			return resources;

		TResourceExample example = new TResourceExample();

		example.createCriteria().andStatusEqualTo(true)
				.andTypeEqualTo(TResource$Type.FOLDER);

		resources = resourceMapper.selectByExample(example);
		if (resources != null)
			StaticCacheHolder.getInstance().setCache(
					StaticCacheHolder.KEY_ALL_FOLDER, resources);

		return resources;
	}

	@Override
	public List<TResource> getAllResource() {
		// 首先从缓存中读取，取不到则读取数据库
		List<TResource> resources = null;

		resources = StaticCacheHolder.getInstance().getCache(
				StaticCacheHolder.KEY_ALL_RESOURCE);
		if (resources != null)
			return resources;

		TResourceExample example = new TResourceExample();

		example.createCriteria().andStatusEqualTo(true);

		resources = resourceMapper.selectByExample(example);
		if (resources != null)
			StaticCacheHolder.getInstance().setCache(
					StaticCacheHolder.KEY_ALL_RESOURCE, resources);

		return resources;
	}

	public static void main(String[] args) {
		ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(
				"classpath*:applicationContext*.xml");
		System.out.println("aaaa");
		context.start();

		ResourceService service = context.getBean(ResourceService.class);
		List<TResource> resource = service.getAllFolder();
		System.out.println("resource size :" + resource.size());
		context.stop();
		context.close();
	}

	@Override
	public List<TResourceExtend> getAllHierarchicResources() {
		// 首先从缓存中读取，取不到则读取数据库
		List<TResourceExtend> resources = null;

		resources = StaticCacheHolder.getInstance().getCache(
				StaticCacheHolder.KEY_ALL_HIERARCHIC_RESOURCE);

		if (resources == null) {
			resources = Lists.newArrayList();
			List<TResource> folders = this.getAllFolder();
			List<TResource> urls = this.getAllUrl();

			for (TResource folder : folders) {
				TResourceExtend resourceExtend = new TResourceExtend(folder);

				for (TResource url : urls) {
					if (folder.getResourceId().equals(url.getParentId()))
						resourceExtend.getChildren().add(url);
				}

				resources.add(resourceExtend);
			}

			StaticCacheHolder.getInstance().setCache(
					StaticCacheHolder.KEY_ALL_HIERARCHIC_RESOURCE, resources);
		}

		return resources;
	}
}
