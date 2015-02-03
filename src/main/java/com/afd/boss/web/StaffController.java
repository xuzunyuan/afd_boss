/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.afd.boss.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.afd.boss.util.PageUtils;
import com.afd.boss.util.PageUtils.PageInfo;
import com.afd.common.encrypt.MD5Encrypt;
import com.afd.common.mybatis.Page;
import com.afd.staff.model.TRole;
import com.afd.staff.model.TStaff;
import com.afd.staff.service.RoleService;
import com.afd.staff.service.StaffService;
import com.google.common.collect.Maps;

/**
 * 员工信息维护
 * 
 * @author xuzunyuan
 * @date 2014年2月7日
 */
@Controller
public class StaffController {
	@Autowired
	StaffService staffService;

	@Autowired
	RoleService roleService;

	@RequestMapping("/sys/staff")
	public String sysStaffList(HttpServletRequest request) {
		// 处理分页信息
		PageInfo pageInfo = null;

		if (request.getParameter("query") != null) { // 查询
			pageInfo = PageUtils.registerPageInfo(request);

		} else if (request.getParameter("pageNo") != null) { // 分页
			int pageNo = (int) ConvertUtils.convert(
					request.getParameter("pageNo"), int.class);

			pageInfo = PageUtils.getPageInfo(request);
			pageInfo.setPageNo(pageNo);

		} else {
			pageInfo = PageUtils.getPageInfo(request);

			if (pageInfo == null) {
				pageInfo = PageUtils.registerPageInfo(request);
				pageInfo.getConditions().put("status", "1"); // 默认有效
			}
		}

		request.setAttribute("pageInfo", pageInfo);

		// 查询
		Map<String, Object> map = Maps.newHashMap();

		if (!StringUtils.isBlank(pageInfo.getConditions().get("loginName"))) {
			map.put("loginName", pageInfo.getConditions().get("loginName"));
		}

		if (!StringUtils.isBlank(pageInfo.getConditions().get("realName"))) {
			map.put("realName", pageInfo.getConditions().get("realName"));
		}

		if (!StringUtils.isBlank(pageInfo.getConditions().get("nickName"))) {
			map.put("nickName", pageInfo.getConditions().get("nickName"));
		}

		if (!StringUtils.isBlank(pageInfo.getConditions().get("roleId"))) {
			map.put("roleId", (Integer) ConvertUtils.convert(pageInfo
					.getConditions().get("roleId"), Integer.class));
		}

		if (!StringUtils.isBlank(pageInfo.getConditions().get("status"))) {
			map.put("status", pageInfo.getConditions().get("status"));
		}

		Page<TStaff> staffsPage = staffService.queryStaffs(map,
				pageInfo.getPageNo());
		request.setAttribute("staffsPage", staffsPage);

		// 准备角色数据
		List<TRole> roleList = roleService.getAllRoles();
		request.setAttribute("roleList", roleList);

		return "/sys/staffList";
	}

	@RequestMapping("/sys/staffPage")
	public String sysStaffPage(HttpServletRequest request) {
		int staffId = (int) ConvertUtils.convert(
				request.getParameter("staffId"), int.class);

		if (staffId != 0) {
			TStaff staff = staffService.getStaff(staffId);
			request.setAttribute("staff", staff);

			Integer[] roleIds = staffService.getStaffRoleIds(staffId);
			request.setAttribute("roleIds", roleIds);
		}

		// 准备所有角色数据
		List<TRole> roleList = roleService.getAllRoles();
		request.setAttribute("roleList", roleList);

		return "/sys/staffPage";
	}

	@RequestMapping("/sys/staffDel")
	public String sysStaffDel(HttpServletRequest request) {
		int staffId = (int) ConvertUtils.convert(
				request.getParameter("staffId"), int.class);

		staffService.deleteStaff(staffId);

		return "redirect:/sys/staff";
	}

	@RequestMapping("/sys/staffUpdate")
	public String sysStaffUpdate(HttpServletRequest request) {
		TStaff staff = new TStaff();

		staff.setStaffId((int) ConvertUtils.convert(
				request.getParameter("staffId"), int.class));
		staff.setLoginName(request.getParameter("loginName"));
		staff.setRealName(request.getParameter("realName"));
		staff.setNickName(request.getParameter("nickName"));
		staff.setAddr(request.getParameter("addr"));
		staff.setZipCode(request.getParameter("zipCode"));
		staff.setMobile(request.getParameter("mobile"));
		staff.setTele(request.getParameter("tele"));
		staff.setQq(request.getParameter("qq"));
		staff.setEmail(request.getParameter("email"));
		staff.setRemark(request.getParameter("remark"));
		staff.setStatus(true);

		String[] roleIdArray = request.getParameterValues("roleId");
		Integer[] roleIds = null;

		if (roleIdArray != null && roleIdArray.length > 0) {
			roleIds = new Integer[roleIdArray.length];

			for (int i = 0; i < roleIdArray.length; i++) {
				roleIds[i] = (Integer) ConvertUtils.convert(roleIdArray[i],
						Integer.class);
			}
		}

		if (staff.getStaffId() == 0) {
			int ret = staffService.newStaff(staff, roleIds);
			if (ret == 0) {
				request.setAttribute("staff", staff);
				request.setAttribute("msg", "该账号已存在！");
				return "forward:/sys/staffPage";
			}

		} else {
			staffService.updateStaff(staff, roleIds);
		}

		return "redirect:/sys/staff";
	}

	@RequestMapping("/sys/resetStaffPassword")
	public String sysResetStaffPassword(HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		int staffId = (int) ConvertUtils.convert(
				request.getParameter("staffId"), int.class);

		staffService.resetStaffPassword(staffId);

		redirectAttributes.addFlashAttribute("msg", "重置密码成功！");
		return "redirect:/sys/staff";
	}

	@RequestMapping("/myAccount/view")
	public String myAccountView(HttpServletRequest request) {
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject()
				.getPrincipal();

		TStaff staff = staffService.getStaff(currentStaff.getStaffId());
		request.setAttribute("staff", staff);

		return "/sys/myAccount";
	}

	@RequestMapping("/myAccount/update")
	public String myAccountUpdate(HttpServletRequest request) {
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject()
				.getPrincipal();
		TStaff staff = new TStaff();

		staff.setStaffId(currentStaff.getStaffId());
		staff.setRealName(request.getParameter("realName"));
		staff.setNickName(request.getParameter("nickName"));
		staff.setAddr(request.getParameter("addr"));
		staff.setZipCode(request.getParameter("zipCode"));
		staff.setMobile(request.getParameter("mobile"));
		staff.setTele(request.getParameter("tele"));
		staff.setQq(request.getParameter("qq"));
		staff.setEmail(request.getParameter("email"));
		staff.setRemark(request.getParameter("remark"));

		staffService.updateStaff(staff);
		request.setAttribute("msg", "保存成功!");

		return "forward:/myAccount/view";
	}

	@RequestMapping("/myPassword/view")
	public String myPasswordView(HttpServletRequest request) {
		return "/sys/myPassword";
	}

	@RequestMapping("/myPassword/update")
	public String myPasswordUpdate(HttpServletRequest request,
			@RequestParam("oldPassword") String oldPassword,
			@RequestParam("newPassword") String newPassword) {

		TStaff currentStaff = (TStaff) SecurityUtils.getSubject()
				.getPrincipal();
		TStaff staff = staffService.getStaff(currentStaff.getStaffId());

		String oldEncrypt = MD5Encrypt.md5(staff.getPrivateKey(), oldPassword);
		if (!staff.getPassword().equals(oldEncrypt)) {
			request.setAttribute("msg", "旧密码不正确！");
			return "/sys/myPassword";
		}

		TStaff newStaff = new TStaff();
		newStaff.setStaffId(staff.getStaffId());
		newStaff.setPassword(MD5Encrypt.md5(staff.getPrivateKey(), newPassword));
		staffService.updateStaff(newStaff);
		request.setAttribute("msg", "密码更改成功！");

		return "/sys/myPassword";
	}
}
