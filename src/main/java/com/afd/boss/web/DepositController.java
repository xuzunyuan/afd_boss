/**
 * Copyright (c)2013-2014 by www.afd.com. All rights reserved.
 * 
 */
package com.afd.boss.web;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.afd.boss.util.PageUtils;
import com.afd.boss.util.PageUtils.PageInfo;
import com.afd.common.mybatis.Page;
import com.afd.common.util.DateUtils;
import com.afd.model.seller.Seller;
import com.afd.model.seller.SellerApply;
import com.afd.model.seller.SellerAudit;
import com.afd.model.seller.SellerLogin;
import com.afd.service.seller.ISellerApplyService;
import com.afd.service.seller.ISellerLoginService;
import com.afd.service.seller.ISellerService;
import com.afd.staff.model.TStaff;
import com.google.common.collect.Maps;

/**
 * 保证金审核
 * 
 * @author xuzunyuan
 * @date 2014年1月16日
 */
@Controller
public class DepositController {
	@Autowired
	ISellerApplyService applyService;

	@Autowired
	ISellerLoginService loginService;

	@Autowired
	ISellerService sellerService;

	/**
	 * 保证金审核列表页面
	 * 
	 * @return
	 */
	@RequestMapping("/seller/deposit")
	public String sellerDeposit(HttpServletRequest request) {
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

		Page<SellerApply> applysPage = applyService.queryWaitDepositAuditApply(
				map, pageInfo.getPageNo(), 20);

		request.setAttribute("applysPage", applysPage);

		return "/seller/depositList";
	}

	/**
	 * 审核详情页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/seller/depositPage")
	public String sellerDepositPage(HttpServletRequest request,
			@Param("appId") int appId) {

		SellerApply apply = applyService.getSellerApplyById(appId);
		request.setAttribute("apply", apply);

		SellerLogin login = loginService.getLoginById(apply.getSellerLoginId());
		request.setAttribute("login", login);

		Seller seller = sellerService.getSellerById(login.getSellerId());
		request.setAttribute("seller", seller);

		// 审核历史数据
		List<SellerAudit> audits = applyService.getAuditList(apply.getAppId());
		request.setAttribute("audits", audits);

		return "/seller/depositPage";
	}

	/**
	 * 保证金到账确认
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/seller/depositPass")
	public String sellerDepositPass(HttpServletRequest request,
			@Param("sellerId") int sellerId) {

		sellerService.confirmDeposit(sellerId, null, ((TStaff) SecurityUtils
				.getSubject().getPrincipal()).getLoginName());

		return "redirect:/seller/deposit";
	}

}
