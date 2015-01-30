<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>规格值列表页</title>
	</head>
	<body>
		<link rel="stylesheet" href="${ctx}/static/style/classes_.css?t=20141022" />
		<script type="text/javascript" src="../static/js/jquery.md.js?t=20141022"></script>
		
		<script type="text/javascript">
			$(function(){
				$(document).on("click","#deleteSpecValue",function(){
					var specValueId = $(this).attr("specValueId");
					var msg = '<p><span>•</span>规格值删除后相关信息将不被保留，确定删除？</p>';
					$.modaldialog(msg,{
						title : '删除规格值',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){deleteSpecValue(specValueId);}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
				});
			});
			function deleteSpecValue(specValueId){
				$.post(
					"${ctx}/specvalue/deleteSpecValue",
					{specValueId:specValueId},
					function(result){
						if(result == 1){
							var msg = "<p><span>•</span>规格值删除成功！</p>";
							$.modaldialog(msg,{
								title : '提醒',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:reload}]
							});
						} else if(result == 0) {
							var msg = "<p><span>•</span>规格值删除失败，请重试！</p>";
							$.modaldialog(msg,{
								title : '提醒',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
							});
						} else if(result == -1) {
							var msg = "<p><span>•</span>该规格值已经关联了相关类目，不能被删除！</p>";
							$.modaldialog(msg,{
								title : '提醒',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
							});
						}
					}
				);
			}
			function reload(){
				location.href = "${ctx}/specvalue/querySpecValues";
			}
		</script>
		
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- crumbs -->
		<div class="crumbs">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="#">规格值管理</a><em>&gt;</em></li>
				<li><strong>规格值列表</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- normsList -->
		<div class="normsList">
			<!-- screening -->
			<div class="screening">
				<form class="form" id="query" action="${ctx}/specvalue/querySpecValues" method="post">
					<fieldset class="default">
						<legend><h3>查询条件</h3></legend>
						<ul class="formBox">
							<li class="item">
								<div class="item-label"><label>规格值名：</label></div>
								<div class="item-cont">
									<input type="text" class="txt textA" name="specValueName" value="<c:out value="${specValueName}"/>" />
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>拼音码：</label></div>
								<div class="item-cont">
									<input type="text" class="txt textA" name="pinyin" value="<c:out value="${pinyin}"/>"/>
								</div>
							</li>
						</ul>
					</fieldset>
					<!-- foldbarH -->
					<div class="foldbarN"><!-- 展开后添加class命open -->
						<div class="searchBtn"><input id="search" type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" /></div>
					</div>
					<!-- foldbarH end -->
				</form>
			</div>
			<!-- actionBar -->
			<div class="actionBar">
				<input type="button" class="btnA" onclick="window.location.href='${ctx}/specvalue/addSpecValue'" value="+添加规格值">
			</div>
			<!-- actionBar end -->
			<!-- table -->
			<div class="tableWrap">
				<table class="table tableA">
					<colgroup>
						<col width="40" />
						<col width="200" />
						<col width="150" />
						<col width="150" />
						<col width="150" />
						<col width="150">
					</colgroup>
					<thead>
						<tr>
							<th>序号</th>
							<th>规格值名</th>
							<th>拼音码</th>
							<th>创建时间</th>
							<th>创建人</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${fn:length(page.result) > 0}">
								<c:forEach items="${page.result }" var="specValue" varStatus="var">
									<tr>
										<td>${var.count }</td>
										<td><c:out value="${specValue.specValueName }"></c:out></td>
										<td><c:out value="${specValue.pinyin }"></c:out></td>
										<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${specValue.createByDate}"/></td>
										<td><c:out value="${specValue.createByName }"></c:out></td>
										<td class="t-operate">
											<div class="mod-operate">
											<div class="def"><a href="${ctx}/specvalue/modifySpecValue?specValueId=${specValue.specValueId}">修改规格值名</a><i class="arr"></i></div>
											<ul>
												<li><a id="deleteSpecValue" specValueId="${specValue.specValueId}" href="#">删除规格值名</a></li>
											</ul>
										</div>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr class="emptyGoods">
									<td rowspan="3" colspan="6">暂无符合条件的查询结果</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<!-- table end -->
			<c:if test="${fn:length(page.result) > 0}">
				<pgNew:page name="querySpecValues" page="${page}" formId="query"></pgNew:page>
			</c:if>
		</div>
	</body>
</html>