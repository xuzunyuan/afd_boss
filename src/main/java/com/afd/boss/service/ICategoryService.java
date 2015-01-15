package com.afd.boss.service;

import java.util.List;

import com.afd.model.product.BaseCategory;


public interface ICategoryService{
	
	/**
	 * 获取远程服务提供的对象
	 * @return
	 */
	public com.afd.service.product.ICategoryService getCategoryService();
	
	 
}