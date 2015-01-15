/**
 * Copyright (c)2013-2014 by www.afd.com. All rights reserved.
 * 
 */
package com.afd.staff.service;

import java.util.List;
import java.util.Map;

import com.afd.common.mybatis.Page;
import com.afd.staff.model.TResource;
import com.afd.staff.model.TStaff;

/**
 * 雇员服务接口
 * 
 * @author xuzunyuan
 * @date 2013年12月25日
 */
public interface StaffService {
	public List<TStaff> getAllStaffs();

	public List<TStaff> getAllValidStaffs();

	public Page<TStaff> getAllStaffsByPage(int... page);

	public Page<TStaff> getAllValidStaffsByPage(int... page);

	/**
	 * 根据ID获取雇员信息
	 * 
	 * @param staffId
	 * @return
	 */
	public TStaff getStaff(int staffId);

	/**
	 * 根据账号获取雇员信息
	 * 
	 * @param login
	 * @return
	 */
	public TStaff getStaffByLogin(String login);

	/**
	 * 获取雇员权限信息
	 * 
	 * @param staffId
	 * @return URL集合
	 */
	public List<TResource> getStaffPrivileges(int staffId);

	/**
	 * 取用户所有角色
	 * 
	 * @param staffId
	 * @return
	 */
	public Integer[] getStaffRoleIds(int staffId);

	public Integer newStaff(TStaff staff);

	public Integer newStaff(TStaff staff, Integer[] roleIds);

	public void updateStaff(TStaff staff);

	public void updateStaff(TStaff staff, Integer[] roleIds);

	public void deleteStaff(Integer staffId);

	/**
	 * 根据条件检索雇员
	 * 
	 * @param cond
	 * @param page
	 * @return
	 */
	public Page<TStaff> queryStaffs(Map<String, Object> cond, int... page);

	public void resetStaffPassword(int staffId);
}
