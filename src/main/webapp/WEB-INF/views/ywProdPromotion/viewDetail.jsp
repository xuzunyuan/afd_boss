<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@include file="/common/common.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>一网全城--活动商品</title>
</head>
<body>
	<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/page.js?t=2014061701"></script>

	<!-- foldbarV -->
				<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
				<!-- foldbarV end -->
				<!-- crumbs -->
				<div class="crumbs crumbsA">
					<ul>
						<li><a href="#">后台首页</a><em>&gt;</em></li>
						<li><a href="#">活动管理</a><em>&gt;</em></li>
						<li><strong>活动商品</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- sellerData -->
					<div class="sellerData activeGoods">
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
									<li><a href="viewPromotion?promotionId=${promotion.ywPPId}">活动概要</a></li>
									<li class="on"><a href="#">活动商品</a></li>
								</ul>
							</div>
						</div>
						<!-- tab end -->
						<form class="form formA">
							<fieldset class="last">
								<!-- tab -->
								<table class="table tableB" id="tbl">
									<colgroup>
										<col width="30">
										<col width="260">
										<col>
										<col width="40">
										<col width="90">
										<col width="70">
										<col width="60">
										<col width="60">
										<col width="60">
										<col>
										<col width="60">
									</colgroup>
									<thead>
										<tr>
											<th>序号</th>
											<th>商品名称</th>
											<th>店铺名称</th>
											<th>库存</th>
											<th>活动库存/剩余</th>
											<th>单价（元）</th>
											<th>活动价</th>
											<th>折扣率</th>
											<th>限购数量</th>
											<th>抢购起止时间</th>
											<th class="o-operate">状态</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${page.result}" var="detail" varStatus="status">
										<tr>
											<td>${(page.currentPageNo-1)*page.pageSize+status.count}</td>
											<td>
			                                    <dl class="o-goodsName">
		                                    		<dt><img src="${empty(detail.prodImg) ? '../static/img/temp/order_02.jpg'  : imgDownDomain.concat(detail.prodImg)}">
			                                    	<dd>
			                                    		<a href="http://item.yiwang.com/detail/${detail.skuId}.html" target="_blank"><c:out value="${detail.prodTitle}"/></a>
			                                    		<p class="o-property"><c:out value="${detail.skuSpecName}"/></p>
			                                    		<p>SKU编码：<c:out value="${detail.skuCode}"/></p>			                                    		
			                                    	</dd>
			                                    </dl>
											</td>
											<td class="align-l"><a href="http://shop.yiwang.com/${detail.storeId}/" target="_blank"><c:out value="${detail.storeName}"/></a></td>
											<td style="align:right"><c:out value="${detail.stockBalance}"/></td>
											<td style="align:right"><c:out value="${detail.promotionBalance}"/>/<c:out value="${empty(detail.saledAmount) ? detail.promotionBalance : (detail.promotionBalance - detail.saledAmount)}"/></td>
											<td style="align:right"><fmt:formatNumber value="${detail.salePrice}" pattern="0.00"/></td>
											<td style="align:right"><fmt:formatNumber value="${detail.promotionPrice}" pattern="0.00"/></td>
											<td style="align:right"><fmt:formatNumber value="${detail.discount}" pattern="0.00"/>&nbsp;折</td>
											<td><c:choose>
												<c:when test="${empty(detail.purchaseCountLimit) || detail.purchaseCountLimit == 0}">
													<p>&nbsp;</p>
												</c:when>
												<c:otherwise>
													${detail.purchaseCountLimit}&nbsp;件
												</c:otherwise>
											</c:choose></td>
											<td><p><fmt:formatDate value="${detail.startDate}" type="both" pattern="yyyy-MM-dd HH:mm"/> </p><p><fmt:formatDate value="${detail.endDate}" type="both" pattern="yyyy-MM-dd HH:mm"/></p></td>
																						
											<td><c:choose>
											<c:when test="${detail.status == '1'}">待开始</c:when>
											<c:when test="${detail.status == '2'}">抢购中</c:when>
											<c:when test="${detail.status == '3'}">已结束</c:when>
											<c:when test="${detail.status == '4'}">已取消</c:when>
											<c:when test="${detail.status == '5'}">已终止</c:when>
											</c:choose></td>
										</tr>
										</c:forEach>
										
									</tbody>
								</table>
								<!-- tab end -->
								<!-- paging -->
								<div class="paging">
									 	<p:page page="${page}" action="viewDetail"/>
								</div>	
								<!-- paging end -->
							</fieldset>
						</form>
						<div class="formBtn">
							<input type="button" class="btn" value="返回列表页" onclick="javascript:self.location.href='list';">
						</div>
					</div>
				<!-- sellerData end-->

<script type="text/javascript">
$(function(){
	$('#tbl').find('p.o-property').each(function(){
		var specName = $(this).html();
		
		if(specName) {
			var arr = specName.split('|||'), html='';
			
			$(arr).each(function(){
				html = html + ' <span>' + this.replace(/:::/g, ': ') + '</span>';
			});
			
			$(this).html(html);		
		}
	});
});
</script>				

</body>
</html>