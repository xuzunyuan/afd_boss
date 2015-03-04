package com.afd.boss.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.afd.common.mybatis.Page;
import com.afd.common.util.DateUtils;
import com.afd.model.product.BaseCategory;
import com.afd.model.product.Product;
import com.afd.model.product.Sku;
import com.afd.model.product.vo.BaseCategoryInfoVO;
import com.afd.model.seller.Seller;
import com.afd.param.product.ProductCondition;
import com.afd.service.product.ICategoryService;
import com.afd.service.product.IProductService;
import com.afd.service.product.ISellerBrandService;
import com.afd.service.seller.ISellerService;
import com.afd.staff.model.TStaff;


/**
 * 
 * @author haikema
 *
 */
@Controller
public class ProductController {
	
	@Autowired
	IProductService productService;
	@Autowired
	ICategoryService categoryService;
	@Autowired
	ISellerBrandService sellerBrandService;
	@Autowired
	ISellerService sellerService;
	
	@InitBinder  
    protected void initBinder(HttpServletRequest request,  
        ServletRequestDataBinder binder) throws Exception {  
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");  
        CustomDateEditor editor = new CustomDateEditor(df, true);  
        binder.registerCustomEditor(Date.class, editor);  
    }
	
	/**
	 * 
	 * @return 商品列表
	 */
	@RequestMapping(value = "/product/productList")
	public String toOnlineProductPage(
			@ModelAttribute ProductCondition productCondition,
			@RequestParam(value = "sortField", defaultValue = "") String sortField,
			@RequestParam(value = "sortDirection", defaultValue = "") String sortDirection,
			HttpServletRequest request, Page<Product> page, ModelMap modelMap
			) {
		page.setPageSize(20);
		
		Date endDate = productCondition.getEndDate();
		if(null != endDate){
			String strEndDate = DateUtils.formatDate(endDate, "yyyy-MM-dd");
			endDate = DateUtils.parseDate(strEndDate + " 23:59:59");
			productCondition.setEndDate(endDate);
		}
		
		page = productService.searchProductByConditionPage(productCondition, sortField, sortDirection, page);
		List<Product> list = page.getResult();
		if(null != list && !list.isEmpty()){
			for (Product p : list) {
				BaseCategoryInfoVO bc = this.categoryService.getBaseCategoryInfoByBcId(p.getBcId());
				String displayBcName = bc.getPathName().trim().replace("|", "/");
				p.setBcName(displayBcName +"/"+ bc.getBcName());
				Seller seller = sellerService.getSellerById(p.getSellerId());
				p.setCoName(seller.getCoName());
			}
		}
		
		modelMap.addAttribute("page", page);
		return "/product/productList";
	}
	
	/**
	 *  ajax调用：抽样下架
	 * @param prodId
	 * @return
	 */
	@RequestMapping(value = "/product/doDownaway")
	@ResponseBody
	public boolean doDownawayProduct(@RequestParam(value = "prodId", required = true) Integer prodId,
			@RequestParam(value = "auditStatus", required = false) String auditStatus,
			@RequestParam(value = "auditContent", required = false) String auditContent){
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject().getPrincipal();
		String loginName = currentStaff.getLoginName();
		
		return productService.auditProduct(prodId, auditStatus, auditContent, loginName);
	}

	/**
	 * ajax调用： 批量抽样下架
	 * @param ids
	 * @return
	 */
	@RequestMapping(value="/product/batchDownaway",method = RequestMethod.POST) 
	@ResponseBody
	public boolean batchUpdateStatus(@RequestParam(value = "ids", required=true) String ids,
			@RequestParam(value = "auditStatus", required = true) String auditStatus,
			@RequestParam(value = "auditContent", required = false) String auditContent){
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject().getPrincipal();
		String loginName = currentStaff.getLoginName();
		List<Integer> idList = new ArrayList<Integer>();
		String[] prodIds = ids.split(",");
		for (String prodId : prodIds) {
			idList.add(Integer.parseInt(prodId));
		}
		return productService.batchAuditProduct(idList, auditStatus, auditContent, loginName);
	}
	
	@RequestMapping(value = "/product/productDetail")
	public String toProductDetail(@RequestParam(value = "prodId", required = true) Integer prodId,
			ModelMap modelMap) {
		Product product = productService.getProductById(prodId);
		if(null != product){
			List<Sku> skuList = productService.getSkusByProdId(prodId);
			BaseCategory bc = this.categoryService.getByBcId(product.getBcId());
			String displayBcName = bc.getPathName().trim().replace("|", "/");
			product.setBcName(displayBcName +"/"+ bc.getBcName());
			modelMap.addAttribute("skus", skuList);
		}
		
		modelMap.addAttribute("p", product);
		return "product/productDetail";
	}
			
	
}
