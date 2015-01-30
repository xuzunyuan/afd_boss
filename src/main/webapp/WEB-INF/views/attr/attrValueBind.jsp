<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>属性名关联管理</title>
</head>
<body>
	<script type="text/javascript" src="../../static/js/jquery.md.js?t=2014102001"></script>
	<script type="text/javascript" src="../../static/js/JSPinyin.js?t=2014102001"></script>

	<!-- main -->
	<div class="main">
		<!-- foldbarV -->
		<div id="foldbarV">
			<div class="foldbarV">
				<div class="foldBtn"></div>
			</div>
		</div>
		<!-- foldbarV end -->
		<!-- crumbs -->
		<div class="crumbs crumbsA">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="#">属性管理</a><em>&gt;</em></li>
				<li><strong>添加新属性名</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- propertyMain -->
		<div class="propertyMain propertyName">
			<div class="hintBar">
				<dl>
					<dt>
						<i class="icon i-exclaim"></i>
					</dt>
					<dd>
						<h4>请注意：</h4>
						<ul>
							<li><em>·</em>属性名在关联属性值后，才可用于和类目的关联</li>
							<li><em>·</em>属性名关联属性值，可在添加属性名后直接创建属性值，并可在关联维护中对关联进行修改。</li>
						</ul>
					</dd>
				</dl>
			</div>
			<form class="form formA">
				<fieldset>
					<div class="legend">
						<h3>属性名关联维护</h3>
						<a href="${ctx}/attr/list">返回属性名列表</a>
					</div>
					<dl class="item">
						<dt class="item-label">
							<label><em>*</em>属性名：</label>
						</dt>
						<dd class="item-cont">
							<p><c:out value="${attr.attrName}" /></p>
						</dd>
					</dl>
					<dl class="item">
						<dt class="item-label">
							<label><em>*</em>拼音码：</label>
						</dt>
						<dd class="item-cont">
							<p><c:out value="${attr.pinyin}" /></p>
						</dd>
					</dl>
					<dl class="item">
						<dt class="item-label">
							<label>已关联属性值：</label>
						</dt>
						<dd class="item-cont item-property">
							<div class="actionBars">
								<input id="addBind" type="button" class="btn" value="+ 添加关联属性值">
								<c:if test="${not empty warn}">
								<div class="errMeg">
									<p>${warn}</p>
								</div>
								</c:if>
							</div>
							<div class="checkAll">
								<div>
									<input type="checkbox" class="chk" id="allCheck" >全选
								</div>
								<input type="button" value="批量取消关联" class="btn disabled" id="multiUnbind">
							</div>
							<!-- table -->
							<table id="mytable" class="table tableA">
								<colgroup>
									<col width="60">
									<col width="240">
									<col width="">
									<col width="150">
								</colgroup>
								<thead id="myhead">
									<tr>
										<th></th>
										<th>属性值</th>
										<th>拼音码</th>
										<th class="align-c">操作</th>
									</tr>
								</thead>
								<c:choose>
				      				<c:when test="${fn:length(avList)>0}">
										<c:forEach items="${avList}" var="attrValue" varStatus="status"> 
											<tbody class="l-1">
												<tr id="${attrValue.aAvId}" hasSub="${attrValue.hasSub}" class="l-1H">
													<td><input type="checkbox" class="chk" name="fattrValue" ><i class="arrow arrB-R"></i></td>
													<td><c:out value="${attrValue.attrValueName}" /></td>
													<td><c:out value="${attrValue.pinyin}" /></td>
													<td class="t-operate align-c"><a href="javascript:void(0);">取消关联</a></td>
												</tr>
												<tr class="l-2">
													<td colspan="4">
														<table class="table tableA">
															<colgroup>
																<col width="60">
																<col width="240">
																<col width="390">	
																<col width="150">
															</colgroup>
															<tbody>
																<tr class="l-2H">
																	<td></td>
																	<td>
																		<div class="t-box"><i class="joint"></i><button name="subButton" class="btn btnAdd"><i class="icon i-inset"></i>添加子属性值 </button></div>
																	</td>
																	<td></td>
																	<td></td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
											</tbody>
										</c:forEach>
									</c:when>
				      				<c:when test="${fn:length(avList)==0}">
										<tbody id="no">
											<tr class="last t-empty">
												<td colspan="4">暂无关联属性值</td>
											</tr>
										</tbody>
				      				</c:when>
			      				</c:choose>
							</table>
							<!-- table end -->
						</dd>
					</dl>
				</fieldset>
			</form>
		</div>
		<!-- propertyMain end -->
	</div>
	<!-- main end -->

	<script type="text/javascript">
		$(function() {
			initBindAttrValue();
			
			loadSubAttrValue();
			
			$("button[name^='subButton']").on("click", initSubBindAttrValue);
			
			$(".l-1 .t-operate").on("click", delAttrAttrValueBind);
			
			$(".l-1H").on("click", loadSubAttrValue);
			
			selectAllCheck();
		});
	
		function selectAllCheck() {
			$("#allCheck").on("click", function(event){
				if(this.checked){ 
					$(".l-1H .chk").each(function(){this.checked = true;}); 
					$('#multiUnbind').removeClass("disabled").prop("disabled", false);
				}else{ 
					$(".l-1H .chk").each(function(){this.checked = false;}); 
					$('#multiUnbind').addClass("disabled").prop("disabled", true);
				} 
			});
			
			$(".l-1H .chk").click(checkAllChecked);
			
			$("#multiUnbind").on("click", function(event){
				var ids = [];
				$(".l-1H .chk").each(function(){
		           	if(this.checked){
		           		ids.push($(this).parent().parent().attr("id"));
		           	}
		        });
				
				if(ids.length > 0){
					$.ajax({
						url : "${ctx}/attr/del/attrValues",
						type : "POST",
						traditional :true, 
						data : {attrAttrValueId : ids},
						success : function(re) {
							window.location.reload(true);
						}
					});
				}else{
					
				}
			});
		}
		
		function checkAllChecked(event) {
			event.stopPropagation();
			
			var chkAllFlag = this.checked;
			if(chkAllFlag){ 
				$('#multiUnbind').removeClass("disabled").prop("disabled", false);
				
				$(".l-1H .chk").each(function(){
		           	if(!this.checked){
		        	   	chkAllFlag = false;
		        	   	return false;
		           	}
		        });
			}else{
				$('#multiUnbind').prop("disabled", true).addClass("disabled");
				
				$(".l-1H .chk").each(function(){
		           	if(this.checked){
		           		$('#multiUnbind').removeClass("disabled").prop("disabled", false);
		        	   	return false;
		           	}
		        });
			}
			 
			$("#allCheck").prop("checked", chkAllFlag);
		}
		
		function loadSubAttrValue() {
			var tr$ = $(this);
			var tbody$ = tr$.parent();
			
			tbody$.toggleClass("on");
			
			if(tbody$.hasClass("on")){
				tr$.find("td:first i").removeClass("arrB-R").addClass("arrB-D");
			}else{
				tr$.find("td:first i").removeClass("arrB-D").addClass("arrB-R");
			}
			
			//有子属性关系加载
			if(tr$.attr("hasSub") === "true"){
				if(!tr$.hasClass("fetch")){
					tr$.addClass("fetch");
					var id = tr$.attr("id");
					
					$.ajax({
						url : "${ctx}/attr/sub/value",
						type : "POST",
						data : {attrValueId : id},
						success : function(savList) {
							$.each(savList, function( index, aav ) {
								var attrStr = "<tr id=\""+aav.aAvId+"\" class=\"l-2\"><td colspan=\"4\"><table class=\"table tableA\">" +
										"<colgroup>" +
											"<col width=\"60\">" +
											"<col width=\"240\">" +
											"<col width=\"390\">" +
											"<col width=\"150\">" +
										"</colgroup>" +
										"<tbody>" +
											"<tr class=\"l-2H\">" +
												"<td></td>" +
												"<td>" +
													"<div class=\"t-box\"><i class=\"joint\"></i><span></span></div>" +
												"</td>" +
												"<td></td>" +
												"<td class=\"t-operate align-c\"><a href=\"javascript:void(0);\">取消关联</a></td>" +
											"</tr>" +
										"</tbody>" +
									"</table></td></tr>";
								tr$.after(attrStr);
								tr$ = tr$.next();
								tr$.find("span").text(aav.attrValueName);
								tr$.find(".l-2H > td:eq(2)").text(aav.pinyin);
								tr$.find("td:last").on("click", delAttrAttrValueBind);
							});
						}
					});
				}
			}
		}
		
		function saveAttrAttrValueBind(attrId, av, py, paavId, sub, dp) {
			var aavId = 0;
			$.ajax({
				url : "${ctx}/attr/add/attrValue",
				type : "POST",
				async: false,
				data : {
					attrId : attrId,
					attrValue : av,
					pinyin : py,
					pAAvId : paavId,
					hasSub : sub,
					displayOrder : dp
				},
				success : function(re) {
					aavId = re;
				}
			});
			
			return aavId;
		}
		
		function initSubBindAttrValue(event) {
			var this$ = $(this);
			this$.attr("disabled", true);
			
			var body$ = $(this).parents(".l-1");
			var firstTr$ = body$.find("tr:first");
			 
			var attrStr = "<tr class=\"l-2\"><td colspan=\"4\"><table class=\"table tableA\">" +
				"<colgroup>" +
					"<col width=\"60\">" +
					"<col width=\"240\">" +
					"<col width=\"390\">" +
					"<col width=\"150\">" +
				"</colgroup>" +
				"<tbody>" +
					"<tr class=\"l-2H\">" +
						"<td></td>" +
						"<td>" +
							"<div class=\"t-box\"><i class=\"joint\"></i><input class=\"txt box-txt\" type=\"text\" maxlength=\"30\" \/></div>" +
						"</td>" +
						"<td></td>" +
						"<td class=\"t-operate align-c\"><a href=\"javascript:void(0);\">取消关联</a></td>" +
					"</tr>" +
				"</tbody>" +
			"</table></td></tr>";

			firstTr$.after(attrStr);
			var tr$ = firstTr$.next();
			
			var pId = firstTr$.attr("id");
			 
			tr$.find(".txt").on("blur", function(event) {
				var attrValue = $.trim(this.value);
				if (attrValue!=null && attrValue.length>0) {
					var py = pinyin.getFullChars(attrValue);
					var pyTr$ = $(this).parent().parent().next().text(py);
					var dp = body$.find(" > tr").length-2;
					 
					var aavId = saveAttrAttrValueBind(0, attrValue, py, pId, 0, dp);
					if(aavId > 0){
						this$.attr("disabled", false);
						tr$.attr("id", aavId);
						
						$(this).before("<span></span>");
						$(this).prev().text(attrValue);
						
						pyTr$.next().off("click").on("click", delAttrAttrValueBind);
						$(this).remove();
					}else if(aavId == -1){
						tr$.find(".t-operate").trigger("click");
					}
				}
			});
			
			tr$.find(".t-operate").on("click", function(event) {
				this$.attr("disabled", false);
				tr$.remove();
			});
			
			return false;
		}
		
		function initBindAttrValue() {
			$("#addBind").on("click", function(event) {
				var this$ = $(this).attr("disabled", true);
				
				var attrStr = "<tbody><tr>" +
								"<td><input type=\"checkbox\" name=\"fattrValue\" class=\"chk\"><i class=\"arrow arrB-R\"></i></td>" +
								"<td><input class=\"txt\" type=\"text\" name=\"attrValueName\" id=\"attrValueName\" maxlength=\"30\" ></td>" +
								"<td></td>" +
								"<td class=\"t-operate align-c\"><a href=\"javascript:void(0);\">取消关联</a></td>" +
						   	  "</tr></tbody>";	
 
				var tbody$ = $(attrStr);
				
				tbody$.find("#attrValueName").on("blur", function(event) {
					var attrValue = $.trim(this.value);
					 
					if (attrValue!=null && attrValue.length>0) {
						var py = pinyin.getFullChars(attrValue);
						var pyTd$ = $(this).parent().next().text(py);
						
						var dp = $("#mytable tbody[id]").length;
						if(dp == 0){
							dp = 1;
						}
						
						var aavId = saveAttrAttrValueBind("${attr.attrId}", attrValue, py, 0, 0, dp);
						
						if(aavId > 0){
							this$.attr("disabled", false);
							tbody$.addClass("l-1");
							
							$(this).parent().prev().find(".chk").on("click", checkAllChecked);
							$("#allCheck").prop("checked", false);
							
							$(this).parent().text(attrValue);
							
							pyTd$.next().off("click").on("click", delAttrAttrValueBind);
							
							var tr$ = tbody$.find("tr:first").attr("id", aavId).attr("hasSub", false).addClass("l-1H").on("click", loadSubAttrValue).trigger("click");
							
							var subStr = "<tr class=\"l-2\"><td colspan=\"4\">" + 
												"<table class=\"table tableA\">" + 
													"<colgroup>" + 
														"<col width=\"60\">" + 
														"<col width=\"240\">" + 
														"<col width=\"390\">" + 
														"<col width=\"150\">" + 
													"</colgroup>" + 
													"<tbody>" + 
														"<tr class=\"l-2H\">" + 
															"<td></td><td><div class=\"t-box\"><i class=\"joint\"></i><button name=\"subButton\" class=\"btn btnAdd\"><i class=\"icon i-inset\"></i>添加子属性值 </button></div></td><td></td><td></td>" + 
														"</tr>" + 
													"</tbody>" + 
												"</table>" + 
										   "</td></tr>";
							tr$.after(subStr);
							tr$.next().find("button[name^='subButton']").on("click", initSubBindAttrValue);
							
							$("#no").remove();
						}else if(aavId == -1){
							pyTd$.next().trigger("click");
						}
					}
				});
				
				tbody$.find(".t-operate").on("click", function(event) {
					$("#addBind").attr("disabled", false);
					$(this).parent().parent().remove();
				});
				 
				tbody$.insertAfter("#myhead");
			});
		}
		
		function delAttrAttrValueBind(event) {
			event.stopPropagation();
			
			var id = 0;
			var subFlag = false;
			var tr$ = $(this).parent();
			 
			if(tr$.hasClass("l-1H")){
				id = tr$.attr("id");
				if(tr$.attr("hasSub") === "true"){
					subFlag = true;
				}
				tr$ = tr$.parent();
				if(!subFlag && tr$.find(" > tr").length>2){
					subFlag = true;
				}
				
			}else if(tr$.hasClass("l-2H")){
				tr$ = tr$.parents(".l-2");
				id = tr$.attr("id");
			}
			
			$.ajax({
				url : "${ctx}/attr/del/attrValue",
				type : "POST",
				data : {attrAttrValueId : id, sub:subFlag},
				success : function(re) {
					if (re == 1) {
						tr$.remove();
					}
				}
			}); 
		}
	</script>
</body>
</html>