<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/common/common.jsp"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>店铺活动</title>
</head>
<body>
	<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/page.js?t=2014061701"></script>

				<!-- foldbarV -->
				<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
				<!-- foldbarV end -->
				<!-- crumbs -->
				<div class="crumbs">
					<ul>
						<li><a href="#">后台首页</a><em>&gt;</em></li>
						<li><a href="#">卖家管理</a><em>&gt;</em></li>
						<li><strong>店铺活动列表</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- goodsList -->
				<div class="activeList">
					<!-- screening -->
					<div class="screening">
						<form class="form" id="frm" method="post" action="list">
							<fieldset class="default" id="fsQuery">
								<legend><h3>查询条件</h3></legend>
								<ul class="formBox">
									<li class="item">
										<div class="item-label"><label>活动类型：</label></div>
										<div class="item-cont">
											<div class="select">
												<select id="type" name="type">
												    <option value="">全部促销</option>
												    <option value="1" ${pageInfo.conditions.type == '1' ? 'selected="selected"' : ''}>免邮促销</option>
												</select>
											</div>
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>活动状态：</label></div>
										<div class="item-cont">
											<div class="select">
												<select id="status" name="status">
												    <option value="">全部</option>
												    <option value="1" ${pageInfo.conditions.status == '1' ? 'selected="selected"' : ''}>已创建</option>
												    <option value="2" ${pageInfo.conditions.status == '2' ? 'selected="selected"' : ''}>活动中</option>
												    <option value="4" ${pageInfo.conditions.status == '4' ? 'selected="selected"' : ''}>取消</option>
												    <option value="5" ${pageInfo.conditions.status == '5' ? 'selected="selected"' : ''}>终止</option>
												    <option value="3" ${pageInfo.conditions.status == '3' ? 'selected="selected"' : ''}>结束</option>
												</select>
											</div>
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>活动起止时间：</label></div>
										<div class="item-cont"><input type="text" class="dateTxt" id="startDate" name="startDate" onfocus="WdatePicker()" value="${pageInfo.conditions.startDate}" /><span>至</span><input type="text" class="dateTxt" id="endDate" name="endDate" onfocus="WdatePicker()" value="${pageInfo.conditions.endDate}" /></div>
									</li>
									<li class="item">
										<div class="item-label"><label>店铺名称：</label></div>
										<div class="item-cont">
											<input type="text" class="txt textA" id="storeName" name="storeName" value="${pageInfo.conditions.storeName}" />
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>活动名称：</label></div>
										<div class="item-cont">
											<input type="text" class="txt textA" id="name" name="name" value="${pageInfo.conditions.name}" />
										</div>
									</li>									
								</ul>
							</fieldset>
							<!-- foldbarH -->
							<div class="foldbarN" id="fld"><!-- 展开后添加class命open -->
								<div class="condition" id="collapse"><span>展开条件</span><i class="ico"></i></div>
								<div class="searchBtn"><input type="submit" name="query" class="btn btn-s" value="查&nbsp;&nbsp;询" /></div>
							</div>
							<!-- foldbarH end -->
						</form>
					</div>
					<!-- table -->
					<div class="tableWrap">
						<table class="table tableA">
							<colgroup>
								<col width="40" />
								<col width="" />
								<col width="90" />
								<col width="90" />
								<col width="90" />
								<col width="100" />
								<col width="90" />
								<col width="130"/>
								<col width="90" />
								<col width="100">
							</colgroup>
							<thead>
								<tr>
									<th>序号</th>
									<th>活动名称</th>
									<th>活动类型</th>
									<th>活动开始时间</th>
									<th>活动结束时间</th>
									<th>活动剩余时间</th>
									<th>活动状态</th>
									<th>店铺名称</th>
									<th>创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${empty(page.result)}">
									<tr>
										<td colspan="10">暂无查询结果</td>
									</tr>
							</c:if>
							
							<c:forEach items="${page.result}" var="promotion" varStatus="status">
							<tr>
									<td>${(page.currentPageNo-1)*page.pageSize+status.count}</td>
									<td class="align-l"><a href="viewPromotion?storePromotionId=${promotion.storePromotionId}"><c:out value="${promotion.name}"/></a></td>
									<td>免邮活动</td>
									<td><p><fmt:formatDate value="${promotion.startDate}" pattern="yyyy-MM-dd" type="both"/></p><p><fmt:formatDate value="${promotion.startDate}" pattern="HH:mm" type="both"/></p></td>
									<td><p><fmt:formatDate value="${promotion.endDate}" pattern="yyyy-MM-dd" type="both"/></p><p><fmt:formatDate value="${promotion.endDate}" pattern="HH:mm" type="both"/></p></td>
									<td class="surplusTime"><c:if test="${promotion.status == 50 && !empty(promotion.remainDay)}">
											${promotion.remainDay}天${promotion.remainHour}小时${promotion.remainMin}分钟
											</c:if></td>
									<td><c:choose>
											<c:when test="${promotion.status == 49}">已创建</c:when>
											<c:when test="${promotion.status == 50}">活动中</c:when>
											<c:when test="${promotion.status == 51}">结束</c:when>
											<c:when test="${promotion.status == 52}">取消</c:when>
											<c:when test="${promotion.status == 53}">终止</c:when>
											</c:choose></td>
									<td><a href="http://shop.yiwang.com/${promotion.storeId}/"><c:out value="${promotion.storeName}"/></a></td>
									<td><p><fmt:formatDate value="${promotion.createByDate}" pattern="yyyy-MM-dd" type="both"/></p><p><fmt:formatDate value="${promotion.createByDate}" pattern="HH:mm" type="both"/></p></td>
									<td class="t-operate">
										<div class="mod-operate">
											<div class="def"><a href="#" storePromotionId="${promotion.storePromotionId}" z="1">活动详情</a><i class="arr"></i></div>
											<ul>
												<c:if test="${promotion.status == 49}"><li><a href="#" storePromotionId="${promotion.storePromotionId}" z="2">上线活动</a></li></c:if>
												<c:if test="${promotion.status == 49}"><li><a href="#" storePromotionId="${promotion.storePromotionId}" z="4">取消活动</a></li></c:if>
												<c:if test="${promotion.status == 50}"><li><a href="#" storePromotionId="${promotion.storePromotionId}" z="5">终止活动</a></li></c:if>
											</ul>
										</div>
									</td>
								</tr>
							
							
							</c:forEach>							
							</tbody>
						</table>
					</div>
					<!-- table end -->
					<!-- paging -->
					<!-- paging -->
					<div class="paging">
					 	<p:page page="${page}" action="list"/>
					</div>
					<!-- paging end -->
				</div>
				<!-- goodsList end -->

<script type="text/javascript">
$(function(){
	$('#frm').submit(function(){
		var jqName = $('#name'), jqStoreName = $('#storeName');
		
		jqName.val($.trim(jqName.val()));
		jqStoreName.val($.trim(jqStoreName.val()));
	});
	
	$('#collapse').click(function(){
		if($(this).attr('open')) {
			$('#fsQuery').addClass('default');
			$('#fld').removeClass('open');
			$(this).find('span').html('更多条件');
			$(this).attr('open', false);
		} else {
			$('#fsQuery').removeClass('default');
			$('#fld').addClass('open');
			$(this).find('span').html('收起条件');			
			$(this).attr('open', true);
		}
	});
	
	$('a[z]').click(function(e){
		e.preventDefault();
		
		var promotionId = $(this).attr('storePromotionId'), z = $(this).attr('z');
		
		if(z == '1') {
			viewPromotion(promotionId);
		} 
		// 上线
		else if(z == '2') {
			startPromotion(promotionId);			
			
		}
		// 终止
		else if(z == '5') {
			endPromotion(promotionId);
			
		} 
		// 取消
		else if(z == '4') {
			cancelPromotion(promotionId);
		}
	});
	
	<c:if test="${!empty(msg)}">
		alert('${fn:escapeXml(msg)}');
	</c:if>
});

function viewPromotion(promotionId) {
	self.location.href = 'viewPromotion?storePromotionId=' + promotionId;
}

function startPromotion(promotionId) {
	if(!confirm("您确定上线该活动吗？")) return;
	
	self.location.href = 'startPromotion?storePromotionId=' + promotionId;
};

function endPromotion(promotionId) {
	if(!confirm("您确定终止该活动吗？终止后不可恢复")) return;
	
	self.location.href = 'endPromotion?storePromotionId=' + promotionId;
}

function cancelPromotion(promotionId) {
	if(!confirm("您确定取消该活动吗？取消后不可恢复")) return;
	
	self.location.href = 'endPromotion?storePromotionId=' + promotionId;
}
</script>	
	
</body>
</html>