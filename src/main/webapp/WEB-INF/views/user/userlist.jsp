<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>会员管理-一网全城</title>
</head>
<body>
<script type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.md.js?t=<%= new java.util.Date().getTime() %>"></script>
<script type="text/javascript" src="${ctx}/static/js/auditList.js?t=<%= new java.util.Date().getTime() %>"></script>
<script type="text/javascript" src="${ctx}/static/js/page.js?t=<%= new java.util.Date().getTime() %>"></script>
<div class="crumbs-box">
     <div class="crumbs">
         <h3>当前位置 &#58;</h3>
         <ul>
             <li><a href="#">BOSS</a>&#62;</li>
             <li><a href="#">用户管理</a>&#62;</li>
             <li>买家信息列表页</li>
         </ul>
     </div>
</div><!--crumbs-box end-->
<div class="orderSearch">
	<!-- screening -->
	<div class="screening">
		<form class="form" action="" method="post" id="frm">
			<fieldset class="default"><!-- 删掉default显示全部查询条件 -->
				<legend><h3>查询条件</h3></legend>
				<ul class="formBox">
			    	<li class="item">
			        	<div class="item-label">用户名：</div>
			            <div class="item-cont"><input type="text" value="<c:out value="${user.userName}"></c:out>" name="userName" id="userName" class="txt textA" ></div>
			        </li>
			    	<li class="item">
			        	<div class="item-label"> 昵称：</div>
			            <div class="item-cont">
			             <input type="text" value="<c:out value="${user.nickname}"></c:out>" name="nickname" id="nickname" class="txt textA" >
			            </div>
			        </li>
			    	<li class="item">
			        	<div class="item-label">注册日期：</div>
			            <div class="item-cont">
				            <input type="text" value="<fmt:formatDate value="${user.regDate}" pattern='yyyy-MM-dd'/>" class="dateTxt"  name="regDate" id="regDate" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'regDateend\',{d:-0});}'})"> 
			            	<span>至</span>
				            <input type="text" value="<fmt:formatDate value="${user.regDateend}" pattern='yyyy-MM-dd'/>" class="dateTxt"  name="regDateend" id="regDateend" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'regDate\',{d:+0});}'})"> 
			            </div>
			        </li>
			    	<li class="item">
			        	<div class="item-label">手机号：</div>
			            <div class="item-cont"> <input type="text" id="mobile" name ="mobile" value="${user.mobile}" class="txt textA"></div>
			        </li>
			        <li class="item">
			        	<div class="item-label">注册方式：</div>
			        	<div class="item-cont"> 
			        		<div class="select">
								<select name="regFrom">
								    <option value="">全部</option>
								    <option value="0" <c:if test="${user.regFrom == '0'}">selected="selected"</c:if>>网站注册</option>
								    <option value="1" <c:if test="${user.regFrom == '1'}">selected="selected"</c:if>>android注册</option>
								    <option value="2" <c:if test="${user.regFrom == '2'}">selected="selected"</c:if>>ios注册</option>
								    <option value="3" <c:if test="${user.regFrom == '3'}">selected="selected"</c:if>>电话注册</option>
								</select>
							</div>
			        	</div>
			        </li>
			    </ul>
			</fieldset>
			<!-- foldbarH -->
			<div id="foldbarH" class="foldbarH"><!-- 展开后添加class命open -->
				<div class="foldBtn" id="foldBtn"><i class="ico"></i></div>
				<div class="searchBtn"><input onclick="checkform()" type="button" class="btn btn-s" value="查&nbsp;&nbsp;询" /></div>
			</div>
			<!-- foldbarH end -->
		</form>
	</div>
	<div class="tableWrap">
	
		<table class="table tableA">
	    	<colgroup>
				<col width="40">
				<col width="100" />
				<col width="120" />
				<col width="120" />
				<col width="120" />
				<col width="80" />
				<col width="90" />
				<col width="100" />
			</colgroup>
			<thead>
		    	<tr>
		    		<th>序号</th>
		        	<th>用户名</th>
		        	<th>呢称</th>
		        	<th>手机号</th>
		        	<th>注册时间</th>
		        	<th>注册方式</th>
		        	<th>状态</th>
		        	<th>操作</th>
		        </tr>
		    </thead>
	      <tbody>
	        <c:forEach items="${page.result}" var="user" varStatus="status"> 
		      	<tr>
		      		<td>${status.count}</td>
		      		<td><c:out value="${user.userName}"/></td>
		      		<td><c:out value="${user.nickname}"/></td>
		      		<td><c:out value="${user.mobile}"/></td>
		      		<td><fmt:formatDate value="${user.regDate}" pattern="yyyy-MM-dd HH:mm"/></td>
		      		<td>	<c:choose>
		      		            <c:when test="${fn:trim(user.regFrom)== '' }">
									<c:out value="网站测试注册"/>
								</c:when>
								<c:when test="${user.regFrom== '0' }">
									<c:out value="网站注册"/>
								</c:when>
								<c:when test="${user.regFrom == '1' }">
									<c:out value="android注册"/>
								</c:when>
								<c:when test="${user.regFrom == '2' }">
									<c:out value="ios注册"/>
								</c:when>
								<c:when test="${user.regFrom == '3' }">
									<c:out value="电话注册"/>
								</c:when>
							</c:choose></td>
		      		<td><c:if test="${user.status==1}">正常</c:if><c:if test="${user.status==0}">无效</c:if></td>
		      		<td class="t-operate">
		      			<p>
		      				<a name="resetpwd" id="resetpwd${user.userId}" href="javascript:void(0)" onclick="resetpwd(${user.userId},${user.mobile})" style="cursor:pointer; color: #0000FF">重置密码</a>
		      			</p>
		      		</td>
				</tr>      
	      </c:forEach> 
	    </tbody>
	    </table>
	</div>
    <!-- paging -->
	<c:if test="${fn:length(page.result) > 0}">
		<pgNew:page name="query" page="${page}" formId="frm"></pgNew:page>
	</c:if>
	<!-- paging end -->
	<div class="tanchu" style="display:none">
	</div>
</div>
<script type="text/javascript">
$(function(){
	var userName = "${user.userName}";
	var nickName = "${user.nickname}";
	var mobile = "${user.mobile}";
	var regDate = "${user.regDate}";
	var regDateend = "${user.regDateend}";
	var regFrom = "${user.regFrom}";
	if(!!userName || !!nickName || !!mobile || !!regDate || !!regDateend || !!regFrom) {
		$("fieldset").removeClass("default");
		$("#foldbarH").addClass("open");
	}
	
	$(document).on("click","#foldBtn",function(){
		var hasOpen = $("#foldbarH").hasClass("open");
		if(hasOpen){
			$("#foldbarH").removeClass("open");
			$("fieldset").addClass("default");
		}else{
			$("#foldbarH").addClass("open");
			$("fieldset").removeClass("default");
		}
	});
});
function checkform(){
	if(!$("#regDate").val()==""&&$("#regDateend").val()==""){
		if($("#regDate").val()==""){
			var msg = "<p><i class='icon i-warns'></i>请输入查询开始日期</p>";
			$.modaldialog(msg,{
				title : '提醒',
				buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){$("#regDate").focus();}}]
			});
			return false;
		}
		if($("#regDateend").val()==""){
			var msg = "<p><i class='icon i-warns'></i>请输入查询结束日期</p>";
			$.modaldialog(msg,{
				title : '提醒',
				buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){$("#regDateend").focus();}}]
			});
			return false;
		}
	}
	var re =/^1\d{10}$/;
	var mobile=$("#mobile").val();
    if ($.trim(mobile)!=""&&!re.test(mobile))
   {
       var msg = "<p><i class='icon i-warns'></i>请正确输入手机号!</p>";
		$.modaldialog(msg,{
			title : '提醒',
			buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){$("#mobile").focus();}}]
		});
        return false;
    }
	$('#frm').submit();
}
function resetpwd(userid,mobile){
	if($("#resetpwd"+userid).hasClass("disabled")) {
		return;
	}
	$("#resetpwd"+userid).addClass("disabled");
	$(document).on("click","#dialog-close",function(){
		$("a[name=resetpwd]").removeClass("disabled");
	});
	var msg = "<p>确定要重置密码吗？</p>" + 
				"<p>新密码会通过手机短信发送给买家。</p>";
	$.modaldialog(msg,{
		title : '重置密码',
		buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
			$.ajax({
				url : "${ctx}/user/info/resetpwd.action",
				type : "POST",
				data : {
					userid : userid,
					mobile : mobile
				},
				dataType : "json",
				success : function(data) {
					var obj=$(".tanchu");
					if (data.flag=="1") {
						obj.html('<p><i class="icon i-duigou"></i>密码重置成功！</p>');
					}else if(data.flag=="-1"){
						obj.html('<p><i class="icon i-errors"></i>短信发送失败，请重新尝试！</p>');
					}else{
						obj.html('<p><i class="icon i-errors"></i>密码重置失败，请重新尝试！</p>');
					}
					obj.show();
					timename=setTimeout(function(){
						$(".tanchu").hide();
						$("#resetpwd"+userid).removeClass("disabled");
					},1000);
				}
			});
		}}, 
					{text:'取&nbsp;&nbsp;消',classes:'btn btn-s',click:function(){
						$("#resetpwd"+userid).removeClass("disabled");
					}}
		]
	});
};
</script>
</body>
</html>