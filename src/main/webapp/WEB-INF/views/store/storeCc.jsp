<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>店铺管理-一网全城</title>
	</head>
	<body>
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- crumbs -->
		<div class="crumbs crumbsA">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="#">店铺管理</a><em>&gt;</em></li>
				<li><strong>店铺资料</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- sellerData -->
		<div class="sellerData">
			<!-- tab -->
			<div class="tab">
				<div class="tabs">
					<ul>
						<li class="back-btn"><input type="button" class="btn btn-s" value="返&nbsp;&nbsp;回" onclick="window.location.href='${ctx}/${backUrl}'"></li>
						<li><a href="${ctx}/store/storeInfo?storeId=${storeId}&operate=${operate}">基本资料</a></li>
						<li class="on"><a href="#">签约品类</a></li>
					</ul>
				</div>
			</div>
			<!-- tab end -->
			<form class="form formA">
				<fieldset>
					<dl class="item item-last">
						<dt class="item-label">
							<label><em>*</em>签约品类：</label>
						</dt>
						<dd class="item-cont">
							<table class="table tableD">
								<colgroup>
									<col width="50">
									<col width="260">
									<col width="350">
								</colgroup>
								<thead>
									<tr>
										<th>序号</th>
										<th>一级类目</th>
										<th>二级类目</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${storeCc}" var="pCc" varStatus="status">
										<c:forEach items="${pCc.value.categories}" var="cc" varStatus="status2">
										<tr>
											<c:if test="${status2.first}">
												<td rowspan="${fn:length(pCc.value.categories)}"><c:out value="${status.count}"/></td>
												<td rowspan="${fn:length(pCc.value.categories)}"><c:out value="${pCc.value.ccName}"/></td>
											</c:if>													
											<td><c:out value="${cc.ccName}"/></td>
										</tr>
										</c:forEach>
									</c:forEach>
								</tbody>
							</table>
						</dd>
					</dl>
				</fieldset>
			</form>
			<table class="table tableC">
				<colgroup>
					<col>
					<col>
					<col>
					<col width="430">
				</colgroup>
				<thead>
					<tr>
						<th colspan="4" class="caption">店铺操作记录</th>	
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>更新时间</th>
						<th>状态名称</th>
						<th>操作人</th>
						<th>操作说明</th>		
					</tr>
					<c:if test="${store.status == 50 && !empty store.freezeDate}">
						<tr>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"  value="${store.freezeDate }"/></td>
							<td>冻结</td>
							<td><c:out value="${store.freezeByName }" /></td>
							<td><c:out value="${store.freezeReason }" /></td>
						</tr>
					</c:if>
					<c:if test="${store.status == 49 && !empty store.unfreezeDate }">
						<tr>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"  value="${store.unfreezeDate }"/></td>
							<td>解冻</td>
							<td><c:out value="${store.unfreezeByName}" /></td>
							<td></td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</body>
</html>