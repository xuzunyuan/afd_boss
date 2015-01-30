<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<c:if test="${!empty carts}">
<script type="text/javascript">$("#addbutton").show();</script>
<!-- table -->
<script type="text/javascript">product_error=0;</script>
<table class="table tableB">
	<colgroup>
		<col width="350">
		<col width="130">
		<col>
		<col width="70">
		<col>
		<col>
		<col width="110">
		<col width="90">
	</colgroup>
	<thead>
		<tr>
			<th>商品名称</th>
			<th>商品编号</th>
			<th>单价(元)</th>
			<th>库存</th>
			<th>状态</th>
			<th>成交价</th>
			<th>购买数量</th>
			<th class="o-operate">操作</th>
		</tr>
	</thead>
	
	<c:set var="total" value="0" />
	<c:forEach items="${carts}" var="cart" varStatus="status">
		<tbody>
			<tr>
				<td colspan="8" class="o-code">
					<span>店铺名称：<a href="http://shop.yiwang.com/${cart.storeId}/"class="storeName">${cart.storeName}</a></span>
					<c:forEach items="${cart.storePromotions}" var="stProm">
						<span class="megs"><c:out value="${stProm.name}" /></span>
					</c:forEach>
				</td>
			</tr>
	 <c:set var="storetotal" value="0" />		
			<c:forEach items="${cart.cartItems}" var="cartItem" varStatus="cartItemSta">			
			  <c:set var="storetotal" value="${storetotal+cartItem.transPrice* cartItem.num}" />
				<tr name="cartitem">
					<td>
						<dl class="o-goodsName">
							<dt>
								<img src="${imgDownPrefix}${cartItem.skuId%count}${imgDownSuffix}${cartItem.skuImgUrl}&op=s1_w50_h50_e1-c3_w50_h50">
							</dt>
							<dd>
								<a href="${prodUrl}${cartItem.skuId}.html" target="_blank">${cartItem.prodName}</a>
								<c:forEach items="${cartItem.specs}" var="spec">
									<p class="o-property">
										<c:forEach items="${spec}" var="map">
											<span><c:out value="${map.key}" />：<c:out value="${map.value}" /></span>
										</c:forEach>
									</p>
								</c:forEach>
								<c:if test="${cartItem.promotionDetail != null}">
									<p>
										<span class="o-active">
											<c:out value="${cartItem.promotionDetail.ywProdPromotion.name}" />
										</span>
									</p>
								</c:if>
							</dd>
						</dl>
					</td>
					<td>${cartItem.prodCode}</td>
					<td><fmt:formatNumber value="${cartItem.salePrice}" pattern="0.00" /></td>
					<td>${cartItem.stock}</td>
					<td>
					<c:if test="${cartItem.statusCode==-4}">sku不存在</c:if>
					<c:if test="${cartItem.statusCode==0}">正常</c:if>
					<c:if test="${cartItem.statusCode==-7}">无货</c:if>
					<c:if test="${cartItem.statusCode==-6}">商品下架</c:if>
					<c:if test="${cartItem.statusCode==-8}">库存不足</c:if>
					<c:if test="${cartItem.statusCode==-5}">sku下架</c:if>
					<c:if test="${cartItem.statusCode==-10}">超出限购数量</c:if>
					<c:if test="${cartItem.outOfZone==2}"> 超区</c:if>
					</td>
					<td>
						<fmt:formatNumber value="${cartItem.transPrice}" pattern="0.00" />
					</td>
					<td>
						<div class="mod-modified">
							<span class="minusBtn <c:if test="${cartItem.num==0}">disable</c:if>">-</span> <input class="txt" name="num" skubalance="${cartItem.stock}" skuid="${cartItem.skuId}" ppdid="${cartItem.selectYwPPDId}" onblur="moditynum(this);" value="${cartItem.num}" onKeyUp="inputFloat(this,0)" type="text"> <span class="plusBtn">+</span>
						</div>
						<c:choose>
							<c:when test="${(cartItem.statusCode == -10)&&(cartItem.num>cartItem.stock)}">
								<script type="text/javascript">product_error=1;</script>
								<p class="meg">最多可买${cartItem.stock}件</p>
							</c:when>
							<c:when test="${cartItem.statusCode != 0||cartItem.outOfZone==2}">
								<script type="text/javascript">product_error=1;</script>
								<p class="meg">无法购买该商品，请删除</p>
							</c:when>
						</c:choose>
					</td>
					<td><a name="del" skuId="${cartItem.skuId}" href="###">删除</a></td>
				</tr>
			</c:forEach>
			<c:set var="pricetotal" value="${storetotal}" />
			<c:set var="storetotal" value="${storetotal+cart.deliverFee}" />
             <c:set var="total" value="${total+storetotal}" />
			<tr class="amountAll">
				<td colspan="8">
					<div class="amount">
						<p>
							<span>商品金额：<em>¥<fmt:formatNumber value="${pricetotal}" pattern="0.00" /></em></span>+<span>运费：<em>¥<c:if test="${empty cart.deliverFee}">0.00</c:if><fmt:formatNumber value="${cart.deliverFee}" pattern="0.00" /></em></span>=<span>店铺合计：<em>¥<fmt:formatNumber value="${storetotal}" pattern="0.00" /></em></span>
						</p>
					</div>
				</td>
			</tr>
		</tbody>
		<input type="hidden" name="storeInfos[${status.index}].deliverFee" value="${cart.deliverFee}" />
		<input type="hidden" name="storeInfos[${status.index}].serviceFee" value="0" />
		<input type="hidden" name="storeInfos[${status.index}].discountFee" value="0" />
		<input type="hidden" name="storeInfos[${status.index}].storeId" value="${cart.storeId}" />
		<input type="hidden" name="storeInfos[${status.index}].userRemark" value="" />
		<input type="hidden" name="storeInfos[${status.index}].logisticsCompa" value="1" />
	</c:forEach>
</table>
<!-- table end -->
<!-- amount -->
<div class="amount amount-clearing">
	<p>
		<b>订单合计（含运费）：</b><strong>¥<fmt:formatNumber value="${total}" pattern="0.00" /><c:if test="${empty total}">¥0.00</c:if></strong>
	</p>
</div>
</c:if>
<script type="text/javascript">$("#totalfee").text("¥<fmt:formatNumber value="${total}" pattern="0.00" /><c:if test="${empty total}">0.00</c:if>");</script>
<c:if test="${empty carts}">
<script type="text/javascript">$("#addbutton").hide();</script>
<!-- amount end -->
<div class="accountNo block">
	<span>暂无可结算商品</span> 
	<input type="button" name="addProd"  value="添加商品" onclick="window.open('${ctx}/order/prodList','newwindow','height=600,width=1022,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, resizable=no,location=no, status=no')" class="btnB">
</div>
</c:if>


