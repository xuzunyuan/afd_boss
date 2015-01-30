<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@include file="/common/common.jsp"%> 

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>创建活动</title>
</head>
<body>
	<!-- foldbarV -->
				<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
				<!-- foldbarV end -->
				<!-- crumbs -->
				<div class="crumbs crumbsA">
					<ul>
						<li><a href="#">后台首页</a><em>&gt;</em></li>
						<li><a href="#">活动管理</a><em>&gt;</em></li>
						<li><strong>创建活动</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- orderSuccess -->
				<div class="orderSuccess activeSuccess">
					<dl>
						<dt><i class="icon i-ok50"></i></dt>
						<dd>
							<h2>活动已${empty(data.ywPPId) ? '创建' : '保存'} 成功</h2>
							<p><span>•</span>活动开始时间：${data.startDay} ${data.startHour}：${data.startMinute}，请尽快完成后续活动页面的发布事宜</p>
							<p><span>•</span>已创建未上线的活动如需上线，也可手动操作上线。<a href="list">点此操作</a></p>
						</dd>
					</dl>
					<div class="orderGuide">
						<h3>您还可以：</h3>
						<p><span>•</span>继续创建&nbsp;&nbsp; <a href="promotion?type=2">直降活动</a><a href="promotion?type=1">限时抢购</a></p>
						<p><span>•</span><a href="list" class="">查看活动列表</a></p>
					</div>
				</div>
				<!-- orderSuccess end -->
</body>
</html>