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
<title>销售类目管理-一网全城</title>
</head>
<body>
	<div class="crumbs-box">
        <div class="crumbs">
            <h3>当前位置 &#58;</h3>
            <ul>
                <li><a href="#">BOSS</a>&#62;</li>
                <li><a href="#">类目管理</a>&#62;</li>
                <li>销售类目管理</li>
            </ul>
        </div>
    </div><!--crumbs-box end-->
    <div class="category-main c-mainA">
    	<div class="category-main-left">
        	<input id="add_first" type="button" class="inputBtn" value="添加一级类目" >
        </div>
    	<!-- <div class="category-main-right">
        	<input id="showMode" type="button" class="inputBtn" value="(+)全部展开" >
        </div> -->
        <div id="0" class="clearfix"></div>
        <c:if test="${!empty(scList)}">
    	<ul class="boos-ul c-m-ul">
        	<li class="boos-ul-th">
            	<div class="boos-ul-td c-m-w1" style="width:230px">分类名称</div>
            	<div class="boos-ul-td c-m-w2" style="width:80px">编码</div>
            	<div class="boos-ul-td c-m-w2">显示顺序</div>
            	<div class="boos-ul-td c-m-w3">客户端是否显示</div>
            	<div class="boos-ul-td c-m-w3-1">网站是否显示</div>
            	<div class="boos-ul-td c-m-w4" style="width:140px">操作</div>
            </li>
            <!--1级列表-->
			<c:forEach var="sc" items="${scList}" varStatus="fstatus">
			<li id="${sc.scId}" class="boos-ul-li">
            	<div class="boos-ul-list cls-1 hasSub">
                    <div class="boos-ul-td c-m-w1" style="width:230px">
                    	<i class="arrowsDown"></i><i class="arrowsRight"></i><span>${sc.scName}</span><input type="button" class="inputBtnA" value="添子类" >
                    </div>
                    <div class="boos-ul-td c-m-w2" style="width:80px">${sc.scCode}</div>
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
                    <div class="boos-ul-td c-m-w3">
                      <select title="选择后自动保存">
                      		<option value="1" <c:if test="${sc.mobileShow}"> selected="selected"</c:if> >显示</option>
                            <option value="0" <c:if test="${not sc.mobileShow}"> selected="selected"</c:if> >不显示</option>
                      </select>
                  	</div>
                    <div class="boos-ul-td c-m-w3-1">
                      <select title="选择后自动保存">
                           <option value="1" <c:if test="${sc.show}"> selected="selected"</c:if> >显示</option>
                           <option value="0" <c:if test="${not sc.show}"> selected="selected"</c:if> >不显示</option>
                      </select>
                  	</div>
                    <div class="boos-ul-td c-m-w4" style="width:140px">
						<a name="mod" href="javascript:void(0);">修改</a> | <a name="del" href="javascript:void(0);">删除</a>
					</div>
                </div>
            </li>
			</c:forEach>
        </ul>
		</c:if>
    </div><!--category-main end-->

	<div id="mask_bg"></div>
	<div id="add_show" style="display: none">
		<h2>
			增加类目名称<a href="javascript:void(0);" title="关闭">关闭</a>
		</h2>
		<form id="addForm" action="">
			<ul class="mask-form-list">
				<li>
					<div class="m-f-l-left">类目名称：</div>
					<div class="m-f-l-right">
						<input type="text" id="add_scName" name="scName" class="inputText">
						<input type="hidden" id="add_pScId" name="pScId"> 
						<input type="hidden" id="add_scLevel" name="scLevel"> 
						<input type="hidden" id="add_pathId" name="pathId"> 
						<input type="hidden" id="add_pathName" name="pathName"> 
					</div>
				</li>
				<li>
					<div class="m-f-l-btn">
						<input id="saveSC" type="button" class="inputBtn" value="保 存" onclick="addSCAjax();return false;">
						<input id="cancelSC" type="button" class="inputBtn" value="取 消">
					</div>
				</li>
			</ul>
		</form>
	</div>
	<div id="update_show" style="display: none">
		<form id="updateForm" action="">
			<h2>
				修改类目名称<a href="javascript:void(0);" title="关闭">关闭</a>
			</h2>
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
						<input id="idCate" type="hidden" name="scId" class="inputText">
					</div>
				</li>
				<li>
					<div class="m-f-l-btn">
						<input id="updateSC" type="button" class="inputBtn" value="保 存" onclick="updateSCAjax();return false;"> 
						<input id="upcanSC" type="button" class="inputBtn" value="取 消">
					</div>
				</li>
			</ul>
		</form>
	</div>


	<script type="text/javascript">
		var invChars = /[\\&\\<\\>\\'\\"\\/]/im;
		$(function() {
			showHide($(".hasSub"), 2);
			seleckBind($(".boos-ul > li"));
			orderBind($("ul.boos-ul-order li"));
			aBind();
			
			initAddSubClick();
		});

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
			};
			if ($("#update_show").is(":visible")) {
				showPop("#update_show");
			};
		});

		function addSubClick(event){
			event.stopPropagation();
			
			$("#mask_bg").addClass("mask-bg");
			showPop("#add_show");
			$("#add_show").addClass("mask-show").show();
			$("#add_scName").focus();
			
			$("#add_scLevel").val(event.data.ccLevel);
			
			if(event.data.ccLevel == 1){
				$("#add_pScId").val(0);
				$("#add_pathId").val("");
				$("#add_pathName").val("");
			}else if(event.data.ccLevel==2 || event.data.ccLevel==3){
				var $li = $(event.target).parents("li:first");
				var pathName = $(event.target).prev().text();
				var pScId = $li.attr("id");
				var pathId = pScId;
				
				//先加载子类目
				if($li.children().length == 1){
					fetchSubCategory($li, pScId, event.data.ccLevel);
				}
				
				if(event.data.ccLevel == 3){
					$li = $li.parents("li:first");
					pathName = $li.children("div:first").children("div:first").children("span").text() + "|" +pathName;
					pathId = $li.attr("id") + "|" + pScId;
				}
				
				$("#add_pScId").val(pScId);
				$("#add_pathId").val(pathId);
				$("#add_pathName").val(pathName);
			}
		} 
		
		function addSCAjax() {
			var name = $.trim($("#add_scName").val());
			if(name.length > 0){
				if(!invChars.test(name)){
					$.ajax({
						url:"${ctx}/category/sc/scAdd",
						type: "POST",
						data: $('#addForm').serialize(),
						success:function(re){
							//1:成功,0:失败,-1:名称已存在,-2:名称不能为空
							if(re.indexOf("_") >= 0){
								var arr = re.split("_");
								alert("增加成功!");
								$("#cancelSC").trigger("click");
								addComplete(arr[1], name, arr[2], $("#add_scLevel").val(), $("#add_pScId").val());
								$("#add_scName").val("");
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
		}
		
		function addComplete(id, name, code, level, pId) {
			if(level == 1){
				var $ul, $div=$("#0");
				
				if($div.next().is("ul")){
					$ul = $div.next();
				}else{
					$ul = $("<ul class=\"boos-ul c-m-ul\"></ul>");
					$div.parent().append($ul);
					$ul.append("<li class=\"boos-ul-th\"><div class=\"boos-ul-td c-m-w1\">分类名称</div><div class=\"boos-ul-td c-m-w2\">显示顺序</div><div class=\"boos-ul-td c-m-w3\">客户端是否显示</div><div class=\"boos-ul-td c-m-w3-1\">网站是否显示</div><div class=\"boos-ul-td c-m-w4\">操作</div></li>");
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
					              "<div class=\"boos-ul-td c-m-w1\" style=\"width:230px\">"+
					              	"<i class=\"arrowsDown\"></i><i class=\"arrowsRight\"></i><span>"+name+"</span><input type=\"button\" class=\"inputBtnA\" value=\"添子类\" >"+
					              "</div>"+
					              "<div class=\"boos-ul-td c-m-w2\" style=\"width:80px\">"+code+"</div>"+
					              "<div class=\"boos-ul-td c-m-w2\">"+
					              	"<ul class=\"boos-ul-order\">"+
					              		"<li class=\"b-u-o-1\"></li><li class=\"b-u-o-2\"></li><li class=\"b-u-o-3 dis\"></li><li class=\"b-u-o-4 dis\"></li>"+
					 				"</ul>"+
					              "</div>"+
					              "<div class=\"boos-ul-td c-m-w3\">"+
					              	"<select title=\"选择后自动保存\">"+
										"<option value=\"1\" selected=\"selected\">显示</option>"+
				                      	"<option value=\"0\">不显示</option>"+
									"</select>"+
					              "</div>"+
					              "<div class=\"boos-ul-td c-m-w3-1\">"+
					              	"<select title=\"选择后自动保存\">"+
										"<option value=\"1\" selected=\"selected\">显示</option>"+
				                      	"<option value=\"0\">不显示</option>"+
									"</select>"+
					              "</div>"+
				              	  "<div class=\"boos-ul-td c-m-w4\" style=\"width:140px\"><a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
				          	  "</div>"+
				 	 	  	"</li>"); 
				$ul.append($li);
				
				resetOrderFlag($ul);
				
				seleckBind($li);
				showHide($li.find(".hasSub"), 2);
				aBinding($li.find(".c-m-w4 a"));
				orderBind($li.find(".boos-ul-order li"));
				$li.find(".c-m-w1 > input").on("click", {ccLevel:2}, addSubClick);
			}else if(level == 2){
				var $li = 	$("<li id=\""+id+"\" >"+
				      			"<div class=\"boos-ul-list cls-2 hasSub\">"+
					      			"<div class=\"boos-ul-td c-m-w1\" style=\"width:210px\">"+
					      				"<i class=\"arrowsDown\"></i><i class=\"arrowsRight\"></i><span>"+name+"</span><input type=\"button\" class=\"inputBtnA\" value=\"添子类\" >"+
					      			"</div>"+
					      			"<div class=\"boos-ul-td c-m-w2\" style=\"width:80px\">"+code+"</div>"+
					      			"<div class=\"boos-ul-td c-m-w2\">"+
						              	"<ul class=\"boos-ul-order\">"+
						              		"<li class=\"b-u-o-1 dis\"></li><li class=\"b-u-o-2 dis\"></li><li class=\"b-u-o-3 dis\"></li><li class=\"b-u-o-4 dis\"></li>"+
						           		"</ul>"+
					                "</div>"+
					                "<div class=\"boos-ul-td c-m-w3\">"+
						              	"<select title=\"选择后自动保存\">"+
											"<option value=\"1\" selected=\"selected\">显示</option>"+
					                      	"<option value=\"0\">不显示</option>"+
										"</select>"+
						              "</div>"+
						            "<div class=\"boos-ul-td c-m-w3-1\">"+
						              	"<select title=\"选择后自动保存\">"+
											"<option value=\"1\" selected=\"selected\">显示</option>"+
					                      	"<option value=\"0\">不显示</option>"+
										"</select>"+
						            "</div>"+
					  	  		    "<div class=\"boos-ul-td c-m-w4\" style=\"width:140px\"><a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
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
				seleckBind($li);
				aBinding($li.find(".c-m-w4 a"));
				orderBind($li.find(".boos-ul-order li"));
				$li.find(".c-m-w1 > input").on("click", {ccLevel:3}, addSubClick);
			}else if(level == 3){
				var $li = $("<li id=\""+id+"\">"+
					              "<div class=\"boos-ul-list cls-2\">"+
						              "<div class=\"boos-ul-td c-m-w1\" style=\"width:165px\">"+
						              	"<i></i><span>"+name+"</span>"+
						              "</div>"+
						              "<div class=\"boos-ul-td c-m-w2\" style=\"width:80px\">"+code+"</div>"+
						              "<div class=\"boos-ul-td c-m-w2\">"+
						              	"<ul class=\"boos-ul-order\">"+
						              		"<li class=\"b-u-o-1 \"></li><li class=\"b-u-o-2\"></li><li class=\"b-u-o-3 dis\"></li><li class=\"b-u-o-4 dis\"></li>"+
						          		"</ul>"+
						              "</div>"+
						              "<div class=\"boos-ul-td c-m-w3\">"+
						              	"<select title=\"选择后自动保存\">"+
											"<option value=\"1\" selected=\"selected\">显示</option>"+
					                      	"<option value=\"0\">不显示</option>"+
										"</select>"+
						              "</div>"+
						              "<div class=\"boos-ul-td c-m-w3-1\">"+
						              	"<select title=\"选择后自动保存\">"+
											"<option value=\"1\" selected=\"selected\">显示</option>"+
					                      	"<option value=\"0\">不显示</option>"+
										"</select>"+
						              "</div>"+
					              	  "<div class=\"boos-ul-td c-m-w4\" style=\"width:140px\"><a name=\"bind\" href=\"javascript:void(0);\">关联类目</a> | <a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
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
				
				seleckBind($li);
				aBinding($li.find(".c-m-w4 a"));
				orderBind($li.find(".boos-ul-order li"));
			}
		}
		function initAddSubClick(){
			$("#add_first").on("click", {ccLevel:1}, addSubClick);
			$(".c-m-w1 > input").on("click", {ccLevel:2}, addSubClick);
			
			$("#add_show h2 a,#cancelSC").click(function(){
				$("#add_scName").val("");
				$("#mask_bg").removeClass("mask-bg");
				$("#add_show").removeClass("mask-show").hide();
			});
		}
		
		function updateSC(id, name) {
			$("#srcCate").text(name);
			$("#idCate").val(id);
			
			$("#mask_bg").addClass("mask-bg");
			$("#update_show").addClass("mask-show").show();
			showPop("#update_show");
			$("#descCate").focus();
		}
		function updateSCAjax() {
			var srcName = $("#srcCate").text();
			var name = $.trim($("#descCate").val());
			 
			if (name.length > 0) {
				if (name != srcName) {
					if(!invChars.test(name)){
						$.ajax({
							url : "${ctx}/category/sc/scUpdate",
							type : "POST",
							data : $('#updateForm').serialize(),
							success : function(re) {
								//1:成功,0:失败,-1:名称已存在,-2:名称不能为空
								switch (re) {
								case 1:
									$("#upcanSC").trigger("click");
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
				} else {
					alert("请输入新的名称!");
					$("#descCate").focus();
				}
			} else {
				alert("请输入名称!");
				$("#descCate").focus();
			}
		}

		function aBind() {
			aBinding($(".c-m-w4 a"));
			
			$("#update_show h2 a,#upcanSC").click(function() {
				$("#descCate").val("");
				$("#mask_bg").removeClass("mask-bg");
				$("#update_show").removeClass("mask-show").hide();
			});
		}
		function aBinding($a) {
			$a.on("click", function(event){
				event.stopPropagation();
				
				var name = $(this).parent().parent().children("div:first").children("span").text();
				var id = $(this).parents("li:first").attr("id");
				
				if(this.name == "mod"){
					updateSC(id, name);
				}else if(this.name == "del"){
					deleteSC(id);
				}else if(this.name == "bind"){
					window.location.href = "${ctx}/category/sc/scbcBind?scId="+id;
				}
			});
		}
		
		function seleckBind($liList) {
			$liList.find(" > div select").on( "click", function( event ) {event.stopPropagation();});
			$liList.find(" > div .c-m-w3 select").on( "change", {type:2}, seleckAjax);
			$liList.find(" > div .c-m-w3-1 select").on( "change", {type:1}, seleckAjax);
		}
		
		function seleckAjax(event) {
			var scId = $(event.target).parents("li:first").attr("id");
			var value = this.value;
			
			$.ajax({
				url : "${ctx}/category/sc/scUpdateShow",
				type : "POST",
				data : {
					scId : scId,
					isShow : value,
					type : event.data.type
				},
				success : function(data) {
				}
			});
		}
		
		function deleteSC(scId) {
			if (window.confirm("确定要删除吗?")) {
				$.ajax({
					url : "${ctx}/category/sc/scDelete?scId=" + scId,
					type : "POST",
					success : function(data) {
						//1:成功,0:失败,-1:存在子类目不允许删除,-2:类目不存在,-3:已关联基本类目不允许删除
						switch (data) {
						case 1:
							alert("删除成功!");
							deleteComplete(scId);
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
		function orderBind($liList) {
			$liList.click(function(event) {
				event.stopPropagation();
				var $curLiObj = $(this);

				if (!$curLiObj.hasClass("dis")) {
					var $liScid = $curLiObj.parents("li:first");
					var curScid = $liScid.attr("id");
					var descScid = 0;
					var $ul = $liScid.parent();
					
					if ($curLiObj.hasClass("b-u-o-1")) {
						if ($ul.hasClass("boos-ul")) {
							descScid = $ul.children("li:nth-child(2)").attr("id");
						} else {
							descScid = $ul.children("li:first").attr("id");
						}
					} else if ($curLiObj.hasClass("b-u-o-2")) {
						descScid = $liScid.prev().attr("id");
					} else if ($curLiObj.hasClass("b-u-o-3")) {
						descScid = $liScid.next().attr("id");
					} else if ($curLiObj.hasClass("b-u-o-4")) {
						descScid = $liScid.parent().children("li:last").attr("id");
					}
					 
					var result = 0;
					$.ajax({
						url : "${ctx}/category/sc/scOrder",
						type : "POST",
						async : false,
						data : {
							sscId : curScid,
							dscId : descScid
						},
						success : function(re) {
							result = re;
							if(re == 0){
								alert("失败!");
							}
						}
					});
					if(result == 1){
						if ($curLiObj.hasClass("b-u-o-1")) {
							if ($ul.hasClass("boos-ul")) {
								$ul.children("li:nth-child(2)").before($liScid);
							} else {
								$ul.children("li:first").before($liScid);
							}
						} else if ($curLiObj.hasClass("b-u-o-2")) {
							$liScid.prev().before($liScid);
						} else if ($curLiObj.hasClass("b-u-o-3")) {
							$liScid.next().after($liScid);
						} else if ($curLiObj.hasClass("b-u-o-4")) {
							$ul.children("li:last").after($liScid);
						}
						
						$ul.find(".dis").removeClass("dis");
						resetOrderFlag($ul);
					}
				}
			});
		}

		function fetchSubCategory($elem, pId, level) {
			$.ajax({
				url : "${ctx}/category/sc/pList",
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
			var $ul = $("<ul class=\"boos-ul-2\"></ul>");
			$elem.append($ul);
			
			$.each(objList, function( index, cate ) {
			  var li = "<li id=\""+cate.scId+"\">"+
              "<div class=\"boos-ul-list cls-2\">"+
	              "<div class=\"boos-ul-td c-m-w1\" style=\"width:165px\">"+
	              	"<i "+(index==0?"class=\"first\"></i>":"></i>")+"<span>"+cate.scName+"</span>"+
	              "</div>"+
	              "<div class=\"boos-ul-td c-m-w2\" style=\"width:80px\">"+cate.scCode+"</div>"+
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
	              "<div class=\"boos-ul-td c-m-w3\">"+
	              	"<select title=\"选择后自动保存\">"+
						"<option value=\"1\" ";if(cate.mobileShow){li+="selected=\"selected\"";} li+=">显示</option>"+
                    	"<option value=\"0\" ";if(!cate.mobileShow){li+="selected=\"selected\"";} li+=">不显示</option>"+
					"</select>"+
	              "</div>"+
	              "<div class=\"boos-ul-td c-m-w3-1\">"+
	              	"<select title=\"选择后自动保存\">"+
						"<option value=\"1\" ";if(cate.show){li+="selected=\"selected\"";} li+=">显示</option>"+
                    	"<option value=\"0\" ";if(!cate.show){li+="selected=\"selected\"";} li+=">不显示</option>"+
					"</select>"+
	              "</div>"+
              	  "<div class=\"boos-ul-td c-m-w4\" style=\"width:140px\"><a name=\"bind\" href=\"javascript:void(0);\">关联类目</a> | <a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
          	  "</div>"+
     	 	  "</li>";
     	 	  
     	 	  $ul.append(li);
			});
			
			seleckBind($ul.find(" > li"));
			aBinding($ul.find(".c-m-w4 a"));
			orderBind($ul.find(".boos-ul-order li"));
		}
		
		function loadCategory2($elem, objList) {
			var $ul = $("<ul class=\"boos-ul-1\"></ul>");
			$elem.append($ul);
			
			$.each(objList, function( index, cate ) {
			  var li = "<li id=\""+cate.scId+"\" >"+
			              "<div class=\"boos-ul-list cls-2 hasSub\">"+
				              "<div class=\"boos-ul-td c-m-w1\" style=\"width:210px\">"+
				              	"<i class=\"arrowsDown\"></i><i class=\"arrowsRight\"></i><span>"+cate.scName+"</span><input type=\"button\" class=\"inputBtnA\" value=\"添子类\" >"+
				              "</div>"+
				              "<div class=\"boos-ul-td c-m-w2\" style=\"width:80px\">"+cate.scCode+"</div>"+
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
				              "<div class=\"boos-ul-td c-m-w3\">"+
				              	"<select title=\"选择后自动保存\">"+
									"<option value=\"1\" ";if(cate.mobileShow){li+="selected=\"selected\"";} li+=">显示</option>"+
			                      	"<option value=\"0\" ";if(!cate.mobileShow){li+="selected=\"selected\"";} li+=">不显示</option>"+
								"</select>"+
				              "</div>"+
				              "<div class=\"boos-ul-td c-m-w3-1\">"+
				              	"<select title=\"选择后自动保存\">"+
									"<option value=\"1\" ";if(cate.show){li+="selected=\"selected\"";} li+=">显示</option>"+
			                      	"<option value=\"0\" ";if(!cate.show){li+="selected=\"selected\"";} li+=">不显示</option>"+
								"</select>"+
				              "</div>"+
			              	  "<div class=\"boos-ul-td c-m-w4\" style=\"width:140px\"><a name=\"mod\" href=\"javascript:void(0);\">修改</a> | <a name=\"del\" href=\"javascript:void(0);\">删除</a></div>"+
			          	  "</div>"+
     	 	  			"</li>";
     	 	  
     	 	  		$ul.append(li);
			});
			 
			showHide($ul.find(".hasSub"), 3);
			seleckBind($ul.find(" > li"));
			aBinding($ul.find(".c-m-w4 a"));
			orderBind($ul.find(".boos-ul-order li"));
			$ul.find(".c-m-w1 > input").on("click", {ccLevel:3}, addSubClick);
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