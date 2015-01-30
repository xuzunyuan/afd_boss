<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@include file="/common/common.jsp"%> 

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>活动查询</title>
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
						<li><a href="#">活动管理</a><em>&gt;</em></li>
						<li><strong>活动查询</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- goodsList -->
				<div class="activeList">
					<!-- screening -->
					<div class="screening">
						<form class="form" action="list" method="post" id="frm">
							<fieldset class="" id="fsQuery">
								<legend><h3>查询条件</h3></legend>
								<ul class="formBox">
									<li class="item">
										<div class="item-label"><label>活动类型：</label></div>
										<div class="item-cont">
											<div class="select">
												<select name="type">
												    <option value="">全部</option>
												    <option value="1" ${pageInfo.conditions.type == '1' ? 'selected="selected"' : ''}>限时抢购</option>
												    <option value="2" ${pageInfo.conditions.type == '2' ? 'selected="selected"' : ''}>直降</option>
												</select>
											</div>
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>活动状态：</label></div>
										<div class="item-cont">
											<div class="select">
												<select name="status">
												    <option value="">全部</option>
												    <option value="1" ${pageInfo.conditions.status == '1' ? 'selected="selected"' : ''}>已创建</option>
												    <option value="2" ${pageInfo.conditions.status == '2' ? 'selected="selected"' : ''}>活动中</option>
												    <option value="3" ${pageInfo.conditions.status == '3' ? 'selected="selected"' : ''}>结束</option>
												    <option value="4" ${pageInfo.conditions.status == '4' ? 'selected="selected"' : ''}>取消</option>
												    <option value="5" ${pageInfo.conditions.status == '5' ? 'selected="selected"' : ''}>终止</option>
												</select>
											</div>
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>活动起止时间：</label></div>
										<div class="item-cont"><input type="text" class="dateTxt" name="startDate" value="${pageInfo.conditions.startDate}" onfocus="WdatePicker()" /><span>至</span><input type="text" class="dateTxt" name="endDate" value="${pageInfo.conditions.endDate}" onfocus="WdatePicker()" /></div>
									</li>
									<li class="item">
										<div class="item-label"><label>活动名称：</label></div>
										<div class="item-cont">
											<input type="text" class="txt textA" name="name" value="${fn:escapeXml(pageInfo.conditions.name)}" />
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>店铺名称：</label></div>
										<div class="item-cont">
											<input type="text" class="txt textA" name="storeName" value="${fn:escapeXml(pageInfo.conditions.storeName)}" />
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>商品名称：</label></div>
										<div class="item-cont">
											<input type="text" class="txt textA" name="title" value="${fn:escapeXml(pageInfo.conditions.title)}"/>
										</div>
									</li>										
								</ul>
							</fieldset>
							<!-- foldbarH -->
							<div class="foldbarN open" id="fld"><!-- 展开后添加class命open -->
								<div class="condition" id="collapse"><span>收起条件</span><i class="ico"></i></div>
								<div class="searchBtn" id="searchBtn"><input type="submit" name="query" class="btn btn-s" value="查&nbsp;&nbsp;询" /></div>
							</div>
							<!-- foldbarH end -->
						</form>
					</div>
					<!-- actionBar 					
					<div class="actionBar">
						<label for="">全选</label>
						<div class="select">
							<select>
							    <option>按活动剩余时间少-多</option>
							    <option>按活动开始时间升序</option>
							    <option>按活动开始时间降序</option>
							</select>
						</div>
						<div class="pagingMini">
							<div class="pagingBtn">
								<a href="javascript:void(0)" class="pageUp disable"></a>
								<a href="#" class="pageDown"></a>
							</div>
							<div class="pageNum"><span><b>1</b></span>/<span>20</span>页</div>
							<div class="count">共<em>23145</em>条记录，本页显示<em>20</em>条</div>
						</div>
					</div>
					
					-->
					<!-- actionBar end -->
					<!-- table -->
					<div class="tableWrap">
						<table class="table tableA">
							<colgroup>
								<col width="40" />
								<col width="" />
								<col width="100" />
								<col width="100" />
								<col width="100" />
								<col width="100" />
								<col width="100" />
								<col width="60" />
								<col width="80" />
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
									<th>创建人</th>
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
										<td class="align-l"><a href="viewPromotion?promotionId=${promotion.ywPPId}"><c:out value="${promotion.name}"/></a></td>
										<td><c:choose>
											<c:when test="${promotion.type == '1'}">限时抢购</c:when>
											<c:when test="${promotion.type == '2'}">直降/折扣</c:when>
											</c:choose>
										</td>
										<td><p><fmt:formatDate value="${promotion.startDate}" pattern="yyyy-MM-dd" type="both"/> </p>
											<p><fmt:formatDate value="${promotion.startDate}" pattern="HH:mm" type="both"/></p></td>
										<td><c:choose>
												<c:when test="${empty(promotion.endDate)}">
													<p>长期有效</p>
												</c:when>
												<c:otherwise>
													<p><fmt:formatDate value="${promotion.endDate}" pattern="yyyy-MM-dd" type="both"/></p>
													<p><fmt:formatDate value="${promotion.endDate}" pattern="HH:mm" type="both"/></p></td>
												</c:otherwise>
											</c:choose>
											
										<td class="surplusTime"><c:if test="${promotion.status == '2' && !empty(promotion.remainDay)}">
											${promotion.remainDay}天${promotion.remainHour}小时${promotion.remainMin}分钟
											</c:if>
										 </td>
										<td><c:choose>
											<c:when test="${promotion.status == '1'}">已创建</c:when>
											<c:when test="${promotion.status == '2'}">活动中</c:when>
											<c:when test="${promotion.status == '3'}">结束</c:when>
											<c:when test="${promotion.status == '4'}">取消</c:when>
											<c:when test="${promotion.status == '5'}">终止</c:when>
											</c:choose></td>
										<td><c:out value="${promotion.createByName}"/></td>
										<td><p><fmt:formatDate value="${promotion.createByDate}" pattern="yyyy-MM-dd" type="both"/> </p>
											<p><fmt:formatDate value="${promotion.createByDate}" pattern="HH:mm" type="both"/></p></td>
										<td class="t-operate">
											<div class="mod-operate">
												<div class="def"><a href="#" promotionId="${promotion.ywPPId}" z="1">活动详情</a><i class="arr"></i></div>
												<ul>
													<c:if test="${promotion.status == '1'}"><li><a href="#" promotionId="${promotion.ywPPId}" z="2">上线活动</a></li></c:if>
													<c:if test="${promotion.status == '1' || promotion.status == '2'}"><li><a href="#" promotionId="${promotion.ywPPId}" z="3">终止活动</a></li></c:if>
													<c:if test="${promotion.status == '1'}"><li><a href="#" promotionId="${promotion.ywPPId}" z="4">编辑活动</a></li></c:if>
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
					<div class="paging">
					 	<p:page page="${page}" action="list"/>
					</div>
					<!-- paging end -->
				</div>
				<!-- goodsList end -->

<script type="text/javascript">
$(function(){
	$('a[promotionId]').click(function(e){
		e.preventDefault();
		
		var promotionId = $(this).attr('promotionId'), z = $(this).attr('z');
		
		if(z == '1') {
			viewPromotion(promotionId);
		} 
		// 上线
		else if(z == '2') {
			startPromotion(promotionId);			
			
		}
		// 终止
		else if(z == '3') {
			endPromotion(promotionId);
			
		} 
		// 编辑
		else if(z == '4') {
			editPromotion(promotionId);
		}
	});
	
	$('#collapse').click(function(){
		if($(this).attr('open')) {
			$('#fsQuery').removeClass('default');
			$('#fld').addClass('open');
			$(this).find('span').html('收起条件');
			$(this).attr('open', false);
		} else {
			$('#fsQuery').addClass('default');
			$('#fld').removeClass('open');
			$(this).find('span').html('更多条件');
			$(this).attr('open', true);
		}
	});
	
	<c:if test="${!empty(msg)}">
		alert('${fn:escapeXml(msg)}');
	</c:if>
});

function viewPromotion(promotionId) {
	self.location.href = 'viewPromotion?promotionId=' + promotionId;
}

function startPromotion(promotionId) {
	if(!confirm("您确定上线该活动吗？")) return;
	
	self.location.href = 'startPromotion?promotionId=' + promotionId;
};

function endPromotion(promotionId) {
	if(!confirm("您确定终止该活动吗？终止后不可恢复")) return;
	
	self.location.href = 'endPromotion?promotionId=' + promotionId;
}

function editPromotion(promotionId) {
	self.location.href = 'promotion?promotionId=' + promotionId;
}

</script>
</body>
</html>