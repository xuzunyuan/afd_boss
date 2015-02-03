<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>选择规格名</title>
	</head>
	<body>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/static/style/all-debug.css?t=2015013001" />
		<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/jquery.cookie.js"></script>
		<script type="text/javascript">
			$(function(){
				$(document).on("click","tr.l-1H",function(){
					if($(this).parent().hasClass("on")){
						$(this).parent().removeClass("on");
						$(this).find("i.arrow").removeClass("arrB-D").addClass("arrB-R");
					} else {
						$(this).parent().addClass("on");
						$(this).find("i.arrow").removeClass("arrB-R").addClass("arrB-D");
						if(!$(this).next().is("tr.l-2")){
							var specId = $(this).parent().attr("specId");
							$.post(
								"${ctx}/catespec/getSpecValuesBySpecId",
								{specId:specId},
								function(list){
									addSpecValueList(specId,list);
								}
							);
						}
					}
				});
				$(document).on("click","button[name=addSpec]",function(event){
					event.stopPropagation();
					var button = $(this);
					var specId = $(this).parents("tbody.l-1").attr("specId");
					$.post(
						"${ctx}/catespec/addBcSpec",
						{specId:specId},
						function(result){
							if(result > 0){
								button.addClass("disabled");
								window.opener.showBcSpecList();
							}
						}
					);
				});
				$(document).on("click","button[name=addSpecValue]",function(){
					var specValueId = $(this).parents("tr.l-2").attr("specValueId");
					var button = $(this);
					var specId = $(this).parents("tbody.l-1").attr("specId");
					var specButton = $(this).parents("tbody.l-1").find("button[name=addSpec]");
					$.post(
						"${ctx}/catespec/addBcSpecValue",
						{specId:specId,specValueId:specValueId},
						function(result){
							if(result > 0){
								button.addClass("disabled");
								specButton.addClass("disabled");
								window.opener.showBcSpecList();
							}
						}
					);
				});
			});
			function addSpecValueList(specId,list){
				var node = $("tbody.l-1[specId="+specId+"]");
				$.each(list,function(){
					node.append("<tr specValueId='"+ this.specValueId +"' class='l-2'>" + 
									"<td colspan='4'>" + 
										"<table class='table tableA'>" + 
											"<colgroup>" + 
												"<col width='150'>" + 
												"<col width='350'>" + 
												"<col width='343'>" + 
												"<col width='150'>" + 
											"</colgroup>" + 
											"<tbody>" + 
												"<tr class='l-2H'>" + 
													"<td></td>" + 
													"<td><div class='t-box'><i class='joint'></i><span name='name'></span></div></td>" + 
													"<td>" + 
														"<p name='pinyin'></p>" + 
													"</td>" + 
													"<td class='align-c'><button name='addSpecValue' type='button' class='btnA'>+添加关联</button></td>" + 
												"</tr>" + 
											"</tbody>" + 
										"</table>" + 
									"</td>" + 
								"</tr>");
					node.children().last().find("span[name=name]").text(this.specValueName);
					node.children().last().find("p[name=pinyin]").text(this.pinyin);
				});
			}
		</script>
		
		<!-- selectproperty -->
		<div class="selectGoods selectproperty">
			<!-- screening -->
			<div class="screening">
				<form id="query" class="form" method="post">
					<fieldset class=""><!-- 删掉default显示全部查询条件 -->
						<div class="legend"><h3>选择关联规格</h3></div>
						<ul class="formBox">
							<li class="item">
								<div class="item-label"><label>规格名：</label></div>
								<div class="item-cont">
									<input name="specName" type="text" class="txt textA" value="<c:out value="${specName}"/>" />
								</div>
							</li>
								<li class="item">
								<div class="item-label"><label>拼音码：</label></div>
								<div class="item-cont">
									<input name="pingyin" type="text" class="txt textA" value="<c:out value="${pingyin}"/>" />
								</div>
							</li>
						</ul>
						<div class="searchBtn"><input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询"></div>
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
							<th>规格名</th>
							<th>拼音码</th>
							<th class="align-c">操作</th>
						</tr>
					</thead>
					<c:choose>
						<c:when test="${fn:length(page.result) > 0 }">
							<c:forEach items="${page.result}" var="spec" varStatus="var">
								<tbody specId="${spec.specId}" class="l-1">
									<tr class="l-1H">
										<td>${var.count}<i class="arrow arrB-R"></i></td>
										<td><c:out value="${spec.specName}"></c:out></td>
										<td>
											<p><c:out value="${spec.pingyin}"></c:out></p>
										</td>
										<td class="align-c"><button name="addSpec" type="button" class="btnA">+添加关联</button></td>
									</tr>
								</tbody>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr class="emptyGoods">
								<td rowspan="3" colspan="4" style="text-align:center;">暂无符合条件的查询结果</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			<!-- table end -->
			<!-- paging -->
			<c:if test="${fn:length(page.result) > 0}">
				<pgNew:page name="querySpec" page="${page}" formId="query"></pgNew:page>
			</c:if>
			<!-- paging end -->
		</div>
		<!-- selectproperty end -->
	</body>
</html>