package com.afd.boss.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.afd.common.mybatis.Page;
import com.afd.constants.SystemConstants;
import com.afd.model.product.BcSpec;
import com.afd.model.product.BcSpecValue;
import com.afd.model.product.Spec;
import com.afd.model.product.SpecSpecValue;
import com.afd.model.product.SpecValue;
import com.afd.model.product.vo.BcSpecVO;
import com.afd.model.product.vo.SpecSpecValueVO;
import com.afd.service.product.ICategoryService;
import com.afd.service.product.ISpecService;
import com.afd.staff.model.TStaff;

@Controller
public class SpecController {
	protected final static Logger logger = LoggerFactory.getLogger(SpecController.class);
	
	@Resource(name="dubbo_specService")
	private ICategoryService cateogryService;
	
	@Autowired
	private ISpecService specService;

	@RequestMapping("/spec/querySpecs")
	public String querySpecs(@RequestParam(value="specName",required=false) String specName, 
			@RequestParam(value="pinyin",required=false) String pinyin, Page<Spec> page, ModelMap modelMap){
		page.setPageSize(20);
		if(specName != null){
			specName = specName.trim();
		}
		if(pinyin != null){
			pinyin = pinyin.trim();
		}
		HashMap<String, String> condition = new HashMap<String, String>();
		condition.put("status", SystemConstants.DB_STATUS_VALID);
		condition.put("order", "desc");
		condition.put("specName", specName);
		condition.put("pingyin", pinyin);
		page = this.specService.getSpecByPage(condition, page);
		modelMap.addAttribute("page", page);
		modelMap.addAttribute("specName",specName);
		modelMap.addAttribute("pinyin",pinyin);
		return "spec/specList";
	}
	
	@RequestMapping("/spec/addSpec")
	public String addSpec(){
		return "spec/addSpec";
	}
	
	@RequestMapping("/spec/deleteSpec")
	@ResponseBody
	public int deleteSpec(@RequestParam(value="specId",required=true) Long specId){
		int result = this.specService.deleteSpecById(specId);
		return result;
	}
	
	@RequestMapping("/spec/modifySpec")
	public String modifySpec(@RequestParam(value="specId",required=true) Long specId, ModelMap modelMap){
		Spec spec = specService.getSpecById(specId);
		modelMap.put("spec", spec);
		return "spec/modifySpec";
	}
	
	@RequestMapping("/spec/saveSpec")
	@ResponseBody
	public Map<String,Long> saveSpec(@RequestParam(value="specName",required=true) String specName, 
			@RequestParam(value="pinyin",required=true) String pinyin){
		Map<String,Long> map = new HashMap<String,Long>();
		Spec spec = this.specService.getSpecByName(specName, SystemConstants.DB_STATUS_VALID);
		if(null != spec){
			map.put("success", -1l);
			return map;//规格名存在
		}
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject().getPrincipal();
		Date date = new Date();
		Spec newSpec = new Spec();
		newSpec.setSpecName(specName.trim());
		newSpec.setPingyin(pinyin.trim());
		newSpec.setStatus(SystemConstants.DB_STATUS_VALID);
		newSpec.setCreateByDate(date);
		newSpec.setCreateByName(currentStaff.getLoginName());
		newSpec.setLastUpdateByDate(date);
		newSpec.setLastUpdateByName(currentStaff.getLoginName());
		
		Long result = this.specService.insertSpec(newSpec);
		if(result.equals(0l)){
			map.put("success", -2l);
			return map;//插入失败
		}
		map.put("success", 0l);
		map.put("specId", result);
		return map;//插入成功
	}
	
	@RequestMapping("/spec/updateSpec")
	@ResponseBody
	public int updateSpec(@RequestParam(value="specId",required=true) Long specId, 
			@RequestParam(value="specName",required=true) String specName, @RequestParam(value="pinyin",required=true) String pinyin){
		Spec spec = this.specService.getSpecByName(specName, SystemConstants.DB_STATUS_VALID);
		if(null != spec && !specId.equals(spec.getSpecId())){
			return -1;//规格名已存在
		}
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject().getPrincipal();
		Date date = new Date();
		Spec newSpec = new Spec();
		newSpec.setSpecId(specId);
		newSpec.setSpecName(specName.trim());
		newSpec.setPingyin(pinyin.trim());
		newSpec.setLastUpdateByDate(date);
		newSpec.setLastUpdateByName(currentStaff.getLoginName());
		boolean result = this.specService.updateSpecById(newSpec);
		if(!result){
			return -2;//更新失败
		}
		
		return 0;//更新成功
	}

	@RequestMapping("/spec/specSpecValueManage")
	public String specSpecValueManage(@RequestParam(value="specId",required=true) Long specId, ModelMap modelMap){
		Spec spec = this.specService.getSpecById(specId);
		List<SpecSpecValueVO> specSpecValues = this.specService.getSpecSpecValueByspecId(specId);
		int maxDisplayOrder = 0;
		for(SpecSpecValueVO ssvv : specSpecValues){
			if(ssvv.getDisplayOrder() > maxDisplayOrder){
				maxDisplayOrder = ssvv.getDisplayOrder();
			}
		}
		modelMap.put("spec", spec);
		modelMap.put("specSpecValues", specSpecValues);
		modelMap.put("maxDisplayOrder", maxDisplayOrder);
		return "spec/specSpecValue";
	}
	
	@RequestMapping("/spec/addSpecSpecValue")
	@ResponseBody
	public Map<String,Object> addSpecSpecValue(@RequestParam(value="specId",required=true) Long specId,
			@RequestParam(value="specValueName",required=true) String specValueName, 
			@RequestParam(value="svPinyin",required=true) String svPinyin, @RequestParam(value="maxDisplayOrder",required=true) int maxDisplayOrder){
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject().getPrincipal();
		Date date = new Date();		
		List<SpecValue> specValues = this.specService.getSpecValueByName(specValueName.trim(), SystemConstants.DB_STATUS_VALID);
		Long specValueId = 0l;
		SpecValue specValue = new SpecValue();
		if(specValues.size() > 0){
			specValue = specValues.get(0);
			specValueId = specValue.getSpecValueId();
		}else{
			specValue.setSpecValueName(specValueName.trim());
			specValue.setPinyin(svPinyin.trim());
			specValue.setStatus(SystemConstants.DB_STATUS_VALID);
			specValue.setCreateByDate(date);
			specValue.setCreateByName(currentStaff.getLoginName());
			specValue.setLastUpdateByDate(date);
			specValue.setLastUpdateByName(currentStaff.getLoginName());
			specValueId = this.specService.insertSpecValue(specValue);
		}
		SpecSpecValue ssv = new SpecSpecValue();
		ssv.setSpecId(specId);
		ssv.setSpecValueId(specValueId);
		ssv.setDisplayOrder(maxDisplayOrder+1);
		Long ssvId = this.specService.insertSpecSpecValue(ssv);
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("ssvId", ssvId);
		map.put("specValueId", specValueId);
		map.put("specValueName", specValue.getSpecValueName());
		map.put("pinyin", specValue.getPinyin());
		map.put("imgUrl", specValue.getImgUrl());
		map.put("maxDisplayOrder", maxDisplayOrder+1);

		return map;
	}
	
	@RequestMapping("/spec/deleteSpecSpecValue")
	@ResponseBody
	public boolean deleteSpecSpecValue(@RequestParam(value="ssvId",required=true) Long ssvId){
		return this.specService.deleteSpecSpecValueById(ssvId);
	}
	
	@RequestMapping("/spec/deleteSpecSpecValues")
	@ResponseBody
	public int deleteSpecSpecValues(@RequestParam(value="ssvIds",required=true) String ssvIds){
		String[] ssvIdsArr = ssvIds.split(",");
		List<Long> ssvIdList = new ArrayList<Long>();
		if(ssvIdsArr != null && ssvIdsArr.length > 0){
			for(String ssvId : ssvIdsArr){
				ssvIdList.add(Long.parseLong(ssvId));
			}
		}
		return this.specService.deleteSpecSpecValuesById(ssvIdList);
	}
	
	@RequestMapping("/spec/saveSpecValueImgUrl")
	@ResponseBody
	public boolean saveSpecValueImgUrl(@RequestParam(value="specValueId",required=true) Long specValueId, 
			@RequestParam(value="imgUrl",required=true) String imgUrl){
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject().getPrincipal();
		Date date = new Date();
		SpecValue specValue = new SpecValue();
		specValue.setSpecValueId(specValueId);
		specValue.setImgUrl(imgUrl);
		specValue.setLastUpdateByDate(date);
		specValue.setLastUpdateByName(currentStaff.getLoginName());
		return this.specService.updateSpecValueById(specValue);
	}

	@RequestMapping("/specvalue/querySpecValues")
	public String querySpecValues(@RequestParam(value="specValueName",required=false) String specValueName, 
			@RequestParam(value="pinyin",required=false) String pinyin, Page<SpecValue> page, ModelMap modelMap){
		page.setPageSize(20);
		if(specValueName != null){
			specValueName = specValueName.trim();
		}
		if(pinyin != null){
			pinyin = pinyin.trim();
		}
		HashMap<String, String> condition = new HashMap<String, String>();
		condition.put("status", SystemConstants.DB_STATUS_VALID);
		condition.put("order", "desc");
		condition.put("specValueName", specValueName);
		condition.put("pinyin", pinyin);
		page = this.specService.getSpecValueByPage(condition, page);
		modelMap.addAttribute("page", page);
		modelMap.addAttribute("specValueName",specValueName);
		modelMap.addAttribute("pinyin",pinyin);
		return "spec/specValueList";
	}
	
	@RequestMapping("/specvalue/addSpecValue")
	public String addSpecValue(){
		return "spec/addSpecValue";
	}
	
	@RequestMapping("/specvalue/deleteSpecValue")
	@ResponseBody
	public int deleteSpecValue(@RequestParam(value="specValueId",required=true) Long specValueId){
		int result = this.specService.deleteSpecValueById(specValueId);
		return result;
	}
	
	@RequestMapping("/specvalue/modifySpecValue")
	public String modifySpecValue(@RequestParam(value="specValueId",required=true) Long specValueId, ModelMap modelMap){
		SpecValue specValue = this.specService.getSpecValueById(specValueId);
		modelMap.put("specValue", specValue);
		return "spec/modifySpecValue";
	}
	
	@RequestMapping("/specvalue/saveSpecValue")
	@ResponseBody
	public Map<String,Long> saveSpecValue(@RequestParam(value="specValueName",required=true) String specValueName, 
			@RequestParam(value="pinyin",required=true) String pinyin, @RequestParam(value="imgUrl",required=true) String imgUrl){
		Map<String,Long> map = new HashMap<String,Long>();
		List<SpecValue> specValues = specService.getSpecValueByName(specValueName, SystemConstants.DB_STATUS_VALID);
		if(null != specValues && specValues.size() > 0){
			map.put("success", -1l);
			return map;//规格值存在
		}
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject().getPrincipal();
		Date date = new Date();
		SpecValue newSpecValue = new SpecValue();
		newSpecValue.setSpecValueName(specValueName.trim());
		newSpecValue.setPinyin(pinyin.trim());
		newSpecValue.setImgUrl(imgUrl);
		newSpecValue.setStatus(SystemConstants.DB_STATUS_VALID);
		newSpecValue.setCreateByDate(date);
		newSpecValue.setCreateByName(currentStaff.getLoginName());
		newSpecValue.setLastUpdateByDate(date);
		newSpecValue.setLastUpdateByName(currentStaff.getLoginName());
		Long result = specService.insertSpecValue(newSpecValue);
		if(result.equals(0l)){
			map.put("success", -2l);
			return map;//插入失败
		}
		map.put("success", 0l);
		map.put("specValueId", result);
		return map;//插入成功
	}
	
	@RequestMapping("/specvalue/updateSpecValue")
	@ResponseBody
	public int updateSpecValue(@RequestParam(value="specValueId",required=true) Long specValueId, 
			@RequestParam(value="specValueName",required=true) String specValueName, @RequestParam(value="pinyin",required=true) String pinyin, 
			@RequestParam(value="imgUrl",required=true) String imgUrl){
		List<SpecValue> specValues = specService.getSpecValueByName(specValueName.trim(), SystemConstants.DB_STATUS_VALID);
		for(SpecValue specValue : specValues){
			if(!specValueId.equals(specValue.getSpecValueId())){
				return -1;//规格值已存在
			}
		}
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject().getPrincipal();
		Date date = new Date();
		SpecValue newSpecValue = new SpecValue();
		newSpecValue.setSpecValueId(specValueId);
		newSpecValue.setSpecValueName(specValueName.trim());
		newSpecValue.setPinyin(pinyin.trim());
		newSpecValue.setImgUrl(imgUrl);
		newSpecValue.setLastUpdateByDate(date);
		newSpecValue.setLastUpdateByName(currentStaff.getLoginName());
		boolean result = specService.updateSpecValueById(newSpecValue);
		if(!result){
			return -2;//更新失败
		}
		cateogryService.updateBcSpecValueBySpecValueId(specValueId,specValueName.trim(),imgUrl);
		return 0;//更新成功
	}

	@RequestMapping("/catespec/bcSpecManage")
	public String bcSpecManage(){
		return "spec/bcSpec";
	}
	
	@RequestMapping("/catespec/saveBcId")
	@ResponseBody
	public void saveBcId(HttpSession session,@RequestParam(value="bcId",required=true) int bcId){
		session.setAttribute("bcspec_bcid", bcId);
	}
	
	@RequestMapping("/catespec/getBcSpecByBcId")
	@ResponseBody
	public List<BcSpecVO> getBcSpecByBcId(@RequestParam(value="bcId",required=true) int bcId){
		return this.cateogryService.getBcSpecByBcId(bcId, SystemConstants.DB_STATUS_VALID);//根据display_order升序
	}
	
	@RequestMapping("/catespec/getBcSpecValueByBcSpecId")
	@ResponseBody
	public List<BcSpecValue> getBcSpecValueByBcSpecId(@RequestParam(value="bcSpecId",required=true) Long bcSpecId){
		return this.cateogryService.getBcSpecValueByBcSpecId(bcSpecId, SystemConstants.DB_STATUS_VALID);//根据display_order升序
	}
	
	@RequestMapping("/catespec/updateBcSpecOrder")
	@ResponseBody
	public boolean updateBcSpecOrder(@RequestParam(value="sbcsId",required=true) Long sbcsId, @RequestParam(value="dbcsId",required=true) Long dbcsId){
		return this.cateogryService.updateBcSpecOrder(sbcsId, dbcsId);
	}
	
	@RequestMapping("/catespec/updateBcSpecValueOrder")
	@ResponseBody
	public boolean updateBcSpecValueOrder(@RequestParam(value="sbcsvId",required=true) Long sbcsvId, @RequestParam(value="dbcsvId",required=true) Long dbcsvId){
		return this.cateogryService.updateBcSpecValueOrder(sbcsvId, dbcsvId);
	}
	
	@RequestMapping("/catespec/updateBcSpecFilter")
	@ResponseBody
	public boolean updateBcSpecFilter(@RequestParam(value="bcSpecId",required=true) Long bcSpecId, @RequestParam(value="isFilter",required=true) boolean isFilter){
		BcSpec bcSpec = this.cateogryService.getBcSpecById(bcSpecId);
		bcSpec.setIsFilter(isFilter);
		return this.cateogryService.updateBcSpecById(bcSpec);
	}
	
	@RequestMapping("/catespec/updateBcSpecValueFilter")
	@ResponseBody
	public boolean updateBcSpecValueFilter(@RequestParam(value="bcSpecValueId",required=true) Long bcSpecValueId, @RequestParam(value="isFilter",required=true) boolean isFilter){
		BcSpecValue bcSpecValue = this.cateogryService.getBcSpecValueById(bcSpecValueId);
		bcSpecValue.setIsFilter(isFilter);
		return this.cateogryService.updateBcSpecValueById(bcSpecValue);
	}
	
	@RequestMapping("/catespec/updateBcSpecValueIsMD")
	@ResponseBody
	public boolean updateBcSpecValueIsMD(@RequestParam(value="bcSpecValueId",required=true) Long bcSpecValueId, @RequestParam(value="isMobileDisplay",required=true) boolean isMobileDisplay){
		BcSpecValue bcSpecValue = this.cateogryService.getBcSpecValueById(bcSpecValueId);
		bcSpecValue.setIsMobileDisplay(isMobileDisplay);
		return this.cateogryService.updateBcSpecValueById(bcSpecValue);
	}
	
	@RequestMapping("/catespec/deleteBcSpecValue")
	@ResponseBody
	public boolean deleteBcSpecValue(@RequestParam(value="bcSpecValueId",required=true) Long bcSpecValueId){
		return this.cateogryService.deleteBcSpecValueById(bcSpecValueId);
	}
	
	@RequestMapping("/catespec/deleteBcSpec")
	@ResponseBody
	public boolean deleteBcSpec(@RequestParam(value="bcSpecId") Long bcSpecId){
		return this.cateogryService.deleteBcSpecByIdForce(bcSpecId);
	}
	
	@RequestMapping("/catespec/deleteBcSpecs")
	@ResponseBody
	public boolean deleteBcSpecs(@RequestParam(value="bcSpecIds") String bcSpecIds){
		boolean result = true;
		String bcSpecIdArr[] = bcSpecIds.split(",");
		for(String bcSpecId : bcSpecIdArr){
			if(!this.cateogryService.deleteBcSpecByIdForce(Long.parseLong(bcSpecId))){
				result = false;
			}
		}
		return result;
	}
	
	@RequestMapping("/catespec/selectSpecs")
	public String selectSpecs(@RequestParam(value="specName",required=false) String specName,
			@RequestParam(value="pingyin",required=false) String pingyin, Page<Spec> page, ModelMap modelMap){
		if(specName != null){
			specName = specName.trim();
		}
		if(pingyin != null){
			pingyin = pingyin.trim();
		}
		Map<String,String> condition = new HashMap<String,String>();
		condition.put("specName", specName);
		condition.put("pingyin", pingyin);
		condition.put("status", SystemConstants.DB_STATUS_VALID);
		condition.put("order", "desc");

		page = this.specService.getSpecByPage(condition, page);
		modelMap.put("page", page);
		modelMap.put("specName", specName);
		modelMap.put("pingyin", pingyin);
		return "spec/selectSpecs";
	}
	
	@RequestMapping("/catespec/getSpecValuesBySpecId")
	@ResponseBody
	public List<SpecSpecValueVO> getSpecValuesBySpecId(@RequestParam(value="specId",required=true) Long specId){
		return this.specService.getSpecSpecValueByspecId(specId);
	}
	
	@RequestMapping("/catespec/addBcSpec")
	@ResponseBody
	public Long addBcSpec(HttpSession session,@RequestParam(value="specId",required=true) Long specId){
		int bcId = (Integer)session.getAttribute("bcspec_bcid");
		if(bcId <= 0){
			return 0l;
		}
		List<BcSpecVO> bcSpecs = this.cateogryService.getBcSpecByBcId(bcId, SystemConstants.DB_STATUS_VALID);//根据display_order升序
		int maxDisplayOrder = 0;
		if(bcSpecs != null && !bcSpecs.isEmpty()){
			maxDisplayOrder = bcSpecs.get(bcSpecs.size()-1).getDisplayOrder();
			for(BcSpecVO bcSpec : bcSpecs){
				if(specId.equals(bcSpec.getSpecId())){
					return bcSpec.getBcSpecId();
				}
			}
		}
		BcSpec newBcSpec = new BcSpec();
		newBcSpec.setBcId(bcId);
		newBcSpec.setDisplayOrder(++maxDisplayOrder);
		newBcSpec.setIsFilter(true);
		newBcSpec.setSpecId(specId);
		newBcSpec.setStatus(SystemConstants.DB_STATUS_VALID);
		return this.cateogryService.insertBcSpec(newBcSpec);
	}
	
	@RequestMapping("/catespec/addBcSpecValue")
	@ResponseBody
	public Long addBcSpecValue(HttpSession session,@RequestParam(value="specId",required=true) Long specId,
			@RequestParam(value="specValueId",required=true) Long specValueId){
		int bcId = (Integer)session.getAttribute("bcspec_bcid");
		if(bcId <= 0){
			return 0l;
		}
		Long bcSpecId = this.addBcSpec(session, specId);
		List<BcSpecValue> bcSpecValues = this.cateogryService.getBcSpecValueByBcSpecId(bcSpecId, SystemConstants.DB_STATUS_VALID);//根据display_order升序
		int maxDisplayOrder = 0;
		if(bcSpecValues != null && !bcSpecValues.isEmpty()){
			maxDisplayOrder = bcSpecValues.get(bcSpecValues.size()-1).getDisplayOrder();
			for(BcSpecValue bcSpecValue : bcSpecValues){
				if(specValueId.equals(bcSpecValue.getSpecValueId())){
					return bcSpecValue.getBcSvId();
				}
			}
		}
		SpecValue specValue = this.specService.getSpecValueById(specValueId);
		BcSpecValue newBcSpecValue = new BcSpecValue();
		newBcSpecValue.setBcId(bcId);
		newBcSpecValue.setBcSpecId(bcSpecId);
		newBcSpecValue.setDisplayOrder(++maxDisplayOrder);
		newBcSpecValue.setImgUrl(specValue.getImgUrl());
		newBcSpecValue.setIsFilter(true);
		newBcSpecValue.setIsMobileDisplay(true);
		newBcSpecValue.setmDisplayPosition(0);
		newBcSpecValue.setSpecValueId(specValueId);
		newBcSpecValue.setSpecValueName(specValue.getSpecValueName());
		newBcSpecValue.setStatus(SystemConstants.DB_STATUS_VALID);
		return this.cateogryService.insertBcSpecValue(newBcSpecValue);
	}
}
