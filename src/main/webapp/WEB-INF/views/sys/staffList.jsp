<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix='p' uri="/WEB-INF/tld/page.tld" %>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>用户管理-阿凡达</title>
</head>
<body>
<script type="text/javascript" src="../static/js/page.js?t=<%= new java.util.Date().getTime() %>"></script>
<script type="text/javascript" src="../static/js/modaldialog/jquery.modaldialog.js?t=<%= new java.util.Date().getTime() %>"></script>
<link rel="stylesheet" href="../static/js/modaldialog/css/jquery.modaldialog.css" />
<script type="text/javascript">
<c:if test="${!empty(msg)}">	
$(function(){
	$.modaldialog('${msg}');
});
</c:if>
$(function(){
	$('a[name="resetPassword"]').click(function(e){
		e.preventDefault();
		$.modaldialog('您确定重置该用户的密码吗?',
				{title :'确认',
				 buttons : [{text : '确&nbsp;&nbsp;认',click:function(){
					 self.location.href = $(e.target).attr('href');
				 }}, 
			            {text : '取&nbsp;&nbsp;消'}]
				});
	});
});
</script>
<div class="crumbs-box">
                   <div class="crumbs">
                       <h3>当前位置 &#58;</h3>
                       <ul>
                           <li><a href="#">BOSS</a>&#62;</li>
                           <li><a href="#">系统管理</a>&#62;</li>
                           <li>用户管理</li>
                       </ul>
                   </div>
               </div><!--crumbs-box end-->
<form action="" method="post" id="frm">
<div class="returns-search" style="height:140px;">
	<ul class="r-s-list clearfix">
    	<li>
        	<div class="r-s-left">登录名：</div>
            <div class="r-s-right"><input type="text" value="<c:out value="${pageInfo.conditions.loginName}"/>" name="loginName" id="loginName" class="inputText inputW1" ></div>
        </li>    	    	
    	<li>
        	<div class="r-s-left">真实姓名：</div>
            <div class="r-s-right"><input type="text" value="<c:out value="${pageInfo.conditions.realName}"/>" name="realName" id="realName" class="inputText inputW1" ></div>
        </li>  
        <li>
        	<div class="r-s-left">昵称：</div>
            <div class="r-s-right"><input type="text" value="<c:out value="${pageInfo.conditions.nickName}"/>" name="nickName" id="nickName" class="inputText inputW1" ></div>
        </li>  
        <li>
        	<div class="r-s-left">角色：</div>
            <div class="r-s-right">
            	<select id="roleId" name="roleId">
            		<option value=""></option>  
            		<c:forEach items="${roleList}" var="role">
            			<option value="${role.roleId}" ${role.roleId == pageInfo.conditions.roleId ? 'selected="selected"' : ''}>${role.roleName}</option>
            		</c:forEach>          	
            	</select>
            </div>
        </li>  
        <li></li>
        <li>
        	<div class="r-s-right"><input type="submit" value="查&nbsp;&nbsp;&nbsp;询" name="query" id="query" class="inputBtn inputW2" >
        	</div>
        </li>
    </ul>
</div><!--returns-search end-->
<div class="returns-list">
	<div class="formTitle">
          <i></i>
          <span class="title">用户列表</span>
          <a href="../sys/staffPage?staffId=0" class="inputBtn_a">新增用户</a>
    </div>
	
	<table class="boos-table">
    <tbody>
    	<tr>
        	<th>登录名</th>
        	<th>真实姓名</th>
        	<th>昵称</th>
        	<th>手机</th>
        	<th>QQ</th>
        	<th><select id="status" name="status" onchange="javascript:$('#query').trigger('click');">
        			<option value=""></option>
        			<option value="0" ${pageInfo.conditions.status == '0' ? 'selected="selected"' : ''}>已删除</option>
        			<option value="1" ${pageInfo.conditions.status == '1' ? 'selected="selected"' : ''}>有效</option>        			
        		</select>
        	</th>
        	<th>操作</th>
        </tr>
        <tr><td colspan="7" class="table-space"></td></tr>
        
      <tr><td colspan="7" class="table-space"></td></tr>
      
      <c:forEach items="${staffsPage.result}" var="staff" varStatus="status"> 
      	<tr>
      		<td><c:out value="${staff.loginName}"/></td>
      		<td><c:out value="${staff.realName}"/></td>
      		<td><c:out value="${staff.nickName}"/></td>
      		<td><c:out value="${staff.mobile}"/></td>
      		<td><c:out value="${staff.qq}"/></td>
      		<td>
      			<c:choose>
      				<c:when test="${staff.status}">有效</c:when>
      				<c:otherwise>已删除</c:otherwise>
      			</c:choose> 
      		</td>
      		<td>
   				<c:if test="${staff.status}"><a style="cursor:pointer; color: #0000FF" href="../sys/resetStaffPassword?staffId=${staff.staffId}" name="resetPassword" >重置密码</a> | </c:if>
      			<a style="cursor:pointer; color: #0000FF" href="../sys/staffPage?staffId=${staff.staffId}" >详细</a>
      		</td>
      	</tr>      
      </c:forEach>      
    </tbody>
    </table>
    <p:page page="${staffsPage}" action="../sys/staff"/>
      
</div><!--returns-list end-->
</form>
</body>
</html>