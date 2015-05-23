<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>专家品牌审核-巨有利</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="../static/js/page.js?t=2014071601"></script>

	<!-- main -->
	<div class="main">
		<!-- foldbarV -->
		<div id="foldbarV">
			<div class="foldbarV">
				<div class="foldBtn"></div>
			</div>
		</div>
		<!-- foldbarV end -->
		<!-- orderSearch -->
		<div class="orderSearch">
			<!-- screening -->
			<div class="screening">
				<form method="post" action="${ctx}/brand/apply" class="form">
					<fieldset id="condition" class="">
						<legend>
							<h3>查询条件</h3>
						</legend>
						<ul class="formBox">
							<li class="item">
								<div class="item-label">
									<label>公司名称：</label>
								</div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${pageInfo.conditions.coName}"/>" name="coName" id="coName" class="txt textA" />
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>品牌名称：</label>
								</div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${pageInfo.conditions.brandName}"/>" name="brandName" id="brandName" class="txt textA" />
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>申请时间：</label>
								</div>
								<div class="item-cont">
									<input type="text" value="${pageInfo.conditions.startDt}" class="dateTxt" onfocus="WdatePicker()" name="startDt" id="startDt" /><span>至</span><input type="text" class="dateTxt" value="${pageInfo.conditions.endDt}" class="dateTxt" onfocus="WdatePicker()" name="endDt" id="endDt"/>
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>商家账号：</label>
								</div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${pageInfo.conditions.loginName}"/>" name="loginName" id="loginName" class="txt textA" />
								</div>
							</li>
						</ul>
					</fieldset>
					<!-- foldbarH -->
					<div id="foldbar" class="foldbarH">
						<!-- 展开后添加class命open -->
						<div class="foldBtn">
							<i class="ico"></i>
						</div>
						<div class="searchBtn">
							<input type="hidden" name="createDate" value="DESC" />
							<input type="hidden" name="status" value="1" />
							<input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" name="query" id="query" />
						</div>
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
							<li>该审核列表目前只显示待审核的卖家品牌申请！</li>
						</ul>
					</dd>
				</dl>
			</div>
			<!-- hintbar end -->

			<!-- table -->
			<div class="tableWrap">
				<table class="table tableA">
					<colgroup>
						<!--<col width="20" />-->
						<col width="40" />
						<col width="80" />
						<col width="150" />
						<col width="140" />
						<col />
						<col width="140" />
						<col width="140">	
						<col width="120">
					</colgroup>
					<thead>
						<tr>
							<!--<th></th>-->
							<th>序号</th>
							<th>品牌LOGO</th>
							<th>品牌名称</th>
							<th>商家账号</th>
							<th>公司名称</th>
							<th>申请时间</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
	      					<c:when test="${fn:length(sellerBrands.result)>0}">
	      						<c:forEach items="${sellerBrands.result}" var="sellerBrand" varStatus="status"> 
									<tr>
										<!--<td class="chkbox"><input type="checkbox" class="chk" name="" id="" value="" /></td>-->
										<td>${sellerBrands.beginRow+status.count}</td>
										<td class="o-goodsName">
											<c:choose>
												<c:when test="${empty sellerBrand.logoUrl }">
													<img src="../static/img/order_02.jpg" alt="" >
												</c:when>
												<c:otherwise>
													<img src="${my:random(imgGetUrl)}${sellerBrand.logoUrl}&op=s2_w50_h50" alt="" >
												</c:otherwise>
											</c:choose>
										</td> 
										<td><c:out value="${sellerBrand.showName}"/></td>
										<td><c:out value="${sellerBrand.loginName}"/></td>
										<td><c:out value="${sellerBrand.coName}"/></td>
										<td><fmt:formatDate value="${sellerBrand.submitDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></td>
										<td>待审核</td>
										<td class="t-operate">
											<div class="mod-operate">
												<div>
													<a href="${ctx}/brand/applyDetail?sbId=${sellerBrand.sellerBrandId}">审核申请</a>
												</div>
											</div>
										</td>
									</tr>
								</c:forEach>
							</c:when>
		      				<c:when test="${fn:length(sellerBrands.result)==0}">
								<tr class="emptyGoods">
									<td colspan="8" rowspan="3">暂无符合条件的查询结果</td>
								</tr>
		      				</c:when>
		      			</c:choose>
					</tbody>
				</table>
			</div>
			<!-- table end -->
			<!-- paging -->
			<div class="paging">
				<p:page page="${sellerBrands}" action="${ctx}/brand/apply"/>
			</div>
			<!-- paging end -->
		</div>
		<!-- orderSearch end -->
	</div>
	<!-- main end -->
</body>
</html>