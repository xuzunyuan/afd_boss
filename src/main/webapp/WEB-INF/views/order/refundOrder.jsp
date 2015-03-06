<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>订单管理-afd</title>
	</head>
	<body>
		<style>
			.tableWrap .tableA tbody td{
				padding:6px 5px;
			}
		</style>
		<script type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="../static/js/jquery.md.js?t=20150210"></script>
		
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- orderSearch -->
		<div class="orderSearch">
			<!-- screening -->
			<div class="screening">
				<form method="post" action="${ctx}/amt/back" class="form">
					<fieldset class=""><!-- 删掉default显示全部查询条件 -->
						<legend><h3>查询条件</h3></legend>
						<ul class="formBox">
							<li class="item">
								<div class="item-label"><label>专场名称：</label></div>
								<div class="item-cont">
									<input name="brandShowTitle" type="text" class="txt textA" value='<c:out value="${pageInfo.conditions.brandShowTitle}" />'/>
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>退货时间：</label></div>
								<div class="item-cont">
									<input type="text" readonly="readonly" name="startDate" value="${pageInfo.conditions.startDate}" onClick="WdatePicker()" class="dateTxt">
									<span>至</span>
									<input type="text" readonly="readonly" name="endDate" value="${pageInfo.conditions.endDate}" onClick="WdatePicker()" class="dateTxt">
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>退货单号：</label></div>
								<div class="item-cont">
									<input name="retOrderCode" type="text" class="txt textA" value='${pageInfo.conditions.retOrderCode}' />
								</div>
							</li>
						</ul>
					</fieldset>
					<!-- foldbarH -->
					<div class="foldbarH open"><!-- 展开后添加class命open -->
						<div class="foldBtn"><i class="ico"></i></div>
						<div class="searchBtn"><input name="query" id="query" type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" /></div>
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
						<col width="70" />
						<col width="140" />
						<col width="90" />
						<col width="" />
						<col width="90" />
						<col width="100" />
						<col width="100" />
						<col width="100" />
						<col width="100">
					</colgroup>
					<thead>
						<tr>
							<th>序号</th>
							<th>退货单号</th>
							<th>退货时间</th>
							<th>专场名称</th>
							<th>退货商品</th>
							<th>商品编码</th>
							<th>交易金额</th>
							<th>退款金额</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${retOrders.result!=null && fn:length(retOrders.result)>0}">
								 <c:forEach items="${retOrders.result}" var="returnOrder" varStatus="var">
								 <tr>
								 	<td>${orders.beginRow+var.count}</td>
									<th><a href="javascript:void(0);" target="_blank">${returnOrder.retOrderCode}</a></th>
									<td><p><fmt:formatDate value="${returnOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p></td>
									<td><c:out value="${returnOrder.brandShowTitle}" /></td>
									<c:if test="${returnOrder.retOrderItems!=null && fn:length(returnOrder.retOrderItems)>0}">
									<c:forEach items="${returnOrder.retOrderItems}" var="returnOrderItem">
									<td class="align-l"><c:out value="${returnOrderItem.orderItem.prodTitle}" /></td>
									<td>${returnOrderItem.orderItem.prodCode}</td>
									<td>&yen;<fmt:formatNumber value="${returnOrderItem.orderItem.transPrice}" pattern="0.00" /></td>
									<td><b style="color:red">&yen;<fmt:formatNumber value="${returnOrderItem.retFee}" pattern="0.00" /></b></td>
									</c:forEach>
									</c:if>
									<td>等待退款</td>
									<td class="t-operate">
										<div class="mod-operate">
											<div class="def"><a id="${returnOrder.retOrderId}" href="javascript:void(0);">退款</a><i class="arr"></i></div>
											<ul>
												<li><a href="${ctx}/amt/refundDetail?retOrderId=${returnOrder.retOrderId}">查看详情</a></li>
											</ul>
										</div>
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
			<c:if test="${fn:length(retOrders.result) > 0}">
			<div class="paging">
					<p:page page="${retOrders}" action="${ctx}/amt/back"/>
			</div>
			</c:if>
		</div>
		<!-- orderSearch end -->
		
		<script type="text/javascript">
			$(function() {
				$(".def a").on("click", function(){
					var retOrderId = $(this).attr("id");
					var msg = '<h2><i class="icon i-warns" ></i>确认退款吗？</h2><p class="xitongP">请您确认退货单并和商家核实退款信息后，再为买家办理退款事宜；如不需要退款，请点击“取消”。</p>';
					$.modaldialog(msg,{
						title : '退款确认',
						buttons : [{text:'确&nbsp;&nbsp;认',classes:'btnB btn-s',click:confirm, param:{id:retOrderId}},{text : '取&nbsp;&nbsp;消',classes : 'btnA btn-s'}]
					});
				});
			});
			
			function confirm(param) {
				if(param.id > 0){
					$.ajax({
						url : "${ctx}/amt/refund",
						type : "POST",
						data : {retOrderId:param.id},
						success : function(data) {
							if(data) {
								//成功通过
								if(data == 1){
									$.modaldialog('<h2><i class="icon i-duigou"></i>退款已成功！</h2><p class="xitongP">线上退款已完成，请及时为买家办理线下退款事宜，谢谢！</p>',{
										buttons : [{text:'继续退款',classes:'btnB btn-s',click:function(){window.location.href = '${ctx}/amt/back';}}, 
										           {text:'查看退货单',classes:'btnB btn-s',click:function(){window.location.href = '${ctx}/amt/refundDetail?retOrderId='+param.id;}}]
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
	</body>
</html>



