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
<title>修改密码-巨有利</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/modaldialog/jquery.modaldialog.js?t=<%= new java.util.Date().getTime() %>"></script>
	<script type="text/javascript" src="../static/js/myPassword.js?t=<%= new java.util.Date().getTime() %>"></script>
	<link rel="stylesheet" href="../static/js/modaldialog/css/jquery.modaldialog.css" />
	<script type="text/javascript">
	<c:if test="${!empty(msg)}">	
		$(function(){
			$.modaldialog('${msg}');
		});
	</c:if>	
	</script>
	<form action="../myPassword/update" id="frm" method="post">
	<div class="crumbs-box">
                        <div class="crumbs">
                            <h3>当前位置 &#58;</h3>
                            <ul>
                                <li><a href="#">BOSS</a>&#62;</li>
                                <li><a href="#">系统管理</a>&#62;</li>
                                <li>修改密码</li>
                            </ul>
                        </div>
                    </div><!--crumbs-box end-->
                    <div class="returns-operation">
                        <div class="formTitle">
                            <i></i>
                            <span class="title">修改密码</span>
                            <!-- <a href="../myAccount/view" class="inputBtn_a">我的账号</a>  -->
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left"><em>*</em>旧密码：</div>
                            <div class="r-o-right">                            	
                            	<input type="password" id="oldPassword" name="oldPassword" maxlength="18">
							</div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left"><em>*</em>新密码：</div>
                            <div class="r-o-right">                            	
                            	<input type="password" id="newPassword" name="newPassword" maxlength="18">
							</div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left"><em>*</em>重复新密码：</div>
                            <div class="r-o-right">                            	
                            	<input type="password" id="newPassword2" name="newPassword2" maxlength="18">
							</div>
                        </div>
                      
                    </div><!--returns-operation end-->
        
        	  <hr />
              <div class="returns-operation">
                  <div class="r-g-btns">
                      <div class="r-g-b-left">
                          <input type="submit" id="saveBtn" name="saveBtn" class="inputBtnA" value="保存">                       
                      </div> 
                      
                      <div class="r-g-b-right">
                         <input type="reset" id="resetBtn" name="resetBtn" class="inputBtnA" value="取消">   
                      </div>                         
                  </div>
              </div>  
        </form>      	 
</body>
</html>