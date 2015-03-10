/**
 * Copyright (c)2015-? by www.afd.com. All rights reserved.
 * 
 */
package com.afd.boss.web;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.afd.boss.util.PageUtils;
import com.afd.boss.util.PageUtils.PageInfo;
import com.afd.common.mybatis.Page;
import com.afd.common.util.DateUtils;
import com.afd.model.order.LogisticsCompany;
import com.afd.model.product.BrandShow;
import com.afd.service.order.ILogisticsCompanyService;
import com.afd.service.product.IBrandShowService;
import com.afd.service.seller.ISellerRetAddrService;
import com.afd.service.user.IGeoService;
import com.afd.staff.model.TStaff;
import com.google.common.collect.Maps;

/**
 * 专场审核
 * 
 * @author xuzunyuan
 * @date 2015年3月9日
 */
@Controller
@RequestMapping("/brandShow")
public class BrandShowController {
	@Autowired
	IBrandShowService brandShowService;

	@Autowired
	IGeoService geoService;

	@Autowired
	private ILogisticsCompanyService logicticsCompanyService;

	@Autowired
	ISellerRetAddrService sellerRetAddrService;

	/**
	 * 审核列表页面
	 * 
	 * @return
	 */
	@RequestMapping("/auditList")
	public String auditList(HttpServletRequest request) {
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

		// 查询条件
		Map<String, Object> cond = Maps.newHashMap();

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("startDt"))) {
			cond.put("startDt", DateUtils.parseDate(pageInfo.getConditions()
					.get("startDt"), DateUtils.PART_TIME_PATTERN));
		}

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("endDt"))) {
			Date endDt = DateUtils.parseDate(
					pageInfo.getConditions().get("endDt"),
					DateUtils.PART_TIME_PATTERN);

			endDt = DateUtils.addDay(endDt, 1);

			cond.put("endDt", endDt);
		}

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("brandName"))) {
			cond.put("brandName", pageInfo.getConditions().get("brandName"));
		}

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("title"))) {
			cond.put("title", pageInfo.getConditions().get("title"));
		}

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("coName"))) {
			cond.put("coName", pageInfo.getConditions().get("coName"));
		}

		Page<BrandShow> brandShowPage = brandShowService
				.queryWaitAuditBrandShowByPage(cond, pageInfo.getPageNo());
		request.setAttribute("brandShowPage", brandShowPage);

		return "/brandShow/auditList";
	}

	/**
	 * 审核列表页面
	 * 
	 * @return
	 */
	@RequestMapping("/auditPage")
	public String auditPage(HttpServletRequest request,
			@RequestParam("brandShowId") int brandShowId) {

		BrandShow brandShow = brandShowService.getBrandShowById(brandShowId);

		request.setAttribute("brandShow", brandShow);
		request.setAttribute("brandShowDetailList",
				brandShowService.getDetailsOfBrandShow(brandShowId));

		// 退货地址
		request.setAttribute("retAddr",
				sellerRetAddrService.getAddrById(brandShow.getsRAId()));

		// 发货城市
		request.setAttribute("deliverCity",
				geoService.getGeoById(brandShow.getDeliverCity()));

		// 快递公司
		String[] sLcId = brandShow.getLogisticsCompId();
		if (sLcId != null && sLcId.length > 0) {
			LogisticsCompany[] lc = new LogisticsCompany[sLcId.length];

			for (int i = 0; i < sLcId.length; i++) {
				long lcId = (long) ConvertUtils.convert(sLcId[i], long.class);
				LogisticsCompany company = logicticsCompanyService
						.getLogisticsCompanyById(lcId);

				lc[i] = company;
			}

			request.setAttribute("lc", lc);
		}

		return "/brandShow/auditPage";
	}

	@RequestMapping("/auditPass")
	public String auditPass(HttpServletRequest request, FormData formData) {
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject()
				.getPrincipal();

		brandShowService.passAuditBrandShow(formData.getBrandShowId(),
				DateUtils.parseDate(formData.getStartDate()),
				DateUtils.parseDate(formData.getEndDate()),
				currentStaff.getLoginName(), null);

		return "redirect:/brandShow/auditList";
	}

	@RequestMapping("/auditReject")
	public String auditReject(HttpServletRequest request, FormData formData) {
		TStaff currentStaff = (TStaff) SecurityUtils.getSubject()
				.getPrincipal();

		brandShowService.rejectAuditBrandShow(formData.getBrandShowId(),
				currentStaff.getLoginName(), formData.getAuditContent());

		return "redirect:/brandShow/auditList";
	}

	public static final class FormData {
		private int brandShowId;
		private String startDate;
		private String endDate;
		private String auditContent;

		public String getStartDate() {
			return startDate;
		}

		public void setStartDate(String startDate) {
			this.startDate = startDate;
		}

		public String getEndDate() {
			return endDate;
		}

		public void setEndDate(String endDate) {
			this.endDate = endDate;
		}

		public String getAuditContent() {
			return auditContent;
		}

		public void setAuditContent(String auditContent) {
			this.auditContent = auditContent;
		}

		public int getBrandShowId() {
			return brandShowId;
		}

		public void setBrandShowId(int brandShowId) {
			this.brandShowId = brandShowId;
		}

	}
}
