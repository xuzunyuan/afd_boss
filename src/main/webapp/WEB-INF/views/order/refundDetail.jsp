<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>订单管理-afd</title>
	</head>
	<body>
		<script type="text/javascript" src="../static/js/jquery.md.js?t=20150210"></script>
	
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- orderDetails -->
		<div class="orderDetails">
			<div class="mod-info info-orderDetails">
				<span>当前订单状态：<em><c:out value="${returnOrder.sellerStatus}" /></em></span>
				<c:if test="${returnOrder.status=='3'}">
					<input id="refund" type="button" class="btn" value="退款" />
				</c:if>
			</div>
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
								<th>退货单号：</th>
								<td>${returnOrder.retOrderCode}</td>
								<th>申请时间：</th>
								<td><fmt:formatDate value="${returnOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							</tr>
							<tr>
								<th>退货原因：</th>
								<td><c:out value="${returnOrder.returnReason}" /></td>
								<th>专场名称：</th>
								<td><a href="javascript:void(0);"><c:out value="${returnOrder.brandShowTitle}" /></a></td>
							</tr>
							<tr>
								<th>退货说明：</th>
								<td><c:out value="${returnOrder.remarks}" /></td>
								<th>原订单号：</th>
								<td><a href="${ctx}/order/orderDetail?orderId=${returnOrder.orderId}">${returnOrder.orderCode}</a></td>
							</tr>
							<tr>
								<td colspan="3"><div class="form-item">
										<div class="item-label"><label>退货凭证：</label></div>
										<div class="item-cont">
											<div class="uploadImg">
												<ul>
													<c:forEach items="${returnOrder.evidencePics}" var="pic">
													<li>
														<a href="${my:random(imgGetUrl)}${pic}" target="_blank"><img src="${my:random(imgGetUrl)}${pic}&op=s1_w40_h40_e1-c3_w40_h40" alt=""></a>
													</li>
												</c:forEach>
												</ul>
											</div>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div><!-- item end -->
				<div class="item">
					<h2>退货信息</h2>
					<table>
						<colgroup>
							<col width="100" />
							<col />
							<col width="100" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>退货地址：</th>
								<td colspan="3">天津 滨海新区 城区 西环路恒圆魏都小区52号商铺，    收件人：林子，     手机：18690689979</td>
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
					<col width="140" />
					<col width="120" />
					<col width="120" />
					<col width="120" />
				</colgroup>
				<thead>
					<tr>
						<th>商品名称</th>
						<th>商品编码</th>
						<th>特卖价</th>
						<th>数量</th>
						<th>交易金额</th>
						<th>退款金额</th>
					</tr>
				</thead>
				<tbody>
					<tr class="last">
						<c:if test="${returnOrder.retOrderItems!=null && fn:length(returnOrder.retOrderItems)>0}">
						<c:forEach items="${returnOrder.retOrderItems}" var="returnOrderItem">
						<td>
                            <dl class="o-goodsName">
                            	<dt><img src="${my:random(imgGetUrl)}${returnOrderItem.orderItem.prodImg}&op=s1_w40_h40_e1-c3_w40_h40"></dt>
                            	<dd>
                            		<a href="javascript:void(0);"><c:out value="${returnOrderItem.orderItem.prodTitle}" /></a>
                            		<p class="o-property">
                            			<c:forEach items="${returnOrderItem.orderItem.specNames}" var="spec">
											<span><c:out value="${spec.key}" />：<c:out value="${spec.value}" /></span>
										</c:forEach>
                            		</p>
                            	</dd>
                            </dl>
						</td>
						<td>${returnOrderItem.orderItem.prodCode}</td>
						<td>&yen;<fmt:formatNumber value="${returnOrderItem.orderItem.salePrice}" pattern="0.00" /></td>
						<td>${returnOrderItem.returnNumber}</td>
						<td><p>&yen;<fmt:formatNumber value="${returnOrderItem.orderItem.transPrice}" pattern="0.00" /></p></td>
						<td>&yen;<fmt:formatNumber value="${returnOrderItem.retFee}" pattern="0.00" /></td>
						<c:set var="total" value='${returnOrderItem.retFee * returnOrderItem.returnNumber}'></c:set>
						</c:forEach>
						</c:if>
					</tr>
				</tbody>
			</table>
			<!-- table end -->
			<!-- amount -->
			<div class="amounts">
				<div class="allList">
					<dl style="float: right">
						<dt>退款总额：</dt>
						<dd style="width: auto;"><strong class="meg"><fmt:formatNumber value="${total}" pattern="0.00" />元</strong></dd>
					</dl>
				</div>
			</div>
			<!-- amount end -->
		</div>
		<!-- orderDetails end -->
		
		<c:if test="${returnOrder.status=='3'}">
			<script type="text/javascript">
				$(function() {
					$("#refund").on("click", function(){
						var msg = '<h2><i class="icon i-warns" ></i>确认退款吗？</h2><p class="xitongP">请您确认退货单并和商家核实退款信息后，再为买家办理退款事宜；如不需要退款，请点击“取消”。</p>';
						$.modaldialog(msg,{
							title : '退款确认',
							buttons : [{text:'确&nbsp;&nbsp;认',classes:'btnB btn-s',click:confirm},{text : '取&nbsp;&nbsp;消',classes : 'btnA btn-s'}]
						});
					});
				});
				
				function confirm() {
					if(${returnOrder.retOrderId} > 0){
						$.ajax({
							url : "${ctx}/amt/refund",
							type : "POST",
							data : {retOrderId:"${returnOrder.retOrderId}"},
							success : function(data) {
								if(data) {
									//成功通过
									if(data == 1){
										$.modaldialog('<h2><i class="icon i-duigou"></i>退款已成功！</h2><p class="xitongP">线上退款已完成，请及时为买家办理线下退款事宜，谢谢！</p>',{
											buttons : [{text:'继续退款',classes:'btnB btn-s',click:function(){window.location.href = '${ctx}/amt/back';}}, 
											           {text:'查看退货单',classes:'btnB btn-s',click:function(){window.location.href = '${ctx}/amt/refundDetail?retOrderId=${returnOrder.retOrderId}';}}]
										});
									}else{
										$.modaldialog('<h2><i class="icon i-errors"></i>退款异常或失败！</h2><p class="xitongP">请重新尝试，多次尝试失败时请联系平台客服协助解决。</p>',{
											buttons : [{text:'我知道了',classes:'btnB btn-s'}]
										});
									}
								}
							},
							error : function() {
								$.modaldialog('<h2><i class="icon i-errors"></i>请重新尝试，多次尝试失败时请联系平台客服协助解决。</h2>');
							}
						});
					}
				}
			</script>			
		</c:if>
	</body>
</html>



