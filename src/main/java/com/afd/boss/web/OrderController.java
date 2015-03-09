package com.afd.boss.web;


import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.afd.boss.util.PageUtils;
import com.afd.boss.util.PageUtils.PageInfo;
import com.afd.common.mybatis.Page;
import com.afd.common.util.DateUtils;
import com.afd.constants.order.OrderConstants;
import com.afd.model.order.Order;
import com.afd.model.order.OrderItem;
import com.afd.model.order.ReturnOrder;
import com.afd.model.product.BrandShow;
import com.afd.model.seller.SellerRetAddress;
import com.afd.service.order.IOrderService;
import com.afd.service.order.IRetOrderService;
import com.afd.service.product.IBrandShowService;
import com.afd.service.seller.ISellerRetAddrService;
import com.afd.staff.model.TStaff;
import com.google.common.collect.Maps;

@Controller
public class OrderController {
	protected static final Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@Autowired
	private IOrderService orderService;
	@Autowired
	private IRetOrderService retOrderService;
	@Autowired
	private IBrandShowService brandShowService;
	@Autowired
	private ISellerRetAddrService sellerRetAddressService;
	
	/**
	 * @return 0:失败,1:成功
	 */
	@RequestMapping("/order/cancelOrders")
	@ResponseBody
	public int cancelOrders(@RequestParam String cancelReason, @RequestParam Long... orderIds){
		int re = 0;
				
		if(orderIds!=null && orderIds.length>0){
			TStaff staff = (TStaff) SecurityUtils.getSubject().getPrincipal();
			String optName = staff.getRealName();
			
			re = this.orderService.cancelOrderByIds(optName, cancelReason, orderIds);
		}
		
		return re;
	}
	
	@RequestMapping("/order/queryOrder")
	public String queryOrders(HttpServletRequest request){
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
			}
		}

		request.setAttribute("pageInfo", pageInfo);
		
		// 查询
		Map<String, Object> cond = Maps.newHashMap();

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("orderCode"))) {
			cond.put("orderCode", pageInfo.getConditions().get("orderCode"));
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("orderStatus"))) {
			cond.put("orderStatus", pageInfo.getConditions().get("orderStatus"));
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("startDt"))) {
			cond.put("startDt", DateUtils.parseDate(pageInfo.getConditions().get("startDt"), "yyyy-MM-dd"));
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("endDt"))) {
			cond.put("endDt", DateUtils.parseDate(pageInfo.getConditions().get("endDt")+" 23:59:59"));
		}		
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("payStatus"))) {
			cond.put("payStatus", pageInfo.getConditions().get("payStatus"));
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("brandShowTitle"))) {
			cond.put("brandShowTitle", pageInfo.getConditions().get("brandShowTitle"));
		} 
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("userName"))) {
			cond.put("userName", pageInfo.getConditions().get("userName"));
		} 
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("prodTitle"))) {
			cond.put("prodTitle", pageInfo.getConditions().get("prodTitle"));
		} 
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("orderSource"))) {
			cond.put("orderSource", pageInfo.getConditions().get("orderSource"));
		} 
		
		Page<Order> orders = new Page<Order>();
		orders.setCurrentPageNo(pageInfo.getPageNo());	
		
		orders = this.orderService.queryOrderByCondition(cond, orders);
		
		request.setAttribute("orders", orders);
		
		return "order/queryOrder";
	}
	
	@RequestMapping("/order/orderDetail")
	public String orderDetail(@RequestParam Long orderId, ModelMap modelMap){
		Order order = this.orderService.getOrderById(orderId);
		
		List<OrderItem> orderItems = null;
		
		Map<String, Date> mapTemp = new LinkedHashMap<String, Date>();
		
		if(order != null){
			orderItems = this.orderService.getOrderItemsByOrderId(order.getOrderId().intValue());
			
			//订单提交时间
			if(order.getCreatedDate()!=null){
				mapTemp.put("1", order.getCreatedDate());
			}
			//发货时间
			if(order.getSendTime()!=null){
				mapTemp.put("2", order.getSendTime());
			}
			//付款时间
			if(order.getReceiptDate()!=null){
				mapTemp.put("3", order.getReceiptDate());
			}
			//订单取消时间
			if(order.getCancelDate()!=null){
				mapTemp.put("4", order.getCancelDate());
			}
			//妥投时间
			if(order.getSignedTime()!=null){
				mapTemp.put("5", order.getSignedTime());
			}
		}
		
		List<Map.Entry<String, Date>> listTemp = null;
		if(mapTemp!=null&&mapTemp.size()>0){
			listTemp = new ArrayList<Map.Entry<String,Date>>(mapTemp.entrySet());
			Collections.sort(listTemp, new Comparator<Map.Entry<String, Date>>() {   
				public int compare(Map.Entry<String, Date> o1, Map.Entry<String, Date> o2) {      
					return o2.getValue().compareTo(o1.getValue());
				}
			});
		}
		
		modelMap.addAttribute("order", order);
		modelMap.addAttribute("orderItems", orderItems);
		
		if(listTemp!=null && listTemp.size()>0){
			modelMap.addAttribute("record", listTemp);
		}
		
		return "order/orderDetail";
	}
	
	@RequestMapping("/amt/back")
	public String refundList(HttpServletRequest request){
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
			}
		}

		request.setAttribute("pageInfo", pageInfo);
		
		// 查询
		Map<String, Object> cond = Maps.newHashMap();

		if (StringUtils.isNotBlank(pageInfo.getConditions().get("brandShowTitle"))) {
			cond.put("brandShowTitle", pageInfo.getConditions().get("brandShowTitle"));
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("retOrderCode"))) {
			cond.put("retOrderCode", pageInfo.getConditions().get("retOrderCode"));
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("startDate"))) {
			cond.put("startDate", DateUtils.parseDate(pageInfo.getConditions().get("startDate"), "yyyy-MM-dd"));
		}
		if (StringUtils.isNotBlank(pageInfo.getConditions().get("endDate"))) {
			String strEndDate = pageInfo.getConditions().get("endDate")+" 23:59:59";
			cond.put("endDate", DateUtils.parseDate(strEndDate));
		}		
		 
		//确认收到货
		cond.put("status", OrderConstants.order_return_comfirm);
		
		Page<ReturnOrder> retOrders = new Page<>();
		retOrders.setCurrentPageNo(pageInfo.getPageNo());	
		
		retOrders = this.retOrderService.getRetOrdersByPage(cond, retOrders);
		
		request.setAttribute("retOrders", retOrders);
		
		return "order/refundOrder";
	}
	
	@RequestMapping("/amt/refundDetail")
	public String refundDetail(@RequestParam Long retOrderId, ModelMap modelMap){
		if(retOrderId!=null && retOrderId>0){
			ReturnOrder retOrder = this.retOrderService.getRetOrderInfoByRetOrderId(retOrderId);
			modelMap.addAttribute("returnOrder", retOrder);
			
			//退货地址
			BrandShow brandShow = this.brandShowService.getBrandShowById(retOrder.getBrandShowId().intValue());
			if(brandShow!=null && brandShow.getsRAId()>0){
				SellerRetAddress retAddr = this.sellerRetAddressService.getAddrById(brandShow.getsRAId());
				modelMap.addAttribute("retAddr", retAddr);
			}
		}
		
		return "order/refundDetail";
	}
	
	@RequestMapping(value="/amt/refund", method=RequestMethod.POST)
	@ResponseBody
	public int modRetOrder(@RequestParam(value = "retOrderId") Long retOrderId, HttpServletRequest request){
		int re = 0;
		
		if(retOrderId!=null && retOrderId>0){
			ReturnOrder retOrder = new ReturnOrder();
			retOrder.setRetOrderId(retOrderId);		
			retOrder.setStatus(OrderConstants.order_return_refund);
			retOrder.setRefundDate(new Date());
			
			re = this.retOrderService.updateRetOrderByIdSelective(retOrder);
		}
		
		return re;
	}
}
