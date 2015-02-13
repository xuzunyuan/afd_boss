<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>订单管理-一afd</title>
		
	</head>
	<body>
		<script type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="../static/js/jquery.md.js?t=20150210"></script>
		
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- orderSearch -->
		<div class="orderSearch">
			<!-- screening -->
			<div class="screening">
				<form id="query" action="${ctx}/order/queryOrder" method="post"  class="form">
					<fieldset id="condition" class="default"><!-- 删掉default显示全部查询条件 -->
						<legend><h3>查询条件</h3></legend>
						<ul id="formBox" class="formBox">
							<li class="item">
								<div class="item-label"><label>订单编号：</label></div>
								<div class="item-cont">
									<input name="orderCode" type="text" value="${pageInfo.conditions.orderCode}" class="txt textA" />
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>下单时间：</label></div>
								<div class="item-cont">
									<input type="text" readonly="readonly" value="<fmt:formatDate value="${pageInfo.conditions.startDt}" pattern="yyyy-MM-dd" />" name="startDt" class="dateTxt" onClick="WdatePicker()" />
			            			<span> 至 </span>
			            			<input type="text" readonly="readonly" value="<fmt:formatDate value="${pageInfo.conditions.endDt}" pattern="yyyy-MM-dd" />" name="endDt" class="dateTxt" onClick="WdatePicker()" />
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>订单状态：</label></div>
								<div class="item-cont">
									<div class="select">
										<select name="orderStatus">
						            		<option value="-1">全部</option>
						            		<option <c:if test="${pageInfo.conditions.orderStatus == '2'}">selected="selected"</c:if> value="2">等待付款</option>
						            		<option <c:if test="${pageInfo.conditions.orderStatus == '3'}">selected="selected"</c:if> value="3">买家已付款</option>
						            		<option <c:if test="${pageInfo.conditions.orderStatus == '4'}">selected="selected"</c:if> value="4">交易取消</option>
						            		<option <c:if test="${pageInfo.conditions.orderStatus == '5'}">selected="selected"</c:if> value="5">商家已发货</option>
						            		<option <c:if test="${pageInfo.conditions.orderStatus == '8'}">selected="selected"</c:if> value="8">交易完成</option>
						            	</select>
									</div>
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>付款状态：</label></div>
								<div class="item-cont">
									<div class="select">
										<select name="payStatus">
										    <option value="-1">全部</option>
										    <option <c:if test="${pageInfo.conditions.payStatus == '1'}">selected="selected"</c:if> value="1">未支付</option>
										    <option <c:if test="${pageInfo.conditions.payStatus == '2'}">selected="selected"</c:if> value="2">已支付</option>
										</select>
									</div>
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>专场名称：</label></div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${pageInfo.conditions.brandShowTitle}" />" name="brandShowTitle" class="txt textA" />
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>买家用户名：</label></div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${pageInfo.conditions.userName}" />" name="userName" class="txt textA" />
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>商品名称：</label></div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${pageInfo.conditions.prodTitle}" />" name="prodTitle" class="txt textA" />
								</div>
							</li>
							
							<li class="item">
								<div class="item-label"><label>订单来源：</label></div>
								<div class="item-cont">
									<div class="select">
										<select name="orderSource">
						            		<option value="-1">全部</option>
						            		<option <c:if test="${pageInfo.conditions.orderSource == '1'}">selected="selected"</c:if> value="1">网站</option>
						            		<option <c:if test="${pageInfo.conditions.orderSource == '2'}">selected="selected"</c:if> value="2">电话</option>
						            		<option <c:if test="${pageInfo.conditions.orderSource == '3'}">selected="selected"</c:if> value="3">手机IOS</option>
						            		<option <c:if test="${pageInfo.conditions.orderSource == '4'}">selected="selected"</c:if> value="4">手机安卓</option>
						            	</select>
									</div>
								</div>
							</li>
						</ul>
					</fieldset>
					<!-- foldbarH -->
					<div id="foldbarH" class="foldbarH"><!-- 展开后添加class命open -->
						<input type="hidden" name="styleF" id="styleF" value="${pageInfo.conditions.styleF}"/>
						<div id="foldBtn" class="foldBtn"><i class="ico"></i></div>
						<div class="searchBtn"><input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" name="query" id="query"/></div>
					</div>
					<!-- foldbarH end -->
				</form>
			</div>
			<!-- screening end -->
			<!-- table -->
			<div class="tableWrap">
				<table class="table tableA">
					<colgroup>
						<col width="40" />
						<col width="110" />
						<col width="110" />
						<col width="90" />
						<col width="100" />
						<col width="90" />
						<col />
						<col width="90" />
						<col width="100" />
						<col width="100">
					</colgroup>
					<thead>
						<tr>
							<th>序号</th>
							<th>订单编号</th>
							<th>下单时间</th>
							<th>金额</th>
							<th>付款状态</th>
							<th>订单状态</th>
							<th>专场名称</th>
							<th>订单来源</th>
							<th>买家用户名</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${fn:length(orders.result) > 0}">
								<c:forEach items="${orders.result}" var="order" varStatus="var">
									<tr>
										<td>${orders.beginRow+var.count}</td>
										<td><a href="${ctx}/order/orderDetail?orderId=${order.orderId}"><c:out value="${order.orderCode}"></c:out></a></td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${order.createdDate}"/></td>
										<td><fmt:formatNumber pattern="0.00" value="${order.orderFee}"></fmt:formatNumber></td>
										<td><c:out value="${order.strPayStatus}"></c:out></td>
										<td><c:out value="${order.strOrderStatus}"></c:out></td>
										<td class="align-l" ><c:out value="${order.brandShowTitle}"></c:out></td>
										<td><c:out value="${order.strOrderSource}"></c:out></td>
										<td><c:out value="${order.userName}"></c:out></td>
										<td class="t-operate">
											<c:choose>
												<c:when test="${order.orderStatus <='3' || order.orderStatus =='5' }">
													<div class="mod-operate">
														<div class="def">
															<a href="${ctx}/order/orderDetail?orderId=${order.orderId}">订单详情</a>
															<i class="arr"></i>
														</div>
														<ul>
															<li>
																<a id="${order.orderId}" href="javascript:;">作废订单</a>
															</li>
														</ul>
													</div>
												</c:when>
												<c:otherwise>
													<a target="_blank" href="${ctx}/order/orderDetail?orderId=${order.orderId}">订单详情</a>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr class="emptyGoods">
									<td rowspan="3" colspan="10">暂无符合条件的查询结果</td>
								</tr>
							</c:otherwise>
						</c:choose>
						
					</tbody>
				</table>
			</div>
			<!-- table end -->
			<c:if test="${fn:length(page.result) > 0}">
			<div class="paging">
					<p:page page="${orders}" action="${ctx}/order/queryOrder"/>
			</div>
			</c:if>
		</div>
		
		<script type="text/javascript">
			$(function(){
				$("#foldBtn").on("click", function(event){
					if($(this).parent().hasClass("open")){
						$("#condition").addClass("default");
						$("#styleF").val("");
						$(this).parent().removeClass("open");
					}else{
						$("#condition").removeClass("default");
						$("#styleF").val("defalut");
						$(this).parent().addClass("open");
					}
				});
				
				<c:if test="${not empty pageInfo.conditions.styleF}">
					$("#foldBtn").trigger("click");
				</c:if>
				
				$(".mod-operate li a").on("click", function(){
					var orderId = $(this).attr("id");
					 
					var msg = '<dl><dt><label>作废原因：</label></dt><dd><textarea name="cancelReason" placeholder="作废原因不超过30字" id="cancelReason" rows="5"></textarea></dd></dl>';
					$.modaldialog(msg,{
						title : '订单作废',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:cancelOrder,param:{orderId:orderId}}, {text:'取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
					
				});
			});
				
			function cancelOrder(param){
				var orderId = param.orderId;
				var cancelReason = $("#cancelReason").val();
				
				if($.trim(cancelReason).length == 0 ){
					var msg = "<p><span>•</span>请填写作废原因！</p>";
					$.modaldialog(msg,{
						title : '提示',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
							$("#"+orderId).trigger("click");
							$('#cancelReason').focus();}}]
					});
					return;
				}
				if(strlen(cancelReason) > 60 ){
					var msg = "<p><span>•</span>作废原因不能超过30字！</p>";
					$.modaldialog(msg,{
						title : '提示',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
							$("#"+orderId).trigger("click");
							$('#cancelReason').focus();}}]
					});
					return;
				}
				
				$.ajax({
					url : "${ctx}/order/cancelOrders",
					type : "POST",
					data : {orderIds:orderId, cancelReason:cancelReason},
					success : function(data) {
						if(data) {
							if(data == '1'){
								var msg = "<p><span>•</span>订单："+orderId+"已作废！</p>";
								$.modaldialog(msg,{
									title : '提醒',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){window.location.href = '${ctx}/order/queryOrder';}}]
								});
							}else if(data == '0'){
								var msg = "<p><span>•</span>作废订单异常,请重新尝试!</p>";
								$.modaldialog(msg,{
									title : '提醒',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){window.location.href = "${ctx}/order/queryOrder";}}]
								});
							}
						}
					},
					error : function() {
						var msg = "<p><span>•</span>作废订单异常,请重新尝试!</p>";
						$.modaldialog(msg,{
							title : '提醒',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
						});
					}
				});
			}
			
			function strlen(str){
				var len = 0;
				for (var i=0; i<str.length; i++) { 
					var c = str.charCodeAt(i); 
					//单字节加1 
					if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) { 
						len++; 
					} else { 
						len+=2; 
					} 
			    } 
			    return len;
			}
		</script>	
	</body>
</html>
