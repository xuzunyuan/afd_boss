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
<script type="text/javascript" src="${ctx}/static/js/page.js?t=20150204"></script>
	
<!-- foldbarV -->
<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
<!-- foldbarV end -->
<!-- goodsList -->
<div class="goodsauditList">
	<!-- screening -->
	<div class="screening">
		<form class="form" method="post" action="${ctx}/brandShow/auditList" id="queryFrm">
			<fieldset class="">
				<legend><h3>查询条件</h3></legend>
				<ul class="formBox">
					<li class="item">
						<div class="item-label"><label>申请时间：</label></div>
						<div class="item-cont"><input type="text" class="dateTxt" onfocus="WdatePicker()" name="startDt" value="${pageInfo.conditions.startDt}"/><span>至</span><input type="text" class="dateTxt" onfocus="WdatePicker()" name="endDt" value="${pageInfo.conditions.endDt}"/></div>
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
	
	<!-- hintbar -->
	<div class="hintBar hintBar-lamp">
		<dl>
			<dt><i class="icon i-lamp"></i></dt>
			<dd>
				<ul>
					<li></i>该列表目前只显示等待审核的专场申请！</li>
				</ul>
			</dd>
		</dl>
	</div>
	<!-- hintbar end -->

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
						<td>待审核</td>
						<td class="t-operate">
							<div class="mod-operate">
								<div class="def"><a href="auditPage?brandShowId=${brandShow.brandShowId}">审核申请</a><i class="arr"></i></div>
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
			<p:page page="${brandShowPage}" action="${ctx}/brandShow/auditList"/>
		</div>
	</div>
	<!-- paging end -->
</div>
<!-- goodsList end -->

</body>
</html>