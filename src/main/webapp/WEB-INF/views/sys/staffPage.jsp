<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
request.setAttribute("currentStaff", org.apache.shiro.SecurityUtils.getSubject().getPrincipal());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>用户管理-一网全城</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/modaldialog/jquery.modaldialog.js?t=<%= new java.util.Date().getTime() %>"></script>
	<script type="text/javascript" src="../static/js/staffPage.js?t=<%= new java.util.Date().getTime() %>"></script>
	<link rel="stylesheet" href="../static/js/modaldialog/css/jquery.modaldialog.css" />
	<script type="text/javascript">
	<c:if test="${!empty(msg)}">	
		$(function(){
			$.modaldialog('${msg}');
		});
	</c:if>
	$(function(){
	<c:forEach items="${roleIds}" var="roleId">
		$('input:checkbox[name="roleId"][value="${roleId}"]').prop("checked", true);			
	</c:forEach>
	});
	
	</script>
	<form action="../sys/staffUpdate" id="frm" method="post">
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
                    <div class="returns-operation">
                        <div class="formTitle">
                            <i></i>
                            <span class="title">基本信息</span>
                            <a href="../sys/staff" class="inputBtn_a">返&nbsp;&nbsp;&nbsp;&nbsp;回</a>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left"><em>*</em>登录名称：</div>
                            <div class="r-o-right">                            	
                            	<input type="text" id="loginName" name="loginName" value="${staff.loginName}" ${param.staffId != 0 ? 'readOnly="true"' : ''}>
							</div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left"><em>*</em>真实姓名：</div>
                            <div class="r-o-right"><input type="text" id="realName" name="realName" value="${staff.realName}">
							</div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left">昵称：</div>
                            <div class="r-o-right"><input type="text" id="nickName" name="nickName" value="${staff.nickName}">
							</div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left">地址：</div>
                            <div class="r-o-right"><input type="text" id="addr" name="addr" value="${staff.addr}" size="60">
							</div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left">邮编：</div>
                            <div class="r-o-right"><input type="text" id="zipCode" name="zipCode" value="${staff.zipCode}" maxlength="6">
							</div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left"><em>*</em>手机：</div>
                            <div class="r-o-right"><input type="text" id="mobile" name="mobile" value="${staff.mobile}" maxlength="11">
							</div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left">固话：</div>
                            <div class="r-o-right"><input type="text" id="tele" name="tele" value="${staff.tele}" maxlength="18">
							</div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left">QQ：</div>
                            <div class="r-o-right"><input type="text" id="qq" name="qq" value="${staff.qq}"></div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left">EMAIL：</div>
                            <div class="r-o-right"><input type="text" id="email" name="email" value="${staff.email}"></div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left">备注：</div>
                        	<div class="r-o-right">
                        		 <textarea class="inputTextC" id="remark" name="remark" rows="2"><c:out value="${staff.remark}"></c:out>
                        		 </textarea>
                        	</div>
                        </div>                       
                    </div><!--returns-operation end-->
     
        	<div class="returns-operation">
                   	<div class="formTitle">
                            <i></i>
                            <span class="title">角色信息</span>
                    </div>
                  
                  	<div class="r-o-list">
                           <table border="0"  cellspacing="0" style="width: 100%">
                           	<c:forEach items="${roleList}" var="role" varStatus="status">
                           	<c:if test="${status.index % 3 == 0}">
                           		<tr>
                           	</c:if>
                           		<td><input type="checkbox" name="roleId" value="${role.roleId}">${role.roleName}</td>
                           	<c:if test="${status.last || status.index % 3 == 2}">
                           		</tr>
                           	</c:if>
                          	</c:forEach>     
                           </table>
                    </div>                  	
                  	               	 
        	</div>
   
        	  <hr />
              <div class="returns-operation">
                  <div class="r-g-btns">
                      <div class="r-g-b-left">
                          <input type="submit" id="saveBtn" name="saveBtn" class="inputBtnA" value="保存">
                          <input type="hidden" name="staffId" value="${param.staffId}">
                      </div>    
                      <c:if test="${param.staffId != 0 && param.staffId != currentStaff.staffId}">
                      <div class="r-g-b-right">
                         <input type="button" id="delBtn" name="delBtn" class="inputBtnA" value="删除" staffId="${param.staffId}">
                      </div>    
                       </c:if>         
                  </div>
              </div>  
        </form>      	 
</body>
</html>