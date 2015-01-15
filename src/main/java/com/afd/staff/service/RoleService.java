/**
 * Copyright (c)2013-2014 by www.afd.com. All rights reserved.
 * 
 */
package com.afd.staff.service;

import java.util.List;

import com.afd.common.mybatis.Page;
import com.afd.staff.model.TRole;

/**
 * 角色服务接口
 * 
 * @author xuzunyuan
 * @date 2014年1月24日
 */
public interface RoleService {
	/**
	 * 获取所有角色
	 * 
	 * @return
	 */
	public List<TRole> getAllRoles();

	/**
	 * 分页获取所有角色
	 * 
	 * @param page
	 * @return
	 */
	public Page<TRole> getAllRolesByPage(int... page);

	/**
	 * 根据ID取角色
	 * 
	 * @param roleId
	 * @return
	 */
	public TRole getRoleById(Integer roleId);

	public TRole getRoleByName(String name);

	/**
	 * 取角色权限
	 * 
	 * @param roleId
	 * @return
	 */
	public List<Integer> getRolePriveleges(Integer roleId);

	/**
	 * 新建角色，不涉及权限的处理
	 * 
	 * @param role
	 */
	public int newRole(TRole role);

	/**
	 * 新建角色，包括权限的处理
	 * 
	 * @param role
	 * @param resourceIds
	 */
	public int newRole(TRole role, Integer[] resourceIds);

	/**
	 * 更新角色，不包括权限的处理
	 * 
	 * @param role
	 */
	public void updateRole(TRole role);

	/**
	 * 更新角色信息，包括权限
	 * 
	 * @param role
	 * @param resourceIds
	 */
	public void updateRole(TRole role, Integer[] resourceIds);

	/**
	 * 删除角色
	 * 
	 * @param roleId
	 */
	public void deleteRole(Integer roleId);
}
