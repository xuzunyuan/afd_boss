package com.afd.boss.web;

import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.afd.boss.util.HttpCilient;
import com.afd.boss.util.PageUtils;
import com.afd.boss.util.PageUtils.PageInfo;
import com.afd.common.mybatis.Page;
import com.afd.common.util.DateUtils;
import com.afd.common.util.PropertyUtils;
import com.afd.constants.SystemConstants;
import com.afd.model.product.Brand;
import com.afd.service.product.IBrandService;
import com.afd.service.product.IProductService;
import com.afd.staff.model.TStaff;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;

@Controller
@RequestMapping("/brand")
public class BrandController {
	protected final static Logger logger = LoggerFactory.getLogger(BrandController.class);
	
	@Autowired
	protected IProductService productService;
	
	@Autowired
	protected IBrandService brandService;
	
	@RequestMapping("/list")
	public String getBrandsByPage(HttpServletRequest request){
		// 处理分页信息
		PageInfo pageInfo = null;

		if (request.getParameter("query") != null) { // 查询
			pageInfo = PageUtils.registerPageInfo(request);

		} else if (request.getParameter("pageNo") != null) { // 分页
			int pageNo = NumberUtils.toInt(request.getParameter("pageNo"), 1);
			
			pageInfo = PageUtils.getPageInfo(request);
			pageInfo.setPageNo(pageNo);
		} else {
			pageInfo = PageUtils.getPageInfo(request);

			if (pageInfo == null) {
				pageInfo = PageUtils.registerPageInfo(request);
				pageInfo.getConditions().put("status", SystemConstants.DB_STATUS_VALID); // 默认有效
				pageInfo.getConditions().put("createDate", "DESC"); // 默认降序
			}
		}

		request.setAttribute("pageInfo", pageInfo);
		
		// 查询
		Map<String, Object> map = Maps.newHashMap();

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("brandName"))) {
			map.put("brandName", pageInfo.getConditions().get("brandName"));
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("brandEname"))) {
			map.put("brandEname", pageInfo.getConditions().get("brandEname").toLowerCase());
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("startDt"))) {
			map.put("startDt", DateUtils.parseDate(pageInfo.getConditions()
					.get("startDt"), "yyyy-MM-dd"));
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("endDt"))) {
			Date endDt = DateUtils.parseDate(
					pageInfo.getConditions().get("endDt"), "yyyy-MM-dd");

			endDt = DateUtils.addDay(endDt, 1);

			map.put("endDt", endDt);
		}		
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("status"))) {
			map.put("status", pageInfo.getConditions().get("status"));
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("brandStatus"))) {
			map.put("brandStatus", pageInfo.getConditions().get("brandStatus"));
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("createDate"))) {
			map.put("createDate", pageInfo.getConditions().get("createDate"));
		}
		
		Page<Brand> brands = new Page<Brand>();
		brands.setCurrentPageNo(pageInfo.getPageNo());	
		
		brands = this.brandService.getBrandsByPage(map, brands);
		
		request.setAttribute("brands", brands);
		
		return "brand/list";
	}
	
	@RequestMapping(value="add", method=RequestMethod.GET)
	public String addBrandView(){
		return "brand/add";
	}
	
	@RequestMapping(value="add", method=RequestMethod.POST)
	public String addBrandSubmit(@ModelAttribute Brand brand,
			HttpServletRequest request, RedirectAttributes redirectAttributes){
		String reP = "redirect:/brand/list?m=33";
		
		if(StringUtils.isEmpty(brand.getBrandName()) && StringUtils.isEmpty(brand.getBrandEname()) ||
				StringUtils.isEmpty(brand.getPinyin()) ||
				(StringUtils.isNotEmpty(brand.getBrandStory()) && brand.getBrandStory().length()>1000)){
			
			request.setAttribute("warnFlag", true);
			reP = "/brand/add";
		}else{
			TStaff staff = (TStaff) SecurityUtils.getSubject().getPrincipal();
			brand.setCreateByName(staff.getLoginName());
			brand.setCreateDate(DateUtils.currentDate());
			brand.setStatus(SystemConstants.DB_STATUS_VALID);
			
			try {
 				this.brandService.insertBrand(brand);
			} catch (Exception e) {
				e.printStackTrace();
			}		
			
			redirectAttributes.addFlashAttribute("addFlag", true);
		}
		
		return reP;
	}
	
	@RequestMapping(value="mod", method=RequestMethod.GET)
	public String modBrandView(@RequestParam(value = "bId") Long brandId, Model model){
		Brand brand = this.brandService.getByBrandId(brandId);
		model.addAttribute("brand", brand);
		
		return "brand/modBrand";
	}
	
	@RequestMapping(value="mod", method=RequestMethod.POST)
	public String modBrandSubmit(@ModelAttribute Brand brand,
			HttpServletRequest request, RedirectAttributes redirectAttributes){
		String reP = "redirect:/brand/list?m=33";
		
		if(StringUtils.isEmpty(brand.getBrandName()) && StringUtils.isEmpty(brand.getBrandEname()) ||
				StringUtils.isEmpty(brand.getPinyin()) ||
				(StringUtils.isNotEmpty(brand.getBrandStory()) && brand.getBrandStory().length()>1000)){
			
			request.setAttribute("warnFlag", true);
			reP = "/brand/modBrand";
		}else{
			try {
 				boolean b = this.brandService.updateByBrandId(brand);
				if(b){
					redirectAttributes.addFlashAttribute("modFlag", true);
				}else{
					request.setAttribute("warnFlag", true);
					reP = "/brand/modBrand";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}		
		}
		
		return reP;
	}
	
	
	@ResponseBody
	@RequestMapping(value="check", method=RequestMethod.POST)
	public int checkName(@RequestParam(value="name") String name, @RequestParam(value="flag") int flag,
			@RequestParam(value="brandId", defaultValue="0") int brandId) {
		int re = 1;
		
		Brand brand = null;
		
		if(flag == 1){
			brand = this.brandService.getBrandByName(name, null, SystemConstants.DB_STATUS_VALID);
			if(brand==null || brand.getBrandId()==brandId){
				re = 0;
			}
		}else if(flag == 2){
			brand = this.brandService.getBrandByName(null, name.toLowerCase(), SystemConstants.DB_STATUS_VALID);
			if(brand==null || brand.getBrandId()==brandId){
				re = 0;
			}
		}
		
		return re;
	}
	
	/**
	 * 删除品牌
	 * @param brandId
	 * @param bcId
	 * @return 1:成功,0:失败,-1:卖家已申请
	 */
	@ResponseBody
	@RequestMapping(value="del", method=RequestMethod.POST)
	public int deleteBrand(long brandId, @RequestParam(value="brandBcId", required=false, defaultValue="0") long brandBcId, 
			@RequestParam(value="bcId", required=false, defaultValue="0") int bcId) {
		int result = 0;
		
		if(brandId > 0){
			try {
				result = this.brandService.deleteByBrandId(brandId);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	@RequestMapping(method = RequestMethod.POST, value="saveImg")
	public void uploadBrandImg(@RequestParam("imgFile") CommonsMultipartFile file, HttpServletResponse response){
		if(file.getSize() > 0){
			//定义允许上传的文件扩展名
			HashMap<String, String> extMap = new HashMap<String, String>();
			extMap.put("image", "gif,jpg,jpeg,png,bmp");
			
			//最大文件大小
			long maxSize = 102400;
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter pw = null;
			
			try {
				pw = response.getWriter();
			
				String fileName = file.getOriginalFilename();
				if (file.getSize() > maxSize) {//检查文件大小
					pw.print(getError("上传文件大小超过限制。"));
					return;
				}
				
				String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase(); //检查扩展名
				
				if (!Arrays.<String>asList(extMap.get("image").split(",")).contains(fileExt)) {
					pw.print(getError("上传文件扩展名是不允许的扩展名。\n只允许"+ extMap.get("image") + "格式。"));
					return;
				}
			
				List<String> urls = HttpCilient.uploadFileService(file.getInputStream(), fileName, null);
				
				StringBuilder fullUrl = new StringBuilder();
				for (String url : urls) {
					fullUrl.append(PropertyUtils.getRandomProperty("imgGetUrl") + url+",");
				}
				pw.print(getRight(fullUrl.substring(0, fullUrl.length()-1)));
			} catch (Exception e) {
				logger.info("上传文件失败！",e);
				if(pw != null){
					pw.println(getError("上传文件失败。"));
				}
			} finally {
				if(pw != null){
					pw.close();
				}
			}
		}
	}

	private String getError(String message) {
		JSONObject obj = new JSONObject();
		obj.put("error", 1);
		obj.put("message", message);
		return obj.toJSONString();
	}
	
	private String getRight(String message) {
		JSONObject obj = new JSONObject();
		obj.put("error", 0);
		obj.put("url", message);
		return obj.toJSONString();
	}
	
}
