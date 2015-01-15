/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.afd.boss.util;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.collect.Maps;

/**
 * 系统中的静态缓存仓库
 * 
 * @author xuzunyuan
 * @date 2013年12月26日
 */
public class StaticCacheHolder {
	private final static Logger logger = LoggerFactory
			.getLogger(StaticCacheHolder.class);

	private static StaticCacheHolder instance = new StaticCacheHolder(); // 单例模式

	// 缓存键值常量
	public static final String KEY_ALL_FOLDER = "ALL_FOLDER";
	public static final String KEY_ALL_RESOURCE = "ALL_RESOURCE";
	public static final String KEY_ALL_HIERARCHIC_RESOURCE = "ALL_HIERARCHIC_RESOURCE";

	private Map<String, Object> cacheHolder = Maps.newHashMap(); // 缓存仓库

	private StaticCacheHolder() {

	}

	public static StaticCacheHolder getInstance() {
		return instance;
	}

	/**
	 * 创建新的静态缓存
	 * 
	 * @param cacheKey
	 * @param cache
	 */
	public void setCache(String cacheKey, Object cache) {
		logger.info("new static cache : [" + cacheKey + "]");
		cacheHolder.put(cacheKey, cache);
	}

	/**
	 * 取缓存
	 * 
	 * @param cacheKey
	 * @return
	 */
	public <T> T getCache(String cacheKey) {
		return (T) cacheHolder.get(cacheKey);
	}
}
