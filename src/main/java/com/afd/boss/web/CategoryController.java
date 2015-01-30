package com.afd.boss.web;

import java.util.Date;
import java.util.List;


import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.afd.constants.SystemConstants;
import com.afd.constants.product.ProductConstants;
import com.afd.model.product.BaseCategory;
import com.afd.service.product.ICategoryService;


@Controller
@RequestMapping("/category")
public class CategoryController {
	protected final static Logger logger = LoggerFactory.getLogger(CategoryController.class);

	@Autowired
	private ICategoryService cateogryService;
	
	/**
	 * @param pId 父类目ID
	 * @param type 1：基础类目,2:签约类目,3:销售类目
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/bc/pList")
	public List<BaseCategory> getCategoryByBpid(@RequestParam(value="pId") Integer pId) {
		return this.cateogryService.getBaseCategorysByPId(pId, SystemConstants.DB_STATUS_VALID);
	}
	/**
	 * 无须权限获取基础类目
	 * @param pId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/noAuth/bc/pList")
	public List<BaseCategory> getCategoryByBpidNoAuth(@RequestParam(value="pId") Integer pId) {
		return this.cateogryService.getBaseCategorysByPId(pId, SystemConstants.DB_STATUS_VALID);
	}
	
	/**
	 * 基础类目列表页
	 * @return
	 */
	@RequestMapping("/bc/bcList")
	public String getFirstLevelBaseCategory(Model model) {
		List<BaseCategory> bcList = this.cateogryService.getBaseCategorysByPId(ProductConstants.CATE_LEVEL_FIRST_PID, SystemConstants.DB_STATUS_VALID);
		model.addAttribute("bcList", bcList);
		 
		return "category/bcList";
	}
	/**
	 * 增加基础类目
	 * @return 1_BCID_CODE:成功,0:失败,-1:名称已存在,-2:名称不能为空,-3:编码已达到最大值
	 */
	@ResponseBody
	@RequestMapping(value="/bc/bcAdd", method=RequestMethod.POST)
	public String addBaseCategory(BaseCategory category) {
		logger.info("add baseCategory name:"+category.getBcName());
		String result = "-1";
		
		try {
			if(StringUtils.isNotEmpty(category.getBcName().trim())){
				category.setBcName(category.getBcName().trim());
				BaseCategory bc = this.cateogryService.getBaseCategoryByNameAndPid(category.getpBcId(), category.getBcName(), SystemConstants.DB_STATUS_VALID);
				if(bc == null){
					String code = this.cateogryService.getCodeByPid(Integer.parseInt(category.getBcLevel()), category.getpBcId());
					if(!"-1".equals(code)){
						category.setCreateDate(new Date());
						category.setBcCode(code);
						category.setIsLeaf(true);
						category.setStatus(SystemConstants.DB_STATUS_VALID);
						List<BaseCategory> bcList = this.cateogryService.getBaseCategorysByPId(category.getpBcId(), SystemConstants.DB_STATUS_VALID);
						int order = (bcList==null || bcList.isEmpty())?1:(bcList.size()+1);
						category.setDisplayOrder(order);
						
						Integer re = this.cateogryService.insertBaseCategory(category);
						result = (re > 0)?("1_"+re+"_"+code):"0";
					}else{
						result = "-3";
					}
				}
			}else{
				result = "-2";
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "0";
		}
		 
		return result;
	}
	
	/**
	 * 修改基础类目
	 * @return 1:成功,0:失败,-1:名称已存在,-2:名称不能为空
	 */
	@ResponseBody
	@RequestMapping(value="/bc/bcUpdate", method=RequestMethod.POST)
	public int updateBaseCategory(@RequestParam(value="bcId") Integer bcId, @RequestParam(value="name") String name) {
		name = name.trim();
		logger.info("bcId:"+bcId+" is update name:"+name);
		
		int result = -1;
		if(bcId!=null && bcId>0 && StringUtils.isNotEmpty(name)){
			BaseCategory bc = this.cateogryService.getByBcId(bcId);
			if(!bc.getBcName().equals(name)){
				BaseCategory cbc = this.cateogryService.getBaseCategoryByNameAndPid(bc.getpBcId(), name, SystemConstants.DB_STATUS_VALID);
				if(cbc == null){
					bc.setBcName(name);
					bc.setUpdateData(new Date());
					result = this.cateogryService.updateBaseCategory(bc)?1:0;
				}
			}else{
				result = 1;
			}
		}else{
			result = -2;
		}
		 
		return result;
	}
	
	/**
	 * 修改基础类目显示顺序
	 * @return 1:成功,0:失败
	 */
	@ResponseBody
	@RequestMapping(value="/bc/bcOrder", method=RequestMethod.POST)
	public int updateBcDisplayOrder(@RequestParam(value="sbcId") Integer sbcId, @RequestParam(value="dbcId") Integer dbcId) {
		return this.cateogryService.updateBcDisplayOrder(sbcId, dbcId);
	}
	
	/**
	 * 删除基础类目
	 * @return 1:成功,0:失败,-1:存在子类目不允许删除-2:类目不存在,-3:已关联签约类目不允许删除,-4:已关联销售类目不允许删除
	 */
	@ResponseBody
	@RequestMapping(value="/bc/bcDelete", method=RequestMethod.POST)
	public int deleteBc(@RequestParam(value="bcId") Integer bcId) {
		return this.cateogryService.deleteByBcId(bcId);
	}
}
