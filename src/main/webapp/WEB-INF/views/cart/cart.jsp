<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>电话下单-一网全城</title>
		
	</head>
	<body>
		<script type="text/javascript" src="${ctx}/static/js/trade.js"></script>
		<script type="text/javascript" src="${ctx}/static/js/jquery.json-2.4.js"></script>
		<script type="text/javascript">
			$(function() {
				$.ajaxSetup({cache:false});
				$("#cart").load("${ctx}/order/cartContent");
				$(document).on("click", "input[name=addProd]", function() {
					window.open ('${ctx}/order/prodList','newwindow','height=700,width=850,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, resizable=no,location=no, status=no') 
				});
				$(document).on("click", "a[name=close]", close);
				$(document).on("click", "input[name=cancel]", close);
				$(document).on("click", "input[name=save]", function() {
					var skuId = $("input[name=skuId]").val();
					var num = $("input[name=num]").val();
					if (!!skuId) {
						if (!/^\d+$/.exec(skuId)) {
							alert("skuId必须是数字型！");
							return false;
						}
					} else {
						alert("请填写skuId！");
						return false;
					}
					if (!!num) {
						if (!/^\d+$/.exec(num)) {
							alert("数量必须是数字型！");
							return false;
						}
					} else {
						alert("请填写数量！");
						return false;
					}
					$.post(
						"${ctx}/order/addProd",
						{skuId:skuId,num:num},
						function(json){
							if(json.errCode != 0){
								showError(json.errCode);
							}else{
								$("#cart").load("${ctx}/order/cartContent");
								close();
							}
						}
					);
				}); 
		
				$(document).on("click", "a[name=del]", function() {
					var skuId = $(this).attr("skuId");
					$.post(
						"${ctx}/order/delCartItem?skuId=" + skuId,
						function(json){
							if(json.success){
								$.ajaxSetup({cache:false});
								$("#cart").load("${ctx}/order/cartContent");
							}
						}
					);
				});
			});
		
			function showError(errCode) {
				if (errCode == '-4') {
					alert("该sku不存在！");
				} else if (errCode == '-5') {
					alert("该sku已下架！");
				} else if (errCode == '-6') {
					alert("该商品已下架！");
				} else if (errCode == '-7') {
					alert("该sku缺货！");
				} else if (errCode == '-8') {
					alert("该sku库存不足！");
				} else if (errCode == '-9') {
					alert("该店铺异常！");
				}
			}
		
			function prodReload(){
				$.ajaxSetup({cache:false});
				$("#cart").load("${ctx}/order/cartContent");
			}
			
			function close() {
				$("div.mask-bg").hide();
				$("div#add").hide();
				$("input[name=skuId]").val("");
				$("input[name=num]").val("");
			}
			
		</script>
		<div class="crumbs-box">
			<div class="crumbs">
				<h3>当前位置 &#58;</h3>
				<ul>
					<li><a>BOSS</a>&#62;</li>
					<li><a>订单管理</a>&#62;</li>
					<li>电话下单</li>
				</ul>
			</div>
		</div>
		<!--crumbs-box end-->
		<div class="returns-operation">
			<div class="returns-search" style="height: 40px;">
				<div class="r-s-right" style="padding-left: 200px; padding-top: 5px;">
					手机号码：<input type="text" value="" name="qmobile" id="qmobile"
						class="inputText inputW1">
					<button class="inputBtn" onclick="trade.checkuser()" type="button">查询会员</button>
				</div>
			</div>
			<div id="addrtable" style="display:none;">
				<div class="formTitle">
				<i></i> <span class="title">会员历史收货地址</span> <button onclick="trade.newaddr()" style="float:right;"  type="button" class="inputBtn">新建收货地址</button>
			</div>
		<table class="boos-table">
		                        <thead>
		                            <tr>
		                                <th>选择</th>
		                                <th>联系人</th>
		                                <th>电话</th>
		                                <th>地址</th>
		                                <th>邮编</th>   
		                                <th>操作</th>                            
		                            </tr>
		                        <tr><td class="table-space" colspan="8"></td></tr>
		                        </thead>
		                        <tbody id="addrlist">
		                           
		                        </tbody>
		                        <tfoot>
		                            <tr><td class="table-space" colspan="8"></td></tr>
		                        </tfoot>
		                      	</table>
		</div>
		<div class="returns-operation" id ="addredit" style="padding-bottom: 10px;">
		<div class="formTitle">
		<i></i><span class="title">新建收货地址</span>
		</div>
			
			<div class="r-o-list">							
										<div class="boos-ul-list act" style="padding-bottom: 5px;">
											<label for=""><em style="color:red">*</em>收货人：&nbsp;&nbsp;&nbsp;&nbsp;</label>
											<input type="text" name="receiver" value="" id="receiver" class="inputText inputW1"><span  class="address-error"></span>
										</div>
										<div class="boos-ul-list act" style="padding-bottom: 5px;">					
											<label for=""><em style="color:red">*</em>所在地区：</label>
											<select name="province" onchange="trade.loadCity()" class="first-child" id="provinceDiv">

<option value="694">吉林省</option>
											</select>									
											<select name="city" onchange="trade.loadCounty()" id="cityDiv"><option value="0">请选择</option></select>
							                <select name="district" onchange="trade.loadTown()"  id="countyDiv"><option value="0">请选择</option></select>
							                <select name="town" onchange="trade.fillTownName()"  id="townDiv" style="width: 100px;display:none"><option value="0">请选择</option></select>
											<span  class="address-error"></span>
										</div>
										<div class="boos-ul-list act" style="padding-bottom: 5px;">
											<label for=""><em style="color:red">*</em>详细地址：</label>
											<input type="text" name="addr" id="addr" class="inputText inputW1" style="width: 340px;"><span  class="address-error"></span>
										</div>	
										<div class="boos-ul-list act" style="padding-bottom: 5px;">
											<label for=""><em style="color:red">*</em>邮政编码：&nbsp;&nbsp;</label>
											<input type="text" name="zipCode" id="zipCode" class="inputText inputW1" onblur="trade.checkzipcode()"><span  class="address-error"></span>
										</div>
										<div class="boos-ul-list act" style="padding-bottom: 5px;">
											<label for=""><em style="color:red">*</em>手机号码：</label>
											<input type="text" name="moblie" id="mobile" class="inputText inputW1" onblur="trade.checkmobile()"><span class="address-error"></span>
										</div>	
										<div class="boos-ul-list act" style="padding-bottom: 5px;">
											<label for=""><em></em>固定电话：&nbsp;&nbsp;</label>
											<input type="text" name="tel" id="tel" class="inputText inputW1" onblur="trade.checktel()"><span class="address-error"></span>
										</div>
																
										<div class="boos-ul-list act">
										<span><span><button id="addbutton" type="button"  class="inputBtn" onclick="trade.updateAddr('add')">保存收货人信息</button></span></span>
										<input type="hidden" name="addrId" id="addrId" value=""/>								
										</div>
			
			</div>
			</div>
			<div id="cart">
			</div>
			
		</div>
		<div class="mask-bg" style="display: none;"></div>
		<div class="mask-show" id="add" style="display: none;">
			<h2>
				添加商品 <a title="关闭" name="close">关闭</a>
				<ul class="mask-form-list">
					<form action="${ctx}/order/addProd" id="addProd">
						<li>
							<div class="m-f-l-left">skuId：</div>
							<div class="m-f-l-right">
								<input name="skuId" class="inputText" type="text" />
							</div>
						</li>
						<li>
							<div class="m-f-l-left">数量：</div>
							<div class="m-f-l-right">
								<input name="num" class="inputText" type="text" />
							</div>
						</li>
						<li>
							<div class="m-f-l-btn">
								<input class="inputBtn" name="save" type="button" value="保 存">
								<input class="inputBtn" name="cancel" type="button" value="取 消">
							</div>
						</li>
						<input type="hidden" name="addressId" id="addressId" value=""/>	
					</form>
				</ul>
			</h2>
		</div>
		<div class="mask-show" id="orderpop" style="display:none;">
			<h2>
				 订单信息<a title="关闭" onclick="$('div.mask-bg').hide();$('#orderpop').hide();">关闭</a>
		    </h2>
				<div id="orderidlist" style="margin-top: 20px;">	
				
				<div>
				
				</div>
		        </div>
		</div>
		<div class="r-o-list">
		<div align="right">
		<input class="inputBtnA inputW2" style="width: 100px;" type="button" id="savebutton" onclick="trade.saveorder()" value="生成订单">
		</div>
		</div>
		<script type="text/javascript">
				$(function(){		
					trade=new trade();
					//trade.getarea(0,$("#provinceDiv"));
					//$("#provinceDiv option[value='0']").prop("selected", true);
					$("#savebutton").prop("disabled", false);
					$("#addbutton").prop("disabled", false);
					$("#addrtable").hide();
					$("#addredit").hide();					
					trade.cleardata();
					trade.getarea(694,$("#cityDiv"));
					$("#addredit input").change(function(){
						trade.addrissave=0;
					});
				});
			</script>
	</body>
</html>