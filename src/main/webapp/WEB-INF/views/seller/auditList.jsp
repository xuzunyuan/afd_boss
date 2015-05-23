<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>卖家申请审核-巨友利</title>
</head>
<body>
	<script type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/auditList.js?t=20150204"></script>
	<script type="text/javascript" src="${ctx}/static/js/page.js?t=20150204"></script>

	<!-- foldbarV -->
	<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
	<!-- foldbarV end -->
	<!-- crumbs -->
	<div class="crumbs">
		<ul>
			<li><a href="#">后台首页</a><em>&gt;</em></li>
			<li><a href="#">商家管理</a><em>&gt;</em></li>
			<li><strong>入驻审核</strong></li>
		</ul>
	</div>
	<!-- crumbs end -->
	<!-- goodsList -->
	<div class="">
		<!-- screening -->
		<div class="screening">
			<form class="form" id="auditForm" method="post" action="${ctx}/seller/audit">
				<fieldset class="default">
					<legend><h3>查询条件</h3></legend>
					<ul class="formBox">
						<li class="item">
							<div class="item-label"><label>申请时间：</label></div>
							<div class="item-cont"><input type="text" value="${pageInfo.conditions.startDt}" class="dateTxt" onfocus="WdatePicker()" name="startDt" id="startDt"><span>至</span><input type="text" value="${pageInfo.conditions.endDt}" class="dateTxt" onfocus="WdatePicker()" name="endDt" id="endDt"></div>
						</li>
						<li class="item">
							<div class="item-label"><label>卖家账号：</label></div>
							<div class="item-cont">
								<input type="text" value="${fn:escapeXml(pageInfo.conditions.loginName)}" name="loginName" id="loginName" class="txt textA" maxlength="50">
							</div>
						</li>
						<li class="item">
							<div class="item-label"><label>公司名称：</label></div>
							<div class="item-cont">
								<input type="text" class="txt textA" value="${fn:escapeXml(pageInfo.conditions.coName)}" name="coName" id="coName" maxlength="50">
							</div>
						</li>
					</ul>
				</fieldset>
				<!-- foldbarH -->
				<div class="foldbarH"><!-- 展开后添加class命open -->
					<div class="foldBtn"><i class="ico" style="display:none"></i></div>
					<div class="searchBtn"><input type="submit" class="btn btn-s" name="query" value="查&nbsp;&nbsp;询"></div>
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
						<li></i>该审核列表目前只显示等待审核的商家入驻申请！</li>
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
					<col width="140" />
					<col />
					<col width="140" />
					<col width="140" />
					<col width="140" />
					<col width="140">
				</colgroup>
				<thead>
					<tr>
						<th>序号</th>
						<th>商家账号</th>
						<th>公司名称</th>
						<th>所在地区</th>
						<th>申请时间</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty(applysPage.result)}">
						<tr class="emptyGoods">
							<td colspan="7">暂无符合条件的查询结果</td>
						</tr>
					</c:if>
					
					<c:forEach items="${applysPage.result}" var="apply" varStatus="status"> 
						<tr>
							<td>${(applysPage.currentPageNo-1)*applysPage.pageSize + status.count}</td>
							<td><a href="#"><c:out value="${apply.loginName}"/></a></td>
							<td><c:out value="${apply.coName}"/></td>
							<td><c:out value="${apply.btGeo}"/></td>
							<td><p><fmt:formatDate value="${apply.applyDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></p></td>
							<td>待审核</td>
							<td class="t-operate">
								<div class="mod-operate">
								<div class="def"><a href="${ctx }/seller/auditPage?appId=${apply.appId}">审核申请</a><i class="arr"></i></div>
									<ul></ul>
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
				<p:page page="${applysPage}" action="${ctx}/brandShow/auditList"/>
			</div>
		</div>
		<!-- paging end -->
	</div>
	<!-- goodsList end -->
</body>
</html>