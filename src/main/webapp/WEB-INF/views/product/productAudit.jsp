<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<%@page import="com.afd.constants.product.ProductConstants" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>卖家后台|商品管理表页</title>
	<link rel="stylesheet" href="css/all-debug.css" />
</head>
<body id="">
		<!-- main -->
		<div class="main">
			<!-- foldbarV -->
			<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
			<!-- foldbarV end -->
			<!-- goodsList -->
			<div class="goodsreferList">
				<!-- screening -->
				<div class="screening">
					<form class="form" id="queryForm" action="${ctx }/product/productList" method="post">
						<fieldset class="">
							<legend><h3>查询条件</h3></legend>
							<ul class="formBox">
								<li class="item">
									<div class="item-label"><label>商品编码：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textA" name="prodId" placeholder="商品编码只能输入数字" onkeydown="CheckUtil.limitDigital($(this));" value="${productCondition.prodId}" />
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>商品名称：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textC" name="title" value="<c:out value="${productCondition.title}"/>" />
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>更新时间：</label></div>
									<div class="item-cont">
										<input type="text" readonly="readonly" value="<fmt:formatDate value="${productCondition.startDate}" pattern="yyyy-MM-dd" />" name="startDate" class="dateTxt" onClick="WdatePicker()" />
			            				<span> 至 </span>
			            				<input type="text" readonly="readonly" value="<fmt:formatDate value="${productCondition.endDate}" pattern="yyyy-MM-dd" />" name="endDate" class="dateTxt" onClick="WdatePicker()" />	
								</li>
								<li class="item">
									<div class="item-label"><label>品牌名称：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textA" name="brandName" value="<c:out value="${productCondition.brandName}"/>" />
									</div>
								</li>
							</ul>
						</fieldset>
						<!-- foldbarH -->
						<div class="foldbarH open"><!-- 展开后添加class命open -->
							<div class="foldBtn"><i class="ico"></i></div>
							<div class="searchBtn"><input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" /></div>
						</div>
						<!-- foldbarH end -->
					</form>
				</div>
				<!-- screening end -->
				<!-- actionBar 
				<div class="actionBar">
	 			<input type="checkbox" class="chk" name="allSelect" id="allSelect" /><label for="allSelect">全选</label>
					<input type="button" class="btnA" value="抽样下架" /> 
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
				<!-- table -->
				<div class="tableWrap">
					<table class="table tableA">
						<colgroup>
						 <!-- 	<col width="20" /> -->
							<col width="50" />
							<col width="100" />
							<col />
							<col width="75" />
							<col width="70" />
							<col width="60" />
							<col width="100" />
							<col />
							<col width="70" />
							<col width="100" />
							<col width="100">
						</colgroup>
						<thead>
							<tr>
							<!-- 	<th></th>  -->
								<th>序号</th>
								<th>商品编码</th>
								<th>商品名称</th>
								<th>单价</th>
								<th>特卖价</th>
								<th>库存</th>
								<th>品牌</th>
								<th>商家名称</th>
								<th>状态</th>
								<th>更新时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${requestScope.page.result}" var="p" varStatus="var">
							<tr>
							 	<!-- <td class="chkbox"><input type="checkbox" class="chk" name="" id="" value="" /></td> -->
								<td>${var.count }</td>
								<th>${p.prodId }</th>
								<td class="align-l"><a href="#"><c:out value="${p.title }"></c:out> </a></td>
								<td>${p.salePrice }</td>
								<td>${p.marketPrice }</td>
								<td>${p.stockBalance }</td>
								<td><c:out value="${p.brandName }" /></td>
								<td class="align-l"><c:out value="${p.coName }" /> </td>
								<td><c:choose>
										<c:when test="${p.status == '0' }">
											在售
										</c:when>
										<c:when test="${p.status == '1' }">
											下架
										</c:when>
										<c:when test="${p.status == '2' }">
											已删除
										</c:when>
										<c:when test="${p.status == '3' }">
											暂停销售
										</c:when>
										</c:choose></td>
								<td><fmt:formatDate value="${p.lastUpdateDate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td class="t-operate">
									<div class="mod-operate">
										<div class="def"><a href="${ctx }/product/productDetail?prodId=${p.prodId }" >查看详情</a><i class="arr"></i></div>
										<ul>
											<li><a href="javascript:;" onclick="product.downProduct(${p.prodId})">抽样下架</a></li>
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
			<!-- 		<div class="ctrlArea">
						<input type="checkbox" class="chk" name="allSelect" id="allSelect2" /><label for="allSelect2">全选</label>
						<input type="button" class="btnA" value="抽样下架" />
					</div> -->
					<p:page page="${page}" action="${ctx}/product/productList" />
				</div>
				<!-- paging end -->
			</div>
			<!-- goodsList end -->
		</div>
		<!-- main end -->
	<!-- bd end -->
	<script type="text/javascript" src="../static/js/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="../static/js/page.js?t=2014071601"></script>
	<script type="text/javascript" src="../static/js/jquery.md.js?t=2014071601"></script>
	<script type="text/javascript" src="../static/js/product.js?t=2014071601"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		product = new product();
	});
	</script>
</body>
</html>
