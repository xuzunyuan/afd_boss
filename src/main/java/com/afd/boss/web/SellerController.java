/**
 * Copyright (c)2013-2014 by www.yiwang.com. All rights reserved.
 * 
 */
package com.afd.boss.web;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.afd.boss.util.PageUtils;
import com.afd.boss.util.PageUtils.PageInfo;
import com.afd.common.mybatis.Page;
import com.afd.common.util.DateUtils;
import com.afd.model.seller.SellerApply;
import com.afd.service.seller.ISellerApplyService;
import com.google.common.collect.Maps;

/**
 * 卖家管理
 * 
 * @author xuzunyuan
 * @date 2014年1月16日
 */
@Controller
public class SellerController {
	@Autowired
	ISellerApplyService applyService;

	/**
	 * 申请列表页面
	 * 
	 * @return
	 */
	@RequestMapping("/seller/audit")
	public String sellerAudit(HttpServletRequest request) {
		// 处理分页信息
		PageInfo pageInfo = null;

		if (request.getParameter("query") != null) { // 查询
			pageInfo = PageUtils.registerPageInfo(request);

		} else if (request.getParameter("pageNo") != null) { // 分页
			int pageNo = (int) ConvertUtils.convert(
					request.getParameter("pageNo"), int.class);

			pageInfo = PageUtils.getPageInfo(request);
			pageInfo.setPageNo(pageNo);

		} else {
			pageInfo = PageUtils.getPageInfo(request);

			if (pageInfo == null) {
				pageInfo = PageUtils.registerPageInfo(request);
			}
		}

		request.setAttribute("pageInfo", pageInfo);

		// 查询
		Map<String, Object> map = Maps.newHashMap();

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("loginName"))) {
			map.put("loginName", pageInfo.getConditions().get("loginName"));
		}

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("coName"))) {
			map.put("coName", pageInfo.getConditions().get("coName"));
		}

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("startDt"))) {
			map.put("startDt", DateUtils.parseDate(pageInfo.getConditions()
					.get("startDt"), DateUtils.PART_TIME_PATTERN));
		}

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("endDt"))) {
			Date endDt = DateUtils.parseDate(
					pageInfo.getConditions().get("endDt"),
					DateUtils.PART_TIME_PATTERN);

			endDt = DateUtils.addDay(endDt, 1);

			map.put("endDt", endDt);
		}

		Page<SellerApply> applysPage = applyService.queryWaitAuditApply(map,
				pageInfo.getPageNo(), 20);

		request.setAttribute("applysPage", applysPage);

		return "/seller/auditList";
	}

	/**
	 * 审核详情页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/seller/auditPage")
	public String sellerAuditP(HttpServletRequest request) {
		/**
		 * Long appId = (Long)
		 * ConvertUtils.convert(request.getParameter("appId"), Long.class);
		 * 
		 * SellerApply apply = applyService.getSellerApplyById(appId);
		 * request.setAttribute("apply", apply);
		 * 
		 * SellerLogin login =
		 * loginService.getLoginById(apply.getSellerLoginId());
		 * request.setAttribute("login", login);
		 * 
		 * if (apply.getDistrictId() != null && apply.getDistrictId() > 0) { //
		 * 准备所在地区数据 String cityName = addressService.getGeoById(
		 * apply.getProvinceId().longValue()).getGeoName() + "   " +
		 * addressService.getGeoById(apply.getCityId().longValue())
		 * .getGeoName() + "   " + addressService.getGeoById(
		 * apply.getDistrictId().longValue()).getGeoName();
		 * 
		 * request.setAttribute("cityName", cityName); }
		 * 
		 * // 个人 if (SellerApply$Status.PERSONAL == apply.getApplyType()) { //
		 * 准备身份证图片数据 String[] url = apply.getCertUrl().split("\\|");
		 * request.setAttribute("frontUrl", url[0]);
		 * request.setAttribute("backUrl", url[1]); if (url.length > 2) {
		 * request.setAttribute("pic", url[2]); } } else if
		 * (SellerApply$Status.BUSINESS == apply.getApplyType()) { // 资质图片
		 * String[] url = apply.getbCertUrl().split("\\|");
		 * request.setAttribute("url", url);
		 * 
		 * // 准备银行所在地区数据 if (apply.getBranchDistrictId() != null) { String
		 * bankCityName = addressService.getGeoById(
		 * apply.getBranchProvinceId().longValue()).getGeoName() + "   " +
		 * addressService.getGeoById( apply.getBranchCityId().longValue())
		 * .getGeoName() + "   " + addressService.getGeoById(
		 * apply.getBranchDistrictId().longValue()) .getGeoName();
		 * 
		 * request.setAttribute("bankCityName", bankCityName); }
		 * 
		 * // 申请资质列表 List<SellerApplyQuali> qualis =
		 * applyService.selectByApplyId(appId); request.setAttribute("qualis",
		 * qualis); }
		 * 
		 * // 准备签约品类数据 Collection<ContractCategory> coll =
		 * this.getContractCategory(apply .getCcIds());
		 * request.setAttribute("ccs", coll);
		 * 
		 * // 审核历史数据 List<SellerAudit> audits =
		 * applyService.getAuditList(apply.getAppId());
		 * request.setAttribute("audits", audits);
		 **/
		return "/seller/auditPage";
	}

	/**
	 * 审核通过/驳回
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/seller/auditOp")
	@ResponseBody
	public int sellerAuditOp(HttpServletRequest request) {
		/**
		 * Long appId = NumberUtils.toLong(request.getParameter("appId")); //
		 * 1:通过,otherwise:拒绝 int flag =
		 * NumberUtils.toInt(request.getParameter("flg")); // 1:基本资料,2:店铺资料 char
		 * auditType = CharUtils.toChar(request.getParameter("auditType"),
		 * SellerApply$Status.BASE_INFO);
		 * 
		 * TStaff staff = (TStaff) SecurityUtils.getSubject().getPrincipal();
		 * int ret = 0;
		 * 
		 * // 1:通过 if (flag == 1) { ret = applyService.passSellerApply(appId,
		 * auditType, staff .getRealName(), RequestUtils.getRemoteAddr(request),
		 * StringUtils.defaultString(request.getParameter("opinion"), "审核通过"));
		 * } else { ret = applyService.rejectSellerApply(appId, auditType,
		 * staff.getRealName(), RequestUtils.getRemoteAddr(request),
		 * request.getParameter("opinion")); }
		 **/
		return 0;
	}

}
