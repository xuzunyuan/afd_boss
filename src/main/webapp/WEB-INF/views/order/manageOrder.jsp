<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>订单管理-一网全城</title>
		
	</head>
	<body>
		<link rel="stylesheet" href="${ctx}/static/style/classes_.css?t=20140716" />
		<script language="javascript" type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="../static/js/jquery.md.js?t=20140704"></script>
		<script type="text/javascript">
			$(function(){
				init();
				$(document).on("click","#search",function(){
					var orderId = $("input[name=orderId]").val();
					if(!!orderId){
						if(!/^\d+$/.exec($.trim(orderId))){
							alert("订单号只能是数字型！");
							return false;
						}
					}
					var mobile = $("input[name=rMobile]").val();
					if(!!mobile){
						if(!/^\d{11}$/.exec($.trim(mobile))){
							alert("请正确输入手机号！");
							return false;
						}
					}
					$("#query").submit();
				});
				$(document).on("change","#allSelect",function(){
					var check = $(this).prop("checked");
					$("input[name=orderCheck]").prop("checked",check);
				});
				$(document).on("change","input[name=orderCheck]",function(){
					var allCheck = true;
					$("input[name=orderCheck]").each(function(){
						var check = $(this).prop("checked");
						if(!check){
							allCheck = false;
							return;
						}
					});
					$("#allSelect").prop("checked",allCheck);
				});
				$(document).on("click","#foldBtn",function(){
					var hasOpen = $("#foldbarH").hasClass("open");
					if(hasOpen){
						$("#foldbarH").removeClass("open");
						$("fieldset").addClass("default");
					}else{
						$("#foldbarH").addClass("open");
						$("fieldset").removeClass("default");
					}
				});
				$(document).on("change","#province",function(){
					var provinceId = $(this).children("option:selected").val();
					if(provinceId == '-1'){
						$("input[name=provinceName]").val('');
					}else{
						$("input[name=provinceName]").val($(this).children("option:selected").html());
					}
					$("input[name=cityName]").val('');
					$("input[name=countyName]").val('');
					$.getJSON(
						"${ctx}/order/getNextGeo",
						{geoId:provinceId},
						function(json){
							if(!!json){
								var cityOptions = [];
								cityOptions.push("<option value='-1'>全部</option>");
								for(var i in json){
									var geo = json[i];
									cityOptions.push("<option value='"+geo.geoId+"'>"+geo.geoName+"</option>");
								}
								$("#city").html(cityOptions.join(''));
								$("#county").html("<option value='-1'>全部</option>");
							}
						}
					);
				});
				$(document).on("change","#city",function(){
					var cityId = $(this).children("option:selected").val();
					if(cityId == '-1'){
						$("input[name=cityName]").val('');
					}else{
						$("input[name=cityName]").val($(this).children("option:selected").html());
					}
					$("input[name=countyName]").val('');
					$.getJSON(
						"${ctx}/order/getNextGeo",
						{geoId:cityId},
						function(json){
							if(!!json){
								var areaOptions = [];
								areaOptions.push("<option value='-1'>全部</option>");
								for(var i in json){
									var geo = json[i];
									areaOptions.push("<option value='"+geo.geoId+"'>"+geo.geoName+"</option>");
								}
								$("#county").html(areaOptions.join(''));
							}
						}
					);
				});
				$(document).on("change","#county",function(){
					var areaId = $(this).children("option:selected").val();
					if(areaId == '-1'){
						$("input[name=countyName]").val('');
					}else{
						$("input[name=countyName]").val($(this).children("option:selected").html());
					}
				});
				$(document).on("click","input[name=cancelOrders]",function(){
					var checkOrderIds = [];
					$("input[name=orderCheck]:checked").each(function(){
						checkOrderIds.push($(this).attr("orderId"));
					});
					if(checkOrderIds.length == 0){
						var msg = "<p><span>•</span>请选择需要作废的订单！</p>";
						$.modaldialog(msg,{
							title : '提醒',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
						});
						return;
					}
					var hasError = false;
					$.ajax({
						type:"get",
						url:"${ctx}/order/orderCanCancel",
						async:false,
						dataType:"json",
						data:{orderIds:checkOrderIds.join(",")},
						success:function(json){
							if(!json.success){
								var msg = "<p><span>•</span>作废订单异常,请重新尝试!</p>";
								$.modaldialog(msg,{
									title : '提醒',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
								});
								hasError = true;
							}
						}
					});
					if(hasError){
						return false;
					}
					
					var msg = '<dl><dt><label>作废原因：</label></dt><dd><textarea name="cancelReason" placeholder="作废原因不超过30字" id="cancelReason" rows="5"></textarea></dd></dl>';
					
					$.modaldialog(msg,{
						title : '订单作废',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:confirm},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
				});
				$(document).on("click","a[name=cancelOrder]",function(){
					var orderId = $(this).attr("orderId");
					var hasError = false;
					$.ajax({
						type:"get",
						url:"${ctx}/order/orderCanCancel",
						async:false,
						dataType:"json",
						data:{orderIds:orderId},
						success:function(json){
							if(!json.success){
								var msg = "<p><span>•</span>作废订单异常,请重新尝试!</p>";
								$.modaldialog(msg,{
									title : '提醒',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
								});
								hasError = true;
							}
						}
					});
					if(hasError){
						return false;
					}
					//var msg = '<p><span>•</span>订单作废后将不可恢复<br /><span>•</span>确认作废吗？</p>';
					var msg = '<dl><dt><label>作废原因：</label></dt><dd><textarea name="cancelReason" placeholder="作废原因不超过30字" id="cancelReason" rows="5"></textarea></dd></dl>';
					
					$("input[name=cancelOrderId]").val(orderId);
					$.modaldialog(msg,{
						title : '订单作废',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:cancelOrder},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
					
				});
			});
			
			function cancelOrder(){
				var orderId = $("input[name=cancelOrderId]").val();
				var cancelReason = $("#cancelReason").val();
				if($.trim(cancelReason).length == 0 ){
					var msg = "<p><span>•</span>请填写作废原因！</p>";
					$.modaldialog(msg,{
						title : '提示',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
					});
					return;
				}
				if(strlen(cancelReason) > 60 ){
					var msg = "<p><span>•</span>作废不能超过30字！</p>";
					$.modaldialog(msg,{
						title : '提示',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
					});	
					return;
				}
				
				$.post(
					"${ctx}/order/cancelOrder",
					{orderId:orderId,cancelReason:cancelReason},
					function(json){
						if(json.success == '0'){
							var msg = "<p><span>•</span>订单："+orderId+"已作废！</p>";
							$.modaldialog(msg,{
								title : '提醒',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:reload}]
							});
						}else if(json.success == '-1'){
							var msg = "<p><span>•</span>作废订单异常,请重新尝试!</p>";
							$.modaldialog(msg,{
								title : '提醒',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:reload}]
							});
						}
					}
				);
			}
			
			function reload(){
				location.href = "${ctx}/order/manageOrder?writable=true"
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
			
			function confirm(){
				var checkOrderIds = [];
				$("input[name=orderCheck]:checked").each(function(){
					checkOrderIds.push($(this).attr("orderId"));
				});
				var cancelReason = $("#cancelReason").val();
				if($.trim(cancelReason).length == 0 ){
					var msg = "<p><span>•</span>请填写作废原因！</p>";
					$.modaldialog(msg,{
						title : '提示',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
					});
					return;
				}
				if(strlen(cancelReason) > 60 ){
					var msg = "<p><span>•</span>作废不能超过30字！</p>";
					$.modaldialog(msg,{
						title : '提示',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
					});	
					return;
				}
				$.post(
					"${ctx}/order/cancelOrders",
					{orderIds:checkOrderIds.join(","),cancelReason:cancelReason},
					function(json){
						if(json.success == '0'){
							var msg = "<p><span>•</span>订单已作废！</p>";
							$.modaldialog(msg,{
								title : '提醒',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:reload}]
							});
						}else if(json.success == '-1'){
							var msg = "<p><span>•</span>作废订单异常,请重新尝试!</p>";
							$.modaldialog(msg,{
								title : '提醒',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:reload}]
							});
						}
					}
				);
			}
			
			function init(){
				var province = '${orderCondition.province}';
				if(!!province){
					$("select#province > option[value="+province+"]").attr("selected",true);
				}
				var city = '${orderCondition.city}';
				if(!!city){
					$.getJSON(
						"${ctx}/order/getNextGeo",
						{geoId:'${orderCondition.province}'},
						function(jsonCity){
							if(!!jsonCity){
								var cityOptions = [];
								cityOptions.push("<option value='-1'>全部</option>");
								for(var i in jsonCity){
									var geo = jsonCity[i];
									cityOptions.push("<option value='"+geo.geoId+"'>"+geo.geoName+"</option>");
								}
								$("#city").html(cityOptions.join(''));
								$("select#city > option[value="+city+"]").attr("selected",true);
								$("input[name=cityName]").val('${orderCondition.cityName}');
							}
						}
					);
				}
				var county = '${orderCondition.county}';
				if(!!county){
					$.getJSON(
						"${ctx}/order/getNextGeo",
						{geoId:'${orderCondition.city}'},
						function(jsonDistrict){
							if(!!jsonDistrict){
								var areaOptions = [];
								areaOptions.push("<option value='-1'>全部</option>");
								for(var i in jsonDistrict){
									var geo = jsonDistrict[i];
									areaOptions.push("<option value='"+geo.geoId+"'>"+geo.geoName+"</option>");
								}
								$("#county").html(areaOptions.join(''));
								$("select#county > option[value="+county+"]").attr("selected",true);
								$("input[name=countyName]").val('${orderCondition.countyName}');
							}
						}
					);
				}
				var orderId = '${orderCondition.orderId}';
				var startDate = '${orderCondition.startDate}';
				var endDate = '${orderCondition.endDate}';
				var orderStatus = '${orderCondition.orderStatus}';
				var payStatus = '${orderCondition.payStatus}';
				var userName = '${orderCondition.userName}';
				var rMobile = '${orderCondition.rMobile}';
				var prodTitle = '${orderCondition.proTitle}';
				var prodCode = '${orderCondition.prodCode}';
				var storeName = '${orderCondition.storeName}';
				var orderSource = '${orderCondition.orderSource}';
				var payType = '${orderCondition.payType}';
				if(!!orderId || !!startDate || !!endDate || (!!orderStatus && orderStatus!='-1') 
						|| (!!payStatus && payStatus !='-1') || !!userName || !!rMobile || !!prodTitle || !!prodCode || !!storeName 
						|| (!!orderSource && orderSource!='-1') || (!!province && province!='-1') 
						|| (!!city && city!='-1') || (!!county && county!='-1') || (!!payType && payType!='-1')){
					$("fieldset").removeClass("default");
					$("#foldbarH").addClass("open");
				}
				
				var ctrlHTML = [];
				ctrlHTML.push("<div class=\"ctrlArea\">");
				ctrlHTML.push("<input id=\"allSelect\" class=\"chk\" type=\"checkbox\" name=\"allSelect\" />");
				ctrlHTML.push("<label for=\"allSelect\">全选</label>");
				ctrlHTML.push("<input class=\"btnA\" name=\"cancelOrders\" type=\"button\" value=\"批量作废订单\" />");
				ctrlHTML.push("</div>");
				var paging = $("div.paging");
				if(!!paging){
					paging.prepend(ctrlHTML.join(""));
				}
			}
		</script>
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- crumbs -->
		<div class="crumbs">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="#">订单管理</a><em>&gt;</em></li>
				<li><strong>订单管理列表</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- orderSearch -->
		<div class="orderSearch">
			<!-- screening -->
			<div class="screening">
				<form id="query" action="${ctx}/order/manageOrder" method="post"  class="form">
					<fieldset class="default"><!-- 删掉default显示全部查询条件 -->
						<legend><h3>查询条件</h3></legend>
						<ul id="formBox" class="formBox">
							<li class="item">
								<div class="item-label"><label>订单编号：</label></div>
								<div class="item-cont">
									<input name="orderId" type="text" value="${orderCondition.orderId}" class="txt textA" />
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>下单时间：</label></div>
								<div class="item-cont">
									<input type="text" readonly="readonly" value="<fmt:formatDate value="${orderCondition.startDate}" pattern="yyyy-MM-dd" />" name="startDate" class="dateTxt" onClick="WdatePicker()" />
			            			<span> 至 </span>
			            			<input type="text" readonly="readonly" value="<fmt:formatDate value="${orderCondition.endDate}" pattern="yyyy-MM-dd" />" name="endDate" class="dateTxt" onClick="WdatePicker()" />
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>订单状态：</label></div>
								<div class="item-cont">
									<div class="select">
										<select name="orderStatus">
						            		<option value="-1">全部</option>
						            		<option <c:if test="${orderCondition.orderStatus == '1'}">selected="selected"</c:if> value="1">待处理</option>
						            		<option <c:if test="${orderCondition.orderStatus == '2'}">selected="selected"</c:if> value="2">等待付款</option>
						            		<option <c:if test="${orderCondition.orderStatus == '3'}">selected="selected"</c:if> value="3">等待发货</option>
						            		<option <c:if test="${orderCondition.orderStatus == '4'}">selected="selected"</c:if> value="4">已取消</option>
						            		<option <c:if test="${orderCondition.orderStatus == '5'}">selected="selected"</c:if> value="5">已发货</option>
						            		<option <c:if test="${orderCondition.orderStatus == '6'}">selected="selected"</c:if> value="6">投递失败</option>
						            		<option <c:if test="${orderCondition.orderStatus == '7'}">selected="selected"</c:if> value="7">客户拒收</option>
						            		<option <c:if test="${orderCondition.orderStatus == '8'}">selected="selected"</c:if> value="8">交易完成</option>
						            		<option <c:if test="${orderCondition.orderStatus == '9'}">selected="selected"</c:if> value="9">退货中</option>
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
										    <option <c:if test="${orderCondition.payStatus == '1'}">selected="selected"</c:if> value="1">未支付</option>
										    <option <c:if test="${orderCondition.payStatus == '2'}">selected="selected"</c:if> value="2">已支付</option>
										</select>
									</div>
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>买家用户名：</label></div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${orderCondition.userName}" />" name="userName" class="txt textA" />
								</div>
							</li>
							<%-- <li class="item">
								<div class="item-label"><label>卖家注册手机号：</label></div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${orderCondition.sellerMobile}" />" name="sellerMobile" class="txt textA" />
								</div>
							</li> --%>
							<li class="item">
								<div class="item-label"><label>收货人手机号：</label></div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${orderCondition.rMobile}" />" name="rMobile" class="txt textA" />
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>收货地区：</label></div>
								<div class="item-cont">
									<div class="select slt-addr">
										<select name="province" id="province">
										    <option value="-1">全部</option>
										    <c:forEach items="${provinces}" var="province">
												<option value="${province.geoId}"><c:out value="${province.geoName}" /></option>
											</c:forEach>
										</select>
										<input type="hidden" value="<c:out value="${orderCondition.provinceName}" />" name="provinceName" />
									</div>
									<div class="select slt-addr">
										<select name="city" id="city">
										    <option value="-1">全部</option>
										</select>
										<input type="hidden" value="<c:out value="${orderCondition.cityName}" />" name="cityName" />
									</div>
									<div class="select slt-addr">
										<select name="county" id="county">
										    <option value="-1">全部</option>
										</select>
										<input type="hidden" value="<c:out value="${orderCondition.countyName}" />" name="countyName" />
									</div>
								</div>
							</li>
							
							<li class="item">
								<div class="item-label"><label>商品名称：</label></div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${orderCondition.proTitle}" />" name="proTitle" class="txt textA" />
								</div>
							</li>
							
							<li class="item">
								<div class="item-label"><label>商品编号：</label></div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${orderCondition.prodCode}" />" name="prodCode" class="txt textA" />
								</div>
							</li>
							
							<li class="item">
								<div class="item-label"><label>店铺名称：</label></div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${orderCondition.storeName}" />" name="storeName" class="txt textA" />
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>订单来源：</label></div>
								<div class="item-cont">
									<div class="select">
										<select name="orderSource">
						            		<option value="-1">全部</option>
						            		<option <c:if test="${orderCondition.orderSource == '1'}">selected="selected"</c:if> value="1">网站</option>
						            		<option <c:if test="${orderCondition.orderSource == '2'}">selected="selected"</c:if> value="2">电话</option>
						            		<option <c:if test="${orderCondition.orderSource == '3'}">selected="selected"</c:if> value="3">手机IOS</option>
						            		<option <c:if test="${orderCondition.orderSource == '4'}">selected="selected"</c:if> value="4">手机安卓</option>
						            	</select>
									</div>
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>支付方式：</label></div>
								<div class="item-cont">
									<div class="select">
										<select name="payType">
						            		<option value="-1">全部</option>
						            		<option <c:if test="${orderCondition.payType == '0'}">selected="selected"</c:if> value="0">货到付款</option>
						            		<option <c:if test="${orderCondition.payType == '1'}">selected="selected"</c:if> value="1">在线支付</option>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '00'}">selected="selected"</c:if> value="00">货到付款-现金</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '01'}">selected="selected"</c:if> value="01">货到付款-POS</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '20'}">selected="selected"</c:if> value="20">支付宝</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '1z'}">selected="selected"</c:if> value="1z">银联在线</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '10'}">selected="selected"</c:if> value="10">银联-中国工商银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '11'}">selected="selected"</c:if> value="11">银联-中国农业银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '12'}">selected="selected"</c:if> value="12">银联-中国银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '13'}">selected="selected"</c:if> value="13">银联-中国建设银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '14'}">selected="selected"</c:if> value="14">银联-交通银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '15'}">selected="selected"</c:if> value="15">银联-招商银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '16'}">selected="selected"</c:if> value="16">银联-中国光大银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '17'}">selected="selected"</c:if> value="17">银联-中信银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '18'}">selected="selected"</c:if> value="18">银联-中国民生银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '1a'}">selected="selected"</c:if> value="1a">银联-华夏银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '1b'}">selected="selected"</c:if> value="1b">银联-广发银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '1c'}">selected="selected"</c:if> value="1c">银联-浦发银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '1d'}">selected="selected"</c:if> value="1d">银联-兴业银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '1e'}">selected="selected"</c:if> value="1e">银联-中国邮政储蓄</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '1f'}">selected="selected"</c:if> value="1f">银联-东亚银行</option> --%>
<%-- 						            		<option <c:if test="${orderCondition.payMode == '30'}">selected="selected"</c:if> value="30">吉林银行</option> --%>
						            	</select>
									</div>
								</div>
							</li>
						</ul>
					</fieldset>
					<!-- foldbarH -->
					<div id="foldbarH" class="foldbarH"><!-- 展开后添加class命open -->
						<div id="foldBtn" class="foldBtn"><i class="ico"></i></div>
						<div class="searchBtn"><input id="search" type="button" class="btn btn-s" value="查&nbsp;&nbsp;询" /></div>
					</div>
					<!-- foldbarH end -->
				</form>
			</div>
			<!-- screening end -->
			<!-- actionBar -->
<!-- 			<div class="actionBar">
				<div class="pagingMini">
					<div class="pagingBtn">
						<a href="javascript:void(0)" class="pageUp disable"></a>
						<a href="#" class="pageDown"></a>
					</div>
					<div class="pageNum"><span><b>1</b></span>/<span>20</span>页</div>
					<div class="count">共<em>23145</em>条记录，本页显示<em>20</em>条</div>
				</div>
			</div> -->
			<!-- actionBar end -->
			<!-- table -->
			<div class="tableWrap">
				<table class="table tableA">
					<colgroup>
						<col width="20" />
						<col width="30" />
						<col width="76" />
						<col width="80" />
						<col width="80" />
						<col width="100" />
						<col width="90" />
						<col />
						<col width="80" />
						<col width="70" />
						<col width="80" />
						<col >
						<col width="100">
					</colgroup>
					<thead>
						<tr>
							<th></th>
							<th>序号</th>
							<th>订单编号</th>
							<th>下单时间</th>
							<th>订单金额</th>
							<th>付款方式</th>
							<th>买家用户名</th>
							<th>收货地区</th>
							<th>订单状态</th>
							<th>付款状态</th>
							<th>订单来源</th>
							<th>店铺名称</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${fn:length(page.result) > 0}">
								<c:forEach items="${page.result}" var="order" varStatus="var">
									<tr>
										<td class="chkbox"><input orderId="${order.orderId}" name="orderCheck" type="checkbox" class="chk" /></td>
										<td>${var.count}</td>
										<th><a target="_blank" href="${ctx}/order/orderDetail?orderId=${order.orderId}"><c:out value="${order.orderId}"></c:out></a></th>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${order.createdDate}"/></td>
										<td><fmt:formatNumber pattern="0.00" value="${order.orderFee}"></fmt:formatNumber></td>
										<td><c:out value="${order.strPayMode}"></c:out></td>
										<td><c:out value="${order.userName}"></c:out></td>
										<td class="align-l">
											<c:out value="${order.rProvince}"></c:out>
											<c:out value="${order.rCity}"></c:out>
											<c:out value="${order.rCounty}"></c:out>
											<c:out value="${order.rTown}"></c:out>
										</td>
										<td><c:out value="${order.strOrderStatus}"></c:out></td>
										<td><c:out value="${order.strPayStatus}"></c:out></td>
										<td><c:out value="${order.strOrderSource}"></c:out></td>
										<td class="align-l"><c:out value="${order.storeName}"></c:out></td>
										<td class="t-operate">
											<c:choose>
												<c:when test="${order.orderStatus <='3' || order.orderStatus =='5' }">
													<div class="mod-operate">
														<div class="def">
															<a target="_blank" href="${ctx}/order/orderDetail?orderId=${order.orderId}">订单详情</a>
															<i class="arr"></i>
														</div>
														<ul>
															<li>
																<a name="cancelOrder" orderId="${order.orderId}" href="javascript:;">作废订单</a>
															</li>
														</ul>
													</div>
												</c:when>
												<c:otherwise>
													<p><a target="_blank" href="${ctx}/order/orderDetail?orderId=${order.orderId}">订单详情</a></p>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr class="emptyGoods">
									<td rowspan="3" colspan="13">暂无符合条件的查询结果</td>
								</tr>
							</c:otherwise>
						</c:choose>
						
					</tbody>
				</table>
			</div>
			<!-- table end -->
			<c:if test="${fn:length(page.result) > 0}">
				<pgNew:page name="queryOrder" page="${page}" formId="query"></pgNew:page>
			</c:if>
		</div>
		<!-- orderSearch end -->
		<input type="hidden" name="cancelOrderId"/>
	</body>
</html>
