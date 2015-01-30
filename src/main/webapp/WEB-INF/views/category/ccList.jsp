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
<title>签约类目管理-一网全城</title>
</head>
<body>
	<!--crumbs-box end-->
	<div class="crumbs-box">
		<div class="crumbs">
			<h3>当前位置 &#58;</h3>
			<ul>
				<li><a href="#">BOSS</a>&#62;</li>
				<li><a href="#">类目管理</a>&#62;</li>
				<li>签约类目管理</li>
			</ul>
		</div>
	</div>
	<!--crumbs-box end-->
    <div class="category-main">
    	<div class="category-main-left">
        	<input id="add_first" type="button" class="inputBtn" value="添加一级类目" >
        </div>
    	<!-- <div class="category-main-right">
        	<input id="showMode" type="button" class="inputBtn" value="(+)全部展开" >
        </div> -->
        <div id="0" class="clearfix"></div>
        <c:if test="${!empty(ccList)}">
    	<ul class="boos-ul c-m-ul c-m-ul1">
        	<li class="boos-ul-th">
            	<div class="boos-ul-td c-m-w1">分类名称</div>
            	<div class="boos-ul-td c-m-w2">显示顺序</div>
            	<div class="boos-ul-td c-m-w3" style="width:110px">编码</div>
            	<div class="boos-ul-td c-m-w4" style="width:140px;">操作</div>
            </li>
            <!--1级列表-->
			<c:forEach var="cc" items="${ccList}" varStatus="fstatus">
        	<li id="${cc.ccId}" class="boos-ul-li">
            	<div class="boos-ul-list cls-1 hasSub">
                    <div class="boos-ul-td c-m-w1">
                    	<i class="arrowsDown"></i><i class="arrowsRight"></i><span>${cc.ccName}</span><input name="${cc.ccId}_${cc.ccName}_${fn:length(cc.categories)}" type="button" class="inputBtnA" value="添子类" >
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
                    <div class="boos-ul-td c-m-w3" style="width:110px">${cc.ccCode}</div>
                    <div class="boos-ul-td c-m-w4" style="width:140px;"><a name="mod" href="javascript:void(0);">修改</a> | <a name="del" href="javascript:void(0);">删除</a></div>
                </div>
            </li>
            </c:forEach>
        </ul>
        </c:if>
    </div><!--category-main end-->
	
	<div id="mask_bg"></div>
	<div id="add_show" style="display:none">
		<h2>增加类目名称<a href="javascript:" title="关闭">关闭</a></h2>
	    <form id="addForm" action="">
	    <ul class="mask-form-list">
	        <li>
	        	<div class="m-f-l-left">类目名称：</div>
	            <div class="m-f-l-right">
	            	<input type="text" id="add_ccName" name="ccName" class="inputText">
	            	<input type="hidden" id="add_pCcId" name="pCcId" >
	            	<input type="hidden" id="add_ccLevel" name="ccLevel" >
	            	<input type="hidden" id="add_pathId" name="pathId" >
	            	<input type="hidden" id="add_pathName" name="pathName" >
	            </div>
	        </li>
	        <li>
	        	<div class="m-f-l-btn">
	            	<input id="saveCC" type="button" class="inputBtn" value="保 存" >
	            	<input id="cancelCC" type="button" class="inputBtn" value="取 消" >
	            </div>
	        </li>
	    </ul>
	    </form>
	</div>
	<div id="update_show" style="display:none">
	    <form id="updateForm" action="">
		<h2>修改类目名称<a href="javascript:" title="关闭">关闭</a></h2>
	    <ul class="mask-form-list">
	        <li>
	        	<div class="m-f-l-left">原类目名称：</div>
	            <div class="m-f-l-right"><strong id="srcCate"></strong></div>
	        </li>
	        <li>
	        	<div class="m-f-l-left">新类目名称：</div>
	            <div class="m-f-l-right">
	            	<input id="descCate" type="text" name="name" class="inputText">
	            	<input id="idCate" type="hidden" name="ccId" class="inputText">
	            </div>
	        </li>
	        <li>
	        	<div class="m-f-l-btn">
	            	<input id="updateCC" type="button" class="inputBtn" value="保 存" onclick="updateCCAjax();return false;">
	            	<input id="upcanCC" type="button" class="inputBtn" value="取 消" >
	            </div>
	        </li>
	    </ul>
	    </form>
	</div>
	<script type="text/javascript">
		var invChars = /[\\&\\<\\>\\'\\"\\/]/im;
		
		$(function() {
			showHide($(".hasSub"));
			orderBind($("ul.boos-ul-order li"));
			aBind();
			initAddSubClick();
		});
		
		function showHide(jObj){
			jObj.click(function(){
				var $pObj = $(this).parent();
				 
				if($pObj.children().length == 1){
					fetchSubCategory($pObj);
				}
				
				$pObj.hasClass("act")?$pObj.removeClass("act"):$pObj.addClass("act");
			});
		}
		
		function fetchSubCategory($li) {
			var pId = $li.attr("id");
			
			$.ajax({
				url : "${ctx}/category/cc/pList",
				type : "POST",
				data : {pId : pId},
				success : function(list) {
					//1:成功,0:失败
					if(list != null && list.length>0){
						 loadSecondCategory($li, list);
					}
				}
			});
		}
		
		function loadSecondCategory($li, objList) {
			var $ul = $("<ul class=\"boos-ul-1\"></ul>");
			$li.append($ul);
			
			$.each(objList, function( index, cate ) {
			  var li = "<li id=\""+cate.ccId+"\" >"+
              "<div class=\"boos-ul-list cls-2\">"+
	              "<div class=\"boos-ul-td c-m-w1\">"+
	              	"<span>"+cate.ccName+"</span>"+
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
	              "<div class=\"boos-ul-td c-m-w3\" style=\"width:110px\">"+cate.ccCode+"</div>"+
              	  "<div class=\"boos-ul-td c-m-w4\" style=\"width:140px\"><a name=\"bind\" href=\"javascript:void(0);\">关联类目</a> | <a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
          	  "</div>"+
     	 	  "</li>";
     	 	  
     	 	  $ul.append(li);
			});
			 
			aBinding($ul.find(".c-m-w4 a"));
			orderBind($ul.find(".boos-ul-order li"));
		}
		function aBinding(jObj) {
			jObj.on("click", function(event){
				event.stopPropagation();
				
				var name = $(this).parent().prev().prev().prev().children("span").text();
				var  $liCcId = $(this).parents("li:first");
				var $ul = $liCcId.parent();
				
				var cId = $liCcId.attr("id");
				var pId = 0;
				var level = 1;
				
				if($ul.hasClass("boos-ul-1")){
					level = 2;
					pId = $liCcId.parents("li:first").attr("id");
				}
				
				if(this.name == "mod"){
					updateCC(cId, name, level, pId);
				}else if(this.name == "del"){
					deleteCC(cId);
				}else if(this.name == "bind"){
					window.location.href="${ctx}/category/cc/ccbcBind?ccId="+cId;
				}
			});
		}
		function showPop(id){
			var objW=$(window);
			var objP=$(id);
			var brsW=objW.width();
			var brsH=objW.height();
			var sclL=objW.scrollLeft();
			var sclT=objW.scrollTop();
			var popW=objP.width();
			var popH=objP.height();
			var left=sclL+(brsW-popW)/2;
			var top=sclT+(brsH-popH)/2;
			objP.css({"left":left,"top":top});
		}
		//窗口改变大小时,调整弹出层位置
		$(window).resize(function(){
			if($("#add_show").is(":visible")){
				showPop("#add_show");
			};
			if($("#update_show").is(":visible")){
				showPop("#update_show");
			};
		}); 
	
		function aBind() {
			aBinding($(".c-m-w4 a"));
			
			$("#update_show h2 a,#upcanCC").click(function() {
				$("#descCate").val("");
				$("#mask_bg").removeClass("mask-bg");
				$("#update_show").removeClass("mask-show").hide();
			});
		}
		
		function updateCC(cId, name, level, pId){
			$("#srcCate").text(name);
			$("#idCate").val(cId);
			
			$("#mask_bg").addClass("mask-bg");
			$("#update_show").addClass("mask-show").show();
			showPop("#update_show");
			$("#descCate").focus();
		}
		function updateCCAjax(){
			var srcName = $("#srcCate").text();
			var name = $.trim($("#descCate").val());
			if(name.length > 0){
				if(name != srcName){
					if(!invChars.test(name)){
						$.ajax({
							url:"${ctx}/category/cc/ccUpdate",
							type: "POST",
							data: $('#updateForm').serialize(),
							success:function(re){
								//1:成功,0:失败,-1:名称已存在,-2:名称不能为空
								switch(re){
									case 1:
										$("#upcanCC").trigger("click");
										alert("修改成功!");
										$("#"+$("#idCate").val()).children("div:first").children("div:first").children("span").text(name);
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
				}else{
					alert("请输入新的名称!");
					$("#descCate").focus();
				}
			}else{
				alert("请输入名称!");
				$("#descCate").focus();
			}
		}
		
		function addSubClick(event){
			event.stopPropagation();
			
			$("#mask_bg").addClass("mask-bg");
			var $form = $("#add_show");
			showPop("#add_show");
			$form.addClass("mask-show").show();
			$("#add_ccName").focus();
			
			$("#add_ccLevel").val(event.data.ccLevel);
			
			if(event.data.ccLevel == 1){
				$("#add_pCcId").val(0);
				$("#add_pathId").val("");
				$("#add_pathName").val("");
			}else if(event.data.ccLevel == 2){
				var jpElem = $(event.target).parents("li:first");
				var pCcId = jpElem.attr("id");
				var pathName = $(event.target).prev().text();
				
				$("#add_pCcId").val(pCcId);
				$("#add_pathId").val(pCcId);
				$("#add_pathName").val(pathName);
				
				//先加载子类目
				if(jpElem.children().length == 1){
					fetchSubCategory(jpElem, pCcId, 2);
				}
			}
		} 
		
		function initAddSubClick(){
			$("#add_first").on("click", {ccLevel:1}, addSubClick);
			$(".c-m-w1 > input").on("click", {ccLevel:2}, addSubClick);
			
			$("#add_show h2 a,#cancelCC").click(function(){
				$("#add_ccName").val("");
				$("#mask_bg").removeClass("mask-bg");
				$("#add_show").removeClass("mask-show").hide();
			});
			
			$("#saveCC").click(function(){
				var name = $.trim($("#add_ccName").val());
				if(name.length>0){
					if(!invChars.test(name)){
						$.ajax({
							url:"${ctx}/category/cc/ccAdd",
							type: "POST",
							data: $('#addForm').serialize(),
							success:function(re){
								
								//1:成功,0:失败,-1:名称已存在,-2:名称不能为空
								if(re.indexOf("_") != -1){
									var arr = re.split("_");
									alert("增加成功!");
									$("#cancelCC").trigger("click");
									addComplete(arr[1], name, arr[2], $("#add_ccLevel").val(), $("#add_pCcId").val());
									$("#add_ccName").val("");
								}else if(re == -1){
									alert("类目已存在!");
								}else if(re == -2){
									alert("名称不能为空!");
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
			});
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
					              "<div class=\"boos-ul-td c-m-w3\" style=\"width:110px\">"+code+"</div>"+
					              "<div class=\"boos-ul-td c-m-w4\" style=\"width:140px\"><a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
				          	  "</div>"+
				 	 	  	"</li>"); 
				$ul.append($li);
				
				resetOrderFlag($ul);
				
				showHide($li.find(".hasSub"));
				aBinding($li.find(".c-m-w4 a"));
				orderBind($li.find(".boos-ul-order li"));
				$li.find(".c-m-w1 > input").on("click", {ccLevel:2}, addSubClick);
			}else if(level == 2){
				var $li = $("<li id=\""+id+"\" >"+
		              			"<div class=\"boos-ul-list cls-2\">"+
			              			"<div class=\"boos-ul-td c-m-w1\">"+
			              				"<span>"+name+"</span>"+
			              			"</div>"+
			              			"<div class=\"boos-ul-td c-m-w2\">"+
						              	"<ul class=\"boos-ul-order\">"+
						              		"<li class=\"b-u-o-1 dis\"></li><li class=\"b-u-o-2 dis\"></li><li class=\"b-u-o-3 dis\"></li><li class=\"b-u-o-4 dis\"></li>"+
						           		"</ul>"+
					                "</div>"+
					                "<div class=\"boos-ul-td c-m-w3\" style=\"width:110px\">"+code+"</div>"+
					                "<div class=\"boos-ul-td c-m-w4\" style=\"width:140px\"><a name=\"bind\" href=\"javascript:void(0);\">关联类目</a> | <a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
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
				
				aBinding($li.find(".c-m-w4 a"));
				orderBind($li.find(".boos-ul-order li"));
			}
		}
		function deleteCC(ccId){
			if(window.confirm("确定要删除吗?")){
				$.ajax({
					url:"${ctx}/category/cc/ccDelete?ccId="+ccId,
					type: "POST",
					success:function(data){
						//1:成功,0:失败,-1:存在子类目不允许删除,-2:类目不存在,-3:已关联基本类目不允许删除
						switch(data){
							case 1:
								alert("删除成功!");
								deleteComplete(ccId);
						  		break;
							case 0:
								alert("删除失败!");
						  		break;
							case -3:
								alert("已关联基础类目不允许删除!");
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
			var $li = $("#"+liId);
			var $ul = $li.parent();
			
			if($ul.hasClass("boos-ul")){
				len = $ul.find(" > li").length - 1;
			}else{
				len = $ul.find(" > li").length;
			}
			
			if(len == 1){
				$ul.remove();
			}else{
				$li.remove();
 				resetOrderFlag($ul);
			}
		}
		function orderBind($LiList){
			$LiList.click(function(event){
				event.stopPropagation();
				
				var $curLiObj = $(this);
				if(!$curLiObj.hasClass("dis")){
					var $liCcid = $curLiObj.parents("li:first");
					var curCcid = $liCcid.attr("id");
					var descCcid = 0;
					
					var $ul = $liCcid.parent();
					if($curLiObj.hasClass("b-u-o-1")){
						if($ul.hasClass("boos-ul")){
							descCcid = $ul.children("li:nth-child(2)").attr("id");
						}else{
							descCcid = $ul.children("li:first").attr("id");
						}
					}else if($curLiObj.hasClass("b-u-o-2")){
						descCcid = $liCcid.prev().attr("id");
					}else if($curLiObj.hasClass("b-u-o-3")){
						descCcid = $liCcid.next().attr("id");
					}else if($curLiObj.hasClass("b-u-o-4")){
						descCcid = $ul.children("li:last").attr("id");
					}
					
					var result = 0;
					$.ajax({
						url:"${ctx}/category/cc/ccOrder",
						type: "POST",
						async : false,
						data: {sccId: curCcid, dccId: descCcid},
						dataType:"json",
						success:function(re){
							//1:成功,0:失败
							result = re;
							if(re == 0){
								alert("失败!");
							}
						}
					});
					
					//成功
					if(result == 1){
						if ($curLiObj.hasClass("b-u-o-1")) {
							if ($ul.hasClass("boos-ul")) {
								$ul.children("li:nth-child(2)").before($liCcid);
							} else {
								$ul.children("li:first").before($liCcid);
							}
						} else if ($curLiObj.hasClass("b-u-o-2")) {
							$liCcid.prev().before($liCcid);
						} else if ($curLiObj.hasClass("b-u-o-3")) {
							$liCcid.next().after($liCcid);
						} else if ($curLiObj.hasClass("b-u-o-4")) {
							$ul.children("li:last").after($liCcid);
						}
						
						$ul.find(".dis").removeClass("dis");
						resetOrderFlag($ul);
					}
				}
		    });
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
	</script>
</body>
</html>