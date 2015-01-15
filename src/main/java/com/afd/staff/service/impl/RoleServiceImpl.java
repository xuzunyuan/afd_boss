/**
 * Copyright (c)2013-2014 by www.afd.com. All rights reserved.
 * 
 */
package com.afd.staff.service.impl;

import java.util.List;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.afd.common.mybatis.Page;
import com.afd.staff.dao.TRoleMapper;
import com.afd.staff.dao.TRoleResourceMapper;
import com.afd.staff.model.TRole;
import com.afd.staff.model.TRoleExample;
import com.afd.staff.model.TRoleResource;
import com.afd.staff.model.TRoleResourceExample;
import com.afd.staff.service.RoleService;
import com.google.common.collect.Lists;

/**
 * 角色服务类
 * 
 * @author xuzunyuan
 * @date 2014年1月26日
 */
@Service
public class RoleServiceImpl implements RoleService {
	@Autowired
	TRoleMapper roleMapper;

	@Autowired
	TRoleResourceMapper roleResourceMapper;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.afd.staff.service.RoleService#getAllRoles()
	 */
	@Override
	public List<TRole> getAllRoles() {
		return roleMapper.selectAll();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.afd.staff.service.RoleService#getAllRolesByPage(int[])
	 */
	@Override
	public Page<TRole> getAllRolesByPage(int... page) {
		Page<TRole> p = new Page<TRole>();

		if (!ArrayUtils.isEmpty(page)) {
			p.setCurrentPageNo(page[0]);
			if (page.length > 1)
				p.setPageSize(page[1]);
		}

		List<TRole> result = roleMapper.selectAllByPage(p);
		p.setResult(result);

		return p;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.afd.staff.service.RoleService#getRoleById(java.lang.Integer)
	 */
	@Override
	public TRole getRoleById(Integer roleId) {
		return roleMapper.selectByPrimaryKey(roleId);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.afd.staff.service.RoleService#getRolePriveleges(java.lang.Integer)
	 */
	@Override
	public List<Integer> getRolePriveleges(Integer roleId) {
		TRoleResourceExample example = new TRoleResourceExample();
		example.createCriteria().andRoleIdEqualTo(roleId);

		List<TRoleResource> roleResourceList = roleResourceMapper
				.selectByExample(example);

		List<Integer> ret = Lists.newArrayList();
		for (TRoleResource roleResource : roleResourceList)
			ret.add(roleResource.getResourceId());

		return ret;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.afd.staff.service.RoleService#newRole(com.afd.staff.model.TRole
	 * )
	 */
	@Override
	public int newRole(TRole role) {
		role.setStatus(true);
		roleMapper.insert(role);

		return role.getRoleId();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.afd.staff.service.RoleService#newRole(com.afd.staff.model.TRole
	 * , java.lang.Integer[])
	 */
	@Override
	public int newRole(TRole role, Integer[] resourceIds) {
		role.setStatus(true);
		roleMapper.insert(role);

		if (resourceIds != null) {
			for (Integer resourceId : resourceIds) {
				TRoleResource roleResource = new TRoleResource();

				roleResource.setRoleId(role.getRoleId());
				roleResource.setResourceId(resourceId);
				roleResourceMapper.insert(roleResource);
			}
		}

		return role.getRoleId();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.afd.staff.service.RoleService#updateRole(com.afd.staff.model
	 * .TRole)
	 */
	@Override
	public void updateRole(TRole role) {
		roleMapper.updateByPrimaryKey(role);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.afd.staff.service.RoleService#updateRole(com.afd.staff.model
	 * .TRole, java.lang.Integer[])
	 */
	@Override
	public void updateRole(TRole role, Integer[] resourceIds) {
		roleMapper.updateByPrimaryKey(role);

		TRoleResourceExample example = new TRoleResourceExample();
		example.createCriteria().andRoleIdEqualTo(role.getRoleId());
		roleResourceMapper.deleteByExample(example);

		if (resourceIds != null) {
			for (Integer resourceId : resourceIds) {
				TRoleResource roleResource = new TRoleResource();

				roleResource.setRoleId(role.getRoleId());
				roleResource.setResourceId(resourceId);

				roleResourceMapper.insert(roleResource);
			}
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.afd.staff.service.RoleService#deleteRole(java.lang.Integer)
	 */
	@Override
	public void deleteRole(Integer roleId) {
		roleMapper.updateRoleStatus(roleId, false);
	}

	@Override
	public TRole getRoleByName(String name) {
		TRoleExample example = new TRoleExample();
		example.createCriteria().andRoleNameEqualTo(name)
				.andStatusEqualTo(Boolean.TRUE);

		List<TRole> roleList = roleMapper.selectByExample(example);

		return (roleList != null && roleList.size() > 0) ? roleList.get(0)
				: null;
	}
}
