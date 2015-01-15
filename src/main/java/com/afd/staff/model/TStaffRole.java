package com.afd.staff.model;

import java.io.Serializable;

public class TStaffRole implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3641089036273979388L;

	private Integer id;

	private Integer staffId;

	private Integer roleId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getStaffId() {
		return staffId;
	}

	public void setStaffId(Integer staffId) {
		this.staffId = staffId;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
}