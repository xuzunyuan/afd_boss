<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<%@page import="com.afd.constants.product.ProductConstants" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>商品管理-一网全城</title>
	</head>
	<body id="">
		<div id="foldbarV">
			<div class="foldbarV">
				<div class="foldBtn"></div>
			</div>
		</div>
		<!-- foldbarV end -->
		<!-- crumbs -->
		<div class="crumbs">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="#">商品管理</a><em>&gt;</em></li>
				<li><strong>商品查询列表</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- goodsList -->
		<div class="goodsreferList">
			<!-- screening -->
			<div class="screening">
				<form class="form" id="query" action="${ctx }/product/productList" method="post" onsubmit="return goods.checkFromData();">
					<fieldset class="default"><!-- class="default" -->
						<h3>查询条件</h3>
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
										    <option <c:if test="${productCondition.status == '2'}">selected="selected"</c:if> value="2">已删除</option>
										    <option <c:if test="${productCondition.status == '6'}">selected="selected"</c:if> value="6">暂停销售</option>
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
			<!-- table -->
			<div class="tableWrap">
				<c:choose>
					<c:when test="${!empty requestScope.page.result}">				
						<table class="table tableA">
							<colgroup>
								<col width="40" />
								<col width="130" />
								<col width="180"/>
								<col width="75" />
								<col width="70" />
								<col width="60" />
								<col width="50" />
								<col width="110" />
								<col width="122"/>
								<col width="180" />
							</colgroup>
							<thead>
								<tr>
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
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.result}" var="p" varStatus="var">
									<tr>
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
										<c:when test="${p.status == '6' }">
											<em>暂停销售</em>
										</c:when>
										</c:choose></td>
										<td><fmt:formatDate value="${p.lastUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td class="align-l">${p.bcName }</td>
										<td class="align-l"><a href="http://shop.afd.com/${p.storeId }/" target="_blank"><c:out value="${p.storeName }"/></a></td>
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
				<pgNew:page name="queryProduct" page="${page}" formId="query"></pgNew:page>
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
