<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>卖家后台|订单详情页</title>
	</head>
	<body>
		<link rel="stylesheet" href="${ctx}/static/style/classes_.css?t=20140626" />
		<style type="text/css">
		dt{font-weight: normal}
		</style>
		<script type="text/javascript">
			$(function() {
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
			});
		
		</script>
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- crumbs -->
		<div class="crumbs crumbsA">
			<ul>
				<li><a href="javascript:;">后台首页</a><em>&gt;</em></li>
				<li><a href="javascript:;">订单管理</a><em>&gt;</em></li>
				<li><strong>订单详情页</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- orderDetails -->
		<div class="orderDetails">
			<!-- mod-info -->
			<div class="mod-info">
				<div class="item">
					<h2>订单信息</h2>
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
								<td>${order.orderId}</td>
								<th>支付类型：</th>
								<td><c:out value="${order.strPayType}"></c:out></td>
							</tr>
							<tr>
								<th>订单状态：</th>
								<td><c:out value="${order.strOrderStatus}"></c:out></td>
								<th>支付方式：</th>
								<td><c:out value="${order.strPayMode}"></c:out></td>
							</tr>
							<tr>
								<th>付款状态：</th>
								<td><c:out value="${order.strPayStatus}"></c:out></td>
								<th>实际支付方式：</th>
								<td><c:out value="${order.strReceiptMode}"></c:out></td>
							</tr>
							<tr>
								<th>订单来源：</th>
								<td><c:out value="${order.strOrderSource}"></c:out></td>
							</tr>
						</tbody>
					</table>
				</div><!-- item end -->
				<div class="item">
					<h2>发货信息</h2>
					<table>
						<colgroup>
							<col width="80" />
							<col />
							<col width="80" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>店铺名称：</th>
								<td><c:out value="${order.storeName}"></c:out></td>
								<th>发货人：</th>
								<td><c:out value="${ssa.linker}" /></td>
							</tr>
							<tr>
								<th>真实姓名：</th>
								<td><c:out value="${seller.realName}"></c:out></td>
								<th>联系电话：</th>
								<td>
									<c:choose>
										<c:when test="${ssa.mobile != null && ssa.tel != null}">
											${ssa.mobile} / ${ssa.tel}
										</c:when>
										<c:when test="${ssa.mobile != null}">
											${ssa.mobile}
										</c:when>
										<c:otherwise>
											${ssa.tel}
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th>商家类型：</th>
								<td>
									<c:choose>
										<c:when test="${seller.type == 98 }">
											企业店铺
										</c:when>
										<c:otherwise>
											个人店铺
										</c:otherwise>
									</c:choose>
								</td>
								<th>发货地址：</th>
								<td>
									<c:out value="${ssa.provinceName}"></c:out>
									<c:out value="${ssa.cityName}"></c:out>
									<c:out value="${ssa.districtName}"></c:out>
									<c:out value="${ssa.townName}"></c:out>
									<c:out value="${ssa.addr}"></c:out>
								</td>
							</tr>
							<tr>
								<th>开店时间：</th>
								<td>
									<fmt:formatDate value="${store.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<th>邮政编码：</th>
								<td><c:out value="${ssa.zipCode}" /></td>
							</tr>
						</tbody>
					</table>
				</div><!-- item end -->
				<div class="item">
					<h2>收货信息</h2>
					<table>
						<colgroup>
							<col width="80" />
							<col />
							<col width="80" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>买家用户名：</th>
								<td><c:out value="${order.userName}"></c:out></td>
								<th>配送方式：</th>
								<td>一网全城EMS快递</td>
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
								<td>
									<c:choose>
										<c:when test="${order.rMobile != null && order.rPhone != null}">
											${order.rMobile} / ${order.rPhone}
										</c:when>
										<c:when test="${order.rMobile != ''}">
											${order.rMobile}
										</c:when>
										<c:otherwise>
											${order.rPhone}
										</c:otherwise>
									</c:choose>
								</td>
								<th></th>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div><!-- item end -->
			</div>
			<!-- mod-info end -->
			<!-- table -->
			<table class="table tableB">
				<colgroup>
					<col width="350" />
					<col width="120" />
					<col width="120" />
					<col />
					<col />
					<col />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th>商品</th>
						<th>商品编号</th>
						<th>SKU编码</th>
						<th>单价(元)</th>
						<th>成交价(元)</th>
						<th>数量</th>
						<th>优惠(元)</th>
						<th>状态</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="8" class="o-code">
							<span>包裹：<em>一网全城EMS快递</em></span>
							<c:if test="${order.awbNo != null && order.awbNo !='' }">
								<span>运单号码：<em><c:out value="${order.awbNo}"></c:out></em></span>
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
					</tr>
					<c:forEach items="${order.orderItems}" var="orderItem">
						<tr>
							<td>
	                            <dl class="o-goodsName">
	                            	<dt><img src="${imgDownPrefix}${orderItem.skuId%count}${imgDownSuffix}${orderItem.skuImgUrl}&op=s1_w40_h40_e1-c3_w40_h40"></dt>
	                            	<dd>
	                            		<a target="_blank" href="${prodSnapUrl}${orderItem.orderItemId}/"><c:out value="${orderItem.prodTitle}"></c:out></a>
	                            		<p class="o-property">
	                            			<c:forEach items="${orderItem.specNames}" var="spec">
												<span><c:out value="${spec.key}" />:<c:out value="${spec.value}" /></span>
											</c:forEach>
	                            		</p>
	                            		<c:if test="${orderItem.ywPPDtail != null}">
	                            			<p>
	                            				<span class="o-active"><c:out value="${orderItem.ywPPDtail.ywProdPromotion.name}"/></span>
	                            			</p>
	                            		</c:if>
	                            	</dd>
	                            </dl>
							</td>
							<td><c:out value="${orderItem.prodCode}"></c:out></td>
							<td><c:out value="${orderItem.skuCode}"></c:out></td>
							<td>
								<fmt:formatNumber value="${orderItem.salePrice}" pattern="0.00" />
							</td>
							<td>
								<fmt:formatNumber value="${orderItem.transPrice}" pattern="0.00" />
							</td>
							<td>${orderItem.num}</td>
							<td><b><fmt:formatNumber value="${orderItem.salePrice - orderItem.transPrice}" pattern="0.00" /></b></td>
							<td><c:out value="${order.strOrderStatus}"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- table end -->
			<!-- amount -->
			<div class="amounts">
				<div class="allList">
					<dl>
						<dt>商品金额：</dt>
						<dd><fmt:formatNumber value="${order.prodFee}" pattern="0.00" />元</dd>
					</dl>
					<dl>
						<dt>运费：</dt>
						<dd><fmt:formatNumber value="${order.deliverFee}" pattern="0.00" />元</dd>
					</dl>
					<c:forEach items="${order.storeProms}" var="stProm" varStatus="status">
						<dl><dt><c:if test="${status.index == 0}">店铺优惠：</c:if></dt><dd><c:out value="${stProm.name}" /></dd></dl>
					</c:forEach>
					<dl>
						<dt>实付款：</dt>
						<dd><strong class="meg"><fmt:formatNumber value="${order.prodFee+order.deliverFee}" pattern="0.00" />元</strong></dd>
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
						<th colspan="3" class="caption">处理时间</th>
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
												<c:when test="${empty(order.userRemark)}">
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
									<td>
										<c:choose>
											<c:when test="${order.orderStatus == '8' }">
												已妥投
											</c:when>
											<c:when test="${order.orderStatus == '7' }">
												未妥投
											</c:when>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${order.orderStatus == '8' }">
												<p></p>
											</c:when>
											<c:when test="${order.orderStatus == '7' }">
												<p>未妥投原因：<c:out value="${order.notSignedCause}" /></p>
											</c:when>
										</c:choose>
									</td>
								</c:when>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- table end -->
		</div>
		<!-- orderDetails end -->
	</body>
</html>
