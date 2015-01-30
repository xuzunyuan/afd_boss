
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>操作成功</title>		
	</head>
	<body id="">
	<link rel="stylesheet" href="${ctx}/static/style/classes_.css?t=201406261" />
	<!-- main -->
			<div class="main">
				<!-- foldbarV -->
				<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
				<!-- foldbarV end -->
				<!-- crumbs -->
				<div class="crumbs crumbsA">
					<ul>
						<li><a href="#">后台首页</a><em>&gt;</em></li>
						<li><a href="#">卖家管理</a><em>&gt;</em></li>
						<li><strong>下单操作</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- orderSuccess -->
				<div class="orderSuccess">
					<dl>
						<dt><i class="icon i-ok50"></i></dt>
						<dd>
							<h2>订单已经成功提交</h2>
							
							<c:forEach items="${orderlist}" var="order" varStatus="status">
							<p>系统已通知<em><a href="http://shop.yiwang.com/${storelist[status.index].storeId}/" target="_blank">${storelist[status.index].storeName}</a></em>发货</p>
							<p><a href="${ctx}/order/orderDetail?orderId=${order.orderId}">查看订单详情</a></p>
							</c:forEach>
						</dd>
					</dl>
					<div class="orderGuide">
						<h3>您还可以：</h3>
						<p><a href="${ctx}/order/cart" class="lnkA">继续下单</a><a href="${ctx}/order/queryOrder">查看全部订单</a></p>
					</div>
					<div class="orderHelp">
						<h2>订单常见问题<em>&amp;</em>帮助</h2>
						<ul>
							<li><i>·</i><a href="#">只能购买吉林省内卖家店铺的东东，并且订单也只能配送到吉林省内</a></li>
							<li><i>·</i><a href="#">只能购买吉林省内卖家店铺的东东，并且订单也只能配送到吉林省内</a></li>
							<li><i>·</i><a href="#">订单付款方式：只付款货到付款</a></li>
							<li><i>·</i><a href="#">订单付款方式：只付款货到付款</a></li>
							<li><i>·</i><a href="#">订单配送方式：吉林省EMS统一发货</a></li>
							<li><i>·</i><a href="#">订单配送方式：吉林省EMS统一发货</a></li>
						</ul>
					</div>
				</div>
				<!-- orderSuccess end -->
			</div>
			<!-- main end -->
</body>
	</html>