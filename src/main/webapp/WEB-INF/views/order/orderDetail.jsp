<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>卖家后台|订单详情页</title>
	</head>
	<body>
		<style type="text/css">
		dt{font-weight: normal}
		</style>
		
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- orderDetails -->
		<div class="orderDetails">
			<!-- mod-info -->
			<div class="mod-info">
				<div class="item">
					<h2>订单信息<a href="${ctx}/order/queryOrder" class="lnkA" style="float:right;font-weight: normal;">返回列表页</a></h2>
					<table>
						<colgroup>
							<col width="100" />
							<col />
							<col width="100" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>订单编号：</th>
								<td>${order.orderCode}</td>
								<th>支付类型：</th>
								<td><c:out value="${order.strPayType}"></c:out></td>
							</tr>
							<tr>
								<th>订单状态：</th>
								<td><c:out value="${order.strOrderStatus}"></c:out></td>
								<th>付款状态：</th>
								<td><c:out value="${order.strPayStatus}"></c:out></td>
							</tr>
							<tr>
								<th>下单时间：</th>
								<td><fmt:formatDate value="${order.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<th>订单来源：</th>
								<td><c:out value="${order.strOrderSource}"></c:out></td>
							</tr>
							<tr>
								<th>专场名称：</th>
								<td><a href="${ctx}/brandShow/manPage?brandShowId=${order.brandShowId}"><c:out value="${order.brandShowTitle}"></c:out></a></td>
							</tr>
						</tbody>
					</table>
				</div><!-- item end -->
				<div class="item">
					<h2>收货信息</h2>
					<table>
						<colgroup>
							<col width="100" />
							<col />
							<col width="100" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>买家用户名：</th>
								<td><c:out value="${order.userName}"></c:out></td>
							</tr>
							<tr>
								<th>收货人：</th>
								<td><c:out value="${order.rName}"></c:out></td>
								<th>买家留言：</th>
								<td rowspan="2">
									<c:choose>
										<c:when test="${order.userRemark != null && order.userRemark != ''}">
											<c:out value="${order.userRemark}"></c:out>
										</c:when>
										<c:otherwise>
											无
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th>收货地址：</th>
								<td>
									<c:out value="${order.rProvince}"></c:out>
									<c:out value="${order.rCity}"></c:out>
									<c:out value="${order.rCounty}"></c:out>
									<c:out value="${order.rTown}"></c:out>
									<c:out value="${order.rAddr}"></c:out>
								</td>
							</tr>
							<tr>
								<th>联系电话：</th>
								<td class="tell">
									<c:choose>
										<c:when test="${not empty order.rMobile and not empty order.rPhone}">
											<span>${order.rMobile}</span>/<span>${order.rPhone}</span>
										</c:when>
										<c:when test="${order.rMobile != ''}">
											<span>${order.rMobile}</span>
										</c:when>
										<c:otherwise>
											<span>${order.rPhone}</span>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</tbody>
					</table>
				</div><!-- item end -->
			</div>
			<!-- mod-info end -->
			<!-- table -->
			<table class="table tableB">
				<colgroup>
					<col width="360" />
					<col width="150" />
					<col width="110" />
					<col width="100" />
					<col width="80" />
					<col width="90" />
					<col width="120" />
				</colgroup>
				<thead>
					<tr>
						<th>商品</th>
						<th>商品编号</th>
						<th>单价(元)</th>
						<th>特卖价(元)</th>
						<th>数量</th>
						<th>优惠(元)</th>
						<th>状态</th>
					</tr>
				</thead>
				<tbody>
					<%-- <tr>
						<td colspan="7" class="o-code">
							<span>快递：<em><c:out value="${order.logisticsName}"/></em></span>
							<c:if test="${not empty order.awbNo}">
								<span>运单号码：<em><c:out value="${order.awbNo}"/></em></span>
							</c:if>
 							<div class="logistics">
<!-- 								<p class="now">2013-11-15   13:29:03   在天津滨海新区大港油田公司进公司公司行扫描港油田公司进公司公司行扫描</p> -->
<!-- 								<div class="mod-more"> -->
<!-- 									<h3>更多<i class="arrow arrB-D"></i></h3> -->
<!-- 									<div class="bd"> -->
<!-- 										<p class="new">2013-11-15   13:29:03   在天津滨海新区大港油田公司进公司公司行扫描</p> -->
<!-- 										<p>2013-11-15   13:29:03   在天津滨海新区大港油田公司进公司公司司公司行扫描</p> -->
<!-- 										<p>2013-11-15   13:29:03   在天津滨海新区大港油田公司进公司公</p> -->
<!-- 										<p>2013-11-15   13:29:03   在天津滨海新区大港油田公司进公司公司行扫描</p> -->
<!-- 										<p>2013-11-15   13:29:03   在天津滨海新区大港油田公司进公司公司扫描</p> -->
<!-- 									</div> -->
<!-- 								</div> -->
 							</div>
						</td>
					</tr> --%>
					<c:if test="${not empty orderItems}">
					<c:forEach items="${orderItems}" var="orderItem">
						<tr>
							<td>
	                            <dl class="o-goodsName">
	                            	<dt><img src="${my:random(imgGetUrl)}${orderItem.prodImg}&op=s1_w40_h40_e1-c3_w40_h40"></dt>
	                            	<dd>
	                            		<a target="_blank" href="${ctx}/product/productDetail?prodId=${orderItem.prodId}"><c:out value="${orderItem.prodTitle}"></c:out></a>
	                            		<p class="o-property">
	                            			<c:forEach items="${orderItem.specNames}" var="spec">
												<span><c:out value="${spec.key}" /> : <c:out value="${spec.value}" /></span>
											</c:forEach>
	                            		</p>
	                            	</dd>
	                            </dl>
							</td>
							<td><c:out value="${orderItem.prodCode}"></c:out></td>
							<td><fmt:formatNumber value="${orderItem.salePrice}" pattern="0.00" /></td>
							<td><p><fmt:formatNumber value="${orderItem.transPrice}" pattern="0.00" /><p></td>
							<td>${orderItem.number}</td>
							<td>--</td>
							<td><c:out value="${order.strOrderStatus}"></c:out></td>
						</tr>
					</c:forEach>
					</c:if>
				</tbody>
			</table>
			<!-- table end -->
			<!-- amount -->
			<div class="amounts">
				<div class="allList">
					<dl>
						<dt>实付款：</dt>
						<dd><strong class="meg"><fmt:formatNumber value="${order.orderFee}" pattern="0.00" />元</strong></dd>
					</dl>
				</div>
			</div>
			<!-- amount end -->
			<!-- table -->
			<table class="table tableC">
				<colgroup>
					<col />
					<col />
					<col width="420" />
				</colgroup>
				<thead>
					<tr>
						<th colspan="3" class="caption">订单状态更新历史</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>更新时间</th>
						<th>状态名称</th>
						<th>操作说明</th>
					</tr>
					<c:forEach items="${record}" var="re">
						<tr>
							<td><fmt:formatDate value="${re.value}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<c:choose>
								<c:when test="${re.key == '1'}">
									<td>提交订单</td>
									<td>
										<p>备注：
											<c:choose>
												<c:when test="${empty order.userRemark}">
													无
												</c:when>
												<c:otherwise>
													<c:out value="${order.userRemark}" />
												</c:otherwise>
											</c:choose>
										</p>
									</td>
								</c:when>
								<c:when test="${re.key == '2'}">
									<td>已发货</td>
									<td><p></p></td>
								</c:when>
								<c:when test="${re.key == '3'}">
									<td>已付款</td>
									<td><p></p></td>
								</c:when>
								<c:when test="${re.key == '4'}">
									<td>订单取消</td>
									<td>
										<p>取消人：<c:out value="${order.cancelByName}" /></p>
										<p>取消原因：<c:out value="${order.cancelReason}" /></p>
									</td>
								</c:when>
								<c:when test="${re.key == '5'}">
									<c:choose>
										<c:when test="${order.orderStatus == '8' }">
											<td>已妥投</td>
											<td><p></p></td>
										</c:when>
										<c:when test="${order.orderStatus == '7' }">
											<td>未妥投</td>
											<td><p>未妥投原因：<c:out value="${order.notSignedCause}" /></p></td>
										</c:when>
									</c:choose>
								</c:when>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- table end -->
		</div>
		<!-- orderDetails end -->
		
		<script type="text/javascript">
			/* $(function() {
				$.getJSON(
						"${ctx}/order/getEmsTrace",
						{emsNo: "${order.awbNo}"},
//						{emsNo: "1018101740908"},
						function(data){
							if(!!data){
								var json;
								if(!!data["traces"]) {
									json = data;
								} else {
									json = $.parseJSON(data);
								}
								var count = json["traces"].length;
								if(0 != count){
									var htmlText = "<p class=\"now\">"
											+ json["traces"][count-1]["acceptTime"] 
											+ "&nbsp" + json["traces"][count-1]["acceptAddress"]
											+ "&nbsp" + json["traces"][count-1]["remark"]
											+"</p>"
											+ "<div class=\"mod-more\">\n"
											+ "<h3>更多<i class=\"arrow arrB-D\"></i></h3>\n"
											+ "<div class=\"bd\">\n";
									for (var i=count-1; i>=0; i--){
										htmlText += "<p>"
											+ json["traces"][i]["acceptTime"] 
											+ "&nbsp" + json["traces"][i]["acceptAddress"]
											+ "&nbsp" + json["traces"][i]["remark"]
											+ "</p>\n";
									}
									htmlText += "</div>";
									$("div.logistics").append(htmlText);
									$("div.bd p:first").addClass("new");
								}
							}
						}
					);
			}); */
		
		</script>
	</body>
</html>
