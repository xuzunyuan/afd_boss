/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.afd.staff.model.extend;

import java.util.List;

import org.springframework.beans.BeanUtils;

import com.google.common.collect.Lists;
import com.afd.staff.model.TResource;

/**
 * 资源VO扩展
 * 
 * @author xuzunyuan
 * @date 2013年12月26日
 */
public class TResourceExtend extends TResource {

	private static final long serialVersionUID = -8292382187816105071L;

	public TResourceExtend(TResource resource) {
		cloneResource(resource);
	}

	/**
	 * 复制资源
	 * 
	 * @param resource
	 */
	public void cloneResource(TResource resource) {
		assert (resource != null);
		BeanUtils.copyProperties(resource, this);
	}

	// 孩子集合
	private List<TResource> children = Lists.newArrayList();

	public List<TResource> getChildren() {
		return children;
	}

	public void setChildren(List<TResource> children) {
		this.children = children;
	}
}
