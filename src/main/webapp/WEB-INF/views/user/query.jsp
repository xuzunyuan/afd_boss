<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%> 
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>会员查询-巨有利</title>
</head>
<body>

<script type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>
	
<!-- foldbarV -->
<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
<!-- foldbarV end -->
<!-- orderSearch -->
<div class="orderSearch">
	<!-- screening -->
	<div class="screening">
		<form class="form" id="queryUserFrm" name="queryUserFrm" method="post" action="query">
			<fieldset class="default" id="fldQuery"><!-- 删掉default显示全部查询条件 -->
				<legend><h3>查询条件</h3></legend>
				<ul class="formBox">
					<li class="item">
						<div class="item-label"><label>用户名：</label></div>
						<div class="item-cont">
							<input type="text" class="txt textA" maxlength="20" name="userName" value="${fn:escapeXml(pageInfo.conditions.userName)}"/>
						</div>
					</li>
					<li class="item">
						<div class="item-label"><label>昵称：</label></div>
						<div class="item-cont">
							<input type="text" class="txt textA" maxlength="20" name="nickname" value="${fn:escapeXml(pageInfo.conditions.nickname)}" />
						</div>
					</li>
					<li class="item">
						<div class="item-label"><label>注册日期：</label></div>
						<div class="item-cont"><input type="text" class="dateTxt" value="${pageInfo.conditions.regDateStart}" onfocus="WdatePicker()" name="regDateStart"/><span>至</span><input type="text" class="dateTxt" value="${pageInfo.conditions.regDateEnd}" onfocus="WdatePicker()" name="regDateEnd"/></div>
					</li>
					<li class="item">
						<div class="item-label"><label>手机号：</label></div>
						<div class="item-cont">
							<input type="text" class="txt textA" maxlength="11" name="mobile" id="mobile" value="${pageInfo.conditions.mobile}"/>
						</div>
					</li>
				</ul>
			</fieldset>
			<!-- foldbarH -->
			<div class="foldbarH"><!-- 展开后添加class命open -->
				<div class="foldBtn" id="divOpen"><i class="ico"></i></div>
				<div class="searchBtn"><input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" name="query"/></div>
			</div>
			<!-- foldbarH end -->
		</form>
	</div>
	<!-- screening end -->
		
	<!-- table -->
	<div class="tableWrap">
		<table class="table tableA">
			<colgroup>
				<col width="40">
				<col width="100" />
				<col width="120" />
				<col width="120" />
				<col width="120" />
				<col width="80" />
				<col width="90" />
				<col width="100" />
			</colgroup>
			<thead>
				<tr>
					<th>序号</th>
					<th>用户名</th>
					<th>昵称</th>
					<th>手机号</th>
					<th>注册时间</th>
					<th>注册方式</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty(userPage.result)}">
					<tr class="emptyGoods">
						<td colspan="8">暂无符合条件的查询结果</td>
					</tr>
				</c:if>
				
				<c:forEach items="${userPage.result}" var="user" varStatus="status"> 
				<tr>
					<td>${(userPage.currentPageNo-1)*userPage.pageSize + status.count}</td>
					<th><c:out value="${user.userName}"/></th>
					<th><c:out value="${user.nickname}"/></th>
					<th><c:out value="${user.mobile}"/></th>
					<td><p><fmt:formatDate value="${user.regDate}" pattern="yyyy-MM-dd HH:mm"/></p></td>
					<td>
						<c:choose>
							<c:when test="${user.regFrom == '0'}">网站注册</c:when>
							<c:when test="${user.regFrom == '1'}">andriod注册</c:when>
							<c:when test="${user.regFrom == '2'}">ios注册</c:when>
							<c:when test="${user.regFrom == '3'}">电话注册</c:when>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${user.status == '0'}">非正常</c:when>
							<c:when test="${user.status == '1'}">正常</c:when>
							<c:when test="${user.status == '2'}">冻结</c:when>
						</c:choose>
					</td>
					<td class="t-operate">
						<p><c:if test="${user.status == '1'}"><a href="" userId="${user.userId}" userName="${fn:escapeXml(user.userName)}" name="resetPwd">重置密码</a></c:if></p>
					</td>
				</tr>
				</c:forEach>			
			</tbody>
		</table>
	</div>
	<!-- table end -->
	<!-- paging -->
	<div class="paging">
		<div class="ctrlArea">
			
		</div>
		<div class="pagingWrap">
			<p:page page="${userPage}" action="${ctx}/user/query"/>
		</div>
	</div>
	<!-- paging end -->
</div>
<!-- orderSearch end -->

<script type="text/javascript">
$(function(){
	CheckUtil.limitDigital($('#mobile'));
	$('a[name="resetPwd"]').click(resetPwd);
	
	$('#divOpen').click(function(){
		if($(this).parent().hasClass('open')) {
			$(this).parent().removeClass('open');
			$('#fldQuery').addClass('default');
		} else {
			$(this).parent().addClass('open');
			$('#fldQuery').removeClass('default');
		}
	});
});

function resetPwd(e) {
	e.preventDefault();
	
	var userId = $(this).attr('userId'),
		userName = $(this).attr('userName');
	
	if(confirm("确认重置用户'" + userName + "'的密码吗？")) {
		$.ajax({url:'resetPwd?userId=' + userId, dataType:'json', async:false,
			success : function(data) {			
				if(data) {
					alert("用户'" + userName + "'重置后的密码为'" + data + "'");	
				} else {
					alert('重置密码失败！');
				}								
			},
			error : function() {
				alert('系统繁忙，请稍后再试！');
			}});	
	}
}
</script>

</body>
</html>