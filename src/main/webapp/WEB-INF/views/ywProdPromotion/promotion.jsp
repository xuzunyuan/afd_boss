<%-- <%@page import="com.afd.common.util.DateUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@include file="/common/common.jsp"%> 

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
com.afd.boss.web.YwProdPromotionController.FormData data = (com.afd.boss.web.YwProdPromotionController.FormData)request.getAttribute("data");

if(data != null && data.getValidRange() != null) {
	request.setAttribute("rangeWeb", ((data.getValidRange() & 1) != 0));
	request.setAttribute("rangeTel", ((data.getValidRange() & 2) != 0));
	request.setAttribute("rangeIos", ((data.getValidRange() & 4) != 0));
	request.setAttribute("rangeAnd", ((data.getValidRange() & 8) != 0));
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>创建平台活动-一网全城</title>
</head>
<body>
<!-- foldbarV -->
				<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/datePicker/WdatePicker.js"></script>
				<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/ywPropPromotion.js"></script>
				
				<form action="savePromotion" method="post" class="form formB" id="frm">
				
				<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
				<!-- foldbarV end -->
				<!-- crumbs -->
				<div class="crumbs crumbsA">
					<ul>
						<li><a href="#">后台首页</a><em>&gt;</em></li>
						<li><a href="#">活动管理</a><em>&gt;</em></li>
						<li><strong>${data.type == '1' ? '创建限时活动' : '创建直降活动'}</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- activeFlashsale -->
				<div class="activeFlashsale ${data.type == '1' ? '' : 'activeHavegoods'}">
					<div class="hintBar">
						<dl>
							<dt><i class="icon i-exclaim"></i></dt>
							<dd>
								<h4>请注意：</h4>
								<ul>
									<li><em>·</em>活动在创建完成后，可在‘活动查询’中查看详情、维护活动资料</li>
								</ul>
							</dd>
						</dl>
					</div>
					<!-- operateStep -->
					<div class="operateStep">
						<div class="os-caption"><h2><i class="icon i-minus"></i><span>第1步</span>设置活动规则</h2></div>
						<div class="os-content block">
							
								<fieldset>
									<dl class="item">
										<dt class="item-label">
											<label><em>*</em>活动类型：</label>
										</dt>
										<dd class="item-cont item-radio">
											<c:choose>
												<c:when test="${data.type == '1'}">
													<input type="radio" class="rdo" name="type" id="type" checked="checked" value="1"><label for="type">限时抢购</label>
												</c:when>
												<c:when test="${data.type == '2'}">
													<input type="radio" class="rdo" name="type" id="type" checked="checked" value="2"><label for="type">直降/折扣</label>
												</c:when>
											</c:choose>											
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label><em>*</em>活动名称：</label>
										</dt>
										<dd class="item-cont">
											<input type="text" class="txt textD" name="name" id="name" maxlength="40" initValue="${fn:escapeXml(data.name)}"  value="${fn:escapeXml(data.name)}"/>
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label><em>*</em>活动开始时间：</label>
										</dt>
										<dd class="item-cont">
											<c:if test="${empty(param.promotionId)}">
											<!-- 
											<input type="radio" class="rdo" name="startType" id="startType1" value="1"><label for="startType1">创建完成即将开始</label>
											 -->
											</c:if>											
											<div class="setTime">
												<input type="radio" class="rdo" name="startType" id="startType2" value="2" checked="checked"><label for="startType2">设定时间</label>
												<input type="text" class="dateTxt" onfocus="WdatePicker({minDate:'<%= DateUtils.formatDate(DateUtils.currentDate()) %>'})" name="startDay" id="startDay" value="${data.startDay}">
												<div class="select">
													<select name="startHour" id="startHour" initValue="${data.startHour}">													    
													</select>
												</div>
												<em>时</em>
												<div class="select">
													<select name="startMinute" id="startMinute" initValue="${data.startMinute}">													 
													</select>
												</div>
												<em>分</em>
											</div>
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label><em>*</em>活动结束时间：</label>
										</dt>
										<dd class="item-cont">
											<input type="radio" class="rdo" name="endType" id="endType1" value="1" ${!empty(param.promotionId) && empty(data.endDate) ? 'checked="checked"' : ''}><label for="endType1">长期有效</label>
											<!--  
											<div class="mod-help">
												<i class="ico"></i>
												<div class="text">
													<div class="text-meg">
													</div>
												</div>
											</div> -->
											<div class="setTime">
												<input type="radio" class="rdo" name="endType" id="endType2" value="2" ${empty(param.promotionId) || (!empty(param.promotionId) && !empty(data.endDate)) ? 'checked="checked"' : ''}><label for="endType2">设定时间</label>
												<input type="text" class="dateTxt" onfocus="WdatePicker({minDate:'<%= DateUtils.formatDate(DateUtils.currentDate()) %>'})" name="endDay" id="endDay" value="${data.endDay}">
												<div class="select">
													<select name="endHour" id="endHour" initValue="${data.endHour}">													    
													</select>
												</div>
												<em>时</em>
												<div class="select">
													<select name="endMinute" id="endMinute" initValue="${data.endMinute}">													 
													</select>
												</div>
												<em>分</em>
											</div>
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label><em>*</em>活动范围：</label>
										</dt>
										<dd class="item-cont">
											<input type="checkbox" class="chk" name="allValidRange" id="allValidRange"><label for="allValidRange">全部</label>
											<div class="setTime">
												<input type="checkbox" class="chk" name="validRange" id="web" value="1" ${!empty(rangeWeb) && rangeWeb ? 'checked=checked' : ''}><label for="web">网站</label>
												<input type="checkbox" class="chk" name="validRange" id="tel" value="2" ${!empty(rangeTel) && rangeTel ? 'checked=checked' : ''}><label for="tel">电话下单</label>
												<input type="checkbox" class="chk" name="validRange" id="IOS" value="4" ${!empty(rangeIos) && rangeIos ? 'checked=checked' : ''}><label for="IOS">IOS客户端</label>
												<input type="checkbox" class="chk" name="validRange" id="And" value="8" ${!empty(rangeAnd) && rangeAnd ? 'checked=checked' : ''}><label for="And">Android客户端</label>
											</div>
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label>统一折扣：</label>
										</dt>
										<dd class="item-cont">
											<div class="setTime">												
												<input type="text" class="txt textB" name="discount" id="discount" maxlength="4" placeholder="5" value="${!empty(data.discount) && data.discount != 0 ? data.discount : ''}"><em>折</em>
											</div>
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label>限购数量：</label>
										</dt>
										<dd class="item-cont">							
											<div class="setTime">												
												<input type="text" class="txt textB" name="purchaseCountLimit" id="purchaseCountLimit" maxlength="4" placeholder="5" value="${!empty(data.purchaseCountLimit) && data.purchaseCountLimit != 0 ? data.purchaseCountLimit : ''}"><em>件</em>
											</div>
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label>活动宣传语：</label>
										</dt>
										<dd class="item-cont item-pub">
											<input type="text" class="txt textD" name="publicity" id="publicity" maxlength="100" value="${fn:escapeXml(data.publicity)}"/>
											<!-- 
											<div class="mod-help">
												<i class="ico"></i>
												<div class="text">
													<div class="text-meg">
													</div>
												</div>
											</div> -->
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label>规则说明：</label>
										</dt>
										<dd class="item-cont item-pub">
											<textarea name="remark" id="remark" cols="" rows="8">${fn:escapeXml(data.remark)}</textarea>
											<!-- 
											<div class="mod-help">
												<i class="ico"></i>
												<div class="text">
													<div class="text-meg">
													</div>
												</div>
											</div>
											 -->
										</dd>
									</dl>
									<!--  
									<dl class="item">
										<dt class="item-label">
											<label>申请部门：</label>
										</dt>
										<dd class="item-cont">
											<input type="text" class="txt textC" />
										</dd>
									</dl>-->
								</fieldset>
							
						</div>
					</div>
					<!-- operateStep end -->
					<!-- operateStep -->
					<div class="operateStep">
						<div class="os-caption"><h2><i class="icon i-minus"></i><span>第2步</span>活动商品设置</h2></div><!-- 默认隐藏用加号 class为i-plus，展开用减号i-minus； -->
						<div class="os-add"><input type="button" class="btnB" value="添加商品" id="btnAddSku"></div>
						<div class="os-content block">												
							<!-- table -->
							<table class="table tableB" id="tbl">
								<colgroup>
									<c:choose>
												<c:when test="${data.type == '1'}"> 
													<col width="30">
													<col width="290" />
													<col width="70" />
													<col width="60" />
													<col/>
													<col width="65">
													<col width="65"/>
													<col width="65" />
													<col width="120" />
													<col width="120" />
													<col width="50" />																
												</c:when>
												<c:when test="${data.type == '2'}">
													<col width="30">
													<col width="300" />
													<col width="70" />
													<col width="60" />
													<col/>
													<col width="80">
													<col width="80" />
													<col width="80"/>
													<col width="80"/>
													<col width="80" />															
												</c:when>
										</c:choose>											
								</colgroup>
								<thead>
									<tr>
										<th>序号</th>
										<th>商品名称</th>
										<th>单价（元）</th>
										<th>可用库存</th>
										<th>店铺名称</th>
										<th>活动库存</th>
										<c:choose>
												<c:when test="${data.type == '1'}">
													<th>抢购价</th>
													<th>限购数量</th>
													<th>抢购开始时间</th>
													<th>抢购结束时间</th>													
												</c:when>
												<c:when test="${data.type == '2'}">
													<th>限购数量</th>
													<th>折扣率（折）</th>
													<th>活动价</th>
												</c:when>
										</c:choose>										
										<th class="o-operate">操作</th>
																				
									</tr>
								</thead>
								<tbody>
									<c:if test="${empty(data.detail)}">
										<tr nodata="1">
											<td colspan="${data.type == '1' ? '11' : '10'}">暂未添加参与活动的商品</td>
										</tr>
									</c:if>
								
									<c:forEach items="${data.detail}" var="detail" varStatus="status">
									<tr>
										<td>${status.index + 1}</td>
										<td>
		                                    <dl class="o-goodsName">		           
		                                    	<dt><img src="${empty(detail.prodImg) ? '../static/img/temp/order_02.jpg'  : imgDownDomain.concat(detail.prodImg)}"></dt>
		                                    	<dd>
		                                    		<a href="http://item.afd.com/detail/${detail.skuId}.html" target="_blank"><c:out value="${detail.prodTitle}"/></a>
		                                    		<p class="o-property">${fn:escapeXml(detail.skuSpecName)}</p>
		                                    		<p>SKU编码：<c:out value="${detail.skuCode}"/></p>
		                                    	</dd>
		                                    </dl>
										</td>
										<td style="align:right"><fmt:formatNumber value="${detail.salePrice}" pattern="0.00"/></td>
										<td style="align:right"><c:out value="${detail.stockBalance}"/></td>
										<td class="align-l"><a href="http://shop.afd.com/${detail.storeId}/" target="_blank"><c:out value="${detail.storeName}"/></a></td>
										<td class="actStock"><input type="text" class="txt"  name="detail-promotionBalance" value="${detail.promotionBalance}" maxlength="3"></td>
										<c:choose>
												<c:when test="${data.type == '1'}"> 
													<td class="buyPrice"><input type="text" class="txt" name="detail-promotionPrice" value="${detail.promotionPrice}" maxlength="9"></td>	
													<td class="actStock"><input type="text" class="txt"  name="detail-purchaseCountLimit" value="${detail.purchaseCountLimit}" maxlength="4"></td>
													<td class="buyTime"><input type="text" class="txt" name="detail-startDate" value="<fmt:formatDate value='${detail.startDate}' type='both' pattern='yyyy-MM-dd HH:mm'/>"></td>
													<td class="buyTime"><input type="text" class="txt" name="detail-endDate" value="<fmt:formatDate value='${detail.endDate}' type='both' pattern='yyyy-MM-dd HH:mm'/>"></td>
																		
												</c:when>
												<c:when test="${data.type == '2'}">
													<td class="actStock"><input type="text" class="txt"  name="detail-purchaseCountLimit" value="${detail.purchaseCountLimit}" maxlength="4"></td>
													<td class="actSate"><input type="text" class="txt" name="detail-discount" value="${detail.discount}" maxlength="4"><i class="ico i-ups"></i><i class="ico i-downs"></i></td>
													<td class="buyPrice"><input type="text" class="txt" name="detail-promotionPrice" value="${detail.promotionPrice}" maxlength="9"></td>
												</c:when>
										</c:choose>													
										<td><a href="#" del="1">删除</a>
											<input type="hidden" name="detail-prodId" value="${detail.prodId}">
											<input type="hidden" name="detail-skuId" value="${detail.skuId}">
											<input type="hidden" name="detail-prodCode" value="${detail.prodCode}">	
											<input type="hidden" name="detail-skuCode" value="${detail.skuCode}">
											<input type="hidden" name="detail-prodTitle" value="${fn:escapeXml(detail.prodTitle)}">
											<input type="hidden" name="detail-prodImg" value="${fn:escapeXml(detail.prodImg)}">
											<input type="hidden" name="detail-salePrice" value="${detail.salePrice}">
											<input type="hidden" name="detail-skuSpecName" value="${fn:escapeXml(detail.skuSpecName)}">
											<input type="hidden" name="detail-storeId" value="${detail.storeId}">
											<input type="hidden" name="detail-storeName" value="${fn:escapeXml(detail.storeName)}">
											<input type="hidden" name="detail-stockBalance" value="${detail.stockBalance}">										
										</td>
									</tr>										
									</c:forEach>								
								</tbody>
							</table>
							<!-- table end -->
							<!-- paging -->
							<div class="paging" style="display:none">
								<div class="pagingWrap">
									<div class="pageup" id="goPrev"><i class="ico"></i>&nbsp;上一页</div>
									<ul>										
									</ul>
									<div class="pagedown" id="goNext">下一页&nbsp;<i class="ico"></i></div>
									<div class="goto"><span>到第</span><input type="text" id="skipPage" value="1"><span>页</span><input type="button" class="btn" id="skipPageBtn" value="确定"/></div>
								</div>
								<div class="count">共<em id="total"></em>条记录，本页显示<em id="cur">20</em>条</div>
							</div>
							<!-- paging end -->
						</div>
					</div>
					<!-- operateStep end -->
					<div class="formBtn">
						<input type="hidden" name="ywPPId" id="ywPPId" value="${data.ywPPId}">
						<input type="submit" class="btnC" value="${empty(data.ywPPId) ? '创建活动' : '保存活动'}" id="btnSubmit">
						<input type="button" class="btn" value="取 消" onclick="javascript:self.location.href='list?m=37';">
					</div>
				</div>
				<!-- activeFlashsale end -->
				
				</form>
				
<script type="text/javascript">
function limitDigit(jq) {
	jq.bind('input propertychange', function(e){
		var jq = $(this), value = jq.val();

		if(value) {
			var newValue = value.replace(/\D/g, '');

			if(value !== newValue) {
				jq.val(newValue);
			}			
		}
	});
}

function limitDigit2(jq) {
	jq.bind('input propertychange', function(e){
		var jq = $(this), value = jq.val();

		if(value) {
			var newValue = value.replace(/[^0-9.]/g, '');

			if(value !== newValue) {
				jq.val(newValue);
			}			
		}
	});
}

$(function(){
	$('#goPrev').click(function(){
		refreshNav(currentPage - 1);
	});
	
	$('#goNext').click(function(){
		refreshNav(currentPage + 1);
	});
	
	limitDigit($('#skipPage, #purchaseCountLimit'));
	
	$('#skipPageBtn').click(function(){
		var skipPage = $('#skipPage').val();
		
		if(skipPage) refreshNav(skipPage);
	});
	
	initHourAndMinute();
	
	$('#allValidRange').change(function(){
		$('input[name="validRange"]').prop('checked', $(this).prop('checked'));
	});
	
	$('input[name="validRange"]').change(function() {
		var all = true;
		
		$('input[name="validRange"]').each(function(){
			all = (all && $(this).prop('checked'));
		});
		
		$('#allValidRange').prop('checked', all);
	});
	
	<c:if test="${empty(param.promotionId)}">
		$('#allValidRange').prop('checked', true);
		$('input[name="validRange"]').prop('checked', true);
	</c:if>
	
	$('#frm').submit(function(){
		$('#btnSubmit').attr('disabled', true);
		var ret = formOnSubmit();
		
		if(ret === false) $('#btnSubmit').attr('disabled', false);
		return ret;
	});
	
	limitDigit2($('#discount'));
	
	$('#discount').bind('input propertychange', function(e){
		var value = $(this).val();
		
		if(value === '') return;
		
		if(value >= 10 || value < 0) $(this).val('');
	});
	
	
	if($('#tbl').find('tr[nodata]').length == 0) {
		$('#tbl').find('tr:gt(0)').each(function(){			
			initSku($(this), true);
		});
	}	
	
	$('#discount').focus(function(){
		$(this).attr('placeHolder', '');
	});
	
	$('#purchaseCountLimit').focus(function(){
		$(this).attr('placeHolder', '');
	});
	
	refreshNav();
});

var currentPage = 1;

function refreshNav(pageNo) {
	var tbl = $('#tbl'), page = $('div.paging');
	
	if(tbl.find('tr[nodata]').length > 0) {
		page.hide();
		return;
	}
	
	var size = tbl.find('tr').length - 1;
	if(size <= 0) {
		page.hide();
		return;
	}
	
	page.find('#total').html(size);
	
	if(!pageNo) {
		pageNo = currentPage;
	} else {
		pageNo = pageNo * 1;
	}
	
	var pageSize = 10, totalPage = Math.ceil(size / pageSize);

	if(pageNo < 1 || pageNo > totalPage) {
		pageNo = 1;	
	}		
		
	var startPos = (pageNo - 1) * pageSize, endPos = startPos + pageSize - 1;
		
	if(endPos > (size - 1)) endPos = size - 1;
	
	page.find('#cur').html((endPos - startPos + 1));
	
	tbl.find('tr:gt(0)').hide();

	tbl.find('tr:lt(' + (endPos + 2) + ')').filter(':gt(' + startPos + ')').show();
	
	currentPage = pageNo;
	
	var startPage = currentPage - 2, endPage = currentPage + 2;
	
	if(startPage < 1) startPage = 1;
	if(endPage > totalPage) endPage = totalPage;
	
	var ul = page.find('ul');
	ul.find('li').remove();
	
	if(startPage != 1) {
		genLi(ul, 1);
	} 
	
	if(startPage > 2) {
		ul.append('<li><b>...</b></li>');
	}
	
	for(var i = startPage; i <= endPage; i++){
		genLi(ul, i);
	}
	
	if(totalPage > endPage) {
		if(totalPage - endPage > 1) {
			ul.append('<li><b>...</b></li>');
		}
		
		genLi(ul, totalPage);
	}
	
	page.show();
}

function genLi(ul, pageNo) {
	var str = '<li>';
	
	if(pageNo == currentPage) {
		str = str + '<span class="on">';
	} else {
		str = str + '<a href="" pageNo="' + pageNo + '">';
	}
	
	str = str + pageNo;
	
	if(pageNo == currentPage) {
		str = str + '</span>';
	} else {
		str = str + '</a>';
	}
	
	str = str + '</li>';
	
	var li = $(str).appendTo(ul);
	
	li.find('a').click(function(e){
		e.preventDefault();
		refreshNav($(this).attr('pageNo'));
	});
} 

function addSku(sku) {
	var tbl = $('#tbl');
	
	tbl.find('tr[nodata]').remove();
	
	var skuCtl = tbl.find('input[name="detail-skuId"][value="' + sku.skuId + '"]'); 
	if(skuCtl.length > 0) return;
	
	var type = $('#type').val();
	var tr = '<tr>';
	
	tr = tr + '<td>' + tbl.find('tr').length + '</td>'
			+ '<td> <dl class="o-goodsName">'; 
	
	if(sku.skuImgUrl) {
		tr = tr + '<dt><img src="${fn:escapeXml(imgDownDomain)}' + sku.skuImgUrl + '"></dt>';
	} else {
		tr = tr + '<dt><img src="../static/img/temp/order_02.jpg"></dt>';
	}

	tr = tr + '<dd>	<a href="http://item.afd.com/detail/' + sku.skuId + '.html" target="_blank">' 
		+ sku.prodTitle + '</a><p class="o-property">' + sku.skuSpecName 
		+ '</p><p>SKU编码：' + sku.skuCode + '</p></dd></dl></td>'
		+ '<td style="align:right">' + (sku.salePrice * 1).toFixed(2) + '</td>'
		+ '<td style="align:right">' + sku.stockBalance + '</td>'
		+ '<td class="align-l"><a href="http://shop.afd.com/' + sku.storeId + '/" target="_blank">' + sku.storeName + '</a></td>';
		
	// 直降
	if(type == '2') {				
		tr = tr + '<td class="actStock"><input type="text" class="txt"  name="detail-promotionBalance" maxlength="3" value="' + sku.stockBalance + '"></td>'
				+ '<td class="actStock"><input type="text" class="txt"  name="detail-purchaseCountLimit" maxlength="4"></td>'
				+ '<td class="actSate"><input type="text" class="txt" name="detail-discount" maxlength="4"><i class="ico i-ups"></i><i class="ico i-downs"></i></td>'
				+ '<td class="buyPrice"><input type="text" class="txt" name="detail-promotionPrice" maxlength="9"></td>';
				
	} 
	// 限时抢购
	else if(type == '1') {
		tr = tr + '<td class="actStock"><input type="text" class="txt"  name="detail-promotionBalance" maxlength="3" value="' + sku.stockBalance + '"></td>'
				+ '<td class="buyPrice"><input type="text" class="txt" name="detail-promotionPrice" maxlength="9"></td>'
				+ '<td class="actStock"><input type="text" class="txt"  name="detail-purchaseCountLimit" maxlength="4"></td>'
				+ '<td class="buyTime"><input type="text" class="txt" name="detail-startDate"></td>'
				+ '<td class="buyTime"><input type="text" class="txt" name="detail-endDate"></td>';
	}	
				
	tr = tr + '<td><a href="#" del="1">删除</a>'
			+ '<input type="hidden" name="detail-prodId" value="' + sku.prodId + '">'
			+ '<input type="hidden" name="detail-skuId" value="' + sku.skuId + '">'	
			+ '<input type="hidden" name="detail-prodCode" value="' + sku.prodCode + '">'	
			+ '<input type="hidden" name="detail-skuCode" value="' + sku.skuCode + '">'
			+ '<input type="hidden" name="detail-prodTitle" value="' + sku.prodTitle + '">'
			+ '<input type="hidden" name="detail-prodImg" value="' + sku.skuImgUrl + '">'
			+ '<input type="hidden" name="detail-salePrice" value="' + sku.salePrice + '">'
			+ '<input type="hidden" name="detail-skuSpecName" value="' + sku.skuSpecName + '">'
			+ '<input type="hidden" name="detail-storeId" value="' + sku.storeId + '">'
			+ '<input type="hidden" name="detail-storeName" value="' + sku.storeName + '">'
			+ '<input type="hidden" name="detail-stockBalance" value="' + sku.stockBalance + '">';
			
	tr = tr + '</td>';
	tr = tr + '</tr>';
		
	var $tr = $(tr).appendTo(tbl);
	
	initSku($tr);	
}

function initSku($tr, init) {	
	var type = $('#type').val();
	
	$tr.find('a[del]').click(function(e){
		e.preventDefault();
		
		$('#tbl').find('tr:gt(' + $tr.index() + ')').each(function(){
			$(this).find('td:eq(0)').html($(this).index());
		});
		
		$tr.remove();
		refreshNav();
	});
	
	limitDigit($tr.find('input[name="detail-promotionBalance"],input[name="detail-purchaseCountLimit"]'));
	limitDigit2($tr.find('input[name="detail-discount"], input[name="detail-promotionPrice"]'));
	
	if(!(init === true)) {
		var discount = $('#discount').val();
		
		if(discount) {
			$tr.find('input[name="detail-discount"]').val(discount);
			$tr.find('input[name="detail-promotionPrice"]').val((discount * 0.1 * $tr.find('input[name="detail-salePrice"]').val()).toFixed(2));
		};
		
		var purchaseCountLimit = $('#purchaseCountLimit').val();
		
		if(purchaseCountLimit) {
			$tr.find('input[name="detail-purchaseCountLimit"]').val(purchaseCountLimit);
		}
	}
	
	$tr.find('p.o-property').each(function(){
		var specName = $(this).html();
		
		if(specName) {
			var arr = specName.split('|||'), html='';
			
			$(arr).each(function(){
				html = html + ' <span>' + this.replace(/:::/g, ': ') + '</span>';
			});
			
			$(this).html(html);		
		}
	});
	
	
	if(type == '2') {
		$tr.find('input[name="detail-discount"]').bind('input propertychange', function(e){
			var discount = $(this).val(), 
				promotionPrice = $tr.find('input[name="detail-promotionPrice"]').val(),
				salePrice =  $tr.find('input[name="detail-salePrice"]').val();
			
			if(discount === '' || discount === '.') return;
			
			discount = discount * 1;

			if(discount >= 10 || discount < 0) {
				$(this).val('');
				$tr.find('input[name="detail-promotionPrice"]').val('');
			
			} else {
				var newPromotionPrice = (discount * salePrice / 10).toFixed(2);
				
				if(newPromotionPrice != promotionPrice)  $tr.find('input[name="detail-promotionPrice"]').val(newPromotionPrice);
			}			
		}).bind('blur', function(){
			var value = $(this).val();
			
			if(value === '.') {
				$(this).val('');
				$tr.find('input[name="detail-promotionPrice"]').val('');
			} else {
				if(value) {
					value = (value * 1).toFixed(2);
					$(this).val(value);
				}
			}
		});
		
		$tr.find('input[name="detail-promotionPrice"]').bind('input propertychange', function(e){
			var discount = $tr.find('input[name="detail-discount"]').val(), 
				promotionPrice = $(this).val(),
				salePrice =  $tr.find('input[name="detail-salePrice"]').val() * 1;

			if(promotionPrice === '' || promotionPrice === '.') return;
			
			promotionPrice = promotionPrice * 1;
			
			if(promotionPrice < 0 || promotionPrice > salePrice) {
				$(this).val('');
				$tr.find('input[name="detail-discount"]').val('');
			
			} else {
				var newDiscount = (promotionPrice / salePrice * 10).toFixed(2);				
				if(newDiscount >= 10) newDiscount = 9.99;
				
				if(newDiscount != discount)  $tr.find('input[name="detail-discount"]').val(newDiscount);
			}			
		}).bind('blur', function(){
			var value = $(this).val();
			
			if(value === '.') {
				$(this).val('');
				$tr.find('input[name="detail-discount"]').val('');
			} else {
				if(value) {
					value = (value * 1).toFixed(2);
					$(this).val(value);
				}
			}
		});
		
		$tr.find('i.i-ups').click(function(){
			var ctl = $tr.find('input[name="detail-discount"]'), discount = ctl.val(), newValue;
			
			if(!discount) {
				newValue = 1;
			} else {
				newValue = discount * 1 + 1;
				
				if(newValue >= 10) newValue = discount;
			}
						
			ctl.val(newValue);
			
			if(newValue != discount) ctl.trigger('input').trigger('propertychange');
		});
		
		$tr.find('i.i-downs').click(function(){
			var ctl = $tr.find('input[name="detail-discount"]'), discount = ctl.val(), newValue;
			
			if(!discount) {
				newValue = 9;
			} else {
				newValue = discount - 1;
				
				if(newValue <= 0) newValue = discount;
			}
			
			
			ctl.val(newValue);
			if(newValue != discount) ctl.trigger('input').trigger('propertychange');
		});
		
	} else if(type == '1') {
		$tr.find('input[name="detail-promotionPrice"]').bind('blur', function(){
			var value = $(this).val();
			
			if(value === '.') {
				$(this).val('');
			} else {
				if(value) {
					value = (value * 1).toFixed(2);
					$(this).val(value);
				}
			}
		});
		$tr.find('input[name="detail-startDate"],input[name="detail-endDate"]').focus(function(){WdatePicker({dateFmt:'yyyy-MM-dd HH:mm', autoPickDate:true});});
	}
}

function initHourAndMinute() {
	$('#startHour, #endHour').each(function(){
		for(var i = 0; i < 24; i++) {
			var s = i;
			
			if(s < 10) s = '0' + s;
			
			$(this).append('<option value="' + s + '">' + s+ '</option>');
		}	
		
		var initValue = $(this).attr('initValue');
		if(initValue) $(this).val(initValue);
	});
	
	$('#startMinute, #endMinute').each(function(){
		for(var i = 0; i < 60; i++) {
			var s = i;
			
			if(s < 10) s = '0' + s;
			
			$(this).append('<option value="' + s + '">' + s+ '</option>');
		}	
		
		var initValue = $(this).attr('initValue');
		if(initValue) $(this).val(initValue);
	});
}

function chnLength(value) {
	if(!value) return 0;
	
	value = value.replace(/[^\x00-\xff]/g, '11');
	return value.length;
}

Date.prototype.format = function(format){ 
	var o = { 
	"M+" : this.getMonth()+1, //month 
	"d+" : this.getDate(), //day 
	"h+" : this.getHours(), //hour 
	"m+" : this.getMinutes(), //minute 
	"s+" : this.getSeconds(), //second 
	"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
	"S" : this.getMilliseconds() //millisecond 
	} 

	if(/(y+)/.test(format)) { 
	format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	} 

	for(var k in o) { 
	if(new RegExp("("+ k +")").test(format)) { 
	format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
	} 
	} 
	return format; 
} 

function formOnSubmit() {
	var name = $('#name').val();
	
	if(!name) {
		alert('请输入活动名称！');
		return false;
	}
	
	if(chnLength(name) > 40) {
		alert('活动名称最多40个字符（20个汉字）！');
		return false;
	}
	
	/**
	if(!/^[\u4e00-\u9fa5a-zA-Z0-9]+$/.test(name)) {
		alert('活动名称填写有误，可为中文、英文或数字组合，最多40个字符（1个汉字占2个字符）！');
		return false;
	} */
	
	if(name != $('#name').attr('initValue')) {
		var isExist = false;
		$.ajax({url:'existsName', type:'post', data:{'name':name}, 
			dataType:'json', async:false,
			success : function(data) {
				if(data) {			
					alert('该活动名称已被使用，请填写其他名称！');
					isExist = true;
				}
			},
			error : function() {
				alert('系统繁忙，无法验证活动名称是否重复，请稍后再试！');
				isExist = true;
			}});	
		
		if(isExist) return false;
	}
	
	if(!$('#startDay').val()) {
		alert('请完整填写活动开始时间！');
		return false;
	}
	
	if(($('#startDay').val() + $('#startHour').val() + $('#startMinute').val()) < new Date().format("yyyy-MM-ddhhmm")) {
		alert('活动开始时间不能小于当前时间！');
		return false;
	}
			
	var endType = $('input[name="endType"]:checked').val();
	
	if(!endType) {
		alert('请填写活动结束时间！')
		return false;
	}
	
	if(endType == '2' && !$('#endDay').val()) {
		alert('请完整填写活动结束时间！')
		return false;
	};
	
	if(endType == '2' && ($('#startDay').val() + $('#startHour').val() + $('#startMinute').val()) >= ($('#endDay').val() + $('#endHour').val() + $('#endMinute').val())) {
		alert('结束时间必须大于开始时间！');
		return false;
	}
	
	if($('input[name="validRange"]:checked').length == 0) {
		alert('请选择活动范围！');
		return false;
	}
	
	if($('#remark').val().length > 1000) {
		alert('活动规则超出位数限制，请确认后重新提交！');
		return false;
	}
	
	if($('input[name="detail-skuId"]').length == 0) {
		alert("请设置参与活动商品！");
		return false;
	}
	
	var type = $('#type').val();
		
	if(type == '2') {
		var trs = $('#tbl').find('tr:gt(0)');
		
		for(var i = 0; i < trs.length; i++) {
			var tr = $(trs[i]);
			
			var balance = tr.find('input[name="detail-promotionBalance"]').val(),
				discount = tr.find('input[name="detail-discount"]').val(),
				promotionPrice = tr.find('input[name="detail-promotionPrice"]').val(),
				purchaseCountLimit = tr.find('input[name="detail-purchaseCountLimit"]').val();
			
			if(!balance || !discount || !promotionPrice) {
				alert('第' + (i + 1) + '个商品数据填写不完整！');
				return false;
			}
			
			var salePrice = tr.find('input[name="detail-salePrice"]').val(),
				stockBalance = tr.find('input[name="detail-stockBalance"]').val() ;
			
			if((balance * 1) <= 0) {
				alert('第' + (i + 1) + '个商品活动库存必须大于0！');
				return false;
			}
						
			if((balance * 1) > stockBalance) {
				alert('第' + (i + 1) + '个商品活动库存超出现有可用库存！');
				return false;
			}
			
			if(purchaseCountLimit !== '') {
				purchaseCountLimit = purchaseCountLimit * 1;
				if(!purchaseCountLimit) {
					alert('第' + (i + 1) + '个商品限购数量不能为0！');
					return false;
				}
				
				if(purchaseCountLimit > (balance * 1)) {
					alert('第' + (i + 1) + '个商品限购数量不能大于活动库存！');
					return false;
				}
			}
			
			if((promotionPrice * 1) <= 0) {
				alert('第' + (i + 1) + '个商品活动价必须大于0！');
				return false;
			}
			
			if((promotionPrice * 1) > salePrice) {
				alert('第' + (i + 1) + '个商品活动价超出当前价格！');
				return false;
			}
		}
	
	} else if(type == '1') {
		var trs = $('#tbl').find('tr:gt(0)');
		var promotionStartDate = $('#startDay').val() + ' ' +  $('#startHour').val() + ':' +  $('#startMinute').val(),
			promotionEndDate;
		
		if(endType == '2') 
			promotionEndDate = $('#endDay').val() + ' ' +  $('#endHour').val() + ':' +  $('#endMinute').val();
		
		for(var i = 0; i < trs.length; i ++) {
			var tr = $(trs[i]);
						
			var balance = tr.find('input[name="detail-promotionBalance"]').val(),
				startDate = tr.find('input[name="detail-startDate"]').val(),
				endDate = tr.find('input[name="detail-endDate"]').val(),
				promotionPrice = tr.find('input[name="detail-promotionPrice"]').val(),
				purchaseCountLimit = tr.find('input[name="detail-purchaseCountLimit"]').val();
			
			if(!balance || !promotionPrice || !startDate || !endDate) {
				alert('第' + (i + 1) + '个商品数据填写不完整！');
				return false;
			}
						
			var salePrice = tr.find('input[name="detail-salePrice"]').val(),
				stockBalance = tr.find('input[name="detail-stockBalance"]').val() ;
			
			if((balance * 1) <= 0) {
				alert('第' + (i + 1) + '个商品活动库存必须大于0！');
				return false;
			}
			
			if((balance * 1) > stockBalance) {
				alert('第' + (i + 1) + '个商品活动库存超出现有可用库存！');
				return false;
			}
					
			if((promotionPrice * 1) <= 0) {
				alert('第' + (i + 1) + '个商品活动价必须大于0！');
				return false;
			}
			
			if((promotionPrice * 1) > salePrice) {
				alert('第' + (i + 1) + '个商品活动价超出当前价格！');
				return false;
			}  
			
			if(purchaseCountLimit !== '') {
				purchaseCountLimit = purchaseCountLimit * 1;
				if(!purchaseCountLimit) {
					alert('第' + (i + 1) + '个商品限购数量不能为0！');
					return false;
				}
				
				if(purchaseCountLimit > (balance * 1)) {
					alert('第' + (i + 1) + '个商品限购数量不能大于活动库存！');
					return false;
				}
			}
			
			if(endDate <= startDate) {
				alert('第' + (i + 1) + '个商品抢购结束时间不能小于抢购开始时间！');
				return false;
			}
			
			if(startDate < promotionStartDate) {
				alert('第' + (i + 1) + '个商品抢购开始时间不能小于活动开始时间！');
				return false;
			}
			
			if(endType == '2' && endDate > promotionEndDate) {
				alert('第' + (i + 1) + '个商品抢购结束时间不能超过活动结束时间！');
				return false;
			}			
		}
	
	} 
}
</script>
</body>
</html> --%>