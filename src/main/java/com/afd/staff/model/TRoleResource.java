package com.afd.staff.model;

import java.io.Serializable;

public class TRoleResource implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1948604070099123903L;

	private Integer id;

	private Integer roleId;

	private Integer resourceId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getResourceId() {
		return resourceId;
	}

	public void setResourceId(Integer resourceId) {
		this.resourceId = resourceId;
	}
}