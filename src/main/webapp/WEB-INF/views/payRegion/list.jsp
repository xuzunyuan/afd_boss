<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>区域支付方式查询-一网全城</title>
</head>
<body>
<script type="text/javascript" src="${ctx}/static/js/auditList.js?t=<%= new java.util.Date().getTime() %>"></script>
<script type="text/javascript" src="${ctx}/static/js/page.js?t=<%= new java.util.Date().getTime() %>"></script>
<script type="text/javascript" src="${ctx}/static/js/paymethod.js?t=<%= new java.util.Date().getTime() %>"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.md.js?t=2014061701"></script>
<!-- main -->
			<div class="main">
				<!-- foldbarV -->
				<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
				<!-- foldbarV end -->
				<!-- crumbs -->
				<div class="crumbs">
					<ul>
						<li><a href="#">后台首页</a><em>&gt;</em></li>
						<li><a href="#">物流管理</a><em>&gt;</em></li>
						<li><strong>区域支付方式列表</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- areapaylist -->
				<div class="areapaylist">
					<!-- screening -->
					<div class="screening">
						<form  id="query" action="${ctx}/payRegion/list.action" method="post"  class="form">
							<fieldset class="default">
								<legend><h3>查询条件</h3></legend>
								<ul class="formBox">
									<li class="item">
										<div class="item-label"><label>区域范围：</label></div>
					<div class="item-cont">
										
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
							<div class="select"> 										
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
										
					</div>
									</li>
									<li class="item">
										<div class="item-label"><label>支付方式：</label></div>
										<div class="item-cont">
											<ul class="payway">
													<li><label><input id="codid" name="cod" value="1" type="checkbox" class="chk"><span>货到付款</span></label></li>
													<li><label><input id="polid" name="pol" value="1" type="checkbox" class="chk"><span>线上支付</span></label></li>
											</ul>
										</div>
									</li>
								</ul>
							</fieldset>
							<!-- foldbarH -->
							<div class="foldbarH"><!-- 展开后添加class命open -->
								<div class="foldBtn"><i class="<!--ico-->"></i></div>
								<div class="searchBtn"><input type="button" onclick="paymethod.submitcheck()" class="btn btn-s" value="查&nbsp;&nbsp;询"></div>
							</div>
							<!-- foldbarH end -->
						</form>
					</div>
					<!-- screening end -->
					<!-- table -->
					<div class="tableWrap">
						<table class="table tableA">
							<colgroup>
								<col width="70" />
								<col width="100" />
								<col width="100" />
								<col width="100" />
								<col width="100" />
								<col width="150"/>
								<col width="200" />
								<col width="100">
							</colgroup>
							<thead>
								<tr>
									<th>序号</th>
									<th>末级ID</th>
									<th>省份</th>
									<th>城市</th>
									<th>区/县</th>
									<th>区域</th>
									<th>已开通支付方式</th>
									<th>更新时间</th>
								</tr>
							</thead>
							<tbody>
							 <c:forEach items="${result}" var="geoInfo" varStatus="status"> 
								<tr>
									<td>${ status.index + 1}</td>
									<th>${geoInfo.leafId}</th>
									<td>${geoInfo.province}</td>
									<td>${geoInfo.city}</td>
									<td>${geoInfo.district}</td>
									<td>${geoInfo.town}</td>
									<td>${geoInfo.payString}</td>
									<td><p><fmt:formatDate value="${geoInfo.lastUpdateDate}" pattern="yyyy-MM-dd HH:mm"/></p></td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- table end -->
					<!-- paging -->
					<c:if test="${fn:length(page.result) > 0}">
				     <pgNew:page name="queryOrder" page="${page}" formId="query"></pgNew:page>
			        </c:if>
					<!-- paging end -->
				</div>
				<!-- areapaylist end -->
			</div>

<script type="text/javascript">
$(function(){
	paymethod = new paymethod();
	<c:if test="${not empty geoInfo.province}">
	
	<c:if test="${geoInfo.province!='0'&&geoInfo.province!=''}">
	$("#provinceDiv option[value='" + "${geoInfo.province}" + "']").prop(
			"selected", true);
	
	var pid = $("#provinceDiv").val();
	paymethod.getarea(pid, $("#cityDiv"));
	<c:if test="${geoInfo.city!='0'}">
	$("#cityDiv option[value='" + "${geoInfo.city}" + "']").prop("selected", true);
	var cid = $("#cityDiv").val();
	if($("#cityDiv option").length==1){
		$("#cityDiv").parent().hide();
		$("#townDiv").parent().show();
	}else{
		$("#cityDiv").parent().show();
		$("#townDiv").parent().hide();
	}
	paymethod.getarea(cid, $("#countyDiv"));
	<c:if test="${geoInfo.district!='0'}">
	$("#countyDiv option[value='" + "${geoInfo.district}" + "']").prop("selected",true);
	var ccid = $("#countyDiv").val();
	paymethod.getarea(ccid, $("#townDiv"));
	<c:if test="${geoInfo.town!='0'}">
	$("#townDiv option[value='" + "${geoInfo.town}" + "']").prop("selected", true);
	</c:if>
	</c:if>
	</c:if>	
	</c:if>
	<c:if test="${geoInfo.cod=='1'}">
	$("#codid").prop("checked","checked");
	</c:if>
	<c:if test="${geoInfo.pol=='1'}">
	$("#polid").prop("checked","checked");
	</c:if>
	
	</c:if>
	
});
</script>
</body>
</html>