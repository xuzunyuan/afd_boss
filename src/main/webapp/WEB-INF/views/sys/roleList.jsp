<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix='p' uri="/WEB-INF/tld/page.tld" %>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>角色管理-巨有利</title>
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
</script>
<div class="crumbs-box">
                   <div class="crumbs">
                       <h3>当前位置 &#58;</h3>
                       <ul>
                           <li><a href="#">BOSS</a>&#62;</li>
                           <li><a href="#">系统管理</a>&#62;</li>
                           <li>角色管理</li>
                       </ul>
                   </div>
               </div><!--crumbs-box end-->

<div class="returns-list">
	<div class="formTitle">
                            <i></i>
                            <span class="title">角色列表</span>
                           <a href="../sys/rolePage?roleId=0" class="inputBtn_a">新增角色</a>
    </div>
	<table class="boos-table">
    <tbody>
    	<tr>
        	<th>角色名称</th>
        	<th>角色代码</th>
        	<th width="300">描述</th>
         	<th>操作</th>
        </tr>
        <tr><td colspan="4" class="table-space"></td></tr>
        
      <tr><td colspan="4" class="table-space"></td></tr>
      
      <c:forEach items="${rolesPage.result}" var="role" varStatus="status"> 
      	<tr>
      		<td><c:out value="${role.roleName}"/></td>
      		<td><c:out value="${role.roleCode}"/></td>
      		<td><c:out value="${role.remark}"/></td>
      		<td>
      			<a style="cursor:pointer; color: #0000FF" href="../sys/rolePage?roleId=${role.roleId}">详细</a>
      		</td>
      	</tr>      
      </c:forEach>      
    </tbody>
    </table>
    <p:page page="${rolesPage}" action="../sys/role"/>
      
</div><!--returns-list end-->

</body>
</html>