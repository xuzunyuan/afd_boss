<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>专场管理-巨友利</title>
</head>
<body>

<script type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>	
<script type="text/javascript" src="${ctx}/static/js/page.js?t=20150204"></script>
	
<!-- foldbarV -->
<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
<!-- foldbarV end -->
<!-- goodsList -->
<div class="goodsauditList">
	<!-- screening -->
	<div class="screening">
		<form class="form" method="post" action="${ctx}/brandShow/manList" id="queryFrm">
			<fieldset class="">
				<legend><h3>查询条件</h3></legend>
				<ul class="formBox">
					<li class="item">
						<div class="item-label"><label>申请时间：</label></div>
						<div class="item-cont"><input type="text" class="dateTxt" onfocus="WdatePicker()" name="startDt" value="${pageInfo.conditions.startDt}"/><span>至</span><input type="text" class="dateTxt" onfocus="WdatePicker()" name="endDt" value="${pageInfo.conditions.endDt}"/></div>
					</li>
					<li class="item">
						<div class="item-label"><label>状态：</label></div>
						<div class="item-cont">
							<div class="select">
								<select name="status">
								    <option value="">全部</option>
								    <option value="1" ${pageInfo.conditions.status == '1' ? 'selected="selected"' : ''}>进行中</option>
								    <option value="2" ${pageInfo.conditions.status == '2' ? 'selected="selected"' : ''}>结束</option>
								    <option value="3" ${pageInfo.conditions.status == '3' ? 'selected="selected"' : ''}>异常终止</option>
								    <option value="4" ${pageInfo.conditions.status == '4' ? 'selected="selected"' : ''}>编辑中</option>
								    <option value="5" ${pageInfo.conditions.status == '5' ? 'selected="selected"' : ''}>待审核</option>
								    <option value="6" ${pageInfo.conditions.status == '6' ? 'selected="selected"' : ''}>审核中</option>
								    <option value="7" ${pageInfo.conditions.status == '7' ? 'selected="selected"' : ''}>等待上线</option>
								    <option value="8" ${pageInfo.conditions.status == '8' ? 'selected="selected"' : ''}>驳回</option>
								</select>
							</div>
						</div>
					</li>
					
					<li class="item">
						<div class="item-label"><label>品牌名称：</label></div>
						<div class="item-cont">
							<input type="text" class="txt textA" name="brandName" value="${pageInfo.conditions.brandName}"/>
						</div>
					</li>
					<li class="item">
						<div class="item-label"><label>专场名称：</label></div>
						<div class="item-cont">
							<input type="text" class="txt textA" name="title" value="${pageInfo.conditions.title}"/>
						</div>
					</li>					
					<li class="item">
						<div class="item-label"><label>商家名称：</label></div>
						<div class="item-cont">
							<input type="text" class="txt textA" name="coName" value="${pageInfo.conditions.coName}"/>
						</div>
					</li>
				</ul>
			</fieldset>
			<!-- foldbarH -->
			<div class="foldbarH open"><!-- 展开后添加class命open -->
				<div class="foldBtn"><i class="ico"></i></div>
				<div class="searchBtn"><input type="submit" class="btn btn-s" name="query" value="查&nbsp;&nbsp;询" /></div>
			</div>
			<!-- foldbarH end -->
		</form>
	</div>
	<!-- screening end -->

	<!-- table -->
	<div class="tableWrap">
		<table class="table tableA">
			<colgroup>
				<col width="60" />
				<col width="80" />
				<col width="140" />
				<col width="120" />
				<col />
				<col width="140" />
				<col width="120">	
				<col width="120">
			</colgroup>
			<thead>
				<tr>
					<th>序号</th>
					<th>活动类型</th>
					<th>专场名称</th>
					<th>品牌名称</th>
					<th>公司名称</th>
					<th>申请时间</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty(brandShowPage.result)}">
					<tr class="emptyGoods">
						<td colspan="8">暂无符合条件的查询结果</td>
					</tr>
				</c:if>
				
				<c:forEach items="${brandShowPage.result}" var="brandShow" varStatus="status"> 
					<tr>
						<td>${(brandShowPage.currentPageNo-1)*brandShowPage.pageSize + status.count}</td>
						<td>品牌特卖</td>
						<td><a href="#"><c:out value="${brandShow.title}"/></a></td>
						<th><c:out value="${brandShow.brandName}"/></th>
						<td><c:out value="${brandShow.coName}"/></td>
						<td><p><fmt:formatDate value="${brandShow.createByDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p></td>
						<td><c:choose>
								<c:when test="${brandShow.status == '1'}">进行中</c:when>
								<c:when test="${brandShow.status == '2'}">结束</c:when>
								<c:when test="${brandShow.status == '3'}">异常终止</c:when>
								<c:when test="${brandShow.status == '4'}">编辑中</c:when>
								<c:when test="${brandShow.status == '5'}">待审核</c:when>
								<c:when test="${brandShow.status == '6'}">审核中</c:when>
								<c:when test="${brandShow.status == '7'}">等待上线</c:when>
								<c:when test="${brandShow.status == '8'}">驳回</c:when>	
							</c:choose>			
						</td>
						<td class="t-operate">
							<div class="mod-operate">
								<div class="def"><a href="manPage?brandShowId=${brandShow.brandShowId}">查看详情</a><i class="arr"></i></div>
								<ul>									
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
		<div class="ctrlArea">
		</div>
		<div class="pagingWrap">
			<p:page page="${brandShowPage}" action="${ctx}/brandShow/manList"/>
		</div>
	</div>
	<!-- paging end -->
</div>
<!-- goodsList end -->

</body>
</html>