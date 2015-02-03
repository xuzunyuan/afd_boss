<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>BOSS后台|属性名列表页</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/page.js?t=2015020201"></script>
	<script type="text/javascript" src="../static/js/jquery.md.js?t=2015020201"></script>
	
	<!-- main -->
	<div class="main">
		<!-- foldbarV -->
		<div id="foldbarV">
			<div class="foldbarV">
				<div class="foldBtn"></div>
			</div>
		</div>
		<!-- foldbarV end -->
		<!-- goodsList -->
		<div class="managevalueList">
			<!-- screening -->
			<div class="screening">
				<form id="attr_list" method="post" action="${ctx}/attr/list" class="form" >
					<fieldset class="default">
						<legend>
							<h3>查询条件</h3>
						</legend>
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
								<div class="item-label">
									<label>拼音码：</label>
								</div>
								<div class="item-cont">
									<input type="text" class="txt textA" name="pinyin" value="<c:out value="${pageInfo.conditions.pinyin}" />" />
								</div>
							</li>
						</ul>
					</fieldset>
					<!-- foldbarH -->
					<div class="foldbarN">
						<!-- 展开后添加class命open -->
						<div class="searchBtn">
							<input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" name="query" id="query"/>
						</div>
					</div>
					<!-- foldbarH end -->
				</form>
			</div>
			<!-- actionBar -->
			<div class="actionBar">
				<input type="button" class="btnA" value="+添加属性名" onclick="window.location.href='${ctx}/attr/add'" >
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
							<th>属性名</th>
							<th>拼音码</th>
							<th>创建时间</th>
							<th>创建人</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
		      				<c:when test="${fn:length(attrs.result)>0}">
							<c:forEach items="${attrs.result}" var="attr" varStatus="status"> 
								<tr>
									<td>${attrs.beginRow+status.count}</td>
									<td><c:out value="${attr.attrName}" /></td>
									<td><c:out value="${attr.pinyin}" /></td>
									<td><p><fmt:formatDate value="${attr.createByDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></p></td>
									<td><c:out value="${attr.createByName}" /></td>
									<td class="t-operate">
										<div class="mod-operate">
											<div class="def">
												<a href="${ctx}/attr/update?attrId=${attr.attrId}">修改属性名</a><i class="arr"></i>
											</div>
											<ul>
												<li><a href="${ctx}/attr/bind/value?attrId=${attr.attrId}">关联维护</a></li>
												<li><a name="del" id="${attr.attrId}" href="javascript:void(0);" >删除属性名</a></li>
											</ul>
										</div>
									</td>
								</tr>
							</c:forEach>
							</c:when>
		      				<c:when test="${fn:length(attrs.result)==0}">
								<tr>
									<td colspan="6" rowspan="3">暂无符合条件的查询结果</td>
								</tr>
		      				</c:when>
		      			</c:choose>
					</tbody>
				</table>
			</div>
			<!-- table end -->
			<!-- paging -->
			<div class="paging">
				<p:page page="${attrs}" action="${ctx}/attr/list"/>
			</div>
			<!-- paging end -->
		</div>
		<!-- goodsList end -->
	</div>
	<!-- main end -->

	<script type="text/javascript">
		$(function() {
			$("a[name='del']").on("click", function(event) {
				var attrId = this.id;
				$.modaldialog('<p>属性名删除后相关信息将不被保留，确定删除？</p>',{
					title : '删除属性名',
					buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:deleteAttr, param:{attrId:attrId}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
				});
			});
			
		});
		
		function deleteAttr(param){
			$.ajax({
				url : "${ctx}/attr/delete",
				type : "POST",
				data : {attrId : param.attrId},
				success : function(re) {
					if(re == 1){
						$.modaldialog('<p>属性名删除成功。</p>',{
							title : '删除属性名',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){window.location.href=window.location.href;}}]
						});
					}else if(re == -1){
						$.modaldialog('<p>该属性名已经关联了相关类目，不能被删除！</p>',{
							title : '删除属性名',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
						}); 
					}else if(re == 0){
						$.modaldialog('<p>属性名删除失败！</p>',{
							title : '删除属性名',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
						});
					}
				}
			}); 
		}
	</script>
</body>
</html>