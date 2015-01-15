package com.afd.boss.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.afd.boss.service.ICategoryService;
import com.afd.constants.SystemConstants;
import com.afd.constants.product.ProductConstants;
import com.afd.model.product.BaseCategory;

@Service("categoryService")
public class CategoryServiceImpl implements ICategoryService {

	@Autowired()
	private com.afd.service.product.ICategoryService categoryService;
	public com.afd.service.product.ICategoryService getCategoryService() {
		return categoryService;
	}
}
