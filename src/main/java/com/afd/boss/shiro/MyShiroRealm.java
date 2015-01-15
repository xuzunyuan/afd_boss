/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.afd.boss.shiro;

import java.util.List;

import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.afd.common.encrypt.MD5Encrypt;
import com.afd.staff.model.TResource;
import com.afd.staff.model.TStaff;
import com.afd.staff.service.StaffService;


/**
 * shiro realm实现
 * 
 * @author xuzunyuan
 * @date 2013年12月25日
 */
public class MyShiroRealm extends AuthorizingRealm {
	/**
	 * 雇员服务
	 */
	private StaffService staffService;

	public StaffService getStaffService() {
		return staffService;
	}

	public void setStaffService(StaffService staffService) {
		this.staffService = staffService;
	}

	/*
	 * 授权
	 * 
	 * @see
	 * org.apache.shiro.realm.AuthorizingRealm#doGetAuthorizationInfo(org.apache
	 * .shiro.subject.PrincipalCollection)
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection arg0) {
		TStaff staff = (TStaff) arg0.getPrimaryPrincipal();
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();

		List<TResource> resources = staffService.getStaffPrivileges(staff
				.getStaffId());

		for (TResource resource : resources) {

			info.addStringPermission(resource.getPermCode());
		}

		return info;
	}

	/*
	 * 认证
	 * 
	 * @see
	 * org.apache.shiro.realm.AuthenticatingRealm#doGetAuthenticationInfo(org
	 * .apache.shiro.authc.AuthenticationToken)
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken arg0) throws AuthenticationException {

		UsernamePasswordToken token = (UsernamePasswordToken) arg0; // 用户密码对
		TStaff staff = staffService.getStaffByLogin(token.getUsername()); // 雇员信息

		if (staff == null)
			throw new AccountException("用户名没找到");
		else if (!staff.getStatus())
			throw new AccountException("用户已失效");

		// 密码比对:使用MD5将明文密码和私钥进行加密，和数据库中的密码对比
		String encrypt = MD5Encrypt.md5(staff.getPrivateKey(),
				String.valueOf(token.getPassword()));

		if (!staff.getPassword().equals(encrypt)) {
			throw new AccountException("密码不正确");
		}

		return new SimpleAuthenticationInfo(staff, token.getPassword(),
				this.getName());
	}
}
