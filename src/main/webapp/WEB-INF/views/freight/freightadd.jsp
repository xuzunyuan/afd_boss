<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setAttribute("ctx", request.getContextPath()); %>
<%request.setAttribute("imgUrl", "http://upload.yiwang.com/rc/getimg"); %>
<%request.setAttribute("prodUrl", "http://item.yiwang.com/detail/"); %>
<%request.setAttribute("prodSnapUrl", "http://member.yiwang.com/index.php?r=product/tradesnapshot&itemid="); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<html>
<head>
<title>运费模板/新增运费模板</title>
</head>
<body>
<script type="text/javascript" src="../static/js/jquery.md.js?t=2014061701"></script>
<script type="text/javascript">
function freight(){
	
	this.changepricetype=function(type){
		freight.clearfreighttpl();
		var unitname="kg";	
		var unitdesc="重";
		if(type=="w"){
			pricetype="weight";
			
		}
		if(type=="v"){
			unitname="m³";
			unitdesc="体积";
			pricetype="volume";
		}
		if(type=="n"){
			unitname="件";
			unitdesc="件";
			pricetype="unit";
		}		
		$("#unitnamewa").text(unitname);
		$("#unitnamewb").text(unitname);
		$("#unitdesca").text(unitdesc);
		$("#unitdescb").text(unitdesc);
		if(type=="n"){
			$("#increunitsp").html('<input type="text" class="txt textB" id="increunits"  name="increUnits" value="" onblur="clearzero(this)"  onKeyUp="inputFloat(this,0)"/><div id="increunitserror" class="warn error"></div>');
			$("#baseunitsp").html('<input type="text" class="txt textB" id="baseunits"  name="baseUnits" value="" onblur="clearzero(this)" onKeyUp="inputFloat(this,0)"/><div id="baseunitserror" class="warn error"></div>');

		}else{
			$("#increunitsp").html('<input type="text" class="txt textB" id="increunits"  name="increUnits" value="" onblur="clearzero(this)" onKeyUp="inputFloat(this,2)"/><div id="increunitserror" class="warn error"></div>');
			$("#baseunitsp").html('<input type="text" class="txt textB" id="baseunits"  name="baseUnits" value="" onblur="clearzero(this)" onKeyUp="inputFloat(this,2)"/><div id="baseunitserror" class="warn error"></div>');
		}
	};
	this.chosepricemode=function(type,typestr){
		if(pricetype==typestr){
			return;
		}
		  
		   var bfee=$.trim($("#basefee").val());
		   var bu=$.trim($("#baseunits").val());
		   var iu=$.trim($("#increunits").val());
		   var ifee=$.trim($("#increfee").val());
		   
		 var msg = '<p>切换计价方式后，所设置当前模板的运输信息将被清空，确定继续么？</p>';
		 $.modaldialog(msg,{
				title : '更换计价方式',
				buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){freight.changepricetype(type); $("div[id$=error]").removeClass("block");}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s',click:function(){
										
							$("#"+pricetype).prop("checked",true);
						
						}}],
				hasclose:false
			});			
	};
   this.chosepaytype=function(type){
	   if(type==paytype){
		   return false;
	   }
	   if(type=='b'){
		   $("#pricetypecode").show();
		   $("#carriage").show();
		   paytype='b';
	   }else{
		   paytype='s';
		   var msg = '<p>选择“卖家承担运费”后，所有区域的运费将设置为0元且原运费设置无法恢复，确定继续么？</p>';
			$.modaldialog(msg,{
				title : '更换为卖家承担运费',
				buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){freight.clearfreighttpl();$("#carriage").hide();$("#pricetypecode").hide();}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s',click:function(){
					$("#buyer").prop("checked",true);
					paytype='b';
					}}],
				hasclose:false
			});		   
	   }
   };
   
   this.clearfreighttpl=function(){
	   $("#basefee").val("");
	   $("#baseunits").val("");
	   $("#increunits").val("");
	   $("#increfee").val(""); 
   };
   
   this.checktplname=function() 
   {
   var obj=$("#tplname");
   var name = obj.val();

   if (!name.match( /^[\u4E00-\u9FA5a-zA-Z0-9]{1,50}$/)) {
   $("#tplNameerror").addClass("block");
   return false;
   } else {
	   $("#tplNameerror").removeClass("block");
   }
   return true;
   };
   
   this.geterrorstr=function(pricetype,type){
	   var str="";
	   if(pricetype=='weight'){
		  if(type=="bfee"){
			  str="首费应输入0.00至999.99的数字（不包含0）";
		  }
		  if(type=="bu"){
			  str="首重应输入0至999.99的数字（不包含0）"; 
		  }
		  if(type=="iu"){
			  str="续重应输入大于0小于999.99的数字（不包含0）";
		  }
		  if(type=="ifee"){
			  str="续费应输入0.00至999.99的数字（不包含0）";
		  }
	   }
	   if(pricetype=='volume'){
		   if(type=="bfee"){
				  str="首费应输入0.00至999.99的数字（不包含0）";
			  }
			  if(type=="bu"){
				  str="首体积应输入0至999.99的数字（不包含0）"; 
			  }
			  if(type=="iu"){
				  str="续体积应输入0至999.99的数字（不包含0）；";
			  }
			  if(type=="ifee"){
				  str="续费应输入0.00至999.99的数字（不包含0）";
			  }
	   }
	   if(pricetype=='unit'){
		   if(type=="bfee"){
				  str="首费应输入0.00至999.99的数字（不包含0）";
			  }
			  if(type=="bu"){
				  str="首件应输入1至9999的数字（不包含0）"; 
			  }
			  if(type=="iu"){
				  str="续件应输入1至9999的数字（不包含0）";
			  }
			  if(type=="ifee"){
				  str="续费应输入0.00至999.99的数字（不包含0）";
			  }
	   }
	   return str;
   };
   this.checkfreighttpl=function(){
	   var bfee=$.trim($("#basefee").val());
	   var bu=$.trim($("#baseunits").val());
	   var iu=$.trim($("#increunits").val());
	   var ifee=$.trim($("#increfee").val());
	   if($("#buyer").prop("checked")){
		   
		   if(pricetype=="unit"){
			 
			   if(bu==""||parseInt(bu)<1||parseInt(bu)>9999){
				   $("#baseunitserror").text(this.geterrorstr(pricetype, 'bu')).addClass("block");
				   return false;
			   }else{
				   $("#baseunitserror").removeClass("block");
			   }
			   			  
		   }else{
			   if(bu==""||parseFloat(bu)<0.01||parseFloat(bu)>999.99){
				   $("#baseunitserror").text(this.geterrorstr(pricetype, 'bu')).addClass("block");
				   return false;
			   }else{
				   $("#baseunitserror").removeClass("block");
			   }
			   			  
		   }
		   
		   if(bfee==""||parseFloat(bfee)<0.01||parseFloat(bfee)>999.99){
			   $("#basefeeerror").text(this.geterrorstr(pricetype, 'bfee')).addClass("block");
			   return false;
		   }else{
			   $("#basefeeerror").removeClass("block");
		   }
		   if(pricetype=="unit"){
				 			  
			   if(iu==""||parseInt(iu)<1||parseInt(iu)>9999){
				   $("#increunitserror").text(this.geterrorstr(pricetype, 'iu')).addClass("block");
				   return false;
			   }else{
				   $("#increunitserror").removeClass("block");
			   }
			   
		   }else{			  
			   if(iu==""||parseFloat(iu)<0.01||parseFloat(iu)>999.99){
				   $("#increunitserror").text(this.geterrorstr(pricetype, 'iu')).addClass("block");
				   return false;
			   }else{
				   $("#increunitserror").removeClass("block");
			   }
		   }
		   if(ifee==""||parseFloat(ifee)<0.01||parseFloat(ifee)>999.99){
			   $("#increfeeerror").text(this.geterrorstr(pricetype, 'ifee')).addClass("block");
			   return false;
		   }else{
			   $("#increfeeerror").removeClass("block");
		   }
	   }
	   $("#ftplerror").removeClass("block");
	   return true;
	  
   };
   this.checkform=function(){
	   if(!this.checktplname()){
		   return false;
	   }
	   if($("#buyer").prop("checked")){
		   
		   if(!this.checkfreighttpl()){
			   return false;
		   } 
	   }   
	   $("#tplform").submit();
   };
}
var pricetype="weight";
var paytype="b";
var freight= new freight();
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
function clearzero(text1){
	str = text1.value;
	if(str=="0"||parseFloat(str)<0.01){
		text1.value  = "";
	}
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
            else {
            	if(dotindex>0.01){

                    if(str.length-dotindex>suffix+1){
                        var ilen = str.length;
                        str = str.substring( 0,ilen - 1 );
                    }
                    if(suffix==0){
               		 var ilen = str.length;
               		 str = str.substring( 0,ilen - 1 );
               	}
                }
            }
            break;
        }
    }
    
    if(($(text1).attr("id")=="baseunits"||$(text1).attr("id")=="increunits")&&pricetype=="unit"){
    	if((9999<parseInt(str)||parseInt(str)<0.01)){
	    	str="";
        }
    }else{
    	if((999.99<parseFloat(str)||parseFloat(str)<0.00)&&suffix==2){
        	str="";
        }
        
    }
    
    
    text1.value  = str;
    $("div[id$=error]").removeClass("block");
}

$(function(){
	$("#weight").prop("checked",true);
	pricetype="weight";	
	freight.clearfreighttpl();
	<c:if test="${!empty tpl.priceType}">
	$("input[name=priceType][value=${tpl.priceType}]").prop("checked",true);
	pricetype=$("input[name=priceType][value=${tpl.priceType}]").attr('id');
	freight.changepricetype('${tpl.priceType}');
	</c:if>
	<c:if test="${!empty tpl.payType}">
	$("input[name=payType][value=${tpl.payType}]").prop("checked",true);	
	paytype="${tpl.payType}";
	</c:if> 
	
	<c:if test="${tpl.payType=='s'}">
	$("#carriage").hide();
	</c:if> 
	
	<c:if test="${tpl.payType=='b'}">
	   $("#basefee").val("${tpl.baseFee}");
	   $("#baseunits").val("${tpl.baseUnits}");
	   $("#increunits").val("${tpl.increUnits}");
	   $("#increfee").val("${tpl.increFee}"); 
	</c:if> 
	
	
});
</script>
<link rel="stylesheet" href="${ctx}/static/style/classes_.css?t=20140626"/>
<!-- main -->
			<div class="main">
				<!-- foldbarV -->
				<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
				<!-- foldbarV end -->
				<!-- crumbs -->
				<div class="crumbs crumbsA">
					<ul>
						<li><a href="#">后台首页</a><em>&gt;</em></li>
						<li><a href="#">物流管理</a><em>&gt;</em></li>
						<li><strong>运费模板</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- addTemplate -->
				<div class="addTemplate">
					<form id="tplform" class="form formA" action="${ctx}/freight/freightSave" method="post">
						<fieldset>
							<div class="legend"><h3>新增运费模板</h3></div>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>模板名称：</label></dt>
								<dd class="item-cont">
									<input type="text" name="tplName" id="tplname" value="<c:out value="${tpl.tplName}"/>" onblur="freight.checktplname()" class="txt textC" />
									<div id="tplNameerror" class="warn error">模板名称由1-50个字符组成,可以使用汉字，字母和数字，不能使用HTML字符, 比如引号("),尖括号(&lt;)</div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>运费承担方：</label></dt>
								<dd class="item-cont item-radio">
									<input type="radio" class="rdo" name="payType"  value="b"  id="buyer" checked="checked" onclick="freight.chosepaytype('b')"/><label for="seller">买家承担运费</label>
									<input type="radio" class="rdo" name="payType" value= "s" id="seller" onclick="freight.chosepaytype('s')"/><label for="buyer">卖家承担运费</label>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>区域限售：</label></dt>
								<dd class="item-cont item-radio">
									<input type="radio" class="rdo" name="isRestricton" value="0" id="areaNo" disabled="disabled" /><label for="areaNo">不支持</label>
									<input type="radio" class="rdo" name="isRestricton" value="1" id="areaYes" checked="checked" /><label for="areaYes">支持</label>
								</dd>
							</dl>
							<dl class="item" id="pricetypecode">
								<dt class="item-label"><label><em>*</em>计价方式：</label></dt>
								<dd class="item-cont item-radio">
									<input type="radio" class="rdo"  value="w" name="priceType"   id="weight" checked="checked"  onclick="freight.chosepricemode('w','weight')"/><label for="weight">按重量</label>
									<input type="radio" class="rdo"  value="v"  name="priceType"  id="volume" onclick="freight.chosepricemode('v','volume')"/><label for="volume">按体积</label>
									<input type="radio" class="rdo"  value="n" name="priceType"   id="unit" onclick="freight.chosepricemode('n','unit')"/><label for="unit">按件</label>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>配送方式：</label></dt>
								<dd class="item-cont item-chk">
									<input type="checkbox" class="chk" name="deliveryType" value="1"  id="normal" checked="checked" disabled="disabled" /><input type="hidden" name="deliveryType" value="1"><label for="normal">普通快递</label>
									<!-- mod-carriage -->
									<div class="mod-carriage" id="carriage">
										<h3>普通快递</h3>
										<div class="item">
											<table class="table tableB">
												<colgroup>
													<col width="310">
													<col width="">
													<col width="">
													<col width="">
													<col width="">
												</colgroup>
												<thead>
													<tr>
														<th>限售区域</th>
														<th>首<span id="unitdesca">重</span>（<span id="unitnamewa">kg</span>）</th>
														<th>首费（<span>元</span>）</th>
														<th>续<span id="unitdescb">重</span>（<span id="unitnamewb">kg</span>）</th>
														<th>续费（元）</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>吉林省<input type="hidden" name="geoId" value="695,706,716,723,728,736,743,749,755"></td>
														<td id="baseunitsp"><input type="text" class="txt textB" id="baseunits"  name="baseUnits"   value=""  onblur="clearzero(this)" onKeyUp="inputFloat(this,2)"/>
														<div id="baseunitserror" class="warn error"></div>
														</td>
														<td><input type="text" class="txt textB" id="basefee" name="baseFee" value="" onblur="clearzero(this)" onKeyUp="inputFloat(this,2)"/>
														<div id="basefeeerror" class="warn error"></div>
														</td>
														
														<td id="increunitsp"><input type="text" class="txt textB" id="increunits" onblur="clearzero(this)" name="increUnits" value=""  onKeyUp="inputFloat(this,2)"/>
														<div id="increunitserror" class="warn error"></div>
														</td>
														<td><input type="text" class="txt textB" id="increfee"  name="increFee" onblur="clearzero(this)" value=""  onKeyUp="inputFloat(this,2)"/>
															<div id="increfeeerror" class="warn error"></div>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<!-- mod-carriage end -->
								</dd>
							</dl>
						</fieldset>
						<div class="formBtn">
							<button type="button" class="btnC" onclick="freight.checkform()">保存并返回</button><input type="button" class="btn" onclick="location.href ='freightList'" value="取&nbsp;消" />
						</div>
						<input type="hidden" name="ywFreightTplId" value="${tpl.ywFreightTplId}">
					</form>
				</div>
				<!-- addTemplate end -->
			</div>
			<!-- main end -->

</body>
</html>