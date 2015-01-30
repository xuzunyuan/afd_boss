<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>选择商品</title>
		<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="../static/js/jquery.md.js?t=2014061701"></script>		
		<script type="text/javascript">
		var prodAdding=0;
		//判断是否是整数
		function isProdCode(s){
		    var patrn =/^([1-9][\d\-]{0,23})$|(0)$/;
		    if (!patrn.exec(s))
		        return false;
		    else
		        return true;
		}
		//判断是否是浮点数
		function isFloat(s)
		{
		    var patrn =/^([1-9]\d*)$|(0)$/;
		    var patrn1=/^([0-9]\d*)$/;
		    var dotindex=s.indexOf(".");
		    if(dotindex>0)
		    {
		        var bs=s.substring(0,dotindex);
		        if (!patrn.exec(bs))
		            return false;
		        if(dotindex==s.length-1){
		            return true;
		        }else{
		            var es = s.substring(dotindex+1);
		            if (!patrn1.exec(es))
		                return false;
		            else
		                return true;
		        }
		    }
		    if (!patrn.exec(s))
		        return false;
		    else
		        return true;
		}
		//onKeyUp="inputFloat(this,0)
		function inputFloat(text1,suffix)
		{
		    str = text1.value;
		    if(!isFloat(str)){
		        text1.value="";
		        $("#"+text1.id+"z").html("");
		        return;
		    }
		    for( var i = ( str.length - 1 )*1; i >= 0; i -- ){
		        if( !isFloat( str ) ){
		            var ilen = str.length;
		            str = str.substring( 0,ilen - 1 );
		        }else{
		            var dotindex = str.indexOf(".");
		            if(dotindex<0)
		            {

		                if(str.length>6)
		                {
		                    var ilen = str.length;
		                    str = str.substring( 0,ilen - 1 );
		                }
		            }
		            else if(dotindex>0.01){

		                if(str.length-dotindex>suffix+1){
		                    var ilen = str.length;
		                    str = str.substring( 0,ilen - 1 );
		                }
		            }
		            break;
		        }
		    }
		    if(1000<parseInt(str)||parseInt(str)<=0){
		        str=1;
		    }
		    text1.value  = str;
		}

			$(function(){
				$(document).on("click", "span.plusBtn", function() {
					var obj = $(this).siblings("input[name=num]");
					var skuId = obj.attr("skuId");
					var balance= $("td[name=stockBalance][skuId="+skuId+"]").text();
					var limitCnt = $("td[name=stockBalance][skuId="+skuId+"]").attr("limitCnt");
					var num = obj.val();
					if(parseInt(balance)<=num){obj.val(parseInt(balance));return;}
					num++;
					if(!!limitCnt){
						if(parseInt(limitCnt)<num&&parseInt(limitCnt)!=0){
							obj.val(parseInt(limitCnt));
							showError("-10",limitCnt);
							return;
						}
					}
					$(this).siblings("span.minusBtn").removeClass("disable");
					//if(!validNum(num, obj)){
					//	return;
					//}
					obj.val(num);
				});
				$(document).on("click", "span.minusBtn", function() {
					var obj = $(this).siblings("input[name=num]");
					var num = obj.val();
					var skuId = obj.attr("skuId");
					var limitCnt = $("td[name=stockBalance][skuId="+skuId+"]").attr("limitCnt");
					if(num<=1){$(this).addClass("disable");obj.val(1);return;}
					num--;
					if(!!limitCnt){
						if(parseInt(limitCnt)<num&&parseInt(limitCnt)!=0){
							obj.val(parseInt(limitCnt));
							showError("-10",limitCnt);
							return;
						}
					}
					//if(!validNum(num, obj)){
					//	return;
					//}
					obj.val(num);
				});
				$(document).on("change","input[name=num]",function(){
					var num = $(this).val();
					var skuId = $(this).attr("skuId");
					var balance= $("td[name=stockBalance][skuId="+skuId+"]").text();
					if(num<=1){$(this).addClass("disable");$(this).val(1);return;}
					if(parseInt(balance)<=num){$(this).val(parseInt(balance));return;}
				});
				
				$(document).on("click","a[name=add]",function(){
					if(prodAdding==1){return;}
					prodAdding=1;
					var skuId = $(this).attr("skuId");
					var num = $("input[name=num][skuId="+skuId+"]").val();
					var ywPPDId = $("select[name=promotion][skuId="+skuId+"]").val();
					if (num) {
						if (!/^\d+$/.exec(num)) {
							showresult("warns","数量必须是数字型！");
							prodAdding=0;
							return false;
						}
					} else {
						showresult("warns","请填写数量！");
						prodAdding=0;
						return false;
					}
					$.post(
						"${ctx}/order/addProd",
						{skuId:skuId,num:num,ywPPDId:ywPPDId},
						function(json){
							prodAdding=0;
							if(json.errCode != 0){
								showError(json.errCode,json.stock);
							}else{
								window.opener.prodReload();
								showresult("success","");
							}
						}
					);
				});
				$(document).on("change","select[name=promotion]",function(){
					var skuId = $(this).attr("skuId");
					var ppdId = $(this).val();
					var stockBalance;
					if (ppdId == '0') {
						var skuStockBalance = $("td[name=stockBalance][skuId="+skuId+"]").attr("stockBalance");
						var promotionFreezeBalance = $("td[name=stockBalance][skuId="+skuId+"]").attr("promotionFreezeBalance");
						if ("" != promotionFreezeBalance) {
							stockBalance = skuStockBalance - promotionFreezeBalance;
						} else {
							stockBalance = skuStockBalance;
						}
					} else {
						stockBalance = $(this).find("option:selected").attr("stockBalance");
					}
					if(parseInt(stockBalance) < 0){
						stockBalance = 0;
					}
					var limitCnt = $(this).find("option:selected").attr("limitCnt");
					$("td[name=stockBalance][skuId="+skuId+"]").text(stockBalance);
					$("td[name=stockBalance][skuId="+skuId+"]").attr("limitCnt",limitCnt);
					//促销价格
					var promPrice = $(this).find("option:selected").attr("promPrice");
					if(!!promPrice){
						$("td[name=price][skuId="+skuId+"]").html(promPrice);
					}
					
					var num = $("input[name=num][skuId="+skuId+"]").val();
					if(parseInt(num) > parseInt(stockBalance)) {
						$("input[name=num][skuId="+skuId+"]").val(parseInt(stockBalance));
					}
				});
				$(function() {
					$("select[name=promotion]").change();
				});
			});
			
			
			function showError(errCode) {
				if (errCode == '-3') {
					showresult("errors","请正确填写购买数量！");
				} else if (errCode == '-4') {
					showresult("errors","该sku不存在！");
				} else if (errCode == '-5') {
					showresult("errors","该sku已下架！");
				} else if (errCode == '-6') {
					showresult("errors","该商品已下架！");
				} else if (errCode == '-7') {
					showresult("errors","该sku缺货！");
				} else if (errCode == '-8') {
					showresult("errors","该sku库存不足！");
				} else if (errCode == '-9') {
					showresult("errors","该店铺异常！");
				} else if (errCode == '-10') {
					var stock = arguments[1];
					showmsg("所选优惠最多购买"+stock+"件！");
				}
			}
		function checkquery(){
			var obj=$("#prodcode");
			if($.trim(obj.val())!==""){
				if(!isProdCode($.trim(obj.val()))){
					showmsg("请写正确的商品编号");
					return false;
				}
			}
			return true;
		}
		function showmsg(msg){
			 $.modaldialog("<p>"+msg+"</p>",{
					title : '提示',
					buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}],
					hasclose:false
				});		
		}
		function showresult(type,str){
			var obj=$(".tanchu");
			if(type=="success"){
				obj.html('<p><i class="icon i-duigou"></i>商品已添加</p>');
			}
           if(type=="errors"){
        	   obj.html('<p><i class="icon i-errors"></i>'+str+'</p>');
			}
           if(type=="warns"){
        	   obj.html('<p><i class="icon i-warns"></i>'+str+'</p>');
			}
           obj.show();
           timename=setTimeout('$(".tanchu").hide()',1000);
			
		}
		</script>
		
		
	</head>
	<body id="">
	<link rel="stylesheet" href="${ctx}/static/style/classes_.css?t=20140626" />
	<div class="tanchu" style="display:none">
		<p><i class="icon i-duigou"></i>商品已添加</p>
	</div>
	<!-- selectGoods -->
				<div class="selectGoods">
					<!-- screening -->
					<div class="screening">
						<form class="form" id="queryProd" method="post" action="${ctx}/order/prodList" onsubmit="return checkquery();">
							<fieldset class=""><!-- 删掉default显示全部查询条件 -->
								<div class="legend"><h3>查找商品</h3></div>
								<ul class="formBox">
									<li class="item">
										<div class="item-label"><label>商品名称：</label></div>
										<div class="item-cont">
											<input type="text"  value="<c:out value="${prodTitle}" />"  name="prodTitle" class="txt textA">
										</div>
									</li>
										<li class="item">
										<div class="item-label"><label>商品编号：</label></div>
										<div class="item-cont">
											<input type="text" id="prodcode" name="prodCode" value="<c:out value="${prodCode}" />"  class="txt textA">
										</div>
									</li>
									<li class="item">
										<div class="item-label"><label>店铺名称：</label></div>
										<div class="item-cont">
											<input type="text" name="storeName"  value="<c:out value="${storeName}" />"  class="txt textA">
										</div>
									</li>
								</ul>
								<div class="searchBtn"><input type="submit"  name="query" value="查&nbsp;&nbsp;询" class="btn btn-s"></div>
							</fieldset>
						</form>
					</div>
					<!-- screening end -->
					<!-- table -->
					<div class="tableWrap">
						<table class="table tableA">
							<colgroup>
								<col width="30">
								<col width="120">
								<col>
								<col width="110">
								<col width="110">
								<col width="70">
								<col width="80">
								<col width="50">
								<col width="50">
								<col>
								<col width="140">
							</colgroup>
							<thead>
								<tr>
									<th>序号</th>
									<th>商品编号</th>
									<th>商品名称</th>
									<th>规格名称</th>
									<th>SKU编号</th>
									<th>单价（元）</th>
									<th>优惠</th>
									<th>库存</th>
									<th>状态</th>
									<th>店铺名称</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							
					<c:forEach items="${page.result}" var="sku" varStatus="status">
					<tr>
						    <td>${status.index+1}</td>
							<td>${sku.prodCode}</td>
							<td class="align-l">
								<p>
									<a href="${prodUrl}${sku.skuId}.html" target="_blank"><c:out value="${sku.product.title}" /></a>
								</p>
								<c:if test="${fn:length(sku.promotionDetails) >0}">
									<span class="o-tags">
										<c:set value='0' var="xian" />
										<c:set value='0' var="zhe" />
										<c:forEach items="${sku.promotionDetails}" var="ppd">
											<c:if test="${ppd.ywProdPromotion.type=='1' and xian=='0'}">
												<c:set value='1' var="xian" />
												<img title="限时抢购" class="tags" src="${pageContext.request.contextPath}/static/img/xian.png"/>
											</c:if>
											<c:if test="${ppd.ywProdPromotion.type=='2' and zhe=='0'}">
												<c:set value='1' var="zhe" />
												<img title="直降/折扣" class="tags" src="${pageContext.request.contextPath}/static/img/zhe.png"/>
											</c:if>
										</c:forEach>
									</span>
								</c:if>
							</td>
							<td>
								<c:forEach items="${sku.skuSpecNames}" var="map">
									<p><em><c:out value="${map.key}" />：</em><c:out value="${map.value}" /></p>
								</c:forEach>
							</td>
							<td>${sku.skuCode}</td>
							<td name="price" skuId="${sku.skuId}"><fmt:formatNumber value="${sku.salePrice}" pattern="0.00" /></td>
							<td>
								<div class="select selectA">
									<select name="promotion" skuId="${sku.skuId}">
										<c:forEach items="${sku.promotionDetails}" var="ppd">
											<option value="${ppd.ywPPDId}" promPrice="${ppd.promotionPrice}" limitCnt="${ppd.purchaseCountLimit}" stockBalance="${ppd.stockBalance}"><c:out value="${ppd.ywProdPromotion.name}" /></option>
										</c:forEach>
										<option value="0" promPrice="${sku.salePrice}">无优惠</option>
									</select>
								</div>
							</td>
							<td name="stockBalance" skuId="${sku.skuId}" stockBalance="${sku.stockBalance}" promotionFreezeBalance="${sku.promotionFreezeBalance}">
								${sku.stockBalance - sku.promotionFreezeBalance}
							</td>
							<td>
					<c:if test="${sku.product.status=='1'}">待上架</c:if>
					<c:if test="${sku.product.status=='2'}">删除</c:if>
					<c:if test="${sku.product.status=='3'}">上架</c:if>
					<c:if test="${sku.product.status=='4'}">下架</c:if>
					<c:if test="${sku.product.status=='5'}">违规</c:if>
					</td>
					<td>
					<c:out value="${sku.product.storeName}" />
					</td>
					<td class="t-operate">
										<div class="mod-modified">
										<c:if test="${sku.product.status!='3'}">
												<span class="minusBtn disable">-</span>
												<input type="text"  name="num_no"  <c:if test="${sku.product.status!='3'}"> disabled="disabled"</c:if> skuId="${sku.skuId}" onKeyUp="inputFloat(this,0)" onKeyUp="inputFloat(this,0)" value ="0"  class="txt">
												<span class="plusBtn disable">+</span>
										</c:if>
										<c:if test="${sku.product.status =='3'}">
												<span class="minusBtn disable">-</span>
												<input type="text"  name="num" skuId="${sku.skuId}" onKeyUp="inputFloat(this,0)" value ="1"  class="txt">
												<span class="plusBtn">+</span>
												<a name="add" skuId="${sku.skuId}" href="###"><input type="button" value="添加"  class="btnA"></a>
										</c:if>
										</div>
					</td>
							
				</tr>
					</c:forEach>
 <c:if test="${nopage==1}">
								<tr class="emptyGoods">
									<td rowspan="2" colspan="11">
										暂无符合条件的商品
									</td>
								</tr>
</c:if>								
							</tbody>
						</table>
					</div>
					<!-- table end -->
					<!-- paging -->
			<c:if test="${fn:length(page.result) >0}">
				<pgNew:page name="prodList" page="${page}" formId="queryProd"></pgNew:page>
			</c:if>
					<!-- paging end -->
				</div>
				<!-- selectGoods end -->
	</body>
</html>
