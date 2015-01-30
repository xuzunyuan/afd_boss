<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@include file="/common/common.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
request.setAttribute("ctx", request.getContextPath());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<title>卖家后台|增加活动商品</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/jquery-1.10.2.min.js?t=2014051601"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/static/style/classes_.css?t=2014061802" />
<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/page.js?t=2014061701"></script>
</head>
<body>
<div class="wrapper">
		<!-- bd -->
		<div id="bd" class="wrap"><!-- 点击.foldbarV下的foldBtn后在此添加class名unfold来实现展开效果 -->
				<!-- selectGoods -->
				<div class="selectGoods activeAddgoods">
					<!-- screening -->
					<div class="screening">
						<form class="form" action="selectSku" method="post">
							<fieldset class=""><!-- 删掉default显示全部查询条件 -->
								<div class="legend"><h3>选择活动商品</h3></div>
								<ul class="formBox">
									<li class="item">
										<div class="item-label"><label>商品类目：</label></div>
										<div class="item-cont">
											<div class="select">
												<select name="fc" id="fc" value="${pageInfo.conditions.fc}">
												    <option value="">全部</option>
												</select>
											</div>
										</div>
										<div class="item-cont">
											<div class="select">
												<select name="sc" id="sc" value="${pageInfo.conditions.sc}">
												    <option value="">全部</option>
												</select>
											</div>
										</div>
										<div class="item-cont">
											<div class="select">
												<select name="tc" id="tc" value="${pageInfo.conditions.tc}">
												    <option value="">全部</option>
												</select>
											</div>
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>品牌：</label></div>
										<div class="item-cont">
											<input type="text" class="txt textA" name="brandName" id="brandName" value="${fn:escapeXml(pageInfo.conditions.brandName) }"/>
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>店铺名称：</label></div>
										<div class="item-cont">
											<input type="text" class="txt textA" name="storeName" id="storeName" value="${fn:escapeXml(pageInfo.conditions.storeName) }"/>
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>商品状态：</label></div>
										<div class="item-cont">
											<div class="select">
												<select name="status" id="status">
												    <option value="">全部</option>
												    <option value="3" ${pageInfo.conditions.status == '3' ? ' selected="selected"' : ''}>上架</option>
												    <option value="1" ${pageInfo.conditions.status == '1' ? ' selected="selected"' : ''}>待上架</option>
												    <option value="4" ${pageInfo.conditions.status == '4' ? ' selected="selected"' : ''}>下架</option>
												    <option value="5" ${pageInfo.conditions.status == '5' ? ' selected="selected"' : ''}>违规</option>
												</select>
											</div>
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>商品名称：</label></div>
										<div class="item-cont">
											<input type="text" class="txt textA" name="title" id="title" value="${fn:escapeXml(pageInfo.conditions.title) }"/>
										</div>
									</li>
								</ul>
								<div class="searchBtn"><input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" name="query"></div>
							</fieldset>
						</form>
					</div>
					<!-- screening end -->
					<!-- actionBar -->
					<div class="actionBar">
						<input type="checkbox" class="chk" name="allSelect" id="allSelect">
						<label for="allSelect">全选</label>
						<input type="button" class="btnA" value="批量添加" id="batchAddSku">
						
					</div>
					<!-- actionBar end -->
					<!-- table -->
					<div class="tableWrap">
						<table class="table tableA" id="tbl">
							<colgroup>
								<col width="20"/>
								<col width="30">
								<col width="120">
								<col>
								<col width="90">
								<col width="60">
								<col width="60">
								<col width="">
								<col width="">
								<col width="100">
								<col width="100">
							</colgroup>

							<thead>
								<tr>
									<th></th>
									<th>序号</th>
									<th>商品编号</th>
									<th>商品名称</th>
									<th>单价（元）</th>
									<th>可用库存</th>
									<th>状态</th>
									<th>店铺名称</th>
									<th>商品类目</th>
									<th>品牌</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty(productQueryVoPage.result)}">
									<tr>
										<td colspan="11">暂无查询结果</td>
									</tr>
								</c:if>
								
								<c:forEach items="${productQueryVoPage.result}" var="product" varStatus="status">
									<tr prodId="${product.prodId}" prod="1" prodCode="${product.prodCode}" storeId="${product.storeId}"
										storeName="${fn:escapeXml(product.storeName)}" prodTitle="${fn:escapeXml(product.title)}"										
									>
									<td class="chkbox"><c:if test="${product.status == 3 && product.stockBalance > 0}"><input type="checkbox" class="chk" name="chkSelect"></c:if></td>
									<td>${(productQueryVoPage.currentPageNo-1)*productQueryVoPage.pageSize+status.count}</td>
									<th><c:out value="${product.prodCode}"/> </th>
									<td class="align-l">
										<c:choose>
											<c:when test="${!empty(product.skus)}">
												<a href="http://item.yiwang.com/detail/${product.skus[0].skuId}.html" target="_blank"><c:out value="${product.title}"/></a></td>
											</c:when>
											<c:otherwise>
												<c:out value="${product.title}"/>
											</c:otherwise>
										</c:choose>										
									<td><fmt:formatNumber value="${product.salePrice}" pattern="0.00"/></td>
									<td><c:out value="${product.stockBalance}"/></td>
									<td>
										<c:choose>
											<c:when test="${product.status == '1'}">待上架</c:when>
											<c:when test="${product.status == '3'}">上架</c:when>
											<c:when test="${product.status == '4'}">下架</c:when>
											<c:when test="${product.status == '5'}">违规</c:when>
										</c:choose>
									</td>
									<td class="align-l"><a href="http://shop.yiwang.com/${product.storeId }/" target="_blank"><c:out value="${product.storeName}"/></a></td>
									<td class="align-l"><c:out value="${product.bcName}"/></td>
									<td><c:out value="${product.brandName}"/></td>
									<td class="t-operate">
										<c:if test="${fn:length(product.skus) > 1}">
										<input type="button" class="btn" name="allSku" value="全部SKU">
										</c:if>
									</td>
								</tr>
								<c:forEach items="${product.skus}" var="sku">
									<tr class="addSKU" ${fn:length(product.skus) > 1 ? 'style="display:none"' : ''} prodId="${product.prodId}" skuSpecName="${fn:escapeXml(sku.skuSpecName)}"
										skuId="${sku.skuId}" skuCode="${sku.skuCode}" skuImgUrl="${fn:escapeXml(sku.skuImgUrl)}" 
										salePrice="${sku.salePrice}" stockBalance="${sku.stockBalance}"
									>
									<td class="chkbox"></td>
									<td></td>
									<td><c:out value="${sku.skuCode}"/></td>
									<td class="align-l" skuSpecName="${fn:escapeXml(sku.skuSpecName)}"></td>
									<td style="align:right"><fmt:formatNumber value="${sku.salePrice}" pattern="0.00"/></td>
									<td style="align:right"><c:out value="${sku.stockBalance}"/></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td class="t-operate">
										<c:if test="${product.status == 3 && sku.stockBalance > 0}">
										<input type="button" class="btn" value="添加" name="btnAddSku">
										</c:if>
									</td>
									</tr>								
								</c:forEach>								
								
								</c:forEach>								
							</tbody>
						</table>
					</div>
					<!-- table end -->
					<!-- paging -->
					<!-- paging -->
					<div class="paging">
						<!-- <div class="ctrlArea">
							<input type="checkbox" class="chk" name="allSelect" id="allSelect2" /><label
								for="allSelect2">全选</label> <input type="button" class="btnA"
								value="审核通过" /> <input type="button" class="btnA" value="驳回申请" />
						</div> -->
					 	<p:page page="${productQueryVoPage}" action="selectSku"/>
					</div>					
					
				</div>
				<!-- selectGoods end -->
		</div>
		<!-- bd end -->
		 <!-- footer -->
		<div id="footer" class="wrap">
			<div class="links">
				<a href="#" title="关于一网全城" target="_blank">关于一网全城</a>|<a href="#" title="联系我们" target="_blank">联系我们</a>|<a href="#" title="网站地图" target="_blank">网站地图</a>|<a href="#" title="联系我们" target="_blank">网站合作</a>|<a href="#" title="友情链接" target="_blank">友情链接</a>|<a href="#" title="网站联盟" target="_blank">网站联盟</a>|<a href="#" title="帮助中心" target="_blank">帮助中心</a>|<a href="#" title="版权声明" target="_blank">版权声明</a>
			</div>
			<p>Copyright &copy; 2008-2014 Yiwang.com All Rights Reserved.</p>
			<p>ICP经营许可证号：吉B2-20140008</p>
		</div>
		<!-- footer end -->

	</div>
	
<script type="text/javascript">
$(function() {
	fetchSubCategory("#fc", 0);
	$('#fc').change(function(){
		fetchSubCategory("#sc", this.value);
		$('#sc').trigger('change');
	});	
	$('#sc').change(function(){
		fetchSubCategory("#tc", this.value);
	});
	
	 var fc = $('#fc').attr('value'), sc = $('#sc').attr('value'), tc = $('#tc').attr('value');	
	 
	 if(fc) {
		 $('#fc').val(fc);
		 fetchSubCategory("#sc", fc);
		 
		 if(sc) {
			 $('#sc').val(sc);
			 fetchSubCategory("#tc", sc);
		 }
		 
		 if(tc) {
			 $('#tc').val(tc);
		 }
	 }
	 
	 initAllSku();
	 initSpecName();
	 
	 $('#allSelect').change(function(){
		 var checked = $(this).prop('checked');
		
		 $(':checkbox[name="chkSelect"]').prop('checked', checked);
	 });
	 
	 initAddSku();
	 initBatchAddSku();
});
	
function fetchSubCategory(elemId, pId) {
	$(elemId).find('option:gt(0)').remove();
		
	if(pId === '') return;
	
	$.ajax({
		url : "${ctx}/category/noAuth/bc/pList",
		type : "POST",
		data : {pId : pId},
		async: false,
		success : function(list) {
			if(list != null && list.length>0){
				appendOption(elemId, list);
			}
		}
	});
}

function appendOption(elemId, objList) {
	var sel$ = $(elemId);

	$.each(objList, function() {
		sel$.append('<option value="' +  this.bcId + '">' + this.bcName + '</option>');
	});
}

function initAllSku() {
	var table = $('#tbl');
	
	table.find('[name="allSku"]').click(function(){
		var prodId = $(this).closest('tr').attr('prodId');
		
		table.find('tr.addSKU[prodId="' + prodId + '"]').show();
		
		$(this).prop("disabled",true); 
		$(this).addClass('disable');
	});
}

function initSpecName() {
	$('#tbl').find('td[skuSpecName]').each(function(){
		var specName = $(this).attr('skuSpecName');
		
		if(specName) {
			var arr = specName.split('|||'), html='';
			
			$(arr).each(function(){
				html = html + ' <span>' + this.replace(/:::/g, ': ') + '</span>';
			});
			
			$(this).html(html);
		}
	});	
}

function initAddSku() {
	$(':button[name="btnAddSku"]').click(function(){
		addSku($(this).closest('tr').attr('skuId'));
		
		$(this).prop("disabled",true); 
		$(this).addClass('disable');
	});
}

function initBatchAddSku() {
	$('#batchAddSku').click(function(){
		$('#tbl').find('input[name="chkSelect"]').filter(':checked').each(function(){
			var prodId = $(this).closest('tr').attr('prodId');

			$('#tbl').find('tr[skuId][prodId="' + prodId + '"]').each(function(){
				addSku($(this).attr('skuId'), false);
				$(this).find('[name="btnAddSku"]').prop("disabled",true).addClass('disable'); 
			});		
			
			if(window.opener.refreshNav) window.opener.refreshNav();
			
			$(this).remove();
		});
	});
}

function addSku(skuId, refresh) {
	if(!window.opener || !window.opener.addSku) return;
		
	var table = $('#tbl');
	var sku = {};
	
	var skuTr = table.find('tr[skuId="' + skuId + '"]'), prodId = skuTr.attr('prodId'), prodTr=table.find('tr[prod][prodId="' + prodId + '"]') ;
	if(skuTr.attr('stockBalance') * 1 <= 0) return;
	
	sku.prodId = prodId;
	sku.prodTitle = prodTr.attr('prodTitle');
	sku.prodCode =  prodTr.attr('prodCode');
	sku.storeId = prodTr.attr('storeId');
	sku.storeName = prodTr.attr('storeName');
	
	sku.skuId = skuId;
	sku.skuCode = skuTr.attr('skuCode');
	sku.skuSpecName = skuTr.attr('skuSpecName');
	sku.skuImgUrl = skuTr.attr('skuImgUrl');
	sku.salePrice = skuTr.attr('salePrice');
	sku.stockBalance = skuTr.attr('stockBalance');
	
	window.opener.addSku(sku);
	
	if(!(refresh === false) && window.opener.refreshNav) window.opener.refreshNav();
}
</script>
</body>
</html>