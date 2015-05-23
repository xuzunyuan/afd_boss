<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% request.setAttribute("ctx", request.getContextPath());%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>基础类目管理-巨友利</title>
</head>
<body>
	<!--<div class="crumbs-box">
        <div class="crumbs">
            <h3>当前位置 &#58;</h3>
            <ul>
                <li><a href="#">BOSS</a>&#62;</li>
                <li><a href="#">类目管理</a>&#62;</li>
                <li>基础类目管理</li>
            </ul>
        </div>
    </div>crumbs-box end-->
    <div class="category-main">
    	<div class="category-main-left">
        	<input id="add_first" type="button" class="inputBtn" value="添加一级类目" >
        </div>
    	<!-- <div class="category-main-right">
        	<input id="showMode" type="button" class="inputBtn" value="(+)全部展开" >
        </div> -->
        <div id="0" class="clearfix"></div>
        <c:if test="${not empty(bcList)}">
    	<ul class="boos-ul c-m-ul">
        	<li class="boos-ul-th">
            	<div class="boos-ul-td c-m-w1">分类名称</div>
            	<div class="boos-ul-td c-m-w2">显示顺序</div>
            	<div class="boos-ul-td c-m-w3" style="width:140px">编码</div>
            	<div class="boos-ul-td c-m-w4" style="width:110px;">操作</div>
            </li>
            <!--1级列表-->
			<c:forEach var="bc" items="${bcList}" varStatus="fstatus">
			<li id="${bc.bcId}" class="boos-ul-li">
            	<div class="boos-ul-list cls-1 hasSub" >
                    <div class="boos-ul-td c-m-w1">
                    	<i class="arrowsDown"></i><i class="arrowsRight"></i><span>${bc.bcName}</span><input type="button" class="inputBtnA" value="添子类" >
                    </div>
                    <div class="boos-ul-td c-m-w2">
                    	<ul class="boos-ul-order">
                    		<c:choose>
                    			<c:when test="${not (fstatus.last || fstatus.first)}">
									<li class="b-u-o-1"></li>
									<li class="b-u-o-2"></li>
									<li class="b-u-o-3"></li>
									<li class="b-u-o-4"></li>
								</c:when>
								<c:when test="${fstatus.first and not fstatus.last}">
									<li class="b-u-o-1 dis"></li>
									<li class="b-u-o-2 dis"></li>
									<li class="b-u-o-3"></li>
									<li class="b-u-o-4"></li>
								</c:when>
								<c:when test="${fstatus.last and not fstatus.first}">
									<li class="b-u-o-1"></li>
									<li class="b-u-o-2"></li>
									<li class="b-u-o-3 dis"></li>
									<li class="b-u-o-4 dis"></li>
								</c:when>
								<c:when test="${fstatus.last and fstatus.first}">
									<li class="b-u-o-1 dis"></li>
									<li class="b-u-o-2 dis"></li>
									<li class="b-u-o-3 dis"></li>
									<li class="b-u-o-4 dis"></li>
								</c:when>
							</c:choose>
                    	</ul>
                    </div>
                    <div class="boos-ul-td c-m-w3" style="width:140px">${bc.bcCode}</div>
                    <div class="boos-ul-td c-m-w4" style="width:110px;"><a name="mod" href="javascript:void(0);">修改</a> | <a name="del" href="javascript:void(0);">删除</a></div>
                </div>
            </li>
            </c:forEach>
        </ul>
		</c:if>
    </div><!--category-main end-->

	<div id="mask_bg"></div>
	<div id="add_show" style="display: none">
		<form id="addForm" action="">
			<h2>增加类目名称<a href="javascript:void(0);" title="关闭">关闭</a></h2>
			<ul class="mask-form-list">
				<li>
					<div class="m-f-l-left">类目名称：</div>
					<div class="m-f-l-right">
						<input type="text" id="add_bcName" name="bcName" class="inputText">
						<input type="hidden" id="add_pBcId" name="pBcId"> 
						<input type="hidden" id="add_bcLevel" name="bcLevel"> 
						<input type="hidden" id="add_pathId" name="pathId"> 
						<input type="hidden" id="add_pathName" name="pathName"> 
					</div>
				</li>
				<li>
					<div class="m-f-l-btn">
						<input id="saveBC" type="button" class="inputBtn" value="保 存" onclick="addBCAjax();return false;">
						<input id="cancelBC" type="button" class="inputBtn" value="取 消">
					</div>
				</li>
			</ul>
		</form>
	</div>
	<div id="update_show" style="display: none">
		<form id="updateForm" action="">
			<h2>修改类目名称<a href="javascript:void(0);" title="关闭">关闭</a></h2>
			<ul class="mask-form-list">
				<li>
					<div class="m-f-l-left">原类目名称：</div>
					<div class="m-f-l-right">
						<strong id="srcCate"></strong>
					</div>
				</li>
				<li>
					<div class="m-f-l-left">新类目名称：</div>
					<div class="m-f-l-right">
						<input id="descCate" type="text" name="name" class="inputText">
						<input id="idCate" type="hidden" name="bcId" class="inputText">
						<input id="level" type="hidden"  name="level"> 
						<input id="pId" type="hidden"  name="pId"> 
					</div>
				</li>
				<li>
					<div class="m-f-l-btn">
						<input id="updateBC" type="button" class="inputBtn" value="保 存" onclick="updateBCAjax();return false;"> 
						<input id="upcanBC" type="button" class="inputBtn" value="取 消">
					</div>
				</li>
			</ul>
		</form>
	</div>


	<script type="text/javascript">
		var invChars = /[\\&\\<\\>\\'\\"]/im;
		
		$(function() {
			showHide($(".hasSub"), 2);
			orderBind($("ul.boos-ul-order li"));
			aBind();
			initAddSubClick();
		});

		function fetchSubCategory($elem, pId, level) {
			$.ajax({
				url : "${ctx}/category/bc/pList",
				type : "POST",
				data : {pId : pId},
				success : function(list) {
					//1:成功,0:失败
					if(list != null && list.length>0){
						 if(level == 2){
							 loadCategory2($elem, list);
						 }else if(level == 3){
							 loadCategory3($elem, list);
						 }
					}
				}
			});
		}
		
		function loadCategory3($elem, objList) {
			var ul = $("<ul class=\"boos-ul-2\"></ul>");
			$elem.append(ul);
			
			$.each(objList, function( index, cate ) {
			  var li = "<li id=\""+cate.bcId+"\">"+
              "<div class=\"boos-ul-list cls-2\">"+
	              "<div class=\"boos-ul-td c-m-w1\">"+
	              	"<i "+(index==0?"class=\"first\"></i>":"></i>")+"<span>"+cate.bcName+"</span>"+
	              "</div>"+
	              "<div class=\"boos-ul-td c-m-w2\">"+
	              	"<ul class=\"boos-ul-order\">";
					  	if(index!=objList.length-1 && index!=0){
		        			li += "<li class=\"b-u-o-1 \"></li><li class=\"b-u-o-2\"></li><li class=\"b-u-o-3\"></li><li class=\"b-u-o-4\"></li>";
		        		}else if(index==0 && objList.length>1){
	              			li += "<li class=\"b-u-o-1 dis\"></li><li class=\"b-u-o-2 dis\"></li><li class=\"b-u-o-3\"></li><li class=\"b-u-o-4\"></li>";
	              		}else if(index==objList.length-1 && index!=0){
	              			li += "<li class=\"b-u-o-1 \"></li><li class=\"b-u-o-2\"></li><li class=\"b-u-o-3 dis\"></li><li class=\"b-u-o-4 dis\"></li>";
	              		}else if(index==objList.length-1 && index==0){
	              			li += "<li class=\"b-u-o-1 dis\"></li><li class=\"b-u-o-2 dis\"></li><li class=\"b-u-o-3 dis\"></li><li class=\"b-u-o-4 dis\"></li>";
	              		}
	          li += "</ul>"+
	              "</div>"+
	              "<div class=\"boos-ul-td c-m-w3\" style=\"width:140px\">"+cate.bcCode+"</div>"+
              	  "<div class=\"boos-ul-td c-m-w4\" style=\"width:110px\"><a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
          	  "</div>"+
     	 	  "</li>";
     	 	  
     	 	  ul.append(li);
			});
			
			aBinding(ul.find(".c-m-w4 a"));
			orderBind(ul.find(".boos-ul-order li"));
		}
		
		function loadCategory2($elem, objList) {
			var ul = $("<ul class=\"boos-ul-1\"></ul>");
			$elem.append(ul);
			
			$.each(objList, function( index, cate ) {
			  var li = "<li id=\""+cate.bcId+"\" >"+
              "<div class=\"boos-ul-list cls-2 hasSub\">"+
	              "<div class=\"boos-ul-td c-m-w1\">"+
	              	"<i class=\"arrowsDown\"></i><i class=\"arrowsRight\"></i><span>"+cate.bcName+"</span><input type=\"button\" class=\"inputBtnA\" value=\"添子类\" >"+
	              "</div>"+
	              "<div class=\"boos-ul-td c-m-w2\">"+
	              	"<ul class=\"boos-ul-order\">";
					  	if(index!=objList.length-1 && index!=0){
		        			li += "<li class=\"b-u-o-1 \"></li><li class=\"b-u-o-2\"></li><li class=\"b-u-o-3\"></li><li class=\"b-u-o-4\"></li>";
		        		}else if(index==0 && objList.length>1){
	              			li += "<li class=\"b-u-o-1 dis\"></li><li class=\"b-u-o-2 dis\"></li><li class=\"b-u-o-3\"></li><li class=\"b-u-o-4\"></li>";
	              		}else if(index==objList.length-1 && index!=0){
	              			li += "<li class=\"b-u-o-1 \"></li><li class=\"b-u-o-2\"></li><li class=\"b-u-o-3 dis\"></li><li class=\"b-u-o-4 dis\"></li>";
	              		}else if(index==objList.length-1 && index==0){
	              			li += "<li class=\"b-u-o-1 dis\"></li><li class=\"b-u-o-2 dis\"></li><li class=\"b-u-o-3 dis\"></li><li class=\"b-u-o-4 dis\"></li>";
	              		}
	          li += "</ul>"+
	              "</div>"+
	              "<div class=\"boos-ul-td c-m-w3\" style=\"width:140px\">"+cate.bcCode+"</div>"+
              	  "<div class=\"boos-ul-td c-m-w4\" style=\"width:110px\"><a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
          	  "</div>"+
     	 	  "</li>";
     	 	  
     	 	  ul.append(li);
			});
			 
			showHide(ul.find(".hasSub"), 3);
			aBinding(ul.find(".c-m-w4 a"));
			orderBind(ul.find(".boos-ul-order li"));
			ul.find(".c-m-w1 > input").on("click", {bcLevel:3}, addSubClick);
		}
		
		function addComplete(id, name, code, level, pId) {
			if(level == 1){
				var $ul, $div=$("#0");
				
				if($div.next().is("ul")){
					$ul = $div.next();
				}else{
					$ul = $("<ul class=\"boos-ul c-m-ul c-m-ul1\"></ul>");
					$div.parent().append($ul);
					$ul.append("<li class=\"boos-ul-th\"><div class=\"boos-ul-td c-m-w1\">分类名称</div><div class=\"boos-ul-td c-m-w2\">显示顺序</div><div class=\"boos-ul-td c-m-w4\">操作</div></li>");
				}
				var len = $ul.find(" > li").length - 1;
				if(len > 1){
					$liList = $ul.find(" > li:last > div ul > li");
					if($liList.eq(2).hasClass("dis")){
						$liList.eq(2).removeClass("dis");
					}
					if($liList.eq(3).hasClass("dis")){
						$liList.eq(3).removeClass("dis");
					}
				} 
            	var $li = $("<li id=\""+id+"\" class=\"boos-ul-li\">"+
				              "<div class=\"boos-ul-list cls-1 hasSub\">"+
					              "<div class=\"boos-ul-td c-m-w1\">"+
					              	"<i class=\"arrowsDown\"></i><i class=\"arrowsRight\"></i><span>"+name+"</span><input type=\"button\" class=\"inputBtnA\" value=\"添子类\" >"+
					              "</div>"+
					              "<div class=\"boos-ul-td c-m-w2\">"+
					              	"<ul class=\"boos-ul-order\">"+
					              		"<li class=\"b-u-o-1\"></li><li class=\"b-u-o-2\"></li><li class=\"b-u-o-3 dis\"></li><li class=\"b-u-o-4 dis\"></li>"+
					 				"</ul>"+
					              "</div>"+
					              "<div class=\"boos-ul-td c-m-w3\" style=\"width:140px\">"+code+"</div>"+
				              	  "<div class=\"boos-ul-td c-m-w4\" style=\"width:110px\"><a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
				          	  "</div>"+
				 	 	  	"</li>"); 
				$ul.append($li);
				
				resetOrderFlag($ul);
				
				showHide($li.find(".hasSub"), 2);
				aBinding($li.find(".c-m-w4 a"));
				orderBind($li.find(".boos-ul-order li"));
				$li.find(".c-m-w1 > input").on("click", {bcLevel:2}, addSubClick);
			}else if(level == 2){
				var $li = $("<li id=\""+id+"\" >"+
		              			"<div class=\"boos-ul-list cls-2 hasSub\">"+
			              			"<div class=\"boos-ul-td c-m-w1\">"+
			              				"<i class=\"arrowsDown\"></i><i class=\"arrowsRight\"></i><span>"+name+"</span><input type=\"button\" class=\"inputBtnA\" value=\"添子类\" >"+
			              			"</div>"+
			              			"<div class=\"boos-ul-td c-m-w2\">"+
						              	"<ul class=\"boos-ul-order\">"+
						              		"<li class=\"b-u-o-1 dis\"></li><li class=\"b-u-o-2 dis\"></li><li class=\"b-u-o-3 dis\"></li><li class=\"b-u-o-4 dis\"></li>"+
						           		"</ul>"+
					                "</div>"+
					                "<div class=\"boos-ul-td c-m-w3\" style=\"width:140px\">"+code+"</div>"+
					              	"<div class=\"boos-ul-td c-m-w4\" style=\"width:110px\"><a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
		          	  			"</div>"+
		     	 	  		"</li>");
				
				var $pId = $("#"+pId);
				var $ul = null;
				if($pId.children().length == 1){
					$ul = $("<ul class=\"boos-ul-1\"></ul>").append($li);
				}else if($pId.children().length > 1){
					$ul = $pId.children(":nth-child(2)");
					var len = $ul.find(" > li").length;
					if(len > 1){
						$liList = $ul.find(" > li:last > div ul > li");
						if($liList.eq(2).hasClass("dis")){
							$liList.eq(2).removeClass("dis");
						}
						if($liList.eq(3).hasClass("dis")){
							$liList.eq(3).removeClass("dis");
						}
					} 
					$ul.append($li);
				}
				
				$pId.append($ul);
				resetOrderFlag($ul);
				
				showHide($li.find(".hasSub"), 3);
				aBinding($li.find(".c-m-w4 a"));
				orderBind($li.find(".boos-ul-order li"));
				$li.find(".c-m-w1 > input").on("click", {bcLevel:3}, addSubClick);
			}else if(level == 3){
				var $li = $("<li id=\""+id+"\">"+
	              "<div class=\"boos-ul-list cls-2\">"+
		              "<div class=\"boos-ul-td c-m-w1\">"+
		              	"<i></i><span>"+name+"</span>"+
		              "</div>"+
		              "<div class=\"boos-ul-td c-m-w2\">"+
		              	"<ul class=\"boos-ul-order\">"+
		              		"<li class=\"b-u-o-1 \"></li><li class=\"b-u-o-2\"></li><li class=\"b-u-o-3 dis\"></li><li class=\"b-u-o-4 dis\"></li>"+
		          		"</ul>"+
		              "</div>"+
		              "<div class=\"boos-ul-td c-m-w3\" style=\"width:140px\">"+code+"</div>"+
	              	  "<div class=\"boos-ul-td c-m-w4\" style=\"width:110px\"><a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
	          	  "</div>"+
	     	 	  "</li>");
				
				var $pId = $("#"+pId);
				var $ul = null;
				 
				if($pId.children().length == 1){
					$ul = $("<ul class=\"boos-ul-2\"></ul>").append($li);
				}else if($pId.children().length > 1){
					$ul = $pId.children(":nth-child(2)");
					var len = $ul.find(" > li").length;
					if(len > 1){
						$liList = $ul.find(" > li:last > div ul > li");
						if($liList.eq(2).hasClass("dis")){
							$liList.eq(2).removeClass("dis");
						}
						if($liList.eq(3).hasClass("dis")){
							$liList.eq(3).removeClass("dis");
						}
					} 
					$ul.append($li);
				}
				$pId.append($ul);
				resetOrderFlag($ul);
				
				aBinding($li.find(".c-m-w4 a"));
				orderBind($li.find(".boos-ul-order li"));
			}
		}
		
		function showPop(id) {
			var objW = $(window);
			var objP = $(id);
			var brsW = objW.width();
			var brsH = objW.height();
			var sclL = objW.scrollLeft();
			var sclT = objW.scrollTop();
			var popW = objP.width();
			var popH = objP.height();
			var left = sclL + (brsW - popW) / 2;
			var top = sclT + (brsH - popH) / 2;
			objP.css({
				"left" : left,
				"top" : top
			});
		}
		//窗口改变大小时,调整弹出层位置
		$(window).resize(function() {
			if ($("#add_show").is(":visible")) {
				showPop("#add_show");
			}
			if ($("#update_show").is(":visible")) {
				showPop("#update_show");
			}
		});

		function aBind() {
			aBinding($(".c-m-w4 a"));
			
			$("#update_show h2 a,#upcanBC").click(function() {
				$("#descCate").val("");
				$("#mask_bg").removeClass("mask-bg");
				$("#update_show").removeClass("mask-show").hide();
			});
		}
		function aBinding(jObj) {
			jObj.on("click", function(event){
				event.stopPropagation();
				
				var name = $(this).parent().prev().prev().prev().children("span").text();
				var  $liBcId = $(this).parents("li:first");
				var $ul = $liBcId.parent();
				
				var bId = $liBcId.attr("id");
				var pId = 0;
				var level = 1;
				if($ul.hasClass("boos-ul-1")){
					level = 2;
					pId = $liBcId.parents("li:first").attr("id");
				}else if($ul.hasClass("boos-ul-2")){
					level = 3;
					pId = $liBcId.parents("li:first").attr("id");
				}
				
				if(this.name == "mod"){
					updateBC(bId, name, level, pId);
				}else if(this.name == "del"){
					deleteBC(bId, level, pId);
				}
			});
		}
		
		function addSubClick(event){
			event.stopPropagation();
			
			$("#mask_bg").addClass("mask-bg");
			showPop("#add_show");
			$("#add_show").addClass("mask-show").show();
			$("#add_bcName").focus();
			
			$("#add_bcLevel").val(event.data.bcLevel);
			
			if(event.data.bcLevel == 1){
				$("#add_pBcId").val(0);
				$("#add_pathId").val("");
				$("#add_pathName").val("");
			}else if(event.data.bcLevel==2 || event.data.bcLevel==3){
				var jpElem = $(event.target).parents("li:first");
				var pathName = $(event.target).prev().text();
				var pBcId = jpElem.attr("id");
				var pathId = pBcId;
				
				//先加载子类目
				if(jpElem.children().length == 1){
					fetchSubCategory(jpElem, pBcId, event.data.bcLevel);
				}
				
				if(event.data.bcLevel == 3){
					jpElem = jpElem.parents("li:first");
					pathName = jpElem.children("div:first").children("div:first").children("span").text() + "|" +pathName;
					pathId = jpElem.attr("id") + "|" + pBcId;
				}
				 
				$("#add_pBcId").val(pBcId);
				$("#add_pathId").val(pathId);
				$("#add_pathName").val(pathName);
			}
		} 
		
		function addBCAjax() {
			var name = $.trim($("#add_bcName").val());
			if(name.length>0){
				if(!invChars.test(name)){
					$.ajax({
						url:"${ctx}/category/bc/bcAdd",
						type: "POST",
						data: $('#addForm').serialize(),
						success:function(re){
							//1:成功,0:失败,-1:名称已存在,-2:名称不能为空
							if(re.indexOf("_") >= 0){
								var arr = re.split("_");
								alert("增加成功!");
								$("#cancelBC").trigger("click");
								addComplete(arr[1], name, arr[2], $("#add_bcLevel").val(), $("#add_pBcId").val());
								//reloadByPid($("#add_bcLevel").val(), $("#add_pBcId").val());
								$("#add_bcName").val("");
							}else if(re == -1){
								alert("类目已存在!");
							}else if(re == -2){
								alert("名称不能为空!");
							}else if(re == -3){
								alert("编码已达到最大值");
							}else if(re == 0){
								alert("增加失败!");
							}						
						}
					}); 
				}else{
					alert("不能包含特殊字符&、<、>、'、\"、/");
				}
			}else{
				alert("请输入名称!");
			}
		}
		
		function initAddSubClick(){
			$("#add_first").on("click", {bcLevel:1}, addSubClick);
			$(".c-m-w1 > input").on("click", {bcLevel:2}, addSubClick);
			
			$("#add_show h2 a,#cancelBC").click(function(){
				$("#add_bcName").val("");
				$("#mask_bg").removeClass("mask-bg");
				$("#add_show").removeClass("mask-show").hide();
			});
		}
		
		function updateBC(id, name, level, pId) {
			$("#srcCate").text(name);
			$("#idCate").val(id);
			$("#level").val(level);
			$("#pId").val(pId);
			
			$("#mask_bg").addClass("mask-bg");
			$("#update_show").addClass("mask-show").show();
			showPop("#update_show");
			$("#descCate").focus();
		}
		function updateBCAjax() {
			var srcName = $("#srcCate").text();
			var name = $.trim($("#descCate").val());
			 
			if (name.length > 0) {
				if (name != srcName) {
					if(!invChars.test(name)){
						$.ajax({
							url : "${ctx}/category/bc/bcUpdate",
							type : "POST",
							data : $('#updateForm').serialize(),
							success : function(re) {
								//1:成功,0:失败,-1:名称已存在,-2:名称不能为空
								switch (re) {
								case 1:
									$("#upcanBC").trigger("click");
									alert("修改成功!");
									$("#"+$("#idCate").val()).children("div:first").children("div:first").children("span").text(name);
									//reloadByPid($("#level").val(), $("#pId").val());
									break;
								case 0:
									alert("修改失败!");
									break;
								case -2:
									alert("名称不能为空!");
									break;
								case -1:
									alert("类目已存在!");
								}
							}
						});
					}else{
						alert("不能包含特殊字符&、<、>、'、\"、/");
					}
				} else {
					alert("请输入新的名称!");
					$("#descCate").focus();
				}
			} else {
				alert("请输入名称!");
				$("#descCate").focus();
			}
		}
		
		function orderAction(sbcId, dbcId, level, pId) {
			var result = 0;
			$.ajax({
				url : "${ctx}/category/bc/bcOrder",
				type : "POST",
				async : false,
				data : {
					sbcId : sbcId,
					dbcId : dbcId
				},
				success : function(re) {
					result = re;
					if(re == 0){
						alert("失败!");
					}
				}
			});
			
			return result;
		}
		
		function orderBind(jLiSet) {
			jLiSet.click(function(event) {
				event.stopPropagation();
				var level = 1;
				var pId = 0;
				
				var curLiObj = $(this);
				 
				if (!curLiObj.hasClass("dis")) {
					var $liBcId = curLiObj.parents("li:first");
					var curBcid = $liBcId.attr("id");
					var descBcid = 0;

					var $ul = $liBcId.parent();
					if($ul.hasClass("boos-ul-1")){
						level = 2;
						pId = $liBcId.parents("li:first").attr("id");
					}else if($ul.hasClass("boos-ul-2")){
						level = 3;
						pId = $liBcId.parents("li:first").attr("id");
					}
					
					if (curLiObj.hasClass("b-u-o-1")) {
						if (level == 1) {
							descBcid = $ul.children("li:nth-child(2)").attr("id");
						} else {
							descBcid = $ul.children("li:first").attr("id");
						}
					} else if (curLiObj.hasClass("b-u-o-2")) {
						descBcid = $liBcId.prev().attr("id");
					} else if (curLiObj.hasClass("b-u-o-3")) {
						descBcid = $liBcId.next().attr("id");
					} else if (curLiObj.hasClass("b-u-o-4")) {
						descBcid = $ul.children("li:last").attr("id");
					}
					
					var result = orderAction(curBcid, descBcid, level, pId);
					if(result == 1){
						if (curLiObj.hasClass("b-u-o-1")) {
							if (level == 1) {
								$ul.children("li:nth-child(2)").before($liBcId);
							} else {
								$ul.children("li:first").before($liBcId);
							}
						} else if (curLiObj.hasClass("b-u-o-2")) {
							$liBcId.prev().before($liBcId);
						} else if (curLiObj.hasClass("b-u-o-3")) {
							$liBcId.next().after($liBcId);
						} else if (curLiObj.hasClass("b-u-o-4")) {
							$liBcId.parent().children("li:last").after($liBcId);
						}
						
						$ul.find(".dis").removeClass("dis");
						resetOrderFlag($ul);
					}
				}
			});
		}

		function showHide(jObj, level){
			jObj.click(function(){
				var $pObj = $(this).parent();
				 
				if($pObj.children().length == 1){
					fetchSubCategory($pObj, $pObj.attr("id"), level);
				}
				
				$pObj.hasClass("act")?$pObj.removeClass("act"):$pObj.addClass("act");
			});
		}
		
		
		function deleteBC(bcId, level, pId) {
			if (window.confirm("确定要删除吗?")) {
				$.ajax({
					url : "${ctx}/category/bc/bcDelete?bcId=" + bcId,
					type : "POST",
					success : function(data) {
						//1:成功,0:失败,-1:存在子类目不允许删除,-2:类目不存在,-3:已关联基本类目不允许删除
						switch (data) {
						case 1:
							alert("删除成功!");
							deleteComplete(bcId);
							//reloadByPid(level, pId);
							break;
						case 0:
							alert("删除失败!");
							break;
						case -3:
							alert("已关联签约类目不允许删除!");
							break;
						case -4:
							alert("已关联销售类目不允许删除!");
							break;
						case -5:
							alert("已关联品牌不允许删除!");
							break;
						case -2:
							alert("类目不存在!");
							break;
						case -1:
							alert("存在子类目不允许删除!");
						}

					}
				});
			}
		}
		
		function deleteComplete(liId) {
			var len = 0;
			var $ul = $("#"+liId).parent();
			
			if($ul.hasClass("boos-ul")){
				len = $ul.find(" > li").length - 1;
			}else{
				len = $ul.find(" > li").length;
			}
			
			if(len == 1){
				$ul.remove();
			}else{
     			$("#"+liId).remove();
 				resetOrderFlag($ul);
			}
		}
		function resetOrderFlag($ul) {
			var len = 0;
			if($ul.hasClass("boos-ul")){
				len = $ul.find(" > li").length - 1;
			}else{
				len = $ul.find(" > li").length;
				if($ul.hasClass("boos-ul-2")){
					$ul.find(".first").removeClass("first");
					$ul.find("li:first > div > div > i").addClass("first");
				}
			}
			
			if(len == 1){
				var $liList;
				if($ul.hasClass("boos-ul")){
					$liList = $ul.find(" > li:eq(1) > div ul > li");
				}else{
					$liList = $ul.find(" > li:first > div ul > li");
				}
				if(!$liList.eq(0).hasClass("dis")){
					$liList.eq(0).addClass("dis");
				}
				if(!$liList.eq(1).hasClass("dis")){
					$liList.eq(1).addClass("dis");
				}
				if(!$liList.eq(2).hasClass("dis")){
					$liList.eq(2).addClass("dis");
				}
				if(!$liList.eq(3).hasClass("dis")){
					$liList.eq(3).addClass("dis");
				}
			}else{
				var $liList;
				//顶部
				if($ul.hasClass("boos-ul")){
					$liList = $ul.find(" > li:eq(1) > div ul > li");
				}else{
					$liList = $ul.find(" > li:first > div ul > li");
				}
				if(!$liList.eq(0).hasClass("dis")){
					$liList.eq(0).addClass("dis");
				}
				if(!$liList.eq(1).hasClass("dis")){
					$liList.eq(1).addClass("dis");
				}
				if($liList.eq(2).hasClass("dis")){
					$liList.eq(2).removeClass("dis");
				}
				if($liList.eq(3).hasClass("dis")){
					$liList.eq(3).removeClass("dis");
				}
				//底部
				$liList = $ul.find(" > li:last > div ul > li");
				
				if($liList.eq(0).hasClass("dis")){
					$liList.eq(0).removeClass("dis");
				}
				if($liList.eq(1).hasClass("dis")){
					$liList.eq(1).removeClass("dis");
				}
				if(!$liList.eq(2).hasClass("dis")){
					$liList.eq(2).addClass("dis");
				}
				if(!$liList.eq(3).hasClass("dis")){
					$liList.eq(3).addClass("dis");
				}
			}
		}
		function reloadByPid(level, pId) {
			if(level == 1){
				window.location.href='${ctx}/category/bc/bcList';
			}else if(level==2 || level==3){
				var $elem = $("#"+pId);
				 
				if($elem.children().length > 1){
					$elem.children(":nth-child(2)").remove();
				}
				
				fetchSubCategory($elem, pId, level);
			}
		}
	</script>
</body>
</html>