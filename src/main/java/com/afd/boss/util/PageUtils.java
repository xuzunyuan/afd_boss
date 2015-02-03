/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.afd.boss.util;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.google.common.collect.Maps;

/**
 * 分页辅助类，通过session记录分页的查询条件、请求页数等信息
 * 
 * @author xuzunyuan
 * @date 2014年1月20日
 */
public class PageUtils {
	private static final String SESSION_PAGE_KEY = "SESSION_PAGE_KEY";

	@SuppressWarnings("unchecked")
	public static final PageInfo registerPageInfo(HttpServletRequest request) {
		PageInfo pageInfo = new PageInfo();

		pageInfo.setUri(request.getRequestURI());

		Map<String, String> map = Maps.newHashMap();
		Map<String, Object> params = request.getParameterMap();

		for (String key : params.keySet()) {
			map.put(key, request.getParameter(key));
		}

		pageInfo.setConditions(map);
		request.getSession().setAttribute(SESSION_PAGE_KEY, pageInfo);

		return pageInfo;
	}

	public static final PageInfo getPageInfo(HttpServletRequest request) {
		PageInfo pageInfo = (PageInfo) request.getSession().getAttribute(
				SESSION_PAGE_KEY);

		if (pageInfo != null
				&& request.getRequestURI().equals(pageInfo.getUri())) {

			return pageInfo;
		} else {
			request.getSession().removeAttribute(SESSION_PAGE_KEY);
			return null;
		}
	}

	public static final class PageInfo {
		public PageInfo() {
		}

		private String uri;
		private Map<String, String> conditions;
		private int pageNo = 1;

		public int getPageNo() {
			return pageNo;
		}

		public void setPageNo(int pageNo) {
			this.pageNo = pageNo;
		}

		public String getUri() {
			return uri;
		}

		public void setUri(String uri) {
			this.uri = uri;
		}

		public Map<String, String> getConditions() {
			return conditions;
		}

		public void setConditions(Map<String, String> conditions) {
			this.conditions = conditions;
		}
	}
}
