<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%request.setAttribute("ctx", request.getContextPath());%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>销售类目管理-一网全城</title>
</head>
<body>
   	<div class="crumbs-box">
           <div class="crumbs">
               <h3>当前位置 &#58;</h3>
               <ul>
                   <li><a href="#">BOSS</a>&#62;</li>
                   <li><a href="#">类目管理</a>&#62;</li>
                   <li>关联类目管理</li>
               </ul>
           </div>
       </div><!--crumbs-box end-->
       <div class="category-main">
       	<div class="promptBox">
               <label>提示：</label><div class="promptInfo">关联类目是指将关联源（基本类目）中的一个或多类目和关联类目（销售类目）进行关联，以达到促进销售的目的。</div>
           </div>
           <div class="formTitle category">
               <i></i>
               <span class="title">您当前选择的类目是：<strong>${fn:replace(sc.pathName,'|',' \\ ')} \ ${sc.scName}</strong></span>
             <a href="#" class="inputBtn_a" onclick="window.location.href='${ctx}/category/sc/scList'">修&nbsp;&nbsp;&nbsp;&nbsp;改</a>
           </div>
           <div class="link-category">
           	<div class="link-category-choose">
               	<div class="l-c-title">
                   	关联类目：销售类目
                   </div>
                   <div class="l-c-con">
                   	<ul class="l-c-list-1">
                       	<li class="act">
                           	<div id="d_first" class="l-c-text cls-1"><i class="arrowsDown"></i><i class="arrowsRight"></i>${fn:substring(sc.pathName, 0, fn:indexOf(sc.pathName, '|')-1)}</div>
                               <ul class="l-c-list-2">
                                   <li class="act">
                                       <div id="d_second" class="l-c-text cls-2"><i class="arrowsDown"></i><i class="arrowsRight"></i>${fn:substring(sc.pathName, fn:indexOf(sc.pathName, '|')+1, fn:length(sc.pathName))}</div>
                                       <ul class="l-c-list-3">
                                           <li>
                                               <div id="d_third" class="l-c-text"><i class="first"></i>${sc.scName}</div>
                                           </li>
                                       </ul>
                                   </li>
                               </ul>
                            </li>
                        </ul>
                   </div>
               </div><!--link-category-choose end-->
               <div class="link-category-source">
               	   <div class="l-c-title">关联源：基础类目（ <b>可关联多个基础类目</b>）</div>
                   <div class="l-c-con">
                   	   <div class="l-c-top">
                       		<input type="text" placeholder="查找类目" class="l-c-inputText" ><a id="search" href="javascript:void(0);" class="l-c-a">查找</a>
                       </div>
                       <ul class="l-c-list-1">
                       		<c:if test="${!empty(bcList)}">
							<c:forEach var="bc" items="${bcList}" varStatus="fstatus">
                       		<li class="hasSub">
                           		<div class="l-c-text"><i class="arrowsDown"></i><i class="arrowsRight"></i>${bc.bcName} ( <em>${fn:length(bc.categories)}</em> )</div>
                               	<ul class="l-c-list-2">
                               	   <c:if test="${!empty(bc.categories)}">
								   <c:forEach var="sbc" items="${bc.categories}" varStatus="sstatus">
                                   <li class="hasSub">
                                       <div class="l-c-text"><i class="arrowsDown"></i><i class="arrowsRight"></i>${sbc.bcName} ( <em>${fn:length(sbc.categories)}</em> )</div>
                                       <ul class="l-c-list-3">
                                       	   <c:if test="${!empty(sbc.categories)}">
										   <c:forEach var="tbc" items="${sbc.categories}" varStatus="tstatus">
                                           <li>
                                               <div name="${tbc.bcId}" class="l-c-text"><i <c:if test="${tstatus.first}">class="first"</c:if>></i>${tbc.bcName}</div>
                                           </li>
                                           </c:forEach>
										   </c:if>
                                       </ul>
                                   </li>
                                   </c:forEach>
								   </c:if>
                               	</ul>
                            </li>
                            </c:forEach>
							</c:if>
                       </ul>
                   </div>
               </div><!--link-category-source end-->
           </div><!--link-category end-->
       </div><!--category-main end-->
		
	<script type="text/javascript">
		 
		$(function() {
			initBind();
			ulBind();
			searchClickBind();
			
			$ulClone = $(".link-category-source .l-c-list-1").clone(true, true);
		});
	
		function searchClickBind(){
			$("#search").click(function(event){
				event.preventDefault();
				var $ul = $(this).parent().next();
				$ul.empty();
				$ul.append($ulClone.clone(true, true).contents());
				
				var se = $.trim($(this).prev().val());
				if(se.length > 0){
					var $sliList = $ul.find(".l-c-list-3 > li");
					$.each($sliList, function(key, value) {
						if($(value).children(":first:contains('"+se+"')").length==0){
							$(value).remove();
						}
					});
					var length = 0;
					var $sliList = $ul.find(".l-c-list-3");
					$.each($sliList, function(key, value) {
						length = $(value).children("li").length;
						if(length == 0){
							$(value).parent().remove();
						}else{
							$(value).prev().children("em").text(length);
						}
					});
					var $sliList = $ul.find(".l-c-list-2");
					$.each($sliList, function(key, value) {
						length = $(value).children("li").length;
						if(length == 0){
							$(value).parent().remove();
						}else{
							$(value).prev().children("em").text(length);
						}
					});
					var $sliList = $ul.find(".l-c-list-1");
					$.each($sliList, function(key, value) {
						if($(value).children("li").length==0){
							$(value).parent().remove();
						}
					});
				}
			});
		}
	
		function bindAction(event){
			event.stopPropagation();
			var param = {scId:"${sc.scId}", bcId:event.data.id, type:event.data.type};
			
			$.ajax({
				url:"${ctx}/category/sc/sbBind",
				type: "POST",
				data: param,
				success:function(re){
					//1:成功,0:失败
					switch(re){
						case 1:
							if(param.type == 1){
								alert("添加成功!");
								$(event.target).val("删除关联").off("click").on("click", {id:param.bcId,type:2},bindAction);
								$(event.target).parent().addClass("l-c-choose");
							}else if(param.type == 2){
								alert("删除成功!");
								$(event.target).val("添加关联").off("click").on("click", {id:param.bcId,type:1},bindAction);
								$(event.target).parent().removeClass("l-c-choose");
							}
					  		break;
						case 0:
							alert("操作失败!");
					  		break;
					};

				}
			}); 
		}
		
		function initBind(){
			var divList = $(".link-category-source .l-c-list-3 div");
			var bindList = $.parseJSON("${bcIds}");
			
			var delHtml = '<input type="button" class="l-c-inputBtn" value="删除关联" />';
			var addHtml = '<input type="button" class="l-c-inputBtn" value="添加关联" />';
			$.each( divList, function(key, value) {
				var id  = $(value).attr("name");
				if($.inArray(parseInt(id), bindList)==-1){
					$(value).append(addHtml);
					$(value).children("input").on("click", {id:id,type:1}, bindAction);
				}else{
					$(value).addClass("l-c-choose").append(delHtml);
					$(value).children("input").on("click", {id:id,type:2}, bindAction);
				}
			});
		}
		
		function ulBind(){
			$("#d_first,#d_second").click(function(event){
				 
				if(this.id=="d_second"){
					event.stopPropagation();
				}
				
				if($(this).parent().hasClass("act")){
					$(this).parent().removeClass("act");
				}else{
					$(this).parent().addClass("act");
				}
			});
			
			$(".hasSub").click(function(event){
				if($(this).parent().hasClass("l-c-list-2")){
					event.stopPropagation();
				}
				
				if($(this).hasClass("act")){
					$(this).removeClass("act");
				}else{
					$(this).addClass("act");
				}
			});
		}
	</script>
</body>
</html>