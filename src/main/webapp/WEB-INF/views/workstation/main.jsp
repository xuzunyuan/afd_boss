<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%@ page import="java.util.List,com.afd.staff.model.extend.TResourceExtend, com.afd.staff.model.*, com.google.common.collect.Lists, org.apache.shiro.SecurityUtils"%>

<%!
com.afd.staff.service.StaffService staffService = com.afd.common.spring.SpringContextUtil.getApplicationContext().getBean(com.afd.staff.service.StaffService.class);
com.afd.staff.service.ResourceService resourceService = com.afd.common.spring.SpringContextUtil.getApplicationContext().getBean(com.afd.staff.service.ResourceService.class);

/**
 * 获取用户菜单
 * 
 * @param urls
 * @param allFolder
 * @return 目录<code>TResourceExtend</code>集合，每个元素具有其向下的url对象集合
 */
private List<TResourceExtend> getStaffMenu(List<TResource> urls,
		List<TResource> allFolder) {

	// 用户的URL从数据库中取出已经是排好序的，相同目录的URL必然相互靠近
	List<TResourceExtend> folders = Lists.newArrayList();
	Integer lastId = null;
	TResourceExtend folder = null;

	for (TResource url : urls) {
		if (lastId == null || url.getParentId().compareTo(lastId) != 0) {
			folder = new TResourceExtend(getFolder(url.getParentId(),
					allFolder));
			folders.add(folder);
			lastId = url.getParentId();
		}

		folder.getChildren().add(url);
	}

	return folders;
}

/**
 * 根据ID获取目录
 * 
 * @param resourceId
 * @param allFolder
 * @return
 */
private TResource getFolder(int folderId, List<TResource> allFolder) {
	for (TResource folder : allFolder) {
		if (folder.getResourceId().compareTo(folderId) == 0)
			return folder;
	}

	return null;
}
%>

<%
	if(request.getParameter("m") != null) {
		request.getSession(true).setAttribute("m", request.getParameter("m"));
	}

	//设置用户信息数据
	TStaff staff = (TStaff) SecurityUtils.getSubject().getPrincipal();
	request.setAttribute("currentStaff", staff);
	
	// 设置用户菜单数据
	List<TResourceExtend> menu = (List<TResourceExtend>)request.getSession(true).getAttribute("menu");
	
	if (menu == null) {
		List<TResource> urls = staffService.getStaffPrivileges(staff.getStaffId());	
		List<TResource> allFolder = resourceService.getAllFolder();
		
		menu = getStaffMenu(urls, allFolder);
		request.getSession(true).setAttribute("menu", menu);
	}
	
	// 计算menu长度
	int length = 0, selectedFolder = 0;
	String m = (String)request.getSession().getAttribute("m");

	if(menu != null) {
		length += menu.size();
		
		for(TResourceExtend folder : menu) {
			length += folder.getChildren().size();
			
			if(selectedFolder == 0 && m != null && !m.equals("")) {
				for(TResource menuItem : folder.getChildren()) {
					if(m.equals(menuItem.getResourceId().toString())) {
						selectedFolder = folder.getResourceId();
						break;
					}
				}
			}
		}		
	}
	
	if(length > 15) request.setAttribute("bigMenu", true);
	if("-101".equals(m) || "-102".equals(m)) selectedFolder = -100;
	
	if(selectedFolder != 0) request.setAttribute("selectedFolder", selectedFolder);
%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<script type="text/javascript" src="<%= request.getContextPath() %>/static/js/g.js?t=20150203"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/static/style/classes.css?t=20150203" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/static/style/all-debug.css?t=20150203" />
<title><decorator:title default="巨友利BOSS管理系统"/></title>
<script type="text/javascript">
$().ready(function(){
	var folder = $('h3[folderId]'), menu = $('a[menuId]');
	folder.click(clickFolder);	
	menu.click(clickMenu);
});

function clickFolder(e) {
	var jq = $(e.target),
	folderId = jq.attr('folderId'),
	expand = !jq.next().is(":visible");
	
	expandFolder(folderId, expand);
}

function expandFolder(folderId, expand) {
	var folder = $('h3[folderId=' + folderId + ']'),
		ul = $('ul[folderId=' + folderId + ']');
	
	if(expand) {
		folder.find("i:last").removeClass('arrA-R').addClass('arrA-D');
		ul.show();
	} else {
		folder.find("i:last").removeClass('arrA-D').addClass('arrA-R');
		ul.hide();
	}
}

function clickMenu(e) {
	e.preventDefault();
	
	var jq = $(e.target), menuId = jq.attr('menuId'), href = jq.attr('href');
	window.location.href = appendParam(href, menuId);
}

function appendParam(href, menuId) {
	if(href.indexOf('?') == -1) {
		href = href + '?m=' + menuId;
		
	} else {		
		href = href + '&m=' + menuId; 
	}
	
	return href;
}

function initMenu() {
	var menuId = '${param.m}';
	if(!menuId) {
		menuId = '${sessionScope.m}';
	}
	
	if(!menuId) return;
	
	var jq = $('li[menuId=' + menuId + ']'), folderId = jq.attr('folderId');
	if(!folderId) return;
	
	expandFolder(folderId, true);
	jq.find('a').addClass('on');
}
</script>
</head>
<body>
	<div class="wrapper">
		<div id="hd">
        	<div class="header">
				<h1><a href="#" title="">巨友利</a><span>后台管理系统</span></h1>
                <ul class="header-menu">
                	<li>欢迎您， <c:out value="${currentStaff.realName}"></c:out> <!-- （<c:out value="${currentStaff.nickName}"></c:out>） --><li>
                    <li><!-- <a href="<%= request.getContextPath() %>/myAccount/view?m=-1">我的账号</a>| --><a href="<%= request.getContextPath() %>/logout">退出</a></li>
                </ul>
			</div><!--header end-->
		</div><!--hd end-->
		<div id="bd">
            <div class="container">
                <div class="aside">
                    <div class="boss-menu">
                    	<h2>后台管理系统</h2>
                        <div id="mainMenu" class="menu">
                        	<c:forEach items="${sessionScope.menu}" var="folder">
								<h3 folderId="${folder.resourceId}" class="${folder.classes}"><i class="ico"></i><c:out value="${folder.name}" /><i class="arrow ${(folder.resourceId == requestScope.selectedFolder || empty(requestScope.bigMenu)) ? 'arrA-D' : 'arrA-R'}"></i></h3>
								<ul folderId="${folder.resourceId}" style="${(folder.resourceId == requestScope.selectedFolder || empty(requestScope.bigMenu)) ? '' : 'display:none'}">									
								<c:forEach items="${folder.children}" var="link">
									<li menuId="${link.resourceId}" folderId="${folder.resourceId}"><a href="<%= request.getContextPath() %>${link.url}" menuId="${link.resourceId}" ${link.resourceId == sessionScope.m ? 'class="on"' : ''}><c:out value="${link.name}"/></a></li>
								</c:forEach>	
								</ul>
							</c:forEach>
							
							<h3 folderId="-100" class="contNumber"><i class="ico"></i>我的账号<i class="arrow ${(requestScope.selectedFolder == -100 || empty(requestScope.bigMenu)) ? 'arrA-D' : 'arrA-R'}"></i></h3>
							<ul folderId="-100" style="${(requestScope.selectedFolder == -100 || empty(requestScope.bigMenu)) ? '' : 'display:none'}">									
								<li menuId="-101" folderId="-100"><a href="<%= request.getContextPath() %>/myAccount/view" menuId="-101" ${'-101' == sessionScope.m ? 'class="on"' : ''}>我的资料</a></li>
								<li menuId="-102" folderId="-100"><a href="<%= request.getContextPath() %>/myPassword/view" menuId="-102" ${'-102' == sessionScope.m ? 'class="on"' : ''}>修改密码</a></li>
							</ul>
                        </div><!--menu end-->
                    </div><!--boss-menu end-->
                </div><!--aside end-->
                <div class="main">
                	<decorator:body/>                   
                </div><!--main end-->
                
            </div><!--container end-->
        </div><!--bd end-->
        <br>
        <div id="footer">
	        <div class="links">
					<a href="#" target="_blank">关于</a>|
					<a href="#" target="_blank">联系我们</a>|
					<a href="#" target="_blank">网站地图</a>|
					<a href="#" target="_blank">网站合作</a>|
					<a href="#" target="_blank">友情链接</a>|
					<a href="#" target="_blank">帮助中心</a>|
					<a href="#" target="_blank">版权声明</a>
				</div>
				<p class="copyright">Copyright © 2013-2015 juyouli.com All Rights Reserved.</p>
				<p><span>ICP经营许可证号：京AA-01334408</span></p>
					
			</div>
		</div><!--footer end-->
    </div><!--wrapper end-->    
</body>
</html>