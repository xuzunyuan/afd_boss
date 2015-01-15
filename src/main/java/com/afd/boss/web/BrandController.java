//package com.afd.boss.web;
//
//import java.io.PrintWriter;
//import java.util.ArrayList;
//import java.util.Arrays;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.annotation.Resource;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.apache.commons.lang.StringUtils;
//import org.apache.commons.lang.math.NumberUtils;
//import org.apache.shiro.SecurityUtils;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.multipart.commons.CommonsMultipartFile;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import com.afd.boss.util.PageUtils;
//import com.afd.boss.util.PageUtils.PageInfo;
//import com.afd.common.mybatis.Page;
//import com.afd.common.util.DateUtils;
//import com.afd.constants.SystemConstants;
//import com.afd.constants.product.ProductConstants;
//import com.afd.model.product.BaseCategory;
//import com.afd.model.product.Brand;
//import com.afd.service.product.IBrandService;
//import com.afd.service.product.ICategoryService;
//import com.afd.service.product.IProductService;
//import com.afd.staff.model.TStaff;
//import com.alibaba.fastjson.JSONObject;
//import com.google.common.collect.Maps;
//
//@Controller
//@RequestMapping("/brand")
//public class BrandController {
//	protected final static Logger logger = LoggerFactory.getLogger(BrandController.class);
//	
//	@Resource(name="dubbo_categoryService")
//	private ICategoryService cateogryService;
//	
//	@Autowired
//	protected IProductService productService;
//	
//	@Autowired
//	protected IBrandService brandService;
//	
//	@RequestMapping("/list")
//	public String getBrandsByPage(HttpServletRequest request){
//		// 处理分页信息
//		PageInfo pageInfo = null;
//
//		if (request.getParameter("query") != null) { // 查询
//			pageInfo = PageUtils.registerPageInfo(request);
//
//		} else if (request.getParameter("pageNo") != null) { // 分页
//			int pageNo = NumberUtils.toInt(request.getParameter("pageNo"), 1);
//			
//			pageInfo = PageUtils.getPageInfo(request);
//			pageInfo.setPageNo(pageNo);
//		} else {
//			pageInfo = PageUtils.getPageInfo(request);
//
//			if (pageInfo == null) {
//				pageInfo = PageUtils.registerPageInfo(request);
//				pageInfo.getConditions().put("status", SystemConstants.DB_STATUS_VALID); // 默认有效
//				pageInfo.getConditions().put("createDate", "DESC"); // 默认降序
//			}
//		}
//
//		request.setAttribute("pageInfo", pageInfo);
//		
//		// 查询
//		Map<String, Object> map = Maps.newHashMap();
//
//		if (StringUtils.isNotBlank(pageInfo.getConditions().get("brandName"))) {
//			map.put("brandName", pageInfo.getConditions().get("brandName"));
//		}
//		if (StringUtils.isNotBlank(pageInfo.getConditions().get("brandEname"))) {
//			map.put("brandEname", pageInfo.getConditions().get("brandEname").toLowerCase());
//		}
//		if (StringUtils.isNotBlank(pageInfo.getConditions().get("startDt"))) {
//			map.put("startDt", DateUtils.parseDate(pageInfo.getConditions()
//					.get("startDt"), "yyyy-MM-dd"));
//		}
//		if (StringUtils.isNotBlank(pageInfo.getConditions().get("endDt"))) {
//			Date endDt = DateUtils.parseDate(
//					pageInfo.getConditions().get("endDt"), "yyyy-MM-dd");
//
//			endDt = DateUtils.addDay(endDt, 1);
//
//			map.put("endDt", endDt);
//		}		
//		if (StringUtils.isNotBlank(pageInfo.getConditions().get("status"))) {
//			map.put("status", pageInfo.getConditions().get("status"));
//		}
//		if (StringUtils.isNotBlank(pageInfo.getConditions().get("brandStatus"))) {
//			map.put("brandStatus", pageInfo.getConditions().get("brandStatus"));
//		}
//		if (StringUtils.isNotBlank(pageInfo.getConditions().get("bcId"))) {
//			map.put("bcId", pageInfo.getConditions().get("bcId"));
//		}
//		if (StringUtils.isNotBlank(pageInfo.getConditions().get("createDate"))) {
//			map.put("createDate", pageInfo.getConditions().get("createDate"));
//		}
//		
//		Page<Brand> brands = new Page<Brand>();
//		brands.setCurrentPageNo(pageInfo.getPageNo());	
////		brands.setPageSize(NumberUtils.toInt(pageInfo.getConditions().get("pageSize"), 20));
//		
//		brands = this.brandService.getBrandsByPage(map, brands);
//		
//		//this.setCateAllName(brands.getResult());
//		
//		request.setAttribute("brands", brands);
//		
//		return "brand/list";
//	}
//	
//	@RequestMapping(value="add", method=RequestMethod.GET)
//	public String addBrandView(){
//		return "brand/add";
//	}
//	
//	@RequestMapping(value="add", method=RequestMethod.POST)
//	public String addBrandSubmit(@ModelAttribute Brand brand, @RequestParam(value = "bcIds") String bcIds,
//			@RequestParam(value = "bcShows") String bcShows,
//			HttpServletRequest request, RedirectAttributes redirectAttributes){
//		String reP = "redirect:/brand/list?m=33";
//		
//		if(StringUtils.isEmpty(brand.getBrandName()) && StringUtils.isEmpty(brand.getBrandEname()) ||
//				StringUtils.isEmpty(brand.getPinyin()) || StringUtils.isEmpty(bcIds) ||
//				(StringUtils.isNotEmpty(brand.getBrandStory()) && brand.getBrandStory().length()>1000)){
//			
//			request.setAttribute("warnFlag", true);
//			reP = "/brand/add";
//		}else{
//			TStaff staff = (TStaff) SecurityUtils.getSubject().getPrincipal();
//			brand.setCreateName(staff.getLoginName());
//			brand.setCreateDate(DateUtils.currentDate());
//			brand.setStatus(SystemConstants.DB_STATUS_VALID);
//			brand.setBrandStatus(ProductConstants.BRAND_LINKED);
//			
//			try {
// 				long brandId = this.brandService.insertBrand(brand);
//				if(brandId > 0){
//					String[] bcIdArr = bcIds.split(",");
//					String[] showArr = bcShows.split(",");
//					
//					BrandBc brandBc = null;
//					for(String bcId : bcIdArr){
//						brandBc = new BrandBc();
//						brandBc.setBcId(Integer.parseInt(bcId));
//						brandBc.setBrandId(brandId);
//						
//						String[] shows = null;
//						for(String show : showArr){
//							if(show.startsWith(bcId+"_")){
//								shows = show.split("_");
//								break;
//							}
//						}
//						if(shows!=null && shows.length==3){
//							brandBc.setIsFilter("1".equals(shows[1]));
//							brandBc.setIsMobileDisplay("1".equals(shows[2]));
//						}
//						
//						this.brandService.insertBrandBc(brandBc);
//					}
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//			}		
//			
//			redirectAttributes.addFlashAttribute("addFlag", true);
//		}
//		
//		return reP;
//	}
//	
//	@RequestMapping(value="mod", method=RequestMethod.GET)
//	public String modBrandView(@RequestParam(value = "bId") Long brandId, Model model){
//		Brand brand = this.brandService.getByBrandId(brandId);
//		model.addAttribute("brand", brand);
//		
//		return "brand/modBrand";
//	}
//	
//	@RequestMapping(value="mod", method=RequestMethod.POST)
//	public String modBrandSubmit(@ModelAttribute Brand brand,
//			HttpServletRequest request, RedirectAttributes redirectAttributes){
//		String reP = "redirect:/brand/list?m=33";
//		
//		if(StringUtils.isEmpty(brand.getBrandName()) && StringUtils.isEmpty(brand.getBrandEname()) ||
//				StringUtils.isEmpty(brand.getPinyin()) ||
//				(StringUtils.isNotEmpty(brand.getBrandStory()) && brand.getBrandStory().length()>1000)){
//			
//			request.setAttribute("warnFlag", true);
//			reP = "/brand/modBrand";
//		}else{
//			try {
// 				boolean b = this.brandService.updateByBrandId(brand);
//				if(b){
//					redirectAttributes.addFlashAttribute("modFlag", true);
//				}else{
//					request.setAttribute("warnFlag", true);
//					reP = "/brand/modBrand";
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//			}		
//		}
//		
//		return reP;
//	}
//	
//	
//	@RequestMapping(value="modCate", method=RequestMethod.GET)
//	public String modBrandCateView(@RequestParam(value = "bId") Long brandId, Model model){
//		//记录类目ID对应的品牌类目关系ID
//		JSONObject bbcIdJSON = new JSONObject();
//		//类目ID对应的类目名称
//		JSONObject bcNameJSON = new JSONObject();
//		//类目对应的子类目关系
//		JSONObject bcIdJSON = new JSONObject();
//		
//		//类目对应的品牌的过滤信息
//		JSONObject filterJSON = new JSONObject();
//		//类目对应的品牌的标签信息
//		JSONObject tagJSON = new JSONObject();
//		
//		Brand brand = this.brandService.getByBrandId(brandId);
//		if(brand != null){
//			String brandName = StringUtils.defaultString(brand.getBrandName());
//			if(StringUtils.isEmpty(brandName)){
//				brandName = StringUtils.defaultString(brand.getBrandEname());
//			}else if(StringUtils.isNotEmpty(brand.getBrandEname())){
//				brandName += "--"+StringUtils.defaultString(brand.getBrandEname());
//			}
//			model.addAttribute("brandName", brandName);
//		}
//		
//		List<BrandBc> brandBcList = this.brandService.getByBrandIdAndBcId(brandId, null);
//		
//		BaseCategory bc = null;
//		 
//		for(BrandBc brandBc : brandBcList){
//			filterJSON.put(brandBc.getBcId().toString(), brandBc.getIsFilter());
//			tagJSON.put(brandBc.getBcId().toString(), brandBc.getIsMobileDisplay());
//			
//			bc = this.cateogryService.getByBcId(brandBc.getBcId());
//			
//			String[] ids = bc.getPathId().split("\\|");
//			String[] names = bc.getPathName().split("\\|");
//			
//			//一级类已存在
//			if(bcIdJSON.containsKey(ids[0])){
//				//一级类下的三级类个数加1
//				bcIdJSON.getJSONObject(ids[0]).put("tl", bcIdJSON.getJSONObject(ids[0]).getInteger("tl") + 1);
//				
//				//二级类目存在
//				if(bcIdJSON.getJSONObject(ids[0]).containsKey(ids[1])){
//					@SuppressWarnings("unchecked")
//					List<String> tIds = bcIdJSON.getJSONObject(ids[0]).getObject(ids[1], List.class);
//					tIds.add(brandBc.getBcId().toString());
//				}else{//二级类不存在
//					List<String> tids = new ArrayList<>();
//					tids.add(brandBc.getBcId().toString());
//					
//					
//					bcIdJSON.getJSONObject(ids[0]).put(ids[1], tids);
//				}
//			}else{//一级类不存在
//				bcIdJSON.put(ids[0], new JSONObject());
//				bcIdJSON.getJSONObject(ids[0]).put("tl", 1);//一级类下的三级类个数
//				List<String> tids = new ArrayList<>();
//				tids.add(brandBc.getBcId().toString());
//				bcIdJSON.getJSONObject(ids[0]).put(ids[1], tids);
//			}
//			
//			if(!bcNameJSON.containsKey(ids[0])){
//				bcNameJSON.put(ids[0], names[0]);
//			}
//			if(!bcNameJSON.containsKey(ids[1])){
//				bcNameJSON.put(ids[1], names[1]);
//			}
//			bcNameJSON.put(bc.getBcId().toString(), bc.getBcName());
//			
//			bbcIdJSON.put(brandBc.getBcId().toString(), brandBc.getBrandBcId().toString());
//		}
//		
//		model.addAttribute("brandId", brandId);
//		model.addAttribute("bbcIds", bbcIdJSON.toJSONString());
//		model.addAttribute("selBcObj", bcNameJSON.toJSONString());
//		model.addAttribute("selBcIdObj", bcIdJSON.toJSONString());
//		model.addAttribute("filterJSON", filterJSON.toJSONString());
//		model.addAttribute("tagJSON", tagJSON.toJSONString());
//		
//		bbcIdJSON.clear();
//		bcNameJSON.clear();
//		bcIdJSON.clear();
//		filterJSON.clear();
//		tagJSON.clear();
//		
//		return "brand/modCate";
//	}
//	
//	/**
//	 * @param brandId
//	 * @param bcIds
//	 * @param redirectAttributes
//	 * @return 0:失败,1:成功
//	 */
//	@ResponseBody
//	@RequestMapping(value="modCate", method=RequestMethod.POST)
//	public int modBrandCateSubmit(@RequestParam(value = "brandId") Long brandId, 
//			@RequestParam(value = "bcIds") String bcIds, @RequestParam(value = "bcShows") String bcShows,
//			RedirectAttributes redirectAttributes){
//		int re = 0;
//		try {
//			if(brandId > 0){
//				String[] bcIdArr = bcIds.split(",");
//				String[] showArr = bcShows.split(",");
//				BrandBc brandBc = null;
//				for(String bcId : bcIdArr){
//					brandBc = new BrandBc();
//					brandBc.setBcId(Integer.parseInt(bcId));
//					brandBc.setBrandId(brandId);
//					
//					String[] shows = null;
//					for(String show : showArr){
//						if(show.startsWith(bcId+"_")){
//							shows = show.split("_");
//							break;
//						}
//					}
//					if(shows!=null && shows.length==3){
//						brandBc.setIsFilter("1".equals(shows[1]));
//						brandBc.setIsMobileDisplay("1".equals(shows[2]));
//					}
//					
//					this.cateogryService.insertBrandBc(brandBc);
//				}
//				re = 1;
//				
//				Brand brand = this.cateogryService.getByBrandId(brandId);
//				if(ProductConstants.BRAND_UNLINK.equals(brand.getBrandStatus())){
//					brand.setBrandStatus(ProductConstants.BRAND_LINKED);
//					
//					this.cateogryService.updateByBrandId(brand);
//				}
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}		
//		
//		return re;
//	}
//	
//	@ResponseBody
//	@RequestMapping(value="check", method=RequestMethod.POST)
//	public int checkName(@RequestParam(value="name") String name, @RequestParam(value="flag") int flag,
//			@RequestParam(value="brandId", defaultValue="0") int brandId) {
//		int re = 1;
//		
//		Brand brand = null;
//		
//		if(flag == 1){
//			brand = this.brandService.getBrandByName(name, null, SystemConstants.DB_STATUS_VALID);
//			if(brand==null || brand.getBrandId()==brandId){
//				re = 0;
//			}
//		}else if(flag == 2){
//			brand = this.brandService.getBrandByName(null, name.toLowerCase(), SystemConstants.DB_STATUS_VALID);
//			if(brand==null || brand.getBrandId()==brandId){
//				re = 0;
//			}
//		}
//		
//		return re;
//	}
//	
//	/**
//	 * 修改品牌和类目显示
//	 * @param brandBcId
//	 * @param flag 1:是否筛选,2:是否标签
//	 * @param value
//	 * @return 1:成功,0:失败
//	 */
//	@ResponseBody
//	@RequestMapping(value="modShow", method=RequestMethod.POST)
//	public int modShow(@RequestParam(value="brandBcId") Long brandBcId, 
//			@RequestParam(value="flag") Integer flag, @RequestParam(value="value") Boolean value) {
//		int result = 0;
//		
//		if(brandBcId > 0){
//			result = this.cateogryService.modBrandCateShow(brandBcId, flag, value)?1:0;
//		}
//		
//		return result;
//	}
//	
//	/**
//	 * 删除品牌和类目关系
//	 * @param brandId
//	 * @param brandBcId
//	 * @param bcId
//	 * @return 1:成功,0:失败,-1:已关联商品
//	 */
//	@ResponseBody
//	@RequestMapping(value="del", method=RequestMethod.POST)
//	public int deleteBrand(long brandId, @RequestParam(value="brandBcId", required=false, defaultValue="0") long brandBcId, 
//			@RequestParam(value="bcId", required=false, defaultValue="0") int bcId) {
//		int result = 0;
//		
//		if(brandId > 0){
//			result = this.productService.checkLinkedProduct(brandId, (bcId==0?null:bcId))?-1:0;
//			
//			try {
//				if(result != -1){
//					if(brandBcId==0 && bcId ==0){
//						result = this.brandService.deleteByBrandId(brandId) ? 1 : 0;
//					}else if(brandBcId>0 && bcId>0){
//						result = this.brandService.deleteById(brandBcId) ? 1 : 0;
//					}
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		
//		return result;
//	}
//	
//	@RequestMapping(method = RequestMethod.POST, value="saveImg")
//	public void uploadBrandImg(@RequestParam("imgFile") CommonsMultipartFile file, HttpServletResponse response){
//		if(file.getSize() > 0){
//			//定义允许上传的文件扩展名
//			HashMap<String, String> extMap = new HashMap<String, String>();
//			extMap.put("image", "gif,jpg,jpeg,png,bmp");
//			
//			//最大文件大小
//			long maxSize = 102400;
//			response.setContentType("text/html;charset=UTF-8");
//			PrintWriter pw = null;
//			
//			try {
//				pw = response.getWriter();
//			
//				String fileName = file.getOriginalFilename();
//				if (file.getSize() > maxSize) {//检查文件大小
//					pw.print(getError("上传文件大小超过限制。"));
//					return;
//				}
//				
//				String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase(); //检查扩展名
//				
//				if (!Arrays.<String>asList(extMap.get("image").split(",")).contains(fileExt)) {
//					pw.print(getError("上传文件扩展名是不允许的扩展名。\n只允许"+ extMap.get("image") + "格式。"));
//					return;
//				}
//			
//				List<String> urls = YWHttpCilient.uploadFileService(file.getInputStream(), fileName, null);
//				
//				StringBuilder fullUrl = new StringBuilder();
//				for (String url : urls) {
//					fullUrl.append("http://img"+(new java.util.Random().nextInt(6))+".afdimg.com/rc/getimg?rid=" + url+",");
//				}
//				pw.print(getRight(fullUrl.substring(0, fullUrl.length()-1)));
//			} catch (Exception e) {
//				logger.info("上传文件失败！",e);
//				if(pw != null){
//					pw.println(getError("上传文件失败。"));
//				}
//			} finally {
//				if(pw != null){
//					pw.close();
//				}
//			}
//		}
//	}
//
//	private String getError(String message) {
//		JSONObject obj = new JSONObject();
//		obj.put("error", 1);
//		obj.put("message", message);
//		return obj.toJSONString();
//	}
//	
//	private String getRight(String message) {
//		JSONObject obj = new JSONObject();
//		obj.put("error", 0);
//		obj.put("url", message);
//		return obj.toJSONString();
//	}
//	
//	//设置类目名称
//	private void setCateAllName(List<BrandBcVO> list){
//		if(list!=null && list.size()>0){
//			BaseCategory bc = null;
//			for(BrandBcVO bbv : list){
//				if(bbv.getBcId() != null){
//					if((bc!=null && bc.getBcId().intValue()!=bbv.getBcId()) || bc==null){
//						bc = this.cateogryService.getByBcId(bbv.getBcId());
//					}
//					if(bc != null){
//						bbv.setBcName(bc.getPathName().replace('|', '/')+'/'+bc.getBcName());
//					}
//				}
//			}
//		}
//	}
//}
