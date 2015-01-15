package com.afd.boss.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.afd.boss.util.PageUtils;
import com.afd.boss.util.PageUtils.PageInfo;
import com.afd.common.mybatis.Page;
import com.afd.common.util.DateUtils;
import com.afd.constants.SystemConstants;
import com.afd.model.product.AttrAttrValue;
import com.afd.model.product.Attribute;
import com.afd.model.product.AttributeValue;
import com.afd.model.product.BcAttrValue;
import com.afd.model.product.BcAttribute;
import com.afd.model.product.vo.AttrAttrValueVO;
import com.afd.model.product.vo.BcAttrValueVO;
import com.afd.model.product.vo.BcAttributeVO;
import com.afd.service.product.IAttributeService;
import com.afd.service.product.ICategoryService;
import com.afd.staff.model.TStaff;
import com.google.common.collect.Maps;

@Controller
public class AttrValueController {
	protected final static Logger logger = LoggerFactory.getLogger(AttrValueController.class);
	
	@Resource(name="dubbo_categoryService")
	private ICategoryService cateogryService;
	
	@Autowired
	private IAttributeService attributeService;
	
	@RequestMapping("/attr/list")
	public String getAttrsByPage(HttpServletRequest request){
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
				//pageInfo.getConditions().put("order", "DESC"); // 默认降序
			}
		}

		request.setAttribute("pageInfo", pageInfo);
		
		// 查询
		Map<String, Object> map = Maps.newHashMap();

		map.put("status", SystemConstants.DB_STATUS_VALID);
		
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("name"))) {
			map.put("attrName", pageInfo.getConditions().get("name").trim());
		}
		
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("pinyin"))) {
			map.put("pinyin", pageInfo.getConditions().get("pinyin").trim());
		}
		
		Page<Attribute> attrs = new Page<Attribute>();
		attrs.setCurrentPageNo(pageInfo.getPageNo());	
		
		attrs = this.attributeService.getAttributeByPage(map, attrs);
		
		request.setAttribute("attrs", attrs);
		
		return "attr/attrList";
	}
	
	@RequestMapping("/attrvalue/list")
	public String getAttrvaluesByPage(HttpServletRequest request){
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
				//pageInfo.getConditions().put("order", "DESC"); // 默认降序
			}
		}

		request.setAttribute("pageInfo", pageInfo);
		
		// 查询
		Map<String, Object> map = Maps.newHashMap();

		map.put("status", SystemConstants.DB_STATUS_VALID);
		
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("attrValue"))) {
			map.put("attrValueName", pageInfo.getConditions().get("attrValue").trim());
		}
		
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("pinyin"))) {
			map.put("pinyin", pageInfo.getConditions().get("pinyin").trim());
		}
		
		Page<AttributeValue> attrValues = new Page<>();
		attrValues.setCurrentPageNo(pageInfo.getPageNo());	
		
		attrValues = this.attributeService.getAttributeValueByPage(map, attrValues);
		
		request.setAttribute("attrValues", attrValues);
		
		return "attr/attrValueList";
	}
	
	/**
	 * @param name
	 * @return 0:不存在,1:已存在
	 */
	@RequestMapping("/attr/name/check")
	@ResponseBody
	public int checkAttrName(@RequestParam(value = "name") String attrName,
			@RequestParam(value = "id", defaultValue="0") int id){
		int re = 1;
		Attribute attr = this.attributeService.getAttributeByName(attrName, SystemConstants.DB_STATUS_VALID);
		if(attr==null || (id>0 && attr.getAttrId()==id)){
			re = 0;
		}
		
		return re;
	}
	
	/**
	 * @param name
	 * @return 0:不存在,1:已存在
	 */
	@RequestMapping("/attrvalue/name/check")
	@ResponseBody
	public int checkAttrValueName(@RequestParam(value = "attrValue") String attrValue,
			@RequestParam(value = "id", defaultValue="0") int id){
		int re = 1;
		AttributeValue attributeValue = this.attributeService.getAttributeValueByName(attrValue, SystemConstants.DB_STATUS_VALID);
		if(attributeValue==null || (id>0 && attributeValue.getAttrValueId()==id)){
			re = 0;
		}
		
		return re;
	}
	
	@RequestMapping(value="/attr/add", method=RequestMethod.GET)
	public String addAttrView(){
		return "attr/addAttr";
	}
	
	@RequestMapping(value="/attrvalue/add", method=RequestMethod.GET)
	public String addAttrValueView(){
		return "attr/addAttrValue";
	}
	
	@RequestMapping(value="/attr/add", method=RequestMethod.POST)
	public String addAttrSubmit(@ModelAttribute Attribute attr, 
			HttpServletRequest request, RedirectAttributes reAttrs){
		String re = "attr/addAttr";
		
		if(StringUtils.isEmpty(attr.getAttrName()) || StringUtils.isEmpty(attr.getPinyin())){
			request.setAttribute("warn", "请填写属性名和拼音!");
		}else{
			TStaff staff = (TStaff) SecurityUtils.getSubject().getPrincipal();
			attr.setCreateByDate(DateUtils.currentDate());
			attr.setCreateByName(staff.getLoginName());
			attr.setStatus(SystemConstants.DB_STATUS_VALID);
			
			try {
 				long attrId = this.attributeService.insertAttribute(attr);
				if(attrId > 0){
					//保存成功跳转到关联属性值页
					reAttrs.addFlashAttribute("attr", attr);
					re = "redirect:/attr/bind/value?attrId="+attrId;
				}else{
					request.setAttribute("warn", "保存失败!");
				}
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("warn", "保存失败!");
			}		
		}
		
		return re;
	}
	
	@RequestMapping(value="/attrvalue/add", method=RequestMethod.POST)
	public String addAttrValueSubmit(@ModelAttribute AttributeValue attrValue, RedirectAttributes reAttrs){
		int re = 0;
		
		if(StringUtils.isEmpty(attrValue.getAttrValueName()) || StringUtils.isEmpty(attrValue.getPinyin())){
			re = -1;
		}else{
			TStaff staff = (TStaff) SecurityUtils.getSubject().getPrincipal();
			attrValue.setCreateByDate(DateUtils.currentDate());
			attrValue.setCreateByName(staff.getLoginName());
			attrValue.setStatus(SystemConstants.DB_STATUS_VALID);
			
			try {
				long attrValueId = this.attributeService.insertAttributeValue(attrValue);
				if(attrValueId > 0){
					re = 1;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}		
		}
		reAttrs.addFlashAttribute("re", re);
		
		return "redirect:/attrvalue/add";
	}

	@RequestMapping(value="/attr/update", method=RequestMethod.GET)
	public String modAttrView(@RequestParam(value = "attrId") Long attrId, Model model){
		if(attrId > 0){
			Attribute attr = this.attributeService.getAttributeById(attrId);
			model.addAttribute("attr", attr);
		}else{
			model.addAttribute("warn", "请选择有效的属性!");
		}
		
		return "attr/modAttr";
	}
	
	@RequestMapping(value="/attrvalue/update", method=RequestMethod.GET)
	public String modAttrValueView(@RequestParam(value = "attrValueId") Long attrValueId, Model model){
		if(attrValueId > 0){
			AttributeValue attrValue = this.attributeService.getAttributeValueById(attrValueId);
			model.addAttribute("attrValue", attrValue);
		}else{
			model.addAttribute("warn", "请选择有效的属性值!");
		}
		
		return "attr/modAttrValue";
	}
	
	/**
	 * @param attr
	 * @return 1:修改成功,0:失败
	 */
	@RequestMapping(value="/attr/update", method=RequestMethod.POST)
	public String modAttrSubmit(@ModelAttribute Attribute attr){
		TStaff staff = (TStaff) SecurityUtils.getSubject().getPrincipal();
		attr.setLastUpdateByDate(DateUtils.currentDate());
		attr.setLastUpdateByName(staff.getLoginName());
		
		this.attributeService.updateAttributeById(attr);
		
		return  "redirect:/attr/list";
	}
	
	/**
	 * @param attr
	 * @return 1:修改成功,0:失败
	 */
	@RequestMapping(value="/attrvalue/update", method=RequestMethod.POST)
	public String modAttrSubmit(@ModelAttribute AttributeValue attrValue){
		TStaff staff = (TStaff) SecurityUtils.getSubject().getPrincipal();
		attrValue.setLastUpdateByDate(DateUtils.currentDate());
		attrValue.setLastUpdateByName(staff.getLoginName());
		
		this.attributeService.updateAttributeValueById(attrValue);
		
		return "redirect:/attrvalue/list";
	}
	
	/**
	 * @param attr
	 * @return 1:成功,0:失败,-1:属性已关联类目不能删除
	 */
	@ResponseBody
	@RequestMapping(value="/attr/delete", method=RequestMethod.POST)
	public int deleteAttrSubmit(@RequestParam(value = "attrId") Long attrId){
		return this.attributeService.deleteAttributeById(attrId);
	}
	
	/**
	 * @param attr
	 * @return 1:成功,0:失败,-1:属性值已关联属性不允许删除
	 */
	@ResponseBody
	@RequestMapping(value="/attrvalue/delete", method=RequestMethod.POST)
	public int deleteAttrValueSubmit(@RequestParam(value = "attrValueId") Long attrValueId){
		return this.attributeService.deleteAttributeValueById(attrValueId);
	}
			
	
	/**
	 * 属性名和属性值关联页
	 * @param attrId 属性ID
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/attr/bind/value", method=RequestMethod.GET)
	public String bindAttrValueView(@RequestParam(value = "attrId") Long attrId, Model model){
		if(attrId > 0){
			Attribute attr = this.attributeService.getAttributeById(attrId);
			if(attr != null){
				if(SystemConstants.DB_STATUS_VALID.equals(attr.getStatus())){
					model.addAttribute("attr", attr);
					
					List<AttrAttrValueVO> attrAttrValues = this.attributeService.getAttrAttrValueByAttrId(attrId, false);
					model.addAttribute("avList", attrAttrValues);
				}else{
					model.addAttribute("warn", "请选择有效的属性关联!");
				}
			}else{
				model.addAttribute("warn", "请选择有效的属性关联!");
			}
		}else{
			model.addAttribute("warn", "请选择有效的属性关联!");
		}
		
		return "attr/attrValueBind";
	}
	
	/**
	 * 通过属性名和属性值关系ID获取子类属性值
	 * @param pAAvId 属性名和属性值关系ID
	 * @return
	 */
	@RequestMapping(value="/attr/sub/value", method=RequestMethod.POST)
	@ResponseBody
	public List<AttrAttrValueVO> getSubAttrVlue(@RequestParam(value = "attrValueId") Long pAAvId){
		 return this.attributeService.getAttrAttrValueByPAAvId(pAAvId);
	}
	
	@RequestMapping(value="/attr/value", method=RequestMethod.POST)
	@ResponseBody
	public List<AttrAttrValueVO> getAttrVlue(@RequestParam(value = "attrId") Long attrId){
		return this.attributeService.getAttrAttrValueByAttrId(attrId, true);
	}
	
	/**
	 * 增加属性和属性值关系包括子关系
	 * @param aav
	 * @return ID:成功,0:失败,-1:已存在
	 */
	@RequestMapping(value="/attr/add/attrValue", method=RequestMethod.POST)
	@ResponseBody
	public Long addAttrAttrrValue(@ModelAttribute AttrAttrValue aav, @RequestParam(value = "attrValue") String attrValue, @RequestParam(value = "pinyin") String pinyin){
		AttributeValue attributeValue = this.attributeService.getAttributeValueByName(attrValue, SystemConstants.DB_STATUS_VALID);
		Long attrValueId = 0l;
		
		//属性值 不存在 新增加
		if(attributeValue == null){
			attributeValue = new AttributeValue();
			attributeValue.setAttrValueName(attrValue);
			attributeValue.setPinyin(pinyin);
			TStaff staff = (TStaff) SecurityUtils.getSubject().getPrincipal();
			attributeValue.setCreateByDate(DateUtils.currentDate());
			attributeValue.setCreateByName(staff.getLoginName());
			attributeValue.setStatus(SystemConstants.DB_STATUS_VALID);
			
			attrValueId = this.attributeService.insertAttributeValue(attributeValue);
		}else{
			attrValueId = attributeValue.getAttrValueId();
		}
		aav.setAttrValueId(attrValueId);
		
		Long re = 0l;
		//一级属性属性值关系		
		if(attrValueId>0 && aav.getAttrId()>0){
			
			AttrAttrValue tmp = this.attributeService.getAttrAttrValueByAttrIdAndAVId(aav.getAttrId(), attrValueId);
			if(tmp == null){
				re = this.attributeService.insertAttrAttrValue(aav);
			}else{
				re = -1l;
			}
		}else if(attrValueId>0 && aav.getpAAvId()>0){//子级属性属性值 关系
			AttrAttrValue tmp = this.attributeService.getAttrAttrValueByPAAvIdAndAVId(aav.getpAAvId(), attrValueId);
			if(tmp == null){
				re = this.attributeService.insertAttrAttrValue(aav);
				
				//如果关系保存成功，并且该关系有父属性值，则检查父属性和值关系的子状态是否为真
				if(re > 0){
					AttrAttrValue attrAttrValue = this.attributeService.getAttrAttrValueById(aav.getpAAvId());
					if(!attrAttrValue.getHasSub()){
						attrAttrValue.setHasSub(true);
						this.attributeService.updateAttrAttrValueById(attrAttrValue);
					}
				}
			}else{
				re = -1l;
			}
		}
		
		return re;
	}
	
	/**
	 * 删除属性和属性名关系
	 * @param aAvId
	 * @return 1:成功,0:失败
	 */
	@RequestMapping(value="/attr/del/attrValue", method=RequestMethod.POST)
	@ResponseBody
	public int deleteAttrAttrrValue(@RequestParam(value = "attrAttrValueId") Long aAvId, @RequestParam(value = "sub") boolean sub){
		return this.attributeService.deleteAttrAttrValueById(aAvId, sub)?1:0;
	}
	
	/**
	 * 删除属性和属性名关系
	 * @param aAvId
	 * @return 1:成功,0:失败
	 */
	@RequestMapping(value="/attr/del/attrValues", method=RequestMethod.POST)
	@ResponseBody
	public int deleteAttrAttrrValues(@RequestParam(value = "attrAttrValueId") Long... aAvIds){
		for(Long aAvId : aAvIds){
			this.attributeService.deleteAttrAttrValueById(aAvId, true);
		}
		
		return 1;
	}
	
	
	@RequestMapping(value="/cateattr/list", method=RequestMethod.GET)
	public String getBcAttrList(){
		return "attr/bcAttrMain";
	}
	
	@RequestMapping(value="/cateattr/list", method=RequestMethod.POST)
	@ResponseBody
	public List<BcAttributeVO> getBcAttrList(@RequestParam(value = "bcId") Integer bcId){
		List<BcAttributeVO> list = this.cateogryService.getBcAttributeByBcId(bcId, SystemConstants.DB_STATUS_VALID);
		
		return list;
	}
	
	@RequestMapping(value="/cateattr/valuelist", method=RequestMethod.POST)
	@ResponseBody
	public List<BcAttrValueVO> getAttrValueListByBcAttrId(@RequestParam(value = "bcAttrId") Long bcAttrId){
		return this.cateogryService.getBcAttrValueByBcAttrId(bcAttrId, SystemConstants.DB_STATUS_VALID, true);
	}
	
	@RequestMapping(value="/cateattr/subvaluelist", method=RequestMethod.POST)
	@ResponseBody
	public List<BcAttrValueVO> getAttrValueList(@RequestParam(value = "pBcAvId") Long pBcAvId){
		return this.cateogryService.getBcAttrValueByPBcAvId(pBcAvId, SystemConstants.DB_STATUS_VALID);
	}
	
	@RequestMapping(value="/cateattr/update", method=RequestMethod.POST)
	@ResponseBody
	public int modBcAttr(@RequestParam(value = "bcAttrId") Long bcAttrId,
			@RequestParam(value = "value") String value,
			@RequestParam(value = "bcId") Integer bcId,
			@RequestParam(value = "flag") Integer flag){
		int re = 0;
		
		if(bcAttrId > 0){
			BcAttribute bcAttr = new BcAttribute();
			bcAttr.setBcAttrId(bcAttrId);
			bcAttr.setBcId(bcId);
			if(flag == 1){//显示方式:1下拉列表,2:复选框
				bcAttr.setDisplayMode(value);
			}else if(flag == 2){//1:必选
				bcAttr.setIsRequire("1".equals(value));
			}else if(flag == 3){//是否显示:1:是
				bcAttr.setIsFilter("1".equals(value));
			}
			
			re = this.cateogryService.updateBcAttributeById(bcAttr)?1:0;
		}
		
		return re;
	}
	
	@RequestMapping(value="/cateattr/valueupdate", method=RequestMethod.POST)
	@ResponseBody
	public int modBcAttrValue(@RequestParam(value = "bcAvId") Long bcAvId,
			@RequestParam(value = "value") int value,
			@RequestParam(value = "bcId") Integer bcId,
			@RequestParam(value = "flag") Integer flag){
		int re = 0;
		
		if(bcAvId > 0){
			BcAttrValue bcAttrValue = new BcAttrValue();
			bcAttrValue.setBcAvId(bcAvId);
			bcAttrValue.setBcId(bcId);
			
			if(flag == 1){//是否筛选项
				bcAttrValue.setIsFilter(value == 1);
			}else if(flag == 2){//是否标签
				bcAttrValue.setIsMobileDisplay(value == 1);
			}
			
			re = this.cateogryService.updateBcAttrValueById(bcAttrValue)?1:0;
		}
		
		return re;
	}
	
	/**
	 * 类目属性排序
	 * @param sbcaId
	 * @param dbcaId
	 * @return
	 */
	@RequestMapping(value="/cateattr/bcattrorder", method=RequestMethod.POST)
	@ResponseBody
	public boolean modBcAttrOrder(@RequestParam(value = "sbcaId") Long sbcaId, @RequestParam(value = "dbcaId") Long dbcaId){
		return this.cateogryService.updateBcAttributeOrder(sbcaId, dbcaId);
	}
	
	/**
     * @param flag 0:按类目属性关系,1:按父类目属性关系值ID
	 * @param sBcAvId 原ID
	 * @param dBcAvId 目标ID
	 * @return
	 */
	@RequestMapping(value="/cateattr/bcattrvalueorder", method=RequestMethod.POST)
	@ResponseBody
	public boolean modBcAttrValueOrder(@RequestParam(value = "flag") Integer flag, @RequestParam(value = "sBcAvId") Long sBcAvId, @RequestParam(value = "dBcAvId") Long dBcAvId){
		return this.cateogryService.updateBcAttrValueOrders(flag, sBcAvId, dBcAvId);
	}
	
	@RequestMapping("/cateattr/attrlist")
	public String getAttrsJsonByPage(HttpServletRequest request){
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
				//pageInfo.getConditions().put("order", "DESC"); // 默认降序
			}
		}

		request.setAttribute("pageInfo", pageInfo);
		
		// 查询
		Map<String, Object> map = Maps.newHashMap();

		map.put("status", SystemConstants.DB_STATUS_VALID);
		
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("name"))) {
			map.put("attrName", pageInfo.getConditions().get("name"));
		}
		
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("pinyin"))) {
			map.put("pinyin", pageInfo.getConditions().get("pinyin"));
		}
		
		Page<Attribute> attrs = new Page<Attribute>();
		attrs.setCurrentPageNo(pageInfo.getPageNo());	
		
		attrs = this.attributeService.getAttributeByPage(map, attrs);
		
		request.setAttribute("attrs", attrs);
		
		return "attr/bindAttrList";
	}
	
	/**
	 * 增加类目属性关系
	 * @param bcAttr
	 * @return
	 */
	@RequestMapping(value="/cateattr/bcattrbind", method=RequestMethod.POST)
	@ResponseBody
	public Long bcAttrBind(@ModelAttribute BcAttribute bcAttr){
		return this.cateogryService.insertBcAttribute(bcAttr);
	}
	
	/**
	 * 增加类目属性的值和子值的关系
	 * @param bcAttrValue
	 * @return
	 */
	@RequestMapping(value="/cateattr/bcattrvaluebind", method=RequestMethod.POST)
	@ResponseBody
	public Long bcAttrValueBind(@ModelAttribute BcAttrValue bcAttrValue, 
			@RequestParam(value = "attrId",defaultValue="0") Long attrId, 
			@RequestParam(value = "pValId",defaultValue="0") Long pValId){
		
		return this.cateogryService.insertBcAttrValue(bcAttrValue, attrId, pValId);
	}
	
	/**
	 * 删除类目属性关系
	 * @param bcAttrId
	 * @return
	 */
	@RequestMapping(value="/cateattr/bcattrunbind", method=RequestMethod.POST)
	@ResponseBody
	public int bcAttrUnbind(@RequestParam(value = "bcAttrId") Long... bcAttrIds){
		return this.cateogryService.deleteBcAttributeById(bcAttrIds);
	}
	
	/**
	 * 删除类目属性值关系
	 * @param bcAvId
	 * @return
	 */
	@RequestMapping(value="/cateattr/bcattrvalueunbind", method=RequestMethod.POST)
	@ResponseBody
	public int bcAttrValueUnbind(@RequestParam(value = "bcAvId") Long bcAvId){
		return this.cateogryService.deleteBcAttrValueById(bcAvId);
	}
	 
}
