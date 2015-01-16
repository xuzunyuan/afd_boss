/**
 * Copyright (c)2013-2014 by www.afd.com. All rights reserved.
 * 
 */
package com.afd.staff.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.afd.common.config.AfdConfig;
import com.afd.common.encrypt.MD5Encrypt;
import com.afd.common.generator.UUIDGenerator;
import com.afd.common.mybatis.Page;
import com.afd.staff.dao.TRoleMapper;
import com.afd.staff.dao.TStaffMapper;
import com.afd.staff.dao.TStaffRoleMapper;
import com.afd.staff.dao.extend.TStaffPrivilegeMapper;
import com.afd.staff.model.TResource;
import com.afd.staff.model.TStaff;
import com.afd.staff.model.TStaffExample;
import com.afd.staff.model.TStaffRole;
import com.afd.staff.model.TStaffRoleExample;
import com.afd.staff.service.StaffService;

/**
 * 雇员服务实现
 * 
 * @author xuzunyuan
 * @date 2013年12月25日
 */
@Service("staffService")
public class StaffServiceImpl implements StaffService {
	@Autowired
	private TStaffMapper staffMapper;

	@Autowired
	private TStaffPrivilegeMapper staffPrivilegeMapper;

	@Autowired
	private TRoleMapper roleMapper;

	@Autowired
	private TStaffRoleMapper staffRoleMapper;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.afd.staff.service.StaffService#getStaff(int)
	 */
	@Override
	public TStaff getStaff(int staffId) {
		return staffMapper.selectByPrimaryKey(staffId);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.afd.staff.service.StaffService#getStaffPrivileges(int)
	 */
	@Override
	public List<TResource> getStaffPrivileges(int staffId) {
		return staffPrivilegeMapper.selectStaffPrivelege(staffId);
	}

	@Override
	public TStaff getStaffByLogin(String login) {
		TStaffExample example = new TStaffExample();
		example.createCriteria().andLoginNameEqualTo(login);

		List<TStaff> staffList = staffMapper.selectByExample(example);

		return staffList.size() > 0 ? staffList.get(0) : null;
	}

	@Override
	public List<TStaff> getAllStaffs() {
		return staffMapper.selectAll(null);
	}

	@Override
	public List<TStaff> getAllValidStaffs() {
		return staffMapper.selectAll(true);
	}

	@Override
	public Page<TStaff> getAllStaffsByPage(int... page) {
		Page<TStaff> pageStaffs = new Page<TStaff>();
		if (page.length > 0)
			pageStaffs.setCurrentPageNo(page[0]);
		if (page.length > 1)
			pageStaffs.setPageSize(page[1]);

		return staffMapper.selectAllByPage(null, pageStaffs);
	}

	@Override
	public Page<TStaff> getAllValidStaffsByPage(int... page) {
		Page<TStaff> pageStaffs = new Page<TStaff>();
		if (page.length > 0)
			pageStaffs.setCurrentPageNo(page[0]);
		if (page.length > 1)
			pageStaffs.setPageSize(page[1]);

		return staffMapper.selectAllByPage(true, pageStaffs);
	}

	@Override
	public Integer[] getStaffRoleIds(int staffId) {
		TStaffRoleExample example = new TStaffRoleExample();

		example.createCriteria().andStaffIdEqualTo(staffId);
		List<TStaffRole> staffRoles = staffRoleMapper.selectByExample(example);

		Integer[] ret = null;

		if (staffRoles.size() > 0) {
			ret = new Integer[staffRoles.size()];
			for (int i = 0; i < staffRoles.size(); i++) {
				TStaffRole staffRole = staffRoles.get(i);
				ret[i] = staffRole.getRoleId();
			}
		}

		return ret;
	}

	@Override
	public Integer newStaff(TStaff staff) {
		// 检查账号是否存在
		TStaffExample example = new TStaffExample();
		example.createCriteria().andLoginNameEqualTo(staff.getLoginName());
		int count = staffMapper.countByExample(example);
		if (count > 0)
			return 0;

		// 生成默认密码
		staff.setPrivateKey(UUIDGenerator.getUUID32());
		staff.setPassword(MD5Encrypt.md5(staff.getPrivateKey(),
				AfdConfig.seller_default_password));

		staffMapper.insert(staff);

		return staff.getStaffId();
	}

	@Override
	public Integer newStaff(TStaff staff, Integer[] roleIds) {
		// 检查账号是否存在
		TStaffExample example = new TStaffExample();
		example.createCriteria().andLoginNameEqualTo(staff.getLoginName());
		int count = staffMapper.countByExample(example);
		if (count > 0)
			return 0;

		// 生成默认密码
		staff.setPrivateKey(UUIDGenerator.getUUID32());
		staff.setPassword(MD5Encrypt.md5(staff.getPrivateKey(),
				AfdConfig.seller_default_password));

		staffMapper.insert(staff);
		int staffId = staff.getStaffId();

		if (roleIds != null) {
			for (int roleId : roleIds) {
				TStaffRole staffRole = new TStaffRole();

				staffRole.setStaffId(staffId);
				staffRole.setRoleId(roleId);

				staffRoleMapper.insert(staffRole);
			}
		}

		return staffId;
	}

	@Override
	public void updateStaff(TStaff staff) {
		staffMapper.updateByPrimaryKeySelective(staff);
	}

	@Override
	public void updateStaff(TStaff staff, Integer[] roleIds) {
		staffMapper.updateByPrimaryKeySelective(staff);

		TStaffRoleExample example = new TStaffRoleExample();
		example.createCriteria().andStaffIdEqualTo(staff.getStaffId());
		staffRoleMapper.deleteByExample(example);

		if (roleIds != null) {
			for (int roleId : roleIds) {
				TStaffRole staffRole = new TStaffRole();
				staffRole.setRoleId(roleId);
				staffRole.setStaffId(staff.getStaffId());

				staffRoleMapper.insert(staffRole);
			}
		}

	}

	@Override
	public void deleteStaff(Integer staffId) {
		staffMapper.updateStaffStatus(staffId, false);
	}

	@Override
	public Page<TStaff> queryStaffs(Map<String, Object> cond, int... page) {
		Page<TStaff> p = new Page<TStaff>();

		if (!ArrayUtils.isEmpty(page)) {
			p.setCurrentPageNo(page[0]);
			if (page.length > 1)
				p.setPageSize(page[1]);
		}

		List<TStaff> result = staffMapper.queryByConditionsPage(cond, p);
		p.setResult(result);

		return p;
	}

	@Override
	public void resetStaffPassword(int staffId) {
		TStaff staff = staffMapper.selectByPrimaryKey(staffId);
		if (staff == null)
			return;

		staffMapper.updateStaffPassword(staffId, MD5Encrypt.md5(
				staff.getPrivateKey(), AfdConfig.staff_default_password));
	}

}
