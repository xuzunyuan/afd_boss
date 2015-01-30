<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/jquery-1.10.2.min.js?t=2014051601"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/static/style/classes_.css?t=201410201500" />
<title>选择关联属性</title>
</head>
<body>
	<div class="wrapper">
		<!-- bd -->
		<div id="bd" class="wrap">
			<!-- 点击.foldbarV下的foldBtn后在此添加class名unfold来实现展开效果 -->
			<!-- selectproperty -->
			<div class="selectGoods selectproperty">
				<!-- screening -->
				<div class="screening">
					<form id="attr_list" method="post" action="${ctx}/cateattr/attrlist" class="form">
						<fieldset class="">
							<!-- 删掉default显示全部查询条件 -->
							<div class="legend">
								<h3>选择关联属性</h3>
							</div>
							<ul class="formBox">
								<li class="item">
									<div class="item-label">
										<label>属性名：</label>
									</div>
									<div class="item-cont">
										<input type="text" class="txt textA" name="name" value="<c:out value="${pageInfo.conditions.name}" />" />
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>拼音码：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textA" name="pinyin" value="<c:out value="${pageInfo.conditions.pinyin}" />" />
									</div>
								</li>
							</ul>
							<div class="searchBtn">
								<input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" name="query" id="query"/>
							</div>
						</fieldset>
					</form>
				</div>
				<!-- screening end -->
				<!-- table -->
				<div class="tableWrap">
					<table class="table tableA">
						<colgroup>
							<col width="150">
							<col width="350">
							<col>
							<col width="150">
						</colgroup>
						<thead>
							<tr>
								<th>序号</th>
								<th>属性名</th>
								<th>拼音码</th>
								<th class="align-c">操作</th>
							</tr>
						</thead>
						<c:choose>
		      				<c:when test="${fn:length(attrs.result)>0}">
							<c:forEach items="${attrs.result}" var="attr" varStatus="status"> 
								<tbody class="l-1">
									<tr id="_${attr.attrId}" class="l-1H">
										<td>${attrs.beginRow+status.count}<i class="arrow arrB-R"></i></td>
										<td><c:out value="${attr.attrName}" /></td>
										<td><p><c:out value="${attr.pinyin}" /></p></td>
										<td class="align-c"><button type="button" class="btnA">+添加关联</button></td>
									</tr>
								</tbody>
							</c:forEach>
							</c:when>
		      				<c:when test="${fn:length(attrs.result)==0}">
								<tbody class="l-1">
									<tr>
										<td colspan="4" rowspan="3">暂无符合条件的查询结果</td>
									</tr>
								</tbody>
		      				</c:when>
		      			</c:choose>
					</table>
				</div>
				<!-- table end -->
				<!-- paging -->
				<div class="paging">
					<p:page page="${attrs}" action="${ctx}/cateattr/attrlist"/>
				</div>
				<!-- paging end -->
			</div>
			<!-- selectproperty end -->
		</div>
	</div>

	<script type="text/javascript">
		function getBcId() {
			if(window.opener.closed){
				alert("已关闭");
			}else{
				return window.opener.tBcId;
			}
		}
		
		$(function() {
			bcAttrEvent();
		});
	
		function bcAttrEvent() {
			$(".l-1H").on("click", function(event){
				var tr$ = $(this);
				var attrId = tr$.attr("id").substring(1);
				
				var eventSrc$ =  $(event.target);
				if (eventSrc$.hasClass("btnA")) {
					$.ajax({
						url : "${ctx}/cateattr/bcattrbind",
						type : "POST",
						data : {
							bcId   : getBcId(),
							attrId : attrId,
							displayOrder:0,
							isRequire:1,
							status:1,
							displayMode:1,
							isFilter:1
						},
						success : function(re) {
							if(re>0 || re==-1){
								eventSrc$.addClass("disabled");
								
								if(!window.opener.closed){
									window.opener.loadBindAttr();
								}
							}
						}
					});
				}else{
					var tbody$ = tr$.parent();
					
					tbody$.toggleClass("on");
					
					if(tbody$.hasClass("on")){
						tr$.find("td:first i").removeClass("arrB-R").addClass("arrB-D");
					}else{
						tr$.find("td:first i").removeClass("arrB-D").addClass("arrB-R");
					}
					
					if(!tr$.hasClass("fetch")){
						tr$.addClass("fetch");
						
						$.ajax({
							url : "${ctx}/attr/value",
							type : "POST",
							data : {attrId : attrId},
							success : function(avList) {
								if(avList!=null && avList.length>0){
									$.each(avList, function( index, attrValue ) {
										var str = '<tr class="l-2 l-half on">' +
										'<td colspan="4">' +
											'<table class="table tableA">' +
												'<colgroup>' +
													'<col width="175">' +
													'<col>' +
													'<col width="343">' +
													'<col width="150">' +
												'</colgroup>' +
												'<tbody>' +
													'<tr class="l-2H">' +
														'<td></td>' +
														'<td><div class="t-box"><i class="joint"></i><span></span></div></td>' +
														'<td><p>'+attrValue.pinyin+'</p></td>' +
														'<td class="align-c"><button id="'+attrValue.attrValueId+'" type="button" class="btnA">+添加关联</button></td>' +
													'</tr>' +
												'</tbody>' +
											'</table>' +
										'</td></tr>';
										
										tr$.after(str);
										tr$ = tr$.next();
										tr$.find("p").text(attrValue.pinyin);
										tr$.find("span").text(attrValue.attrValueName);
										
										//子属性列表
										if(attrValue.subList!=null && attrValue.subList.length>0){
											var subTr$ = tr$.find(".l-2H");
											
											$.each(attrValue.subList, function( index, attrValue ) {
												var str = '<tr class="l-3 l-half"><td colspan="4">' +
													'<table class="table">' +
														'<colgroup>' +
															'<col width="175">' +
															'<col>' +
															'<col width="343">' +
															'<col width="150">' +
														'</colgroup>' +
														'<tbody>' +
															'<tr>' +
																'<td></td>' +
																'<td><div class="t-box t-boxs"><i class="joint"></i><span></span></div></td>' +
																'<td><p>'+attrValue.pinyin+'</p></td>' +
																'<td class="align-c"><button id="'+attrValue.attrValueId+'" name="sub" type="button" class="btnA">+添加关联</button></td>' +
															'</tr>' +
														'</tbody>' +
													'</table>' +
												'</td></tr>';
											
												subTr$.after(str);
												subTr$ = subTr$.next();
												subTr$.find("span").text(attrValue.attrValueName);
												tr$.find("p").text(attrValue.pinyin);
											});
										}
										
										tr$.find("tbody:first .btnA").on("click", function(event){
											var pValId = 0;
											var bu$ = $(this);
											var valueId = bu$.attr("id");
											
											var level = bu$.attr("name");
											if(level && level=="sub"){
												pValId = $(this).parents(".l-2").find(".l-2H .btnA").attr("id");
											}
											 
											$.ajax({
												url : "${ctx}/cateattr/bcattrvaluebind",
												type : "POST",
												data : {
													bcId   : getBcId(),
													attrId : attrId,
													displayOrder:0,
													status:1,
													displayMode:1,
													isFilter:false,
													pValId:pValId,
													attrValueId:valueId,
													isSubAttr:false,
													mDisplayPosition:0,
													isMobileDisplay:false
												},
												success : function(re) {
													if(re>0 || re==-1){
														bu$.addClass("disabled");
														
														if(pValId > 0){
															$("#"+pValId).addClass("disabled");
														}
														
														$("#_"+attrId).find(" > td:last .btnA").addClass("disabled");
														
														if(re>0 && !window.opener.closed){
															window.opener.reloadAttrValues(re);
														}
													}
												}
											});
										});
									});
								}
							}
						});
					}
				}
			});
		}
		</script>
</body>
</html>