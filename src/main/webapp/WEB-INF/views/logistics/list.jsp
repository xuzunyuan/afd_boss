<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="/WEB-INF/tld/page.tld" prefix="pg"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>物流管理-一网全城</title>
</head>
<body>
<script type="text/javascript" src="../static/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="../static/js/auditList.js?t=<%= new java.util.Date().getTime() %>"></script>
<script type="text/javascript" src="../static/js/page.js?t=<%= new java.util.Date().getTime() %>"></script>
<div class="crumbs-box">
    <div class="crumbs">
        <h3>当前位置 &#58;</h3>
        <ul>
            <li><a href="#">BOSS</a>&#62;</li>
            <li><a href="#">物流公司管理</a>&#62;</li>
            <li>物流公司列表</li>
        </ul>
    </div>
</div><!--crumbs-box end-->
<form action="${pageContext.request.contextPath}/logistics/showLogistics" method="post" id="queryLogistics">
<div class="returns-search" style="height:140px;">
	<ul class="r-s-list clearfix">
    	<li>
        	<div class="r-s-left">物流公司名称：</div>
            <div class="r-s-right"><input type="text" id="logisticsCompName" name="logisticsCompName" value="<c:out value="${logisticsCondition.logisticsCompName }"/>"  class="inputText inputW1" ></div>
        </li>
    	<li>
        	<div class="r-s-left">联系人：</div>
            <div class="r-s-right"> <input type="text" id="linkman" name ="linkman" value="<c:out value="${logisticsCondition.linkman}" />" class="inputText inputW1"></div>
        </li>
    	<li>
        	<div class="r-s-left">手机号：</div>
            <div class="r-s-right"> <input type="text" id="mobile" name ="mobile" value="<c:out value="${logisticsCondition.mobile}" />" class="inputText inputW1"></div>
        </li>        
    	<li>
    		<div class="r-s-left">创建时间：</div>  
    	 	<div class="r-s-right">
       			<input type="text" readonly="readonly" value="<fmt:formatDate value="${logisticsCondition.startDate}" pattern="yyyy-MM-dd HH:mm:ss" />" name="startDate" class="inputText inputDate" onClick="WdatePicker()" /> 
       			至 <input type="text" readonly="readonly" value="<fmt:formatDate value="${logisticsCondition.endDate }" pattern="yyyy-MM-dd HH:mm:ss" />" name="endDate" class="inputText inputDate" onClick="WdatePicker()" />
       		</div>
        </li>        
        <li>
        	<div class="r-s-right"><input type="submit" value="查&nbsp;&nbsp;&nbsp;询"  name="query" class="inputBtn inputW2" ></div>
        </li>
    </ul>
</div><!--returns-search end-->
<div class="returns-list">
	<input type="button" name="addBtn" class="inputBtn inputW2" value="添加" onclick="addLogistics();" /><br><br>
	<table class="boos-table">
    <tbody>
    	<tr>
        	<th>物流公司名称</th>
        	<th>所在地区</th>
        	<th>联系人</th>
        	<th>手机号</th>
        	<th>状态</th>
        	<th>创建时间</th>
        	<th>操作</th>
        </tr>
      	<tr><td colspan="7" class="table-space"></td></tr>
	<c:choose>
	  <c:when test="${!empty requestScope.page.result}">
        <c:forEach items="${page.result}" var="logistics" varStatus="status"> 
      	<tr>
      		<td><c:out value="${logistics.logisticsCompName}"/></td>
      		<td><c:out value="${logistics.provinceName} ${logistics.cityName } ${logistics.districtName } ${logistics.townName}"/></td>
      		<td><c:out value="${logistics.linkman}"/></td>
      		<td><c:out value="${logistics.mobile}"/></td>
      		<td><c:if test="${logistics.status==1}">正常</c:if><c:if test="${logistics.status==0}">无效</c:if><c:if test="${logistics.status==2}">删除</c:if></td>
      		<td><fmt:formatDate value="${logistics.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
      		<td>
      			<a  href="${pageContext.request.contextPath}/logistics/addLogistics/1?logisticsCompId=${logistics.logisticsCompId}" style="cursor:pointer" class="code">修改</a>|
      			<a href="javascript:void(0);" lcId="${logistics.logisticsCompId}" onclick="delLogistics(this);" style="cursor:pointer" class="code">删除</a>
      		</td>
      	</tr>    
      </c:forEach>
	  </c:when>	
		<c:otherwise>
			<tr><td colspan="9">您还没有添加数据，请先添加！</td></tr>
		</c:otherwise>						
		</c:choose>	 
    </tbody>
    </table>
      <pg:page page="${page}" action="${pageContext.request.contextPath}/logistics/showLogistics" />
</div><!--returns-list end-->
</form>
<script type="text/javascript">
function　addLogistics(){
 	window.location.href = "${pageContext.request.contextPath}/logistics/addLogistics/0";
}
 function delLogistics(obj){
	var lcId =  $(obj).attr("lcId");
	$.post("${pageContext.request.contextPath}/logistics/delLogistics",{logisticsCompId:lcId},function(data){
		if(data.success == 1){
			alert("删除成功！");
			$("#queryLogistics").submit();
		}else{
			alert("删除失败，请联系管理员！");
		}
	})
 }
	
</script>
</body>
</html>