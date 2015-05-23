<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>角色管理-巨友利</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/modaldialog/jquery.modaldialog.js?t=<%= new java.util.Date().getTime() %>"></script>
	<script type="text/javascript" src="../static/js/rolePage.js?t=<%= new java.util.Date().getTime() %>"></script>
	<link rel="stylesheet" href="../static/js/modaldialog/css/jquery.modaldialog.css" />
	<script type="text/javascript">
	<c:if test="${!empty(msg)}">	
		$(function(){
			$.modaldialog('${msg}');
		});
	</c:if>
	$(function(){
	<c:forEach items="${resourceIds}" var="resourceId">
		$('input:checkbox[name="resourceId"][value="${resourceId}"]').prop("checked", true);			
	</c:forEach>
	});
	
	</script>
	<form action="../sys/roleUpdate" id="frm" method="post">
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
                    <div class="returns-operation">
                        <div class="formTitle">
                            <i></i>
                            <span class="title">基本信息</span>
                            <a href="../sys/role" class="inputBtn_a">返&nbsp;&nbsp;&nbsp;&nbsp;回</a>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left"><em>*</em>角色名称：</div>
                            <div class="r-o-right"><input type="text" id="roleName" name="roleName" value="${role.roleName}">
							</div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left">角色代码：</div>
                        	<div class="r-o-right">
                            	<input type="text" id="roleCode" name="roleCode" value="${role.roleCode}">
                            </div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left">备注：</div>
                        	<div class="r-o-right">
                        		 <textarea class="inputTextC" id="remark" name="remark" rows="2"><c:out value="${role.remark}"></c:out>
                        		 </textarea>
                        	</div>
                        </div>                       
                    </div><!--returns-operation end-->
     
        	<div class="returns-operation">
                   	<div class="formTitle">
                            <i></i>
                            <span class="title">权限信息</span>
                    </div>
                  	<c:forEach items="${allResources}" var="folder">
                  	<div class="r-o-list">
                            <div class="r-o-left"><c:out value="${folder.name}"></c:out>：</div>
                        	<div class="r-o-right">
                            	<c:forEach items="${folder.children}" var="url">
                            	   		<p><input type="checkbox" name="resourceId" value="${url.resourceId}"><c:out value="${url.name}"></c:out></p>
                            	</c:forEach>
                            </div>
                    </div>                  	
                  	</c:forEach>                    	 
        	</div>
   
        	  <hr />
              <div class="returns-operation">
                  <div class="r-g-btns">
                      <div class="r-g-b-left">
                          <input type="button" id="saveBtn" name="saveBtn" class="inputBtnA" value="保存">
                          <input type="hidden" name="roleId" value="${param.roleId}">
                          <input type="hidden" name="flg" id="flg">
                      </div>    
                      <c:if test="${param.roleId != 0}">
                      <div class="r-g-b-right">
                         <input type="button" id="delBtn" name="delBtn" class="inputBtnA" value="删除">
                      </div>    
                       </c:if>         
                  </div>
              </div>  
        </form>      	 
</body>
</html>