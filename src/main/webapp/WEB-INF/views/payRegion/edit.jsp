<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>区域支付方式维护-一网全城</title>
</head>
<body>
<script type="text/javascript" src="${ctx}/static/js/auditList.js?t=<%= new java.util.Date().getTime() %>"></script>
<script type="text/javascript" src="${ctx}/static/js/page.js?t=<%= new java.util.Date().getTime() %>"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.md.js?t=2014061701"></script>
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
						<li><strong>区域支付方式维护</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- typeManage -->
				<div class="typeManage">
					<!-- hintbar -->
					<div class="hintBar">
							<dl>
								<dt><i class="icon i-exclaim"></i></dt>
								<dd>
									<h4>请注意：</h4>
									<ul>
										<li><em>·</em>设置区域限制支付方式，需选到末级区域；</li>
										<li><em>·</em>选择父级区域时，子集区域即全选或取消全选；</li>
										<li><em>·</em>区域支付方式将影响到买家订单的付款方式，且操作时点击复选框即生效或失效，请谨慎操作。</li>
									</ul>
								</dd>
							</dl>
						</div>
					<!-- hintbar end -->
					<!-- sellerData -->
					<div class="sellerData areapayment areapayindex">
						<!-- tab -->
						<div class="tab">
							<div class="tabs">
								<ul>
									<li class="backBtn"></li>
									<li class="on" style="cursor:default;">区域支付方式维护</li>
								</ul>
							</div>
						</div>
						<!-- tab end -->
						<form class="form formA">
							<fieldset>
								<dl class="item">
									<dt class="item-label">
										<label><em>*</em>选择地区：</label>
									</dt>
									<dd class="item-cont">
										<div class="select">
											<select name="province"  onchange="paymethod.loadCity()" class="select" id="provinceDiv">
											    <option value="0">请选择</option>
											    <option value="1">北京市</option>
												<option value="99">天津市</option>
												<option value="150">河北省</option>
					                            <option value="334">山西省</option>
					                            <option value="465">内蒙古自治区</option>
												<option value="579">辽宁省</option>
												<option value="694">吉林省</option>
												<option value="764">黑龙江省</option>
												<option value="906">上海市</option>
												<option value="999">江苏省</option>
												<option value="1117">浙江省</option>
												<option value="1219">安徽省</option>
												<option value="1341">福建省</option>
												<option value="1436">江西省</option>
												<option value="1548">山东省</option>
												<option value="1706">河南省</option>
												<option value="1884">湖北省</option>
												<option value="2087">湖南省</option>
												<option value="2224">广东省</option>
												<option value="2425">广西壮族自治区</option>
												<option value="2549">海南省</option>
												<option value="2843">重庆市</option>
												<option value="3906">四川省</option>
												<option value="4109">贵州省</option>
												<option value="4207">云南省</option>
												<option value="4353">西藏自治区</option>
												<option value="4434">陕西省</option>
												<option value="4552">甘肃省</option>
												<option value="4656">青海省</option>
												<option value="4708">宁夏回族自治区</option>
												<option value="4736">新疆维吾尔自治区</option>
											</select>
										</div>
										<div class="select" >
											<select name="city"  class="select" onchange="paymethod.loadCounty()" id="cityDiv">
											    <option value="0">请选择</option>
											</select>
										</div>
										<div class="select">
											<select name="district" class="select" onchange="paymethod.loadTown()" id="countyDiv">
											    <option value="0">请选择</option>
											</select>
										</div>
										 <div class="select" style="display:none">
									    <select name="town" class="select" onchange="paymethod.fillTownName()" id="townDiv">
									     <option value="0">请选择</option>
									    </select>
									    </div>	
										<input type="button" onclick="submitcheck()" class="btn btn-s" value="查&nbsp;&nbsp;询">
										<div class="errMeg"><p>#&nbsp;表示此区域含有“货到付款”服务的地区！</p></div>
									</dd>
								</dl>
								<!-- table -->
								<table class="table typeTable">
									<colgroup>
										<col width="100" />
										<col width="300" />
										<col />
									</colgroup>
									<thead>
									<tr>
										<th>序号</th>
										<th>地区</th>
										<th>开通支付方式<span>（<em class="meg">勾选/取消勾选后，即实时生效</em>）</span></th>
									</tr>
									</thead>
									<!-- l-1 -->
									<tbody id="arealist">
									
									</tbody>
								</table>
								<!-- table end -->
							</fieldset>
						</form>
					</div>
					<!-- sellerData end -->
					
				</div>
				<!-- typeManage end -->
			</div>
			<!-- main end -->

<script type="text/javascript">
$(function(){
	paymethod = new paymethod();
	paymethod.getarea(0, $("#provinceDiv"));
});
function submitcheck(){
	var pid=$("#provinceDiv").val();
	var cid=$("#cityDiv").val();
	var ccid=$("#countyDiv").val();
	var tid=$("#townDiv").val();
	var fid=0;
	if(pid!=0){
		fid=pid;
	}
	if(cid!=0){
		fid=cid;
	}	
	if(ccid!=0){
		fid=ccid;
	}
	if(tid!=0&&$("#townDiv").is(":visible")){
		fid=tid;
	}
	if(fid==0){
		var msg = '<p>请选择一个区域</p>';
		$.modaldialog(msg,{
			title : '提示',
			buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){}}],
			hasclose:false
		});		   
		return 
	}
	paymethod.getpaymethod(fid,$("#arealist"));
	
	
}
function paymethod(){

	this.getarea = function(fid, obj) {
		$.ajax({
			url : "edit/geopay.action",
			data : {
				fid : fid
			},
			async : false,
			dataType : "json",
			success : function(data) {
				if (data.length == 0) {
					if(obj.prop("id")=='townDiv'){
						obj.parent().hide();
					}
					return false;
				}else{
					obj.parent().show();
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
    
	this.gethtml=function (obj,index){
		var html_str="";
		html_str+="<tr>";
		html_str+="<td>"+index+"</td>";
		html_str+="<th>"+obj.geoName+"</th>";
		html_str+="<td>";
		html_str+="<ul class=\"payway\">";
		var paymethod_str=obj.payMethod;
		var cod="";
		var pol="";
		if(paymethod_str.substring(0,1)=="1"){
			 cod="checked='checked'";
		}
        if(paymethod_str.substring(1,2)=="1"){
        	 pol="checked='checked'";
		}
		html_str+="<li><label><input id='pol"+obj.geoId+"' type=\"checkbox\" "+pol+" onclick=\"paymethod.changepaymethod("+obj.geoId +",this,'pol')\" class=\"chk\"><span>线上支付</span></label></li>";
		html_str+="<li><label><input id='cod"+obj.geoId+"' type=\"checkbox\" "+cod+"onclick=\"paymethod.changepaymethod("+obj.geoId +",this,'cod')\" class=\"chk\"><span>货到付款</span></label></li>";
		html_str+="</ul>";
		var show="style='display:none'";
		if(paymethod_str.substring(0,2)=="00"){
			show="style='display:'";
		}
		html_str+="<div id='errmsg"+obj.geoId+"' class=\"errMeg\" "+show+" ><p><i class=\"icon i-caution\"></i>至少选择一种支付方式</p></div>";
		html_str+="</td>";
		html_str+="</tr>";
		return html_str;
	};
	
	this.changepaymethod=function(id,obj,typestr){
		var ischecked=$(obj).prop("checked");
		var val="0";
		if(ischecked){val="1";}else{
			var flag1=$("#pol"+id).prop("checked");
			var flag2=$("#cod"+id).prop("checked");
			if(!flag1&&!flag2){
				$("#errmsg"+id).show();
				$(obj).prop("checked",true);
				return;
			}else{
				$("#errmsg"+id).hide();
			}
		}
		var msg;
		$.ajax({
			url : "edit/setpaymethod.action",
			data : {
				gid : id,
				type: typestr,
				val :val
			},
			dataType : "json",
			success : function(data) {
				if (data == 0) {
					 msg = '<p>操作失败</p>';
						   
				}else{
					 msg = '<p>操作成功</p>';
					 paymethod.updateselects();
				}	
				if(typestr=="cod"){
					if(val=="0"){
						$("#codflag"+id).html("");
					}else{
						$("#codflag"+id).html("#");
					}
				}
				$.modaldialog(msg,{
					title : '提示',
					buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){}}],
					hasclose:false
				});	
			}
		});
		
	};
	
    this.getpaymethod= function(fid,obj){
    	
    	$.ajax({
			url : "edit/getpaymethod.action",
			data : {
				fid : fid
			},
			async : false,
			dataType : "json",
			success : function(data) {
				if (data.length == 0) {
					obj.html("");	
					return false;
				}
				var optList = "";			
				if (data.length == 1&&obj.prop("id")=='cityDiv') {
					optList="";
				}
				for ( var gindex in data) {
					optList +=paymethod.gethtml(data[gindex], parseInt(gindex)+1) ;
				}
				obj.html(optList);				
			}
		});
    };
	
	this.loadCity = function() {
		var fid = $("#provinceDiv").val();
		if(fid==0){
			$("#cityDiv").prop("length", 1);
			$("#countyDiv").prop("length", 1);
			$("#townDiv").prop("length", 1);return;
			}
		this.getarea(fid, $("#cityDiv"));
		if($("#cityDiv option").length==1){
			 $("#cityDiv").parent().hide();
			 $("#townDiv").parent().show();
			this.loadCounty();		
			return false;
		}else{
			 $("#cityDiv").parent().show();
		}
		$("#countyDiv").prop("length", 1);
		$("#townDiv").prop("length", 1);
		$("#townDiv").parent().hide();	
	};
	this.loadCounty = function() {
		var fid = $("#cityDiv").val();
		if(fid==0){
			$("#countyDiv").prop("length", 1);
			$("#townDiv").prop("length", 1);return;
		}
		this.getarea(fid, $("#countyDiv"));
		$("#townDiv").prop("length", 1);
	};
	this.loadTown = function() {
		var fid = $("#countyDiv").val();
		if(fid==0){$("#townDiv").prop("length", 1);return;}
		this.getarea(fid, $("#townDiv"));
	};

	this.fillTownName = function() {
		$("#townDiv option:selected").text();
	};

	this.submitcheck=function(){	
		$("#query").submit();
	};
	
	this.updateselects=function(){
		var pid=$("#provinceDiv").val();
		var cid=$("#cityDiv").val();
		var ccid=$("#countyDiv").val();
		var tid=$("#townDiv").val();
		if(pid!=0){
			paymethod.getarea(0, $("#provinceDiv"));
			$("#provinceDiv option[value='" + pid + "']").prop(
					"selected", true);
			paymethod.getarea(pid, $("#cityDiv"));
		};
		if(cid!=0){
			
			$("#cityDiv option[value='" + cid + "']").prop(
					"selected", true);
			paymethod.getarea(cid, $("#countyDiv"));
			if($("#cityDiv option").length==1){
				 $("#cityDiv").parent().hide();
				 $("#townDiv").parent().show();
			}else{
				 $("#cityDiv").parent().show();
			}
		};
		
      if(ccid!=0){
			
			$("#countyDiv option[value='" + ccid + "']").prop(
					"selected", true);
			paymethod.getarea(ccid, $("#townDiv"));
		};
		
	   if(tid!=0){
		   $("#townDiv option[value='" + tid + "']").prop(
					"selected", true); 
	   };
	};
};


</script>
</body>
</html>