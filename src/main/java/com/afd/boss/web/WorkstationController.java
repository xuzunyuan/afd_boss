/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.afd.boss.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.afd.staff.service.ResourceService;
import com.afd.staff.service.StaffService;

/**
 * 主工作界面控制器
 * 
 * @author xuzunyuan
 * @date 2013年12月25日
 */
@Controller
public class WorkstationController {
	protected final static Logger logger = LoggerFactory
			.getLogger(WorkstationController.class);

	@Autowired
	StaffService staffService;

	@Autowired
	ResourceService resourceService;

	/**
	 * 进入主工作台，准备用户欢迎数据和菜单数据
	 * 
	 * @return
	 */
	@RequestMapping("/")
	public String main() {
		return "workstation/workstation";
	}
}
