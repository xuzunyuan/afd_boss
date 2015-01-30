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
<title>我的账号-一网全城</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/modaldialog/jquery.modaldialog.js?t=<%= new java.util.Date().getTime() %>"></script>
	<script type="text/javascript" src="../static/js/myAccount.js?t=<%= new java.util.Date().getTime() %>"></script>
	<link rel="stylesheet" href="../static/js/modaldialog/css/jquery.modaldialog.css" />
	<script type="text/javascript">
	<c:if test="${!empty(msg)}">	
		$(function(){
			$.modaldialog('${msg}');
		});
	</c:if>	
	</script>
	<form action="../myAccount/update" id="frm" method="post">
	<div class="crumbs-box">
                        <div class="crumbs">
                            <h3>当前位置 &#58;</h3>
                            <ul>
                                <li><a href="#">BOSS</a>&#62;</li>
                                <li><a href="#">系统管理</a>&#62;</li>
                                <li>我的资料</li>
                            </ul>
                        </div>
                    </div><!--crumbs-box end-->
                    <div class="returns-operation">
                        <div class="formTitle">
                            <i></i>
                            <span class="title">账号信息</span>
                            <!-- <a href="../myPassword/view" class="inputBtn_a">修改密码</a>  -->
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left"><em>*</em>登录名称：</div>
                            <div class="r-o-right">                            	
                            	<input type="text" id="loginName" name="loginName" value="${staff.loginName}" readOnly="true">
							</div>
                        </div>
                        <div class="r-o-list">
                            <div class="r-o-left"><em>*</em>真实姓名：</div>
                            <div class="r-o-right"><input type="text" id="realName" name="realName" value="${staff.realName}">
							</div>
                        </div>
                        <div class="r-o-list" style="display:none">
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
                            <div class="r-o-left">手机：</div>
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