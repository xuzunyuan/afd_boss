<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>专场审核-巨友利</title>
</head>
<body>

<script type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>	

<!-- foldbarV -->
<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
<!-- foldbarV end -->

<div class="mod-info info-details">
	<dl>
		<dt><img style="width:80px;height:80px;" src="${my:random(imgGetUrl).concat(brandShow.showBannerImg)}"/></dt>
		<dd>
			<p>活动名称：<b><c:out value="${brandShow.title}"/></b></p>
			<p>活动类型：品牌特卖</p>
			<p>公司名称：<c:out value="${brandShow.coName}"/></p>
			<p>申请时间：<fmt:formatDate value="${brandShow.createByDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
			<p>活动状态：<em><c:choose>
					<c:when test="${brandShow.status == '1'}">进行中</c:when>
					<c:when test="${brandShow.status == '2'}">结束</c:when>
					<c:when test="${brandShow.status == '3'}">异常终止</c:when>
					<c:when test="${brandShow.status == '4'}">编辑中</c:when>
					<c:when test="${brandShow.status == '5'}">待审核</c:when>
					<c:when test="${brandShow.status == '6'}">审核中</c:when>
					<c:when test="${brandShow.status == '7'}">等待上线</c:when>
					<c:when test="${brandShow.status == '8'}">驳回</c:when>				
				</c:choose></em></p>
		</dd>
	</dl>
</div>
<!-- sellerData -->
	<div class="sellerData zc-details">
		<div class="tab">
			<div class="tabs">
				<ul>
					<li class="on" tabId="1">活动规则</li>
					<li tabId="2">活动商品</li>
				</ul>
			</div>
			<div class="tabbed">
				<div class="tabGroup block" tabId="1">
					<form class="form formA">
						<fieldset>
							<div class="legend"><h3>专场信息</h3></div>
							<div class="formBox">
								<dl class="item">
									<dt class="item-label">
										<label>品牌名称：</label>
									</dt>
									<dd class="item-cont">
										<p><c:out value="${brandShow.brandName}"/></p>
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>专场页Banner：</label>
									</dt>
									<dd class="item-cont">
										<div class="item-prve"><img style="width:497px;height:96px;" src="${my:random(imgGetUrl).concat(brandShow.showBannerImg)}"/></div>
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>首页Banner：</label>
									</dt>
									<dd class="item-cont">
										<div class="item-prve"><img style="width:215px;height:86px;" src="${my:random(imgGetUrl).concat(brandShow.homeBannerImg)}&op=s0_w468_h240"/></div>
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>专场页背景色：</label>
									</dt>
									<dd class="item-cont">
										<p><c:out value="${brandShow.bgColor}"/></p>
									</dd>
								</dl>
							</div>
						</fieldset>
						<fieldset class="last">
							<div class="legend"><h3>服务信息</h3></div>
							<div class="formBox">
								<dl class="item">
									<dt class="item-label">
										<label>专场退货地址：</label>
									</dt>
									<dd class="item-cont">
										<p><c:out value="${retAddr.provinceName}"/><c:out value="${retAddr.cityName}"/><c:out value="${retAddr.districtName}"/><c:out value="${retAddr.townName}"/>
										   <c:out value="${retAddr.addr}"/>
							               （<c:out value="${retAddr.zipCode}"/>）
							               <c:out value="${retAddr.receiver}"/>
							               <c:out value="${retAddr.mobile}"/>
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>客服QQ：</label>
									</dt>
									<dd class="item-cont">
										<p>${fn:replace(brandShow.serviceQq, ',', '&nbsp;&nbsp;')}</p>
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>客服电话：</label>
									</dt>
									<dd class="item-cont">
										<p>${fn:replace(brandShow.serviceTel, ',', '&nbsp;&nbsp;')}</p>
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>发货城市：</label>
									</dt>
									<dd class="item-cont">
										<p><c:out value="${deliverCity.geoName}"/></p>
									</dd>
								</dl>
								<dl class="item item-kuaidi">
									<dt class="item-label">
										<label>快递公司：</label>
									</dt>
									<dd class="item-cont">
										<p><c:forEach items="${lc}" var="lc">
											<span><c:out value="${lc.logisticsCompName}"/></span>
										  </c:forEach>
										</p>
									</dd>
								</dl>
							</div>
						</fieldset>
					<div class="formBtn">
						<button type="button" class="btnC" onclick="javascript:passAudit();">审核通过</button>
						<input type="button" class="btn" value="驳回申请" onclick="javascript:rejectAudit();">
					</div>
					</form>
					<c:if test="${!empty(brandShow.auditContent)}">
					<table class="table tableC">
						<colgroup>
							<col>
							<col>
							<col>
							<col width="430">
						</colgroup>
						<thead>
							<tr>
								<th colspan="4" class="caption">审核历史</th>	
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>更新时间</th>
								<th>状态名称</th>
								<th>操作人</th>
								<th>操作说明</th>		
							</tr>
							<tr>
								<td><fmt:formatDate value="${brandShow.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td>审核驳回</td>
								<td><c:out value="${brandShow.auditByName}"/></td>
								<td><c:out value="${brandShow.auditContent}"/></td>								
							</tr>
						</tbody>
					</table>
					</c:if>
				</div>
				<div class="tabGroup " tabId="2">
					<form class="form formA activeProduct">						
							<c:forEach items="${brandShowDetailList}" var="brandShowDetail" varStatus="status">
								<c:if test="${!status.first && (brandShowDetail.prodId != lastBrandShowDetail.prodId)}">					
										</tbody>
									</table>	
									</div>					
								</c:if>
								
								<c:if test="${brandShowDetail.prodId != lastBrandShowDetail.prodId}">	
									<div class="table-wrap">
									<table class="table tableB">
										<colgroup>
											<col width="190">
											<col>
											<col>
											<col>
											<col>
											<col>
										</colgroup>
										<thead>
											<tr>
												<th></th>
												<th>规格</th>
												<th>原价</th>
												<th>折扣</th>
												<th>特卖价</th>
												<th>库存</th>
											</tr>
										</thead>
										<tbody>								
								</c:if>
								
								<tr>
									<c:if test="${brandShowDetail.prodId != lastBrandShowDetail.prodId}">	
										<c:set var="rowspan" value="0"></c:set>
										<c:forEach items="${brandShowDetailList}" var="detail">
											<c:if test="${detail.prodId == brandShowDetail.prodId}">
												<c:set var="rowspan" value="${rowspan + 1}"></c:set>
											</c:if>
										</c:forEach>
									<td rowspan="${rowspan}" class="borderR goodsdetal">
										<div class="item-prve"><a href="#"><img style="width:100px;height:100px;" src="${my:random(imgGetUrl).concat(brandShowDetail.prodImg)}"></a></div>
										<p class="title"><a href="#"><c:out value="${brandShowDetail.prodName}"/></a></p>
										<p>货号：<c:out value="${brandShowDetail.artNo}"/></p>
										<p>品牌：<c:out value="${brandShowDetail.brandName}"/></p>
									</td>
									</c:if>
									<td><p><c:out value="${fn:replace(fn:replace(brandShowDetail.skuSpecName, ':::', ' : '), '|||', '</p><p>')}" escapeXml="false"/></p></td>
									<td>&yen;<c:out value="${brandShowDetail.orgPrice}"/></td>
									<td><c:out value="${brandShowDetail.discount}"/>折</td>
									<td>&yen;<c:out value="${brandShowDetail.showPrice}"/></td>
									<td><c:out value="${brandShowDetail.showBalance}"/></td>
								</tr>
								
								<c:if test="${status.last}">					
									</tbody>
								</table>	
								</div>					
								</c:if>
								
								<c:set var="lastBrandShowDetail" value="${brandShowDetail}"></c:set>
							</c:forEach>
											
						<div class="formBtn">
							<button type="button" class="btnC" onclick="javascript:passAudit();">审核通过</button>
							<input type="button" class="btn" value="驳回申请" onclick="javascript:rejectAudit();">
						</div>
					</form>
					<c:if test="${!empty(brandShow.auditContent)}">
					<table class="table tableC">
						<colgroup>
							<col>
							<col>
							<col>
							<col width="430">
						</colgroup>
						<thead>
							<tr>
								<th colspan="4" class="caption">审核历史</th>	
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>更新时间</th>
								<th>状态名称</th>
								<th>操作人</th>
								<th>操作说明</th>		
							</tr>
							<tr>
								<td><fmt:formatDate value="${brandShow.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td>审核驳回</td>
								<td><c:out value="${brandShow.auditByName}"/></td>
								<td><c:out value="${brandShow.auditContent}"/></td>								
							</tr>
						</tbody>
					</table>
					</c:if>
				</div>
			</div>
		</div>
		
	</div>
<!-- sellerData end-->

<form action="auditPass" id="frmPass" method="post">
<input type="hidden" name="brandShowId" value="${brandShow.brandShowId}">
<div class="pop pop-paiqi" style="display:none" id="popupConfirm">
		<div class="hd">
			<h1>操作确认</h1>
			<span><i class="icon i-close" title="关闭" id="closeConfirm"></i></span>
		</div>
		<div class="bd">
			<div class="pop-con">
				<dl>
					<dt><label><em>*</em>专场名称：</label></dt>
					<dd>
						<span class="defInfo"><c:out value="${brandShow.title}"/></span>
					</dd>
				</dl>
				<dl>
					<dt><label><em>*</em>专场开始时间：</label></dt>
					<dd>
						<input type="text" class="txt" style="width: 174px;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss', autoPickDate:true, minDate:'<%= com.afd.common.util.DateUtils.formatDate(com.afd.common.util.DateUtils.currentDate()) %>'});" name="startDate" id="startDate"/>						
					</dd>
				</dl>
				<dl>
					<dt><label><em>*</em>专场结束时间：</label></dt>
					<dd>
						<input type="text" class="txt" style="width: 174px;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss', autoPickDate:true, minDate:'<%= com.afd.common.util.DateUtils.formatDate(com.afd.common.util.DateUtils.currentDate()) %>'});" name="endDate" id="endDate"/>						
					</dd>
				</dl>
			</div>
			<div class="formBtn">
				<input type="submit" value="保 存" class="btnB btn-s">
				<input type="button" value="取 消" class="btn btn-s" id="cancelConfirm">
			</div>
		</div>
	</div>
</form>
<form action="auditReject" id="frmReject" method="post">
<input type="hidden" name="brandShowId" value="${brandShow.brandShowId}">
<div class="pop" style="display:none" id="popupReject">
		<div class="hd">
			<h1>操作确认</h1>
			<span><i class="icon i-close" title="关闭" id="closeRejct"></i></span>
		</div>
		<div class="bd">
			<div class="pop-con">
				<dl>
					<dt><label><em>*</em>驳回理由：</label></dt>
					<dd>
						<textarea name="auditContent" id="auditContent" rows="5"></textarea>
						<div class="hint popHint">最多可输入100个中文汉字</div>
					</dd>
				</dl>
			</div>
		</div>
		<div class="formBtn">
				<input type="submit" value="确 定" class="btnB btn-s">
				<input type="button" value="取 消" class="btn btn-def" id="cancelReject">
		</div>
	</div>
	
<div class="mask" style="display:none" id="popupMask"></div>
</form>


<script type="text/javascript">
$(function(){
	$('li[tabId]').click(function(){
		var tabId = $(this).attr('tabId');

		var tabGroups = $('div.tabGroup');
		tabGroups.removeClass('block');
		
		tabGroups.filter('[tabId="' + tabId + '"]').addClass('block');
		
		$('li[tabId]').removeClass('on');
		$(this).addClass('on');
	});
	
	$('#cancelConfirm,#closeConfirm').click(function(){
		$('#popupConfirm,#popupMask').hide();
	});
	
	$('#cancelReject,#closeRejct').click(function(){
		$('#popupReject,#popupMask').hide();
	});
	
	CheckUtil.limitDbLength($('#auditContent'), 300);
	
	$('#frmPass').submit(function(){
		var startValue = $('#startDate').val();
		var endValue = $('#endDate').val();
		
		if(!startValue || !endValue || startValue >= endValue) {
			return false;
		}
	});
	
	$('#frmReject').submit(function(){
		if(!$('#auditContent').val()) return false;
	});
});

function passAudit() {
	$('#popupConfirm,#popupMask').show();
}

function rejectAudit() {
	$('#popupReject,#popupMask').show();
	$('#auditContent').focus();
}
</script>

</body>
</html>