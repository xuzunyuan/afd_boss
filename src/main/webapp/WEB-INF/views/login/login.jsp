<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/analyze.baidu.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/jquery-1.10.2.min.js?t=2014051601"></script>
<link rel="stylesheet" href="static/style/classes.css?t=2015013001" />
<title>欢迎登录巨友利boss系统</title>
</head>
<body class="login-bgcolor">
	<form id="frm" action="<%= request.getContextPath() %>/login/validate" method="post">	
	
<div class="wrapper">
	<div class="login-bd">
    	<div class="login-main clearfix">
        	<div class="header">
            	<h1><a href="#" title="">巨友利</a><span>后台管理系统</span></h1>
            </div>
            <div class="login-form">
            	<div class="l-f-title">用户登录<i></i></div>
                <div class="l-f-con">
                	<ul>
                    	<li>
                        	<div class="l-f-left">用户名：</div>
                            <div class="l-f-right"><input type="text" class="inputTextB" name="loginName" id="loginName" value="${param.loginName}" maxlength="18"></div>
                        </li>
                    	<li>
                        	<div class="l-f-left">密码：</div>
                            <div class="l-f-right"><input type="password" class="inputTextB" value="" name="password" id="password" maxlength="18"></div>
                            <div class="l-f-warn" id="msg" style="display:none"><c:out value="${loginError}"/></div>
                        </li>
                        <li>
                        	<div class="l-f-btn"><input type="submit" class="login-submit" value="登&nbsp;&nbsp;&nbsp;录" ></div>
                        </li>
                    </ul>
                </div>
            </div>
            
        </div>
    </div>
</div>

</form>
<!--[if lte IE 6]>
<script type="text/javascript" src="static/script/DD_PNG08a-min.js"></script>
<script>
DD_belatedPNG.fix('.header h1 a,.l-f-title i');
</script>
<![endif]-->

</body>
</html>
<script type="text/javascript">
	// 提交前校验
	$(function() {
		$("#frm").submit(function () {
			if(!$("#loginName").val()) {
				showMsg("请输入用户名");
				$("#loginName").focus();
				return false;
			}
			
			if(!$("#password").val()) {
				showMsg("请输入密码");
				$("#password").focus();
				return false;
			}
			
			return true;
		});	
	});	
	
	$(function() {
		if(!$("#loginName").val()) {
			$("#loginName").focus();		
		} else {
			$("#password").focus();
		}
		
		<c:if test="${!empty(loginError)}">
			$("#msg").show();
		</c:if>
	});
	
	// 显示用户信息
	function showMsg(msg) {
		$("#msg").show();
		$("#msg").html(msg);
	}
</script>
