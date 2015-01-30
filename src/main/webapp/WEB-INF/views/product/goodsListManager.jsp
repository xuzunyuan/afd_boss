<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.afd.constants.product.ProductConstants" %>
<%request.setAttribute("ctx", request.getContextPath()); %>
<%
request.setAttribute("imgDownPrefix", "http://img");
request.setAttribute("imgDownSuffix", ".afdimg.com/rc/getimg?rid=");
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib uri="/WEB-INF/tld/pageNew.tld" prefix="pg"%>
<html>
<head>
	<meta charset="utf-8" />
	<title>商品管理-一网全城</title>
	<link rel="stylesheet" href="css/all-debug.css" />
</head>
<body id="">
	<link rel="stylesheet" href="${ctx}/static/style/classes_.css?t=20140627" />
		<div id="bd"><!-- 点击.foldbarV下的foldBtn后在此添加class名unfold来实现展开效果 -->
			<!-- foldbarV -->
			<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
			<!-- foldbarV end -->
			<!-- crumbs -->
			<div class="crumbs">
				<ul>
					<li><a href="#">后台首页</a><em>&gt;</em></li>
					<li><a href="#">商品管理</a><em>&gt;</em></li>
					<li><strong>商品管理列表</strong></li>
				</ul>
			</div>
			<!-- crumbs end -->
			<!-- goodsList -->
			<div class="goodsreferList">
				<!-- screening -->
				<div class="screening">
					<form class="form" id="query" action="${ctx }/prod/showProd" method="post" onsubmit="return goods.checkFromData();">
						<fieldset class="default"><!-- class="default" -->
							<legend><h3>查询条件</h3></legend>
							<ul class="formBox">
								<li class="item">
									<div class="item-label"><label>商品编号：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textA" name="prodCode" placeholder="商品编号只能输入数字" onkeydown="CheckUtil.limitDigital($(this));" value="${prodcutCondition.prodCode}" />
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>商品标题：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textC" name="title" value="<c:out value="${prodcutCondition.title}"/>"/>
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>更新时间：</label></div>
									<div class="item-cont">
										<input type="text" readonly="readonly" value="<fmt:formatDate value="${prodcutCondition.startDate}" pattern="yyyy-MM-dd" />" name="startDate" class="dateTxt" onClick="WdatePicker()" />
			            				<span> 至 </span>
			            				<input type="text" readonly="readonly" value="<fmt:formatDate value="${prodcutCondition.endDate}" pattern="yyyy-MM-dd" />" name="endDate" class="dateTxt" onClick="WdatePicker()" />									
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>商品状态：</label></div>
									<div class="item-cont">
										<div class="select">
											<select name="status">
											    <option value="">全部</option>
											    <option <c:if test="${productCondition.status == '3'}">selected="selected"</c:if> value="3">上架</option>
											    <option <c:if test="${productCondition.status == '4'}">selected="selected"</c:if> value="4">下架</option>
											    <option <c:if test="${productCondition.status == '1'}">selected="selected"</c:if> value="1">待上架</option>
											</select>
										</div>
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>SKU编号：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textA" name="skuCode" placeholder="SKU编号只能输入数字" onkeydown="CheckUtil.limitDigital($(this));" value="${prodcutCondition.skuCode}"/>
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>卖家名称：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textA"  name="sellerName" value="<c:out value="${prodcutCondition.sellerName}"/>"/>
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>店铺名称：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textA" name="storeName" value="<c:out value="${prodcutCondition.storeName}"/>"/>
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>基础类目：</label></div>
									<div class="select">
										<select name="fc" id="fc">
											<option value="${prodcutCondition.bcCode }">全部</option>
										</select>
									</div>
									<div class="select">
										<select name="sc" id="sc">
											<option value="${prodcutCondition.bcCode }">全部</option>
										</select>
									</div>
									<div class="select">
										<select name="bcId" id="tc">
											<option value="${prodcutCondition.bcCode }">全部</option>
										</select>
									</div>
								</li>		
							</ul>
						</fieldset>
						<!-- foldbarH -->
						<div class="foldbarH" id="foldbarH"><!-- 展开后添加class命open -->
							<div id="foldBtn" class="foldBtn" ><i class="ico" onclick="goods.searchMenu();"></i></div>
							<div class="searchBtn"><input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" /></div>
						</div>
						<!-- foldbarH end -->
						<input type="hidden" name="bcId" id="bcId" value="">									
						<input type="hidden" name="fId" id="fId" value="">
						<input type="hidden" name="sId" id="sId" value="">
						<input type="hidden" name="bcCode" value="">
					</form>
				</div>
				<!-- screening end -->
				<!-- actionBar -->
				<div class="actionBar">
					<input type="checkbox" class="chk" name="allSelect" id="allSelect" onclick="goods.allSelect();" /><label for="allSelect">全选</label>
					<input type="button" class="btnA" onclick="goods.batchUpdateStatus(<%=ProductConstants.PROD_STATUS_ON %>);" value="批量上架" />
					<input type="button" class="btnA" onclick="goods.batchUpdateStatus(<%=ProductConstants.PROD_STATUS_DOWN %>);" value="批量下架" />
					<input type="button" class="btnA" onclick="goods.batchUpdateStatus(<%=ProductConstants.PROD_STATUS_REMOVE %>);" value="批量删除" />
				</div>
				<!-- actionBar end -->
				<!-- table -->
				<div class="tableWrap">
				<c:choose>
					<c:when test="${!empty requestScope.page.result}">				
						<table class="table tableA">
							<colgroup>
								<col width="20" />
								<col width="30" />
								<col width="120" />
								<col />
								<col width="75" />
								<col width="60" />
								<col width="60" />
								<col width="50" />
								<col width="90" />
								<col />
								<col width="" />
								<col width="100">
							</colgroup>
							<thead>
								<tr>
									<th></th>
									<th>序号</th>
									<th>商品编号</th>
									<th>商品标题</th>
									<th>市场价（元）</th>
									<th>单价（元）</th>
									<th>库存</th>
									<th>状态</th>
									<th>更新时间</th>
									<th>基础类目</th>
									<th>店铺名称</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.result}" var="p" varStatus="var">
									<tr>
										<td class="chkbox"><input type="checkbox" class="chk" name="prodCheck"  pId="${p.prodId}" /></td>
										<td>${var.count}</td>
										<th>${p.prodCode }</th>
										<td class="align-l"><a href="http://item.afd.com/detail/${p.defultSkuId}.html" target="_blank"><c:out value="${p.title}"/></a></td>
										<td><fmt:formatNumber pattern="0.00" value="${p.marketPrice }"></fmt:formatNumber></td>
										<td><fmt:formatNumber pattern="0.00" value="${p.salePrice }"></fmt:formatNumber></td>
										<td>${p.stockBalance }</td>
										<td><c:choose>
										<c:when test="${p.status == '1' }">
											<em>待上架</em>
										</c:when>
										<c:when test="${p.status == '2' }">
											<em>已删除</em>
										</c:when>
										<c:when test="${p.status == '3' }">
											<em>上架</em>
										</c:when>
										<c:when test="${p.status == '4' }">
											<em>下架</em>
										</c:when>
										</c:choose></td>
										<td><fmt:formatDate value="${p.lastUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td class="align-l">${p.bcName }</td>
										<td class="align-l"><a href="http://shop.afd.com/${p.storeId }/" target="_blank"><c:out value="${p.storeName }"/></a></td>
										<td class="t-operate">
											<div class="mod-operate">
												<div class="def">
												<c:choose>
													<c:when test="${p.status =='1' or p.status == '4' or p.status == '2'}">
														<a href="javascript:;" onclick="goods.updateStatus(${p.prodId},<%=ProductConstants.PROD_STATUS_ON %>);">上 架</a>
													</c:when>
													<c:when test="${p.status == '3' }">
														<a href="javascript:;" onclick="goods.updateStatus(${p.prodId},<%=ProductConstants.PROD_STATUS_DOWN %>);">下 架</a>
													</c:when></c:choose>
												<i class="arr"></i></div>
												<ul>
												<c:choose>
													<c:when test="${p.status =='1' or p.status == '4' or p.status =='3'}">
														<li><a href="javascript:;" onclick="goods.updateStatus(${p.prodId},<%=ProductConstants.PROD_STATUS_REMOVE %>);" >删 除</a></li>
													</c:when>
													<c:when test="${p.status == '2'}">
														<li><a href="javascript:;" onclick="goods.updateStatus(${p.prodId},<%=ProductConstants.PROD_STATUS_DOWN %>);">下 架</a></li>
													</c:when></c:choose>
												</ul>
											</div>
										</td>
									</tr>
								</c:forEach>	
							</tbody>
						</table>
					</c:when>
					<c:otherwise>
						<div class="hintBar screeningMes">暂无符合条件的查询结果</div>
					</c:otherwise>
				</c:choose>					
				</div>
				<!-- table end -->
				<c:if test="${fn:length(page.result) > 0}">
					<pg:page name="queryProduct" page="${page}" formId="query"></pg:page>
				</c:if>
			</div>
			<!-- goodsList end -->
<script type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.md.js?t=2014061704"></script>
<script type="text/javascript" src="${ctx }/static/js/check-util.js?t=20140709"></script>
<script type="text/javascript" src="${ctx}/static/js/goodsAudit.js?t=20140916"></script>
<script type="text/javascript">
	$(document).ready(function(){
		goods = new goods();
		
	 	var status = '${prodcutCondition.status}';
	 	var skuCode = '${prodcutCondition.skuCode}';
	 	var sellerName = '${prodcutCondition.sellerName}';
	 	var storeName = '${prodcutCondition.storeName}';
		var bcId = '${prodcutCondition.bcId}';
	 	var fId = '${fId}';
	 	var sId = '${sId}';
	 	var bcCode = '${prodcutCondition.bcCode}';
	 	
	 	if(!!bcCode || !!storeName || !!bcId || (!!status && status!='-1') || !!sellerName || !!skuCode){
			$("fieldset").removeClass("default");
			$("#foldbarH").addClass("open");
	 	}
	 	
	 	goods.fetchSubCategory("#fc", 0);
	 	
	 	$('#fc').change(function(){
	 		goods.fetchSubCategory("#sc", this.value);
	 		$('input[name=fId]').val(this.value);
	 		var bcCode = $(this).children("option:selected").attr("bcCode");
		 	$('input[name=bcCode]').val(bcCode);
	 	});	
	 	$('#sc').change(function(){
	 		goods.fetchSubCategory("#tc", this.value);
	 		$('input[name=sId]').val(this.value);
	 		var bcCode = $(this).children("option:selected").attr("bcCode");
	 		if(bcCode === undefined){
	 			bcCode = $("#fc").children("option:selected").attr("bcCode");
	 		}
	 		$('input[name=bcCode]').val(bcCode);
	 	});
	 	$('#tc').change(function(){
	 		$('input[name=bcId]').val(this.value);
	 		var bcCode = $(this).children("option:selected").attr("bcCode");
	 		if(bcCode === undefined){
	 			bcCode = $("#sc").children("option:selected").attr("bcCode");
	 		}
	 		$('input[name=bcCode]').val(bcCode);
	 	});
	 	
 		if(!!fId){
 			$("#fc").val(fId).trigger("change");
 			
		 	if(!!sId){
		 		$("#sc").val(sId).trigger("change");
		 	}
		 	if(!!bcId){
		 		$("#tc").val(bcId).trigger("change");
		 	}
 		}
 		
 		$("#allSelect").bind("click",function(){
 			$("input[name=prodCheck]").prop("checked",this.checked);
 		});
 		$("input[name=prodCheck]").bind('click',function(){
 			$("input[name=allSelect]").prop("checked",false);
 		});
	});
	
</script>	
</body>
</html>
