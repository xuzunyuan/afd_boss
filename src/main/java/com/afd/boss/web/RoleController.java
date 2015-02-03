/**
 * Copyright (c)2013-2014 by www.afd.com. All rights reserved.
 * 
 */
package com.afd.boss.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.ConvertUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.afd.boss.util.PageUtils;
import com.afd.boss.util.PageUtils.PageInfo;
import com.afd.common.mybatis.Page;
import com.afd.staff.model.TRole;
import com.afd.staff.model.extend.TResourceExtend;
import com.afd.staff.service.ResourceService;
import com.afd.staff.service.RoleService;

/**
 * 角色管理
 * 
 * @author xuzunyuan
 * @date 2014年2月7日
 */
@Controller
public class RoleController {
	@Autowired
	RoleService roleService;

	@Autowired
	ResourceService resourceService;

	@RequestMapping("/sys/role")
	public String sysRoleList(HttpServletRequest request) {
		PageInfo pageInfo = null;

		if (request.getParameter("pageNo") != null) { // 分页
			int pageNo = (int) ConvertUtils.convert(
					request.getParameter("pageNo"), int.class);

			pageInfo = PageUtils.getPageInfo(request);
			pageInfo.setPageNo(pageNo);

		} else {
			pageInfo = PageUtils.getPageInfo(request);

			if (pageInfo == null) {
				pageInfo = PageUtils.registerPageInfo(request);
			}
		}

		Page<TRole> rolesPage = roleService.getAllRolesByPage(pageInfo
				.getPageNo());
		request.setAttribute("rolesPage", rolesPage);

		return "/sys/roleList";
	}

	@RequestMapping("/sys/rolePage")
	public String sysRolePage(HttpServletRequest request) {
		int roleId = (int) ConvertUtils.convert(request.getParameter("roleId"),
				int.class);

		if (roleId != 0) {
			TRole role = roleService.getRoleById(roleId);
			request.setAttribute("role", role);

			List<Integer> resourceIds = roleService.getRolePriveleges(roleId);
			request.setAttribute("resourceIds", resourceIds);
		}

		// 准备所有权限数据
		List<TResourceExtend> allResources = resourceService
				.getAllHierarchicResources();
		request.setAttribute("allResources", allResources);

		return "/sys/rolePage";
	}

	@RequestMapping("/sys/roleUpdate")
	public String sysRoleUpdate(HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		int roleId = (int) ConvertUtils.convert(request.getParameter("roleId"),
				int.class);

		if ("del".equals(request.getParameter("flg"))) {
			roleService.deleteRole(roleId);

		} else {
			TRole existRole = roleService.getRoleByName(request
					.getParameter("roleName"));

			if (existRole != null) {
				if (roleId == 0) {
					redirectAttributes.addFlashAttribute("msg", "角色名已存在，不能创建！");
					return "redirect:/sys/role";

				} else {
					if (roleId != existRole.getRoleId().intValue()) {
						redirectAttributes.addFlashAttribute("msg",
								"角色名已存在，保存失败！");
						return "redirect:/sys/role";
					}
				}

			}

			TRole role = new TRole();
			role.setRoleId(roleId);
			role.setRoleName(request.getParameter("roleName"));
			role.setRoleCode(request.getParameter("roleCode"));
			role.setRemark(request.getParameter("remark"));
			role.setStatus(true);

			String[] resourceIds = request.getParameterValues("resourceId");
			Integer[] urls = null;

			if (resourceIds != null && resourceIds.length > 0) {
				urls = new Integer[resourceIds.length];
				for (int i = 0; i < resourceIds.length; i++) {
					urls[i] = (Integer) ConvertUtils.convert(resourceIds[i],
							Integer.class);
				}
			}

			if (roleId == 0) {
				roleService.newRole(role, urls);
			} else {
				roleService.updateRole(role, urls);
			}
		}

		return "redirect:/sys/role";
	}

}
