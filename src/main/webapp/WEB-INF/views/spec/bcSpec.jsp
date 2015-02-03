<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>类目规格关联</title>
	</head>
	<body>
		<script type="text/javascript" src="../static/js/jquery.md.js?t=20140923"></script>
		
		<script type="text/javascript">
			$(function(){
				$(document).on("click","#selectBC",function(){
					$("#bc_mask").addClass("mask");
					$("#bc_show").show();
					showPop("#bc_show");
					$('#tc').empty().append('<option value="-1">请选择</option>');
					$('#sc').empty().append('<option value="-1">请选择</option>');
					$('#fc').empty().append('<option value="-1">请选择</option>');
					fetchSubCategory("#fc",0);
				});
				$('#fc').change(function() {
					$('#fcE').text(this.value==-1?"请选择一级类目":"");
					fetchSubCategory("#sc", this.value);
				});
				$('#sc').change(function() {
					$('#scE').text(this.value==-1?"请选择二级类目":"");
					fetchSubCategory("#tc", this.value);
				});
				$('#tc').change(function() {
					$('#tcE').text(this.value==-1?"请选择三级类目":"");
				});
				
				$(document).on("click","#cacel,#bc_show .hd span i",function(){
					$("#bc_mask").removeClass("mask");
					$("#bc_show").hide();
				});
				$(document).on("click","#submit",function(){
					if($("#fc").val() == "-1") {
						$("#fcE").text("请选择一级类目");
						return;
					}
					if($("#sc").val() == "-1") {
						$("#scE").text("请选择二级类目");
						return;
					}
					if($("#tc").val() == "-1") {
						$("#tcE").text("请选择三级类目");
						return;
					}
					$.post(
						"${ctx}/catespec/saveBcId",
						{bcId:$("#tc").val()},
						null
					);
					createTable();
					showBcSpecList();
					$("#bc_mask").removeClass("mask");
					$("#bc_show").hide();
					$("#selectSpec").removeClass("disabled");
					$("#selectSpec").attr("disabled",false);
				});
				$(document).on("click","#selectSpec",function(){
					window.open('${ctx}/catespec/selectSpecs','newwindow','height=600,width=1050,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, resizable=no,location=no, status=no');
				});
				$(document).on("click","tr.l-1H",function(){
					if($(this).parent().hasClass("on")){
						$(this).parent().removeClass("on");
						$(this).find("i.arrow").removeClass("arrB-D").addClass("arrB-R");
					} else {
						$(this).parent().addClass("on");
						$(this).find("i.arrow").removeClass("arrB-R").addClass("arrB-D");
						if(!$(this).next().is("tr.l-2")){
							var bcSpecId = $(this).attr("bcSpecId");
							$.post(
								"${ctx}/catespec/getBcSpecValueByBcSpecId",
								{bcSpecId:bcSpecId},
								function(bcSpecValueList){
									addBcSpecValueList(bcSpecId,bcSpecValueList);
								}
							);
						}
					}
				});
				$(document).on("change","#chkAll",function(){
					var check = $(this).prop("checked");
					$("input[name=chkSel]").prop("checked",check);
					if(check && $("input[name=chkSel]").size() > 0){
						$("#batchDelete").removeClass("disabled");
						$("#batchDelete").attr("disabled",false);
					} else {
						$("#batchDelete").addClass("disabled");
						$("#batchDelete").attr("disabled",true);
					}
				});
				$(document).on("click","#batchDelete",function(){
					var bcSpecId = $(this).parents("tr.l-1H").attr("bcSpecId");
					var msg = "<p><span>•</span>您确定批量取消规格名和类目的关联？</p>" + 
								"<p><span>•</span>取消后其相应规格值也将取消！</p>";
					$.modaldialog(msg,{
						title : '删除规格名',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:deleteBcSpecs},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
				});
				$(document).on("click","input[name=chkSel]",function(event){
					event.stopPropagation();
					setChkAll();
					setBatchDelBtn();
				});
				$(document).on("click","tr.l-1H i.arrM-T",function(event){
					event.stopPropagation();
					if($(this).hasClass("disable")){
						return;
					}
					var curNode = $(this).parents("tbody.l-1");
					var curId = curNode.find("tr.l-1H").attr("bcSpecId");
					var descNode = curNode.parent().find("tbody.l-1").first();
					var descId = descNode.find("tr.l-1H").attr("bcSpecId");
					$.post(
						"${ctx}/catespec/updateBcSpecOrder",
						{sbcsId:curId,dbcsId:descId},
						function(result){
							if(result){
								descNode.before(curNode);
								updateSpecOrderDisplay();
							}
						}
					);
				});
				$(document).on("click","tr.l-1H i.arrM-P",function(event){
					event.stopPropagation();
					if($(this).hasClass("disable")){
						return;
					}
					var curNode = $(this).parents("tbody.l-1");
					var curId = curNode.find("tr.l-1H").attr("bcSpecId");
					var descNode = curNode.prev();
					var descId = descNode.find("tr.l-1H").attr("bcSpecId");
					$.post(
						"${ctx}/catespec/updateBcSpecOrder",
						{sbcsId:curId,dbcsId:descId},
						function(result){
							if(result){
								descNode.before(curNode);
								updateSpecOrderDisplay();
							}
						}
					);
				});
				$(document).on("click","tr.l-1H i.arrM-N",function(event){
					event.stopPropagation();
					if($(this).hasClass("disable")){
						return;
					}
					var curNode = $(this).parents("tbody.l-1");
					var curId = curNode.find("tr.l-1H").attr("bcSpecId");
					var descNode = curNode.next();
					var descId = descNode.find("tr.l-1H").attr("bcSpecId");
					$.post(
						"${ctx}/catespec/updateBcSpecOrder",
						{sbcsId:curId,dbcsId:descId},
						function(result){
							if(result){
								descNode.after(curNode);
								updateSpecOrderDisplay();
							}
						}
					);
				});
				$(document).on("click","tr.l-1H i.arrM-B",function(event){
					event.stopPropagation();
					if($(this).hasClass("disable")){
						return;
					}
					var curNode = $(this).parents("tbody.l-1");
					var curId = curNode.find("tr.l-1H").attr("bcSpecId");
					var descNode = curNode.parent().find("tbody.l-1").last();
					var descId = descNode.find("tr.l-1H").attr("bcSpecId");
					$.post(
						"${ctx}/catespec/updateBcSpecOrder",
						{sbcsId:curId,dbcsId:descId},
						function(result){
							if(result){
								descNode.after(curNode);
								updateSpecOrderDisplay();
							}
						}
					);
				});
				$(document).on("click","tr.l-1H td input[name=isFilter]",function(event){
					event.stopPropagation();
					var bcSpecId = $(this).parents("tr.l-1H").attr("bcSpecId");
					var isFilter = $(this).is(":checked");
					var node = $(this);
					$.post(
						"${ctx}/catespec/updateBcSpecFilter",
						{bcSpecId:bcSpecId,isFilter:isFilter},
						function(result){
							if(!result){
								node.trigger("click");
							}
						}
					);
				});
				$(document).on("click","tr.l-1H td a[name=delete]",function(event){
					event.stopPropagation();
					var bcSpecId = $(this).parents("tr.l-1H").attr("bcSpecId");
					var msg = "<p><span>•</span>您确定取消该规格名和类目的关联？</p>" + 
								"<p><span>•</span>取消后其相应规格值也将取消！</p>";
					$.modaldialog(msg,{
						title : '删除规格名',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){deleteBcSpec(bcSpecId);}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
				});
				$(document).on("click","tr.l-2 i.arrM-T",function(){
					if($(this).hasClass("disable")){
						return;
					}
					var curNode = $(this).parents("tr.l-2");
					var curId = curNode.attr("bcSpecValueId");
					var descNode = curNode.parent().find("tr.l-2").first();
					var descId = descNode.attr("bcSpecValueId");
					$.post(
						"${ctx}/catespec/updateBcSpecValueOrder",
						{sbcsvId:curId,dbcsvId:descId},
						function(result){
							if(result){
								descNode.before(curNode);
								updateSpecValueOrderDisplay(curNode.attr("bcSpecId"));
							}
						}
					);
				});
				$(document).on("click","tr.l-2 i.arrM-P",function(){
					if($(this).hasClass("disable")){
						return;
					}
					var curNode = $(this).parents("tr.l-2");
					var curId = curNode.attr("bcSpecValueId");
					var descNode = curNode.prev();
					var descId = descNode.attr("bcSpecValueId");
					$.post(
						"${ctx}/catespec/updateBcSpecValueOrder",
						{sbcsvId:curId,dbcsvId:descId},
						function(result){
							if(result){
								descNode.before(curNode);
								updateSpecValueOrderDisplay(curNode.attr("bcSpecId"));
							}
						}
					);
				});
				$(document).on("click","tr.l-2 i.arrM-N",function(){
					if($(this).hasClass("disable")){
						return;
					}
					var curNode = $(this).parents("tr.l-2");
					var curId = curNode.attr("bcSpecValueId");
					var descNode = curNode.next();
					var descId = descNode.attr("bcSpecValueId");
					$.post(
						"${ctx}/catespec/updateBcSpecValueOrder",
						{sbcsvId:curId,dbcsvId:descId},
						function(result){
							if(result){
								descNode.after(curNode);
								updateSpecValueOrderDisplay(curNode.attr("bcSpecId"));
							}
						}
					);
				});
				$(document).on("click","tr.l-2 i.arrM-B",function(){
					if($(this).hasClass("disable")){
						return;
					}
					var curNode = $(this).parents("tr.l-2");
					var curId = curNode.attr("bcSpecValueId");
					var descNode = curNode.parent().find("tr.l-2").last();
					var descId = descNode.attr("bcSpecValueId");
					$.post(
						"${ctx}/catespec/updateBcSpecValueOrder",
						{sbcsvId:curId,dbcsvId:descId},
						function(result){
							if(result){
								descNode.after(curNode);
								updateSpecValueOrderDisplay(curNode.attr("bcSpecId"));
							}
						}
					);
				});
				$(document).on("click","tr.l-2 td input[name=isFilter]",function(){
					var bcSpecValueId = $(this).parents("tr.l-2").attr("bcSpecValueId");
					var isFilter = $(this).is(":checked");
					var node = $(this);
					$.post(
						"${ctx}/catespec/updateBcSpecValueFilter",
						{bcSpecValueId:bcSpecValueId,isFilter:isFilter},
						function(result){
							if(!result){
								node.trigger("click");
							}
						}
					);
				});
				$(document).on("click","tr.l-2 td input[name=isMobileDisplay]",function(){
					var bcSpecValueId = $(this).parents("tr.l-2").attr("bcSpecValueId");
					var isMobileDisplay = $(this).is(":checked");
					var node = $(this);
					$.post(
						"${ctx}/catespec/updateBcSpecValueIsMD",
						{bcSpecValueId:bcSpecValueId,isMobileDisplay:isMobileDisplay},
						function(result){
							if(!result){
								node.trigger("click");
							}
						}
					);
				});
				$(document).on("click","tr.l-2 td a[name=delete]",function(){
					var bcSpecValueId = $(this).parents("tr.l-2").attr("bcSpecValueId");
					var msg = "<p><span>•</span>您确定取消该规格值的关联？</p>";
					$.modaldialog(msg,{
						title : '删除规格名',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){deleteBcSpecValue(bcSpecValueId);}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
				});
				$(window).resize(function() {
					if ($("#bc_show").is(":visible")) {
						showPop("#bc_show");
					}
				});
			});
			function showPop(id) {
				var objW = $(window);
				var objP = $(id);
				var brsW = objW.width();
				var brsH = objW.height();
				var popW = objP.width();
				var popH = objP.height();
				var left = (brsW - popW) / 2;
				var top = (brsH - popH) / 2;
				objP.css({
					"margin-left" : 0,
					"margin-top" : 0,
					"left" : left,
					"top" : top
				});
			}
			function setChkAll(){
				var allCheck = true;
				if ($("input[name=chkSel]").size() == 0) {
					return false;
				}
				$("input[name=chkSel]").each(function(){
					var check = $(this).prop("checked");
					if(!check){
						allCheck = false;
						return;
					}
				});
				$("#chkAll").prop("checked",allCheck);
			}
			function setBatchDelBtn(){
				var anyCheck = false;
				$("input[name=chkSel]").each(function(){
					var check = $(this).prop("checked");
					if(check){
						anyCheck = true;
						return;
					}
				});
				if(anyCheck){
					$("#batchDelete").removeClass("disabled");
					$("#batchDelete").attr("disabled",false);
				}else{
					$("#batchDelete").addClass("disabled");
					$("#batchDelete").attr("disabled",true);
				}
			}
			function fetchSubCategory(elemId, pId) {
				$('#tc').empty().append('<option value="-1">请选择</option>');
				if(pId == "-1"){
					if(elemId == "#tc"){
						$('#tc').empty().append('<option value="-1">请选择</option>');
					} else if (elemId == "#sc") {
						$('#sc').empty().append('<option value="-1">请选择</option>');
					}
				} else {
					$.post(
						"${ctx}/category/noAuth/bc/pList",
						{pId:pId},
						function(list){
							if (list != null && list.length > 0) {
								appendOption(elemId, list);
							}
						}
					);
				}
			}
			function appendOption(elemId, list){
				var sel$ = $(elemId);
				sel$.empty();

				sel$.append('<option value="-1">请选择</option>');
				$.each(list, function() {
					sel$.append('<option value="' +  this.bcId + '">' + this.bcName
							+ '</option>');
				});
			}
			function createTable(){
				$("#bcDisplay").empty().append("<td id='fcName' bcId=''></td>" + 
						"<td id='scName' bcId=''></td>" + 
						"<td id='tcName' bcId=''></td>");
				$("#fcName").attr("bcId",$("#fc").val());
				$("#fcName").text($("#fc").find("option:selected").text());
				$("#scName").attr("bcId",$("#sc").val());
				$("#scName").text($("#sc").find("option:selected").text());
				$("#tcName").attr("bcId",$("#tc").val());
				$("#tcName").text($("#tc").find("option:selected").text());
			}
			function showBcSpecList(){
				var bcId = $("#tcName").attr("bcId");
				$.post(
					"${ctx}/catespec/getBcSpecByBcId",
					{bcId:bcId},
					function(bcSpecList){
						addBcSpecList(bcSpecList);
						setChkAll();
						setBatchDelBtn();
					}
				);
			}
			function addBcSpecList(bcSpecList){
				var node = $("#mainTable");
				node.children("tbody").remove();
				$.each(bcSpecList, function(){
					node.append("<tbody class='l-1'>" + 
									"<tr bcSpecId='"+ this.bcSpecId +"' class='l-1H'>" + 
										"<td><input name='chkSel' type='checkbox' class='chk'><i class='arrow arrB-R'></i></td>" + 
										"<td name='name' class='align-l'></td>" + 
										"<td>" + 
											"<ul name='order'>" + 
												"<li><i class='arrM-T'></i></li>" + 
												"<li><i class='arrM-P'></i></li>" + 
												"<li><i class='arrM-N'></i></li>" + 
												"<li><i class='arrM-B'></i></li>" + 
											"</ul>" + 
										"</td>" + 
										"<td><input name='isFilter' type='checkbox' class='chk chks' "+ (this.isFilter=='1'?'checked':'') +"></td>" + 
										"<td></td>" + 
										"<td><a name='delete'>删除关联</a></td>" +
									"</tr>" + 
								"</tbody>");
					node.children().last().find("td[name=name]").text(this.specName);
				});
				updateSpecOrderDisplay();
			}
			function updateSpecOrderDisplay(){
				$("tbody.l-1 ul[name=order] li i").removeClass("disable");
				$("tbody.l-1").first().find("i.arrM-T").addClass("disable");
				$("tbody.l-1").first().find("i.arrM-P").addClass("disable");
				$("tbody.l-1").last().find("i.arrM-N").addClass("disable");
				$("tbody.l-1").last().find("i.arrM-B").addClass("disable");
			}
			function addBcSpecValueList(bcSpecId,bcSpecValueList){
				var node = $("tr[bcSpecId="+bcSpecId+"]").parent();
				$.each(bcSpecValueList,function(){
					node.append("<tr bcSpecId='"+ bcSpecId +"' bcSpecValueId='"+ this.bcSvId +"' class='l-2'>" + 
									"<td colspan='7'>" + 
									"<table class='table tableA'>" + 
										"<colgroup>" + 
											"<col width='80'>" + 
											"<col width='220'>" + 
											"<col width='160'>" + 
											"<col width='130'>" + 
											"<col width='130'>" + 
											"<col width='130'>" + 
										"</colgroup>" + 
										"<tbody>" + 
											"<tr>" + 
												"<td></td>" + 
												"<td class='align-l'>" + 
													"<div class='t-box'><i class='joint'></i><span name='name'></span></div>" + 
												"</td>" + 
												"<td>" + 
													"<ul name='order'>" + 
														"<li><i class='arrM-T'></i></li>" + 
														"<li><i class='arrM-P'></i></li>" + 
														"<li><i class='arrM-N'></i></li>" + 
														"<li><i class='arrM-B'></i></li>" + 
													"</ul>" + 
												"</td>" + 
												"<td><input name='isFilter' type='checkbox' class='chk chks' "+ (this.isFilter=='1'?'checked':'') +"></td>" + 
												"<td><input name='isMobileDisplay' type='checkbox' class='chk chks' "+ (this.isMobileDisplay=='1'?'checked':'') +"></td>" + 
												"<td><a name='delete'>删除关联</a></td>" + 
											"</tr>" + 
										"</tbody>" + 
									"</table>" + 
								"</td>" + 
							"</tr>");
					node.children().last().find("span[name=name]").text(this.specValueName);
				});
				updateSpecValueOrderDisplay(bcSpecId);
			}
			function updateSpecValueOrderDisplay(bcSpecId){
				$("tr.l-2[bcSpecId="+bcSpecId+"] ul[name=order] li i").removeClass("disable");
				$("tr.l-2[bcSpecId="+bcSpecId+"]").first().find("i.arrM-T").addClass("disable");
				$("tr.l-2[bcSpecId="+bcSpecId+"]").first().find("i.arrM-P").addClass("disable");
				$("tr.l-2[bcSpecId="+bcSpecId+"]").last().find("i.arrM-N").addClass("disable");
				$("tr.l-2[bcSpecId="+bcSpecId+"]").last().find("i.arrM-B").addClass("disable");
			}
			function deleteBcSpecValue(bcSpecValueId){
				$.post(
					"${ctx}/catespec/deleteBcSpecValue",
					{bcSpecValueId:bcSpecValueId},
					function(result){
						if(result){
							$("tr.l-2[bcSpecValueId="+bcSpecValueId+"]").remove();
						}
					}
				);
			}
			function deleteBcSpec(bcSpecId){
				$.post(
					"${ctx}/catespec/deleteBcSpec",
					{bcSpecId:bcSpecId},
					function(result){
						if(result){
							$("tr.l-1H[bcSpecId="+bcSpecId+"]").parent().remove();
							setChkAll();
							setBatchDelBtn();
						} else {
							showBcSpecList();
						}
					}
				);
			}
			function deleteBcSpecs(){
				var bcSpecIds = [];
				$("input[name=chkSel]:checked").each(function(){
					var bcSpecId = $(this).parents("tr.l-1H").attr("bcSpecId");
					bcSpecIds.push(bcSpecId);
				});
				if(bcSpecIds.length <= 0){
					return;
				}
				$.post(
					"${ctx}/catespec/deleteBcSpecs",
					{bcSpecIds:bcSpecIds.join(',')},
					function(result){
						if(result){
							$.each(bcSpecIds,function(){
								$("tr.l-1H[bcSpecId="+this+"]").parent().remove();
							});
							setChkAll();
							setBatchDelBtn();
						} else {
							showBcSpecList();
						}
					}
				);
			}
		</script>
		
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- propertyMain -->
		<div class="propertyMain normsMain">
			<div class="hintBar">
				<dl>
					<dt><i class="icon i-exclaim"></i></dt>
					<dd>
						<h4>请注意：</h4>
						<ul>
							<li><em>·</em> 该功能支持对某一个基础类目,添加或修改其关联规格；</li>
							<li><em>·</em>页面设置完毕，将及时立即保存。</li>
							<li><em>·</em>新添加规格时，如果有颜色和尺码等相关用于sku的规格，请将颜色排于尺码前边，以便于商品发布时显示。</li>
						</ul>
					</dd>
				</dl>
			</div>
			<form class="form formA">
				<fieldset>
					<div class="legend"><h3>分类关联管理</h3></div>
					<dl class="item">
						<dt class="item-label"><label><em>*</em>类目选择：</label></dt>
						<dd class="item-cont">
							<button id="selectBC" type="button" class="btnA">+ 选择基础类目</button>
							<div class="errMeg">
								<p><em>*</em>每次只允许选择一个3级基础类目，重新选择则替换之前已选类目。</p>
							</div>
							<table class="table tableD">
								<colgroup>
									<col width="180">
									<col width="180">
									<col width="180">
								</colgroup>
								<thead>
									<tr>
										<th>一级类目</th>
										<th>二级类目</th>
										<th>三级类目</th>
									</tr>
								</thead>
								<tbody>
									<tr id="bcDisplay">
										<td colSpan="3">请选择基础类目</td>
									</tr>
								</tbody>
							</table>
						</dd>
					</dl>
					<dl class="item">
						<dt class="item-label"><label><em>*</em>关联规格：</label></dt>
						<dd class="item-cont item-property">
							<div class="actionBars">
								<input id="selectSpec" type="button" class="btn disabled" disabled value="+ 选择关联规格">
							</div>
							<div class="checkAll">
								<div><input id="chkAll" autocomplete="off" type="checkbox" class="chk">全选</div>
								<input id="batchDelete" type="button" value="批量取消关联" class="btn disabled" disabled />
							</div>
							<!-- table -->
							<table id="mainTable" class="table tableA">
								<colgroup>
									<col width="80">
									<col width="220">
									<col width="160">
									<col width="130">
									<col width="130">
									<col width="130">
								</colgroup>
								<thead>
									<tr>
										<th>序号</th>
										<th class="align-l">关联规格</th>
										<th>排序</th>
										<th>是否web筛选项</th>
										<th>是否手机标签</th>
										<th class="align-c">操作</th>
									</tr>
								</thead>
								
							</table>
							<!-- table end -->
						</dd>
					</dl>
				</fieldset>
			</form>
		</div>
		
		<div id="bc_mask"></div>
		<div id="bc_show" class="pop pop-type" style="display: none">
			<div class="hd">
				<h1>操作确认</h1>
				<span><i class="icon i-close" title="关闭"></i></span>
			</div>
			<div class="bd">
				<div class="pop-con">
					<form class="form">
						<fieldset>	
							<div class="item">
								<div class="item-label"><label><em>*</em><strong>一级类目：</strong></label></div>
								<div class="item-cont">
									<div class="select">
										<select id="fc" name="fc">
										    <option value="-1">请选择</option>
										</select>
									</div>
									<div id="fcE" class="hint error"></div>
								</div>
							</div>
							<div class="item">
								<div class="item-label"><label><em>*</em><strong>二级类目：</strong></label></div>
								<div class="item-cont">
									<div class="select">
										<select id="sc" name="sc">
										    <option value="-1">请选择</option>
										</select>
									</div>
									<div id="scE" class="hint error"></div>
								</div>
							</div>
							<div class="item last">
								<div class="item-label"><label><em>*</em><strong>三级类目：</strong></label></div>
								<div class="item-cont">
									<div class="select">
										<select id="tc" name="tc">
										    <option value="-1">请选择</option>
										</select>
									</div>
									<div id="tcE" class="hint error"></div>
								</div>
							</div>
						</fieldset>
					</form>
				</div>
				<div class="formBtn">
					<input id="submit" type="submit" value="提 交" class="btnB btn-s">
					<input id="cacel" type="button" value="取 消" class="btn btn-s">
				</div>
					
			</div>
		</div>
	</body>
</html>