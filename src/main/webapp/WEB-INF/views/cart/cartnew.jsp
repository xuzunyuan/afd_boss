<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title></title>
	</head>
	<body>
		<link rel="stylesheet" href="${ctx}/static/style/classes_.css?t=20140626" />
		<script type="text/javascript" src="../static/js/jquery.md.js?t=2014061701"></script>
		<script type="text/javascript" src="${ctx}/static/js/trade.js"></script>
		<script type="text/javascript" src="${ctx}/static/js/jquery.json-2.4.js"></script>
		<script type="text/javascript">
		var product_error=0;
			$(function() {
				//$.ajaxSetup({cache:false});
				//$("#step2content").load("${ctx}/order/cartContent?uid=97&addrid=294");
				//$(document).on("click", "input[name=addProd]", function() {window.open ('/yiwang_boss/order/prodList','newwindow','height=800,width=1200,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, resizable=no,location=no, status=no');});
				$(document).on("click", "a[name=close]", close);
				$(document).on("click", "input[name=cancel]", close);
				$(document).on("click", "span.plusBtn", function() {
					var obj = $(this).siblings("input[name=num]");
					var balance= obj.attr("skubalance");
					var num = obj.val();
					if(parseInt(balance)<=num){obj.val(parseInt(balance));return;}
					num++;
					$(this).siblings("span.minusBtn").removeClass("disable");
					obj.val(num);
					var skuid= obj.attr("skuid");
					var ppdid= obj.attr("ppdid");
					changnum(skuid,ppdid,num);
				});
				$(document).on("click", "span.minusBtn", function() {
					var obj = $(this).siblings("input[name=num]");
					var num = obj.val();
					if(num<=1){$(this).addClass("disable");obj.val(1);return;}
					num--;					
					obj.val(num);
					var skuid= obj.attr("skuid");
					var ppdid= obj.attr("ppdid");
					changnum(skuid,ppdid,num);
				});	
				
				$(document).on("click", "input[name=save]", function() {
					var skuId = $("input[name=skuId]").val();
					var num = $("input[name=num]").val();
					if (!!skuId) {
						if (!/^\d+$/.exec(skuId)) {
							showmsg("skuId必须是数字型！");
							return false;
						}
					} else {
						showmsg("请填写skuId！");
						return false;
					}
					if (!!num) {
						if (!/^\d+$/.exec(num)) {
							showmsg("数量必须是数字型！");
							return false;
						}
					} else {
						showmsg("请填写数量！");
						return false;
					}
					$.post(
						"${ctx}/order/addProd",
						{skuId:skuId,num:num},
						function(json){
							if(json.errCode != 0){
								showError(json.errCode);
							}else{
								$("#cartlist").load("${ctx}/order/cartContent?uid="+trade.userid+"&addrid="+$("#addressId").val());
								close();
							}
						}
					);
				}); 
		
				$(document).on("click", "a[name=del]", function() {
				 //if(trade.userid==0||$("#addressId").val()==""){
				//		alert("请保存或选择收货地址");return;
				//	}
					var skuId = $(this).attr("skuId");
					$.post(
						"${ctx}/order/delCartItem?skuId=" + skuId,
						function(json){
							if(json.success){
								$.ajaxSetup({cache:false});
								$("#cartlist").load("${ctx}/order/cartContent?uid="+trade.userid+"&addrid="+$("#addressId").val());
							}
						}
					);
				});
			});
		
			function showError(errCode) {
				if (errCode == '-3') {
					showmsg("请正确填写购买数量！");
				}else if (errCode == '-4') {
					showmsg("该sku不存在！");
				} else if (errCode == '-5') {
					showmsg("该sku已下架！");
				} else if (errCode == '-6') {
					showmsg("该商品已下架！");
				} else if (errCode == '-7') {
					showmsg("该sku缺货！");
				} else if (errCode == '-8') {
					showmsg("该sku库存不足！");
				} else if (errCode == '-9') {
					showmsg("该店铺异常！");
				}else if (errCode == '-10') {
					var stock = arguments[1];
					showmsg("所选优惠最多购买"+stock+"件！");
				}
			}
		
			function prodReload(){
				//if(trade.userid==0||$("#addressId").val()==""){
				//	alert("请保存或选择收货地址");return;
				//}
				$.ajaxSetup({cache:false});
				$("#cartlist").load("${ctx}/order/cartContent?uid="+trade.userid+"&addrid="+$("#addressId").val());
			}
			
			function close() {
				$("div.mask-bg").hide();
				$("div#add").hide();
				$("input[name=skuId]").val("");
				$("input[name=num]").val("");
			}
			function moditynum(obj){
				var skuid= $(obj).attr("skuid");
				var ppdid= $(obj).attr("ppdid");
				num=$(obj).val();
				if(num==""){showmsg("请填写数量！"); prodReload();return;}
				changnum(skuid,ppdid,num);
			}
			
			function changnum(skuid,ppdid,num){
				//if(trade.userid==0||$("#addressId").val()==""){
				//	alert("请保存或选择收货地址");return;
				//}
				$.post(
						"${ctx}/order/modifyProd",
						{skuId:skuid,ppdId:ppdid,num:num,uid:trade.userid},
						function(json){
							if(json.errCode != 0){
								showError(json.errCode,json.stock);								
							}else{								
								close();
							}
							$("#cartlist").load("${ctx}/order/cartContent?uid="+trade.userid+"&addrid="+$("#addressId").val());
						}
					);
			}
			
		</script>
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
				<!-- orderOperate -->
				<div class="orderOperate">
					<div class="hintBar">
						<dl>
							<dt><i class="icon i-exclaim"></i></dt>
							<dd>
								<h4>请注意：</h4>
								<ul>
									<li><em>·</em>只能购买吉林省内卖家店铺的东东，并且订单也只能配送到吉林省内</li>
									<li><em>·</em>订单付款方式：只支持货到付款</li>
									<li><em>·</em>订单配送方式：吉林省EMS统一发货</li>
								</ul>
							</dd>
						</dl>
					</div>
					<!-- operateStep -->
					<div class="operateStep">
						<div class="os-caption" onmouseover="this.style.cursor='pointer';this.style.cursor='hand'"  onclick="$('#step1').toggleClass('i-minus i-plus'); $('#step1content').toggleClass('block'); "><h2><i id="step1" class="icon i-minus"></i><span>第1步</span>确认客户信息</h2></div>
						<div id="step1content" class="os-content block">
							<form action="" class="form formB">
								<fieldset>
									<div class="content-hd">
										<ul class="formBox">
											<li class="item">
												<div class="item-label"><label>手机号码：</label></div>
												<div class="item-cont">
													<input type="text" name="qmobile" id="qmobile" class="txt textC">
												</div>
											</li>
											<li class="item">
												<div class="item-label"><label>用户名：</label></div>
												<div class="item-cont">
													<input type="text" name="qname" id="qname" class="txt textC">
												</div>
											</li>
										</ul>
										<div class="searchBtn"><input type="button" onclick="trade.checkuser()" class="btn btn-s" value="查&nbsp;&nbsp;询"></div>
									</div>
									<div id="userinfo" style="display:none;">
									<h3>客户注册信息：</h3>
										<ul class="comMeg">
											<li class="item">
												<div class="item-label"><label>用户名：</label></div>
												<div id="username" class="item-cont">
												</div>
											</li>
											<li class="item">
												<div class="item-label"><label>注册时间：</label></div>
												<div id="regdate" class="item-cont">
												</div>
											</li>
											<li class="item">
												<div class="item-label"><label>账号状态：</label></div>
												<div id="usertatus" class="item-cont">
												</div>
											</li>
											<li class="item">
												<div class="item-label"><label>注册方式：</label></div>
												<div id="regtype" class="item-cont">
												</div>
											</li>
										</ul>
									</div>
									<div id="addrtable">
									<h3><input type="button" class="btnA" value="+添加新收货地址" onclick="trade.newaddr()">客户收货地址：</h3>
									 <div class="clamMeg">
										<ul id="addrlist">
										
										</ul>
									 </div>
									</div>
									<div id="addredit">
									<h3><span id="addroptname">添加</span>收货地址：</h3>
									<dl class="item">
										<dt class="item-label">
											<label><em>*</em>所在地区：</label>
										</dt>
										<dd class="item-cont">
											<div class="select slt-addr">
												<select name="province" onchange="trade.loadCity()" id="provinceDiv">
												    <option value="694">吉林省</option>
												</select>
											</div>
											
											<div class="select slt-addr">
												<select name="city" onchange="trade.loadCounty()" id="cityDiv">
												    <option value="0">请选择</option>
												</select>
											</div>
											<div class="select slt-addr">
												<select  name="district" onchange="trade.loadTown()"  id="countyDiv">
												    <option value="0">请选择</option>
												</select>
											</div>
											<div class="select slt-addr" style="display:none">
												<select  name="town" onchange="trade.fillTownName()"  id="townDiv" style="display:none">
												    <option value="0">请选择</option>
												</select>
											</div>
											<div  class="checkHint error"><div  class="hintBox"><span id="areaerror"></span></div></div>
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label><em>*</em>详请地址：</label>
										</dt>
										<dd class="item-cont">
											<p id="areastr"></p>
											<input name="addr" id="addr"  type="text" class="txt textC" /><div class="checkHint error"><div class="hintBox"><span></span></div></div>
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label>邮政编码：</label>
										</dt>
										<dd class="item-cont">
											<input type="text"  name="zipCode" id="zipCode" class="txt textB" /><div class="checkHint error"><div class="hintBox"><span style="width: 180px;"></span></div></div>
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label><em>*</em>收货人姓名：</label>
										</dt>
										<dd class="item-cont">
											<input type="text" name="receiver" value="" id="receiver"  class="txt textC" /><div class="checkHint error"><div class="hintBox"><span></span></div></div>
										</dd>
									</dl>
									<dl class="item">
										<dt class="item-label">
											<label><em>*</em>手机号码：</label>
										</dt>
										<dd class="item-cont">
											<input type="text"  name="moblie" id="mobile"  onblur="trade.checkmobile()" class="txt textC" /><div class="checkHint error"><div class="hintBox"><span></span></div></div>											
										</dd>
									</dl>
									<dl class="item item-tel">
										<dt class="item-label">
											<label>固定电话：</label>
										</dt>
										<dd class="item-cont">
											<input type="text" id="tela" class="txt telArea" maxlength="4" /><span>-</span>
											<input type="text" id="telb" class="txt telNum"  maxlength="8" /><span>-</span>
											<input type="text" id="telc" class="txt telExt"  maxlength="4" />
											<div class="checkHint error"><div class="hintBox"><span></span></div></div>
										</dd>
									</dl>
									<input type="hidden" name="addrId" id="addrId" value=""/>
									<input type="hidden" name="addressId" id="addressId" value=""/>
									<input type="hidden" name="payType" value="0"/>
									<dl class="item">
									<dt class="item-label">
                                    <label class="hidden">保存收货信息</label>
                                    </dt>										
										<dd class="item-cont">
											<input type="button" onclick="trade.updateAddr('add')" class="btnC" value="保 存" />
											<input type="button" onclick="trade.canceledit()" class="btn" value="取 消" />
										</dd>
									</dl>
								</div>
								</fieldset>
							</form>
						</div>
					</div>
					<!-- operateStep end -->
					<!-- operateStep -->
					<div class="operateStep">
						<div class="os-caption" onmouseover="this.style.cursor='pointer';this.style.cursor='hand'"  onclick="$('#step2').toggleClass('i-minus i-plus'); $('#step2content').toggleClass('block'); "><h2><i id="step2" class="icon i-plus"></i><span>第2步</span>选择商品</h2></div><!-- 默认隐藏用加号 class为i-plus，展开用减号i-minus； -->
						
						<div id="step2content" class="os-content">
						<div class="os-add" id="addbutton" style="display:none">
						<input type="button" name="addProd"  value="添加商品" onclick="window.open('${ctx}/order/prodList','newwindow','height=600,width=1022,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, resizable=no,location=no, status=no')" class="btnB">
						</div>
	                    <div id="cartlist">
                        <div class="accountNo block">
	                    <span>暂无可结算商品</span> 
	                    <input type="button" name="addProd"  value="添加商品" onclick="window.open('${ctx}/order/prodList','newwindow','height=600,width=1022,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, resizable=no,location=no, status=no')" class="btnB">
                        </div>
						</div>
					</div>
					<!-- operateStep end -->
					
					<!-- operateStep -->
					<div class="operateStep">
						<div class="os-caption"  onmouseover="this.style.cursor='pointer';this.style.cursor='hand'"  onclick="$('#step3').toggleClass('i-minus i-plus'); $('#step3content').toggleClass('block'); "><h2><i id="step3" class="icon i-plus"></i><span>第3步</span>选择支付方式</h2></div>
						<div  class="os-content block">
							<div id="step3content" class="payMode" style="display:none">
								<h3>支付方式</h3>
								<div class="item">
									<input type="radio" class="rdo" name="payMode" value="00" checked="checked" id="payModeCash" /><label for="payModeCash"><i class="icon i-cash"></i>货到付款 - 现金</label>
								</div>
								<div class="item">
									<input type="radio" class="rdo" name="payMode"  value="01"  id="payModePos" /><label for="payModePos"><i class="icon i-pos"></i>货到付款 - POS机刷卡</label>
								</div>
							</div>
							<!-- amount -->
							<div class="amount amount-payMode">
								<div class="amountAdr">
									<p id="addressc">寄送至：</p><br>
									<p id="phonec">收件人：</p>
								</div>
								<div class="amountMon">
									<p><b>订单合计（含运费）：</b><strong id="totalfee"></strong></span></p>
								<input type="button" class="btnC"  id="savebutton" onclick="trade.saveorder()" value="提交订单" />
								</div>
							</div>
							<!-- amount end -->
						</div>
					</div>
					<!-- operateStep end -->
				</div>
				<!-- orderOperate end -->
			</div>
			<div class="pop" id="savedinfo" style="display:none">
		<div class="hd">
			<h1>操作成功</h1>
			<span></span>
		</div>
		<div class="bd">
			<div class="pop-con">
				<h2><i class="icon i-duigou"><!--<i class="icon i-warns"></i>--></i>订单已成功提交</h2>
				<p class="xitongP">系统已通知卖家安排发货！</p>
			</div>
			<div class="formBtn">
				<input type="button" onclick="location.href='${ctx}/order/cart'" value="继续下单" class="btnB btn-s">
				<input type="button" onclick="location.href='${ctx}/order/queryOrder?m=19'" value="查看订单" class="btnA btn-s">
			</div>
		</div>
	</div>
	<div class="mask" id="savedmask" style="display:none"></div>
			<!-- main end -->
			<script type="text/javascript">
			//判断是否是整数
			function isInt(s){
			    var patrn =/^([1-9]\d{0,9})$|(0)$/;
			    if (!patrn.exec(s))
			        return false;
			    else
			        return true;
			}
			//判断是否是浮点数
			function isFloat(s)
			{
			    var patrn =/^([1-9]\d*)$|(0)$/;
			    var patrn1=/^([0-9]\d*)$/
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
					trade=new trade();
					$("#addrtable").hide();
					$("#addredit").hide();					
					trade.cleardata();
					trade.getarea(694,$("#cityDiv"));
					trade.userid=0;
					$("#addredit input").change(function(){
						trade.addrissave=0;
					});
				});
			</script>
</body>
</html>