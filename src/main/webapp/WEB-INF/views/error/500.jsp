<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.afd.staff.model.extend.TResourceExtend, com.afd.staff.model.*, com.google.common.collect.Lists, org.apache.shiro.SecurityUtils"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
	//设置用户信息数据
	TStaff staff = (TStaff) SecurityUtils.getSubject().getPrincipal();
	request.setAttribute("currentStaff", staff);
%>


<!doctype html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>一网全城BOSS系统</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/style/classes.css?t=2014051601" />
</head>
<body>
	<div class="wrapper">
		<div id="err-hd">
        	<div class="header">
				<h1><a href="#" title="一网全城购物中心">一网全城购物中心</a><span>后台管理系统</span></h1>
                <ul class="header-menu">
               		<c:if test="${!empty(currentStaff)}">
                	<li>欢迎您， <c:out value="${currentStaff.realName}"></c:out> （<c:out value="${currentStaff.nickName}"></c:out>）<li>
                    <li><a href="<%= request.getContextPath() %>/myAccount/view?m=-1">我的账号</a>|<a href="<%= request.getContextPath() %>/logout">退出</a></li>
               		</c:if>
                </ul>
			</div><!--header end-->
		</div><!--hd end-->
		<div id="err-bd">
            <div class="err-con">
            	<ul class="err-ul-a">
                	<li class="err-ico">
                    </li>
                    <li class="err-txt">
                    	<h3>程序出错啦</h3>
                        <div class="err-code">ERROR...PAGE NOT FOUND</div>
                        <div class="err-text">错误代码：500（服务器内部错误）<br>您可以联系网站管理员，电话：400-911-8888</div>
                        <div class="err-btn"><a href="javascript:location.reload();" class="inputBtn">刷新试试</a><a href="javascript:history.go(-1);" class="inputBtn">返回上一页</a></div>
                    </li>
                </ul>
            </div>
        </div><!--bd end-->
        <br>
        <div class="footer">
				<div class="footer-links">
					<a href="#" title="关于一网全城" target="_blank">关于一网全城</a>|
					<a href="#" title="联系我们" target="_blank">联系我们</a>|
					<a href="#" title="网站地图" target="_blank">网站地图</a>|
					<a href="#" title="网站合作" target="_blank">网站合作</a>|
					<a href="#" title="友情链接" target="_blank">友情链接</a>|
					<a href="#" title="网站联盟" target="_blank">网站联盟</a>|
					<a href="#" title="帮助中心" target="_blank">帮助中心</a>|
					<a href="#" title="版权声明" target="_blank">版权声明</a>
				</div>
				<p>Copyright &copy; 2013-2014 Yiwang.com All Rights Reserverd.</p>
				<p>ICP经营许可证号：吉B2-20140008</p>
				
			</div><!--footer end-->
    </div><!--wrapper end-->
    


<!--[if lte IE 6]>
<script type="text/javascript" src="<%= request.getContextPath() %>/static/script/DD_PNG08a-min.js"></script>
<script>
DD_belatedPNG.fix('.header h1 a');
</script>
<![endif]-->
</body>
</html>
