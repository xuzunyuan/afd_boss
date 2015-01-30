<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setAttribute("ctx", request.getContextPath());
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
	<head>
		<title>添加物流公司-一网全城</title>
	</head>
<body>
<script type="text/javascript" src="${ctx}/static/js/jquery.json-2.4.js"></script>
<div class="crumbs-box">
	<div class="crumbs">
		<h3>当前位置 &#58;</h3>
		<ul>
			<li><a href="#">BOSS</a>&#62;</li>
			<li><a href="#">物流管理</a>&#62;</li>
			<li>添加物流公司</li>
		</ul>
	</div>
</div><!--crumbs-box end-->
<div class="formTitle">
<i></i>
<span class="title">物流公司信息</span>
<a class="inputBtn_a" href="${ctx}/logistics/showLogistics">返    回</a>
</div>
<form id="addfrom" action="${ctx}/logistics/doAddLogistics/${operateId}" onsubmit="return checkFromData();" method="post" >
<div class="returns-operation">
    <div class="r-o-list">
        <div class="r-o-left">物流公司名称：</div>
        <div class="r-o-right"><input type="text" id="logisticsCompName" name="logisticsCompName"  onblur="logistics.logisticsCompName()" class="inputText inputW1" value= "<c:out value="${logistics.logisticsCompName}"/>" /><span  class="address-error"></span></div>
    </div>
    <div class="r-o-list">
        <div class="r-o-left">联系人：</div>
        <div class="r-o-right"><input type="text" id="linkman" name="linkman" class="inputText inputW1" onblur="logistics.checklinkman()" value="<c:out value="${logistics.linkman}"/>"/><span  class="address-error"></span></div>
    </div>
    <div class="r-o-list">
        <div class="r-o-left">手机号码：</div>
        <div class="r-o-right"><input type="text" id="mobile" name="mobile" class="inputText inputW1" value="<c:out value="${logistics.mobile}"/>"/><span  class="address-error"></span></div>
    </div>
    <div class="r-o-list">
        <div class="r-o-left">固定电话：</div>
        <div class="r-o-right"><input type="text" id="tel" name="tel" class="inputText inputW1" onblur="logistics.checktel()" value="<c:out value="${logistics.tel}"/>"/><span  class="address-error"></span></div>
    </div>
    <div class="r-o-list">
      <div class="r-o-left">通信地址：</div>
       <div class="r-o-right">
        <select name="province" onchange="logistics.loadCity();" class="first-child" id="provinceDiv">
        	<option value="0">请选择</option>
			<option value="694">吉林</option>
			<option value="1">北京</option>
			<option value="99">天津</option>
			<option value="150">河北</option>
			<option value="334">山西</option>
			<option value="465">内蒙古</option>
			<option value="579">辽宁</option>
			<option value="764">黑龙江</option>
			<option value="905">上海</option>
			<option value="998">江苏</option>
			<option value="1116">浙江</option>
			<option value="1218">安徽</option>
			<option value="1340">福建</option>
			<option value="1435">江西</option>
			<option value="1547">山东</option>
			<option value="1705">河南</option>
			<option value="1883">湖北</option>
			<option value="2086">湖南</option>
			<option value="2223">广东</option>
			<option value="2424">广西</option>
			<option value="2548">海南</option>
			<option value="2841">重庆</option>
			<option value="3904">四川</option>
			<option value="4105">贵州</option>
			<option value="4202">云南</option>
			<option value="4348">西藏</option>
			<option value="4429">陕西</option>
			<option value="4547">甘肃</option>
			<option value="4651">青海</option>
			<option value="4703">宁夏</option>
			<option value="4731">新疆</option>
		</select>									
		<select name="city" onchange="logistics.loadCounty()" id="cityDiv"><option value="0">请选择</option></select>
              <select name="district" onchange="logistics.loadTown()"  id="countyDiv"><option value="0">请选择</option></select>
              <select name="town" onchange="logistics.fillTownName()"  id="townDiv" style="width: 100px;display:none"><option value="0">请选择</option></select>
		<span  class="address-error"></span>
		</div>
    </div>

    <div class="r-o-list">
        <div class="r-o-left">详细地址：</div>
        <div class="r-o-right"><input type="text" id="addr" name="addr" class="inputText inputW1" onblur="logistics.checkaddr()" value="<c:out value="${logistics.addr }"/>"/><span  class="address-error"></span></div>
    </div>
    <div class="r-o-list">
        <div class="r-o-left">邮编：</div>
        <div class="r-o-right"><input type="text" id="zipCode" name="zipCode" class="inputText inputW1" value="${logistics.zipCode }" onblur="logistics.checkzipcode()" /><span  class="address-error"></span></div>
    </div>
    <div class="r-o-list">
        <div class="r-o-left">法人：</div>
        <div class="r-o-right"><input type="text" id="lawman" name="lawman" class="inputText inputW1" value="<c:out value="${logistics.lawman }"/>" onblur="logistics.checklawman()" /><span  class="address-error"></span></div>
    </div>
     <div class="r-o-list">
        <div class="r-o-left">备注：</div>
        <div class="r-o-right"><textarea rows="5" cols="60" name="remark"><c:out value="${logistics.remark }"/></textarea><span  class="address-error"></span></div>
    </div>    
    <div align="center">
    	<input type="submit" class="inputBtn" value="保存"/> <input type="reset" class="inputBtn" value="取消"/>
	</div>  
	<input type="hidden" name="logisticsCompId" value="${logistics.logisticsCompId }">
	<input type="hidden" name="provinceName" value="">
	<input type="hidden" name="cityName" value="">
	<input type="hidden" name="districtName" value="">
	<input type="hidden" name="townName" value="">	
</div><!--returns-operation end-->	
</form>
<!--[if lte IE 6]>
<script type="text/javascript" src="./script/DD_PNG08a-min.js"></script>
<script>
DD_belatedPNG.fix('.header h1 a');
</script>
<![endif]-->
<script type="text/javascript">
		$(function(){		
			$("#addfrom").bind("submit",function(){
				var provinceName = $("#provinceDiv option:selected").text();
				var cityName = $("#cityDiv option:selected").text();
				var districtName = $("#countyDiv option:selected").text();
				var townName = $("#townDiv option:selected").text();
				$("input[name=provinceName]").val(provinceName);
				$("input[name=cityName]").val(cityName);
				$("input[name=districtName]").val(districtName);
				if(townName!="请选择"){
					$("input[name=townName]").val(townName);
				}
				
			});
			
			logistics = new logistics();
			
			var operateId = ${operateId};
			if(operateId ==1){
				logistics.filldata();
			}
			
		});

		function logistics() {
			this.displayaddr = [];
			this.alladdr=[];
			this.addrshowtype = 1;
			this.choseaddrs = {};
			this.addrissave=0;
			this.getarea = function(fid, obj) {
				$.ajax({
					url : "${ctx}/logistics/geo",
					data : {
						fid : fid
					},
					async : false,
					dataType : "json",
					success : function(data) {
						if (data.length == 0) {
							if(obj.prop("id")=='townDiv'){
								obj.hide();
							}
							return false;
						}else{
							obj.show();
						}
						optList = "<option value='0'>请选择</option>";
						if (data.length == 1&&obj.prop("id")=='cityDiv') {
							optList="";
						}
						for ( var gindex in data) {
							optList += "<option value='" + data[gindex].geoId + "'>"
									+ data[gindex].geoName + "</option>";
						}
						obj.html(optList);				
					}
				});
			};

 			this.filldata = function() {
				var addr={};
				<c:if test="${logistics !=null}">
					addr.province=${logistics.province};
					addr.city = ${logistics.city};
					addr.district = ${logistics.district};
					addr.town = ${logistics.town};
				</c:if>
				
				$("#provinceDiv option[value='" + addr.province + "']").prop("selected", true);
				var pid = $("#provinceDiv").val();
				this.getarea(pid, $("#cityDiv"));
				$("#cityDiv option[value='" + addr.city + "']").prop("selected", true);
				var cid = $("#cityDiv").val();
				this.getarea(cid, $("#countyDiv"));
				$("#countyDiv option[value='" + addr.district + "']").prop("selected",
						true);
				var ccid = $("#countyDiv").val();
				this.getarea(ccid, $("#townDiv"));
				$("#townDiv option[value='" + addr.town + "']").prop("selected", true);
				
				
			}; 

			this.loadCity = function() {
				var fid = $("#provinceDiv").val();
				if(fid==0){$("#cityDiv").prop("length", 1);
				$("#countyDiv").prop("length", 1);
				$("#townDiv").prop("length", 1);return;}
				this.getarea(fid, $("#cityDiv"));
				if($("#cityDiv option").length==1){
					
					this.loadCounty();
					 $("#cityDiv").hide();
					 $("#townDiv").show();
					return false;
				}
				$("#countyDiv").prop("length", 1);
				$("#townDiv").prop("length", 1);
				$("#townDiv").hide();
			};
			this.loadCounty = function() {
				var fid = $("#cityDiv").val();
				if(fid==0){
				$("#countyDiv").prop("length", 1);
				$("#townDiv").prop("length", 1);return;}
				this.getarea(fid, $("#countyDiv"));
				$("#townDiv").prop("length", 1);

			};
			this.loadTown = function() {
				var fid = $("#countyDiv").val();
				if(fid==0){
				$("#townDiv").prop("length", 1);return;}
				this.getarea(fid, $("#townDiv"));
			};

			this.fillTownName = function() {
				$("#townDiv option:selected").text();
			};
			
			this.checkzipcode=function(){
				var ret=false;
				var obj=$("#zipCode");
				var value=obj.val().trim();
				var pattern =/^[0-9]{6}$/;
		        if(value!="")
		        {
		            if(pattern.exec(value))
		            {
		              ret=true;
		            }
		        }
		        if(!ret){
		        	obj.closest('div').removeClass('success').addClass('error');
		        	obj.siblings('span').html("请填写邮编,邮编由6位数字组成");
		        }else{
		        	obj.closest('div').removeClass('error').addClass('success');
		        	obj.siblings('span').html("");
		        }
		        return ret;
			};
			this.checkmobile=function(){
				var ret=false;
				var obj=$("#mobile");
				var value=obj.val().trim();
				var pattern =/^1[3|4|5|8][0-9]\d{8}$/;
		        if(value!=""){
		            if(pattern.exec(value))
		            {
		              ret=true;
		            }
		        }else{
		        	obj.siblings('span.address-error').html("请填写手机号码");
		        	return false;
		        }
		        
		        if(!ret){
		        	obj.closest('div').removeClass('success').addClass('error');
		        	obj.siblings('span.address-error').html("请填写正确的手机号码");
		        }else{
		        	obj.closest('div').removeClass('error').addClass('success');
		        	obj.siblings('span.address-error').html("");
		        }
		        return ret;
			};	
			this.checktel=function(){
				var ret=false;
				var obj=$("#tel");
				var value=obj.val().trim();
				var pattern =/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
		        if(value!=""){
		            if(pattern.exec(value))
		            {
		              ret=true;
		            }
		        }
		        if(!ret){
		        	obj.closest('div').removeClass('success').addClass('error');
		        	obj.siblings('span.address-error').html("请填写正确的电话号码");
		        }else{
		        	obj.closest('div').removeClass('error').addClass('success');
		        	obj.siblings('span.address-error').html("");
		        }
		        return ret;
			};
			
			this.checklinkman=function(){
				var ret=false;
				var obj=$("#linkman");
				var value=obj.val().trim();
		        if(value!="")
		        {
		           ret=true;
		        }
		        if(!ret){
		        	obj.closest('div').removeClass('success').addClass('error');
		        	obj.siblings('span.address-error').html("请填写联系人姓名");
		        }else{
		        	obj.closest('div').removeClass('error').addClass('success');
		        	obj.siblings('span.address-error').html("");
		        }
		        return ret;
			};

			this.logisticsCompName=function(){
				var ret=false;
				var obj=$("#logisticsCompName");
				var value=obj.val().trim();
		        if(value!="")
		        {
		           ret=true;
		        }
		        if(!ret){
		        	obj.closest('div').removeClass('success').addClass('error');
		        	obj.siblings('span.address-error').html("请填物流公司名称");
		        }else{
		        	obj.closest('div').removeClass('error').addClass('success');
		        	obj.siblings('span.address-error').html("");
		        }
		        return ret;
			};			
						
			this.checkaddr=function(){
				var ret=false;
				var obj=$("#addr");
				var value=obj.val().trim();
		        if(value!="")
		        {
		           ret=true;
		        }
		        if(!ret){
		        	obj.closest('div').removeClass('success').addClass('error');
		        	obj.siblings('span.address-error').html("请填写详细地址");
		        }else{
		        	obj.closest('div').removeClass('error').addClass('success');
		        	obj.siblings('span.address-error').html("");
		        }
		        return ret;
			};

			this.checklawman=function(){
				var ret=false;
				var obj=$("#lawman");
				var value=obj.val().trim();
		        if(value!="")
		        {
		           ret=true;
		        }
		        if(!ret){
		        	obj.closest('div').removeClass('success').addClass('error');
		        	obj.siblings('span.address-error').html("请填写物流公司法人");
		        }else{
		        	obj.closest('div').removeClass('error').addClass('success');
		        	obj.siblings('span.address-error').html("");
		        }
		        return ret;
			};	
 		this.checkcity = function(){
 			var ret=false;
 			var obj = $("#townDiv");
			var provinceId =  $("#provinceDiv").val();
			var cityId =  $("#cityDiv").val();
			var countyId =  $("#countyDiv").val();
			var townId = $("#townDiv").val();
			
			if(townId > 0){
				if(townId >0 && countyId >0 && cityId >0 && provinceId >0){
		        	obj.closest('div').removeClass('error').addClass('success');
		        	obj.siblings('span.address-error').html("");
					ret =  true;
				}
			}
			
			if(countyId >0 && cityId >0 && provinceId >0) {
	        	obj.closest('div').removeClass('error').addClass('success');
	        	obj.siblings('span.address-error').html("");
	        	ret =  true;
			}else{
				obj.closest('div').removeClass('success').addClass('error');
				obj.siblings('span.address-error').html("请填写完整的区域信息");
				ret =  false;
			}
			return ret;
		}
	};
	
	function checkFromData(){
		var ret = false;
		ret = logistics.logisticsCompName();
		if(!ret){
			return ret;
		}
		ret = logistics.checkmobile();
		if(!ret){
			return ret;
		}		
		ret = logistics.checkcity();
		if(!ret){
			return ret;
		}
		ret = logistics.checklinkman();
		if(!ret){
			return ret;
		}
		ret = logistics.checkaddr();
		if(!ret){
			return ret;
		}
	}
		
</script>
</body>
</html>
