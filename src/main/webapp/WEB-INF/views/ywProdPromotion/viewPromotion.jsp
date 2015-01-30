<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%
com.afd.model.product.YWProdPromotion data = (com.afd.model.product.YWProdPromotion)request.getAttribute("promotion");

if(data != null && data.getValidRange() != null) {
	request.setAttribute("rangeWeb", ((data.getValidRange() & 1) != 0));
	request.setAttribute("rangeTel", ((data.getValidRange() & 2) != 0));
	request.setAttribute("rangeIos", ((data.getValidRange() & 4) != 0));
	request.setAttribute("rangeAnd", ((data.getValidRange() & 8) != 0));
}
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>一网全城--活动概要</title>
</head>
<body>
				<!-- foldbarV -->
				<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
				<!-- foldbarV end -->
				<!-- crumbs -->
				<div class="crumbs crumbsA">
					<ul>
						<li><a href="#">后台首页</a><em>&gt;</em></li>
						<li><a href="#">活动管理</a><em>&gt;</em></li>
						<li><strong>活动概要</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- sellerData -->
					<div class="sellerData activeOutline">
						<div class="hintBar">
							<dl>
								<dt><i class="icon i-exclaim"></i></dt>
								<dd>
									<h4>请注意：</h4>
									<ul>
										<li><em>·</em>支持对活动的查询、上线、终止等操作</li>
										<li><em>·</em>已创建未上线的活动，可编辑、可取消</li>
									</ul>
								</dd>
							</dl>
						</div>
						<!-- tab -->
						<div class="tab">
							<div class="tabs">
								<ul>
									<li class="on"><a href="#">活动概要</a></li>
									<li><a href="viewDetail?promotionId=${param.promotionId}">活动商品</a></li>
								</ul>
							</div>
						</div>
						<!-- tab end -->
						<form class="form formA">
							<fieldset class="last">
								<dl class="item">
									<dt class="item-label">
										<label><em>*</em>活动名称：</label>
									</dt>
									<dd class="item-cont">
										<p>
											<b><c:out value="${promotion.name}"/></b>
										</p>
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>活动类型：</label>
									</dt>
									<dd class="item-cont">
										<p><c:choose>
											<c:when test="${promotion.type == '1'}">限时抢购</c:when>
											<c:when test="${promotion.type == '2'}">直降/折扣</c:when>
										</c:choose>
										</p>
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>活动状态：</label>
									</dt>
									<dd class="item-cont">
										<p class="meg"><c:choose>
											<c:when test="${promotion.status == '1'}">已创建</c:when>
											<c:when test="${promotion.status == '2'}">活动中</c:when>
											<c:when test="${promotion.status == '3'}">结束</c:when>
											<c:when test="${promotion.status == '4'}">取消</c:when>
											<c:when test="${promotion.status == '5'}">终止</c:when>
											</c:choose></p>
									</dd>
								</dl>								
								<dl class="item">
									<dt class="item-label">
										<label>活动时间：</label>
									</dt>
									<dd class="item-cont">
										<p><fmt:formatDate value="${promotion.startDate}" type="both" pattern="yyyy年MM月dd日 HH:mm"/><span> — </span><fmt:formatDate value="${promotion.endDate}" type="both" pattern="yyyy年MM月dd日 HH:mm"/></p>
									</dd>
								</dl>
								<c:if test="${promotion.status == '2' && !empty(promotion.remainDay)}">
									<dl class="item">
									<dt class="item-label">
										<label>剩余时间：</label>
									</dt>
									<dd class="item-cont">
										<p style="color:red"> ${promotion.remainDay}天${promotion.remainHour}小时${promotion.remainMin}分钟
										</p>
									</dd>
									</dl>
								</c:if>																
								<dl class="item">
									<dt class="item-label">
										<label>适用范围：</label>
									</dt>
									<dd class="item-cont">
										<c:if test="${rangeWeb}"><p>网站</p></c:if>
										<c:if test="${rangeTel}"><p>电话下单</p></c:if>
										<c:if test="${rangeIos}"><p>IOS客户端</p></c:if>
										<c:if test="${rangeAnd}"><p>Android客户端</p></c:if>
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>统一折扣：</label>
									</dt>
									<dd class="item-cont">
										<c:choose>
											<c:when test="${empty(promotion.discount)}">
												<p>否</p>
											</c:when>
											<c:otherwise>
												<fmt:formatNumber value="${promotion.discount}" pattern="0.00"/>&nbsp;折
											</c:otherwise>
										</c:choose>										
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>限购数量：</label>
									</dt>
									<dd class="item-cont">
										<c:choose>
											<c:when test="${empty(promotion.purchaseCountLimit) || promotion.purchaseCountLimit == 0}">
												<p>无</p>
											</c:when>
											<c:otherwise>
												${promotion.purchaseCountLimit}&nbsp;件
											</c:otherwise>
										</c:choose>										
									</dd>
								</dl>
								
								<dl class="item">
									<dt class="item-label">
										<label>宣传语：</label>
									</dt>
									<dd class="item-cont">
										<p><c:out value="${promotion.publicity}"/></p>
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>规则说明：</label>
									</dt>
									<dd class="item-cont"  id="publicity"><c:out value="${promotion.remark}"/></dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>创建人：</label>
									</dt>
									<dd class="item-cont">
										<p><c:out value="${promotion.createByName}"/></p>
									</dd>
								</dl>
								<dl class="item">
									<dt class="item-label">
										<label>创建时间：</label>
									</dt>
									<dd class="item-cont">
										<p><fmt:formatDate value="${promotion.createByDate}" type="both" pattern="yyyy年MM月dd日 HH:mm"/></p>
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
});

</script>

</body>
</html>