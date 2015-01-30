<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
com.afd.model.seller.StorePromotion promotion = (com.afd.model.seller.StorePromotion)request.getAttribute("promotion");

request.setAttribute("rangeWeb", ((promotion.getValidRange() & 1) != 0));
request.setAttribute("rangeIos", ((promotion.getValidRange() & 4) != 0));
request.setAttribute("rangeAnd", ((promotion.getValidRange() & 8) != 0));
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>活动概要</title>
</head>
<body>
	<script language="javascript" type="text/javascript" src="<%= request.getContextPath() %>/static/js/region.js"></script>
	<!-- foldbarV -->
				<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
				<!-- foldbarV end -->
				<!-- crumbs -->
				<div class="crumbs crumbsA">
					<ul>
						<li><a href="#">后台首页</a><em>&gt;</em></li>
						<li><a href="#">卖家管理</a><em>&gt;</em></li>
						<li><strong>活动概要</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- sellerData -->
					<div class="sellerData activeGoods storeoutline">
						<div class="hintBar">
							<dl>
								<dt><i class="icon i-exclaim"></i></dt>
								<dd>
									<h4>请注意：</h4>
									<ul>
										<li><em>·</em>boss系统支持对店铺满减、满赠活动的查询、上线、撤销、终止等操作</li>
										<li><em>·</em>已编辑但是未上线的活动，可以撤销</li>
									</ul>
								</dd>
							</dl>
						</div>
						<!-- tab -->
						<div class="tab">
							<div class="tabs">
								<ul>
									<li class="on"><a href="#">活动概要</a></li>
								</ul>
							</div>
						</div>
						<!-- tab end -->
						<form class="form formA">
							<fieldset>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>活动名称：</label></dt>
								<dd class="item-cont">
									<p><c:out value="${promotion.name}"/></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>活动类型：</label></dt>
								<dd class="item-cont">
									<p>免邮</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>开始时间：</label></dt>
								<dd class="item-cont">
									<c:choose>
									<c:when test="${!empty(promotion.startByhandDate)}">
										<p><span><fmt:formatDate value="${promotion.startByhandDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></span><span class="starBef"><fmt:formatDate value="${promotion.startDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></span></p>
									</c:when>
									<c:otherwise>
										<p><span></span><span><fmt:formatDate value="${promotion.startDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></span></p>
									</c:otherwise>
									</c:choose>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>结束时间：</label></dt>
								<dd class="item-cont">
									<c:choose>
									<c:when test="${!empty(promotion.endByDate)}">
										<p><span><fmt:formatDate value="${promotion.endByDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></span><span class="starBef"><fmt:formatDate value="${promotion.endDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></span></p>
									</c:when>
									<c:otherwise>
										<p><fmt:formatDate value="${promotion.endDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></p>
									</c:otherwise>
									</c:choose>		
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>剩余时间：</label></dt>
								<dd class="item-cont">
									<p class="meg"><c:if test="${promotion.status == 50 && !empty(promotion.remainDay)}">${promotion.remainDay}天${promotion.remainHour}小时${promotion.remainMin}分钟</c:if></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>活动状态：</label></dt>
								<dd class="item-cont">
									<p class="meg"><c:choose>
										<c:when test="${promotion.status == 49}">已创建</c:when>
										<c:when test="${promotion.status == 50}">进行中</c:when>
										<c:when test="${promotion.status == 51}">结束</c:when>
										<c:when test="${promotion.status == 52}">取消</c:when>
										<c:when test="${promotion.status == 53}">终止</c:when>
									</c:choose></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>活动范围：</label>
								</dt>
								<dd class="item-cont">
										<c:if test="${rangeWeb}"><span>网站</span></c:if>
										<c:if test="${rangeIos}"><span>IOS客户端</span></c:if>
										<c:if test="${rangeAnd}"><span>Android客户端</span></c:if>									
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>满：</label></dt>
								<dd class="item-cont">
									<strong><fmt:formatNumber value="${promotion.amtThreshhold}" pattern="0.00"/></strong>
									<span>元</span>
									<span class="meg">免运费</span>
								</dd>
							</dl>
							
													
							<dl class="item item-tabel">
								<dt class="item-label"><label><em>*</em>免邮地区：</label></dt>
								<dd class="item-cont" id="freepost">
									<!-- table -->
									<table class="table tableC" id="tbl">
										<colgroup>
											<col width="100">
											<col width="100">
											<col width="600">
										</colgroup>

										<tbody>
											
										</tbody>
									</table>
									<!-- table end -->
								</dd>
							</dl>							
						
					
						<dl class="item last">
								<dt class="item-label">
									<label>规则说明：</label>
								</dt>
								<dd class="item-cont item-pub">
									<p id="publicity"><c:out value="${promotion.remark}"/></p>
								</dd>
						</dl>
												
						</fieldset>
						</form>
						<div class="formBtn">
							<input type="button" class="btn" value="返回列表页" onclick="javascript:self.location.href='list';">
						</div>
					</div>
				<!-- sellerData end-->
	<script type="text/javascript">
$(function(){
	var html = $('#publicity').html();
	
	html = html.replace(/\r\n/g, '<br/>').replace(/\r/g, '<br/>').replace(/\n/g, '<br/>');
	$('#publicity').html(html);
	 
	 setTable();
});

function setTable() {
	var tbody = $('#tbl>tbody'), cities = '${promotion.applyCityIds}'.split(','), html = '', arr=[];
	
	if(!'${promotion.applyCityIds}') {
		$('#freepost').html('<span>全国</span>');
		return;
	}
	
	tbody.empty();
	
	$(cities).each(function(index, cityId){
		var c = true;
		$(Region).each(function(i, region){
			$(this.children).each(function(j, province){
				$(this.children).each(function(k, city){
					if(city.id == cityId) {
						var region1, province1;
						
						$(arr).each(function(){
							if(this.id == region.id) {
								region1 = this;
								return false;
							}
						});
						
						if(!region1) {
							region1 = {id : region.id, name : region.name, children : []};
							arr[arr.length] = region1;
						}
						
						$(region1.children).each(function(){
							if(this.id == province.id) {
								province1 = this;
								return false;
							}							
						});
						
						if(!province1) {
							province1 = {id : province.id, name : province.name};
							region1.children[region1.children.length] = province1;
						}
						
						if(province1.cities) {
							province1.cities += ',' + city.name;
						} else {
							province1.cities = city.name;
						}
						
						c = false;
						return false;
					}
				});
				
				return c;
			});
			
			return c;
		});
	});
		
	$(arr).each(function(i, region){
		$(region.children).each(function(j, province){
			html += '<tr>';
			
			if(j == 0) {
				html += '<th rowspan="' + region.children.length + '">' + region.name + '</th>';				
			} 
			
			html += '<td>' + province.name + '</td>'
				+ '<td class="city">' + province.cities + '</td></tr>';
		});
	});
	
	tbody.append(html);
}

</script>	

</body>
</html>