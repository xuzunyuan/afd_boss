package com.afd.staff.model;

import java.io.Serializable;

public class TRole implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7913920460769027260L;

	private Integer roleId;

	private String roleCode;

	private String roleName;

	private String remark;

	private Boolean status;

	private Character type;

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public String getRoleCode() {
		return roleCode;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public Character getType() {
		return type;
	}

	public void setType(Character type) {
		this.type = type;
	}
}