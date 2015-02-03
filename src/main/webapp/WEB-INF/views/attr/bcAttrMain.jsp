<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>类目属性关联-维护页</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/page.js?t=2014061701"></script>
	<script type="text/javascript" src="../static/js/jquery.md.js?t=2014102001"></script>
	<script type="text/javascript" src="../static/js/cateSel.js?t=2014102001"></script>
	
	<!-- main -->
			<div class="main">
				<!-- foldbarV -->
				<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
				<!-- foldbarV end -->
				<!-- propertyMain -->
				<div class="propertyMain">
					<div class="hintBar">
						<dl>
							<dt><i class="icon i-exclaim"></i></dt>
							<dd>
								<h4>请注意：</h4>
								<ul>
									<li><em>·</em>该功能支持对某一个基础类目,添加或修改其关联属性</li>
									<li><em>·</em>页面设置完毕，将及时立即保存</li>
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
									<button type="button" class="btnA" onclick="selCateClick()">+ 选择基础类目</button>
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
											<tr>
												<td id="firstCate"></td>
												<td id="secondCate"></td>
												<td id="thirdCate"></td>
											</tr>
										</tbody>
									</table>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>关联属性：</label></dt>
								<dd class="item-cont item-property">
									<div class="actionBars">
										<input id="bindAttr" type="button" class="btn disabled" value="+ 选择关联属性" disabled="disabled" >
									</div>
									<div class="checkAll">
										<div><input id="allCheck" type="checkbox" class="chk" >全选</div>
										<input id="multiUnbind" type="button" value="批量取消关联" class="btn disabled" >
										<input id="bcId" type="hidden" >
										<!-- <p class="sort-operate"><span class="sort-open">展开</span>|<span class="trigger">收起</span></p> -->
									</div>
									<!-- table -->
									<table id="mainTable" class="table tableA">
										<colgroup>
											<col width="60">
											<col width="140">
											<col width="140">
											<col width="120">
											<col width="90">
											<col width="100">
											<col width="100">
											<col width="100">
										</colgroup>
										<thead id="thead">
											<tr>
												<th>序号</th>
												<th class="align-l">关联属性</th>
												<th>排序</th>
												<th>填写方式</th>
												<th>是否必填</th>
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
				<!-- propertyMain end -->
			</div>
			<!-- main end -->

	<script type="text/javascript">
		var tBcId = -1;
		var newPage;
		
		$(function() {
			$("#bindAttr").on("click", function(event){
				newPage = window.open('${ctx}/cateattr/attrlist','bind','width='+(window.screen.availWidth-5)+',height='+(window.screen.availHeight-30)+ ',top=0,left=0,toolbar=no,menubar=no,scrollbars=yes, resizable=no,location=no, status=no');
			});
			
			selectAllCheck();
		});
		 
		$(window).unload(function(){
		  	if(newPage && newPage.open && !newPage.closed) { 
		  		newPage.close(); 
		  	} 
		});
		
		function selectAllCheck() {
			$("#allCheck").on("click", function(event){
				if(this.checked){ 
					$("#mainTable tbody tr td input[name='sel']").each(function(){this.checked = true;}); 
					$('#multiUnbind').removeClass("disabled").prop("disabled", false);
				}else{ 
					$("#mainTable tbody tr td input[name='sel']").each(function(){this.checked = false;}); 
					$('#multiUnbind').addClass("disabled").prop("disabled", true);
				} 
			});
			
			$("#multiUnbind").on("click", function(event){
				var ids = [];
				 
				$("#mainTable tbody tr td input[name='sel']").each(function(){
		           	if(this.checked){
		           		ids.push($(this).parents("tr[id]").attr("id").substring(1));
		           	}
		        });
				 
				if(ids.length > 0){
					$.modaldialog('<p>您确定批量删除相关属性？</p>',{
						title : '批量删除',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
							$.ajax({
								url : "${ctx}/cateattr/bcattrunbind",
								type : "POST",
								traditional :true, 
								data : {bcAttrId : ids},
								success : function(re) {
									if(re == 1){
										/* for(var id in ids){
											$("#_"+id).remove();
										} */
										
										loadBindAttr();
									}
								}
							});
						}}, {text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
				}
			});
		}
		
		function checkAllChecked(event) {
			event.stopPropagation();
			
			var chkAllFlag = this.checked;
			if(chkAllFlag){ 
				$('#multiUnbind').removeClass("disabled").prop("disabled", false);
				 
				$("#mainTable tbody tr td input[name='sel']").each(function(){
		           	if(!this.checked){
		        	   	chkAllFlag = false;
		        	   	return false;
		           	}
		        });
			}else{
				$('#multiUnbind').prop("disabled", true).addClass("disabled");
				
				$("#mainTable tbody tr td input[name='sel']").each(function(){
		           	if(this.checked){
		           		$('#multiUnbind').removeClass("disabled").prop("disabled", false);
		        	   	return false;
		           	}
		        });
			}
			 
			$("#allCheck").prop("checked", chkAllFlag);
		}
		
		function selCateClick() {
			$.modaldialog('<form class="form">'+
						'<fieldset>'+
					'<div class="item">'+
					'<div class="item-label"><label><em>*</em><strong>一级类目：</strong></label></div>'+
					'<div class="item-cont">'+
						'<div class="select">'+
							'<select name="fc" id="fc">'+
							    '<option>请选择</option>'+
							'</select>'+
						'</div>'+
						'<div id="fcE" class="hint error"></div>'+
					'</div>'+
					'</div>'+
					'<div class="item">'+
						'<div class="item-label"><label><em>*</em><strong>二级类目：</strong></label></div>'+
						'<div class="item-cont">'+
							'<div class="select">'+
								'<select name="sc" id="sc">'+
								    '<option>请选择</option>'+
								'</select>'+
							'</div>'+
							'<div id="scE" class="hint error"></div>'+
						'</div>'+
					'</div>'+
					'<div class="item last">'+
						'<div class="item-label"><label><em>*</em><strong>三级类目：</strong></label></div>'+
						'<div class="item-cont">'+
							'<div class="select">'+
								'<select name="tc" id="tc">'+
								    '<option>请选择</option>'+
								'</select>'+
							'</div>'+
							'<div id="tcE" class="hint error"></div>'+
						'</div>'+
					'</div></fieldset>'+
						'</form>', {
				title:"操作确认",
				dialogClass:"pop-type",
				buttons : [{text : '提&nbsp;&nbsp;交', click:selectdHandle},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
			});
			
			cateSelect.init("${ctx}");
		}
		
		function selectdHandle() {
			var re = true;
			
			var fBcId = $('#fc').val();
			
			if(fBcId > -1){
				 $('#fcE').text("");
				 
				 var sBcId = $('#sc').val();
				 if(sBcId > -1){
					 $('#scE').text("");
					 
					 tBcId = $('#tc').val();
					 if(tBcId > -1){
						 re = false;
						 $('#bcId').val(tBcId);
						 $('#tcE').text("");
						 
						 $('#firstCate').text($('#fc').find("option:selected").text());
						 $('#secondCate').text($('#sc').find("option:selected").text());
						 $('#thirdCate').text($('#tc').find("option:selected").text());
						 
						 $('#bindAttr').removeClass("disabled").prop("disabled", false);
						 
						 loadBindAttr();
					 }else{
						 $('#tcE').text("请选择三级类目");
					 }
				 }else{
					$('#scE').text("请选择二级类目");
				 }
			}else{
				$('#fcE').text("请选择一级类目");
			}
			
			return re;
		}
		
		function loadBindAttr() {
			$("#mainTable > tbody").remove();
			
			$.ajax({
				url : "${ctx}/cateattr/list",
				type : "POST",
				data : {bcId : tBcId},
				success : function(bcAttrList) {
					var prev$ = $("#thead");
					
					if(bcAttrList!=null && bcAttrList.length>0){
						$.each(bcAttrList, function(index, bcAttr) {
							var str = '<tbody class="l-1">' +
								'<tr id="_'+bcAttr.bcAttrId+'" class="l-1H">' +
								'<td><input name="sel" type="checkbox" class="chk"><i class="arrow arrB-R"></i></td>' +
								'<td class="align-l"></td>' +
								'<td><ul>';  
									if(bcAttrList.length == 1){
										str += '<li><i class="arrM-T disable"></i></li>' +
										'<li><i class="arrM-P disable"></i></li>' +
										'<li><i class="arrM-N disable"></i></li>'+
										'<li><i class="arrM-B disable"></i></li>';
									}else{
										if(index == 0){
											str += '<li><i class="arrM-T disable"></i></li>' +
											'<li><i class="arrM-P disable"></i></li>' +
											'<li><i class="arrM-N"></i></li>'+
											'<li><i class="arrM-B"></i></li>';
										}else if(index == bcAttrList.length-1){
											str += '<li><i class="arrM-T"></i></li>' +
											'<li><i class="arrM-P"></i></li>' +
											'<li><i class="arrM-N disable"></i></li>' +
											'<li><i class="arrM-B disable"></i></li>';
										}else{
											str += '<li><i class="arrM-T"></i></li>' +
											'<li><i class="arrM-P"></i></li>' +
											'<li><i class="arrM-N"></i></li>' +
											'<li><i class="arrM-B"></i></li>';
										}
									}
								str += '</ul></td>' +
								'<td><div class="select"><select>';
										str += (bcAttr.displayMode==1)?'<option selected="selected" value="1">下拉菜单</option>':'<option value="1">下拉菜单</option>';
										str += (bcAttr.displayMode==2)?'<option selected="selected" value="2">复选框</option>':'<option value="2">复选框</option>';
								str += '</select></div></td>' +
								'<td><input type="checkbox" class="chk chks"';
								if(bcAttr.isRequire){
									str +=' checked="checked"';
								}
								str +=' /></td>' +
								'<td><input type="checkbox" class="chk chks"';
								if(bcAttr.isFilter){
									str +=' checked="checked"';
								}
								str +=' /></td>' +
								'<td></td>' +
								'<td><a href="javascript:void(0);">取消关联</a></td>' +
							'</tr></tbody>';
							
							prev$.after(str);
							prev$ = prev$.next();
							prev$.find(".align-l").text(bcAttr.attrName);
							
							bcAttrEvent(prev$);
						});
						
						//排序处理
						bcAttrOrderEvent($("#mainTable"));
					}else{
						var str = '<tbody><tr class="last t-empty">' +
										'<td colspan="8">暂无已关联的属性</td>' +
									'</tr></tbody>';
						prev$.after(str);
					}
				}
			});
			
			var checked = false;
			$("#mainTable tbody tr td input[name='sel']").each(function(){
	           	if(this.checked){
	           		checked = true;
	           		$('#multiUnbind').removeClass("disabled").prop("disabled", false);
	        	   	return false;
	           	}
	        });
			if(!checked){
				if(!$('#multiUnbind').hasClass("disabled")){
	           		$('#multiUnbind').addClass("disabled").prop("disabled", true);
				}
           	}
		}
		function bcAttrOrderEvent(table$) {
			table$.find(" > tbody > tr > td li").on("click", function(event){
				event.stopPropagation();
				var tr$ = $(this).parent().parent().parent();
				
				var sBcAttrId = tr$.attr("id").substring(1);
				var dBcAttrId = 0;
				
				var i$ =  $(event.target);
				if (!i$.hasClass("disable")) {
					if (i$.hasClass("arrM-T")) {
						dBcAttrId = table$.find(" > tbody:first > tr:first").attr("id").substring(1);
					} else if (i$.hasClass("arrM-P")) {
						dBcAttrId = tr$.parent().prev().find(" > tr:first").attr("id").substring(1);
					} else if (i$.hasClass("arrM-N")) {
						dBcAttrId = tr$.parent().next().find(" > tr:first").attr("id").substring(1);
					} else if (i$.hasClass("arrM-B")) {
						dBcAttrId =  table$.find(" > tbody:last > tr:first").attr("id").substring(1);
					}
				}
				
				$.ajax({
					url : "${ctx}/cateattr/bcattrorder",
					type : "POST",
					data : {
							sbcaId:sBcAttrId,
							dbcaId:dBcAttrId
						   },
			 		success : function(re) {
			 			loadBindAttr();
					}
				});
			});
		}
		function bcAttrEvent(tbody$) {
			var tr$ = tbody$.find(".l-1H");
			
			var bcAttrId = tr$.attr("id").substring(1);
			
			tr$.find("td:eq(0) input").on("click", checkAllChecked);
			
			tr$.find("td:eq(3) select").on("change", function(event){
				event.stopPropagation();
				
				modBcAttr(bcAttrId, $(this).val(), 1);
			}).on("click", function(event){
				event.stopPropagation();
			});
			
			tr$.find("td:eq(4) input").on("click", function(event){
				event.stopPropagation();
				
				modBcAttr(bcAttrId, this.checked?1:0, 2);
			});
			tr$.find("td:eq(5) input").on("click", function(event){
				event.stopPropagation();
				
				modBcAttr(bcAttrId, this.checked?1:0, 3);
			});
			tr$.find("td:eq(7) a").on("click", function(event){
				event.stopPropagation();
				
				$.modaldialog('<p>您确定取消此该属性名和类目的关联？取消后其相应属性值也将取消！</p>',{
					title : '取消关联',
					buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
						$.ajax({
							url : "${ctx}/cateattr/bcattrunbind",
							type : "POST",
							traditional :true, 
							data : {bcAttrId : bcAttrId},
							success : function(re) {
								if(re == 1){
									loadBindAttr();
									//tbody$.remove();
								}
							}
						});
					}}, {text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
				});
			});
			
			tr$.on("click", loadBcAttrValue);
		}
		
		function loadBcAttrValue() {
			var tr$ = $(this);
			var tbody$ = tr$.parent();
			
			tbody$.toggleClass("on");
			
			if(tbody$.hasClass("on")){
				tr$.find("td:first i").removeClass("arrB-R").addClass("arrB-D");
			}else{
				tr$.find("td:first i").removeClass("arrB-D").addClass("arrB-R");
			}
			
			var bcAttrId = tr$.attr("id").substring(1);
			
			if(!tr$.hasClass("fetch")){
				tr$.addClass("fetch");
				
				$.ajax({
					url : "${ctx}/cateattr/valuelist",
					type : "POST",
					data : {bcAttrId : bcAttrId},
					success : function(bcAVList) {
						if(bcAVList!=null && bcAVList.length>0){
							$.each(bcAVList, function( index, bcAttrAttrValue ) {
								var attrValueStr = '<tr class="l-2 l-half on"><td colspan="8"><table class="table">' +
									'<colgroup>' +
										'<col width="60">' +
										'<col width="140">' +
										'<col width="140">' +
										'<col width="130">' +
										'<col width="100">' +
										'<col width="90">' +
										'<col width="90">' +
										'<col width="100">' +
									'</colgroup>' +
									'<tbody><tr id="'+bcAttrAttrValue.bcAvId+'" class="l-2H">' +
											'<td></td>' +
											'<td class="align-l">' +
												'<div class="t-box"><i class="joint"></i><span></span></div>' +
											'</td>' +
											'<td>' +
												'<ul>';  
													if(bcAVList.length == 1){
														attrValueStr += '<li><i class="arrM-T disable"></i></li>' +
														'<li><i class="arrM-P disable"></i></li>' +
														'<li><i class="arrM-N disable"></i></li>'+
														'<li><i class="arrM-B disable"></i></li>';
													}else{
														if(index == 0){
															attrValueStr += '<li><i class="arrM-T disable"></i></li>' +
															'<li><i class="arrM-P disable"></i></li>' +
															'<li><i class="arrM-N"></i></li>'+
															'<li><i class="arrM-B"></i></li>';
														}else if(index == bcAVList.length-1){
															attrValueStr += '<li><i class="arrM-T"></i></li>' +
															'<li><i class="arrM-P"></i></li>' +
															'<li><i class="arrM-N disable"></i></li>' +
															'<li><i class="arrM-B disable"></i></li>';
														}else{
															attrValueStr += '<li><i class="arrM-T"></i></li>' +
															'<li><i class="arrM-P"></i></li>' +
															'<li><i class="arrM-N"></i></li>' +
															'<li><i class="arrM-B"></i></li>';
														}
													}
								attrValueStr += '</ul>' +
											'</td>' +
											'<td></td><td></td>' +
											'<td><input type="checkbox" class="chk chks"';
											if(bcAttrAttrValue.isFilter){
												attrValueStr +=' checked="checked"';
											}
											attrValueStr +=' /></td>' +
											'<td><input type="checkbox" class="chk chks"';
											if(bcAttrAttrValue.isMobileDisplay){
												attrValueStr +=' checked="checked"';
											}
											attrValueStr +=' /></td>' +
											'<td><a href="javascript:void(0);">取消关联</a></td>' +
										'</tr></tbody></table></td></tr>';
										
								tr$.after(attrValueStr);
								tr$ = tr$.next();
								tr$.find("span").text(bcAttrAttrValue.attrValueName);
								
								bcAttrValueEvent(tr$.find(".l-2H"));
								 
								//子属性列表
								if(bcAttrAttrValue.subList!=null && bcAttrAttrValue.subList.length>0){
									var subTr$ = tr$.find(".l-2H");
									var subLength = bcAttrAttrValue.subList.length;
									
									$.each(bcAttrAttrValue.subList, function( index, bcAttrAttrValue ) {
										var attrValueStr = '<tr class="l-3"><td colspan="8"><table class="table">' +
										'<colgroup>' +
											'<col width="60">' +
											'<col width="140">' +
											'<col width="140">' +
											'<col width="130">' +
											'<col width="100">' +
											'<col width="90">' +
											'<col width="90">' +
											'<col width="100">' +
										'</colgroup>' +
										'<tbody><tr id="'+bcAttrAttrValue.bcAvId+'" class="l-3H">' +
														'<td></td>' +
														'<td class="align-l">' +
															'<div class="t-box t-boxs"><i class="joint"></i><span></span></div>' +
														'</td>' +
														'<td><ul>';  
																if(subLength == 1){
																	attrValueStr += '<li><i class="arrM-T disable"></i></li>' +
																	'<li><i class="arrM-P disable"></i></li>' +
																	'<li><i class="arrM-N disable"></i></li>'+
																	'<li><i class="arrM-B disable"></i></li>';
																}else{
																	if(index == 0){
																		attrValueStr += '<li><i class="arrM-T disable"></i></li>' +
																		'<li><i class="arrM-P disable"></i></li>' +
																		'<li><i class="arrM-N"></i></li>'+
																		'<li><i class="arrM-B"></i></li>';
																	}else if(index == subLength-1){
																		attrValueStr += '<li><i class="arrM-T"></i></li>' +
																		'<li><i class="arrM-P"></i></li>' +
																		'<li><i class="arrM-N disable"></i></li>' +
																		'<li><i class="arrM-B disable"></i></li>';
																	}else{
																		attrValueStr += '<li><i class="arrM-T"></i></li>' +
																		'<li><i class="arrM-P"></i></li>' +
																		'<li><i class="arrM-N"></i></li>' +
																		'<li><i class="arrM-B"></i></li>';
																	}
																}
										attrValueStr += '</ul></td>' +
														'<td></td><td></td><td></td><td></td>' +
														'<td><a href="javascript:void(0);">取消关联</a></td>' +
											'</tr></tbody></table></td></tr>';
											
										subTr$.after(attrValueStr);
										subTr$ = subTr$.next();
										subTr$.find("span").text(bcAttrAttrValue.attrValueName);
										subBcAttrValueEvent(subTr$.find(".l-3H"));
									});
								}
								
								//子级属性值排序事件
								subBcAttrValueOrderEvent(tr$.find("tbody:first"));
							});
							//属性值排序事件
							bcAttrValueOrderEvent(tbody$);
						}
					}
				});
			}
		}
		function bcAttrValueOrderEvent(tbody$) {
			tbody$.find(".l-2H li").on("click", function(event){
				event.stopPropagation();
				var tr$ = $(this).parent().parent().parent();
				
				var sBcAttrValueId = tr$.attr("id");
				var dBcAttrValueId = 0;
				
				var i$ =  $(event.target);
				if (!i$.hasClass("disable")) {
					if (i$.hasClass("arrM-T")) {
						dBcAttrValueId = tbody$.find(".l-2H:first").attr("id");
					} else if (i$.hasClass("arrM-P")) {
						dBcAttrValueId = tr$.parents(".l-2").prev().find(".l-2H").attr("id");
					} else if (i$.hasClass("arrM-N")) {
						dBcAttrValueId = tr$.parents(".l-2").next().find(".l-2H").attr("id");
					} else if (i$.hasClass("arrM-B")) {
						dBcAttrValueId =  tbody$.find(".l-2H:last").attr("id");
					}
				}
				 
				modAttrValueOrders(0, sBcAttrValueId, dBcAttrValueId);
			});
		}
		
		function subBcAttrValueOrderEvent(tbody$) {
			tbody$.find(".l-3H li").on("click", function(event){
				event.stopPropagation();
				var tr$ = $(this).parent().parent().parent();
				
				var sBcAttrValueId = tr$.attr("id");
				var dBcAttrValueId = 0;
				
				var i$ =  $(event.target);
				if (!i$.hasClass("disable")) {
					if (i$.hasClass("arrM-T")) {
						dBcAttrValueId = tbody$.find("tbody:first > tr:first").attr("id");
					} else if (i$.hasClass("arrM-P")) {
						dBcAttrValueId = tr$.parents(".l-3").prev().find(".l-3H").attr("id");
					} else if (i$.hasClass("arrM-N")) {
						dBcAttrValueId = tr$.parents(".l-3").next().find(".l-3H").attr("id");
					} else if (i$.hasClass("arrM-B")) {
						dBcAttrValueId =  tbody$.find("tbody:last > tr:first").attr("id");
					}
				}
				
				modAttrValueOrders(1, sBcAttrValueId, dBcAttrValueId);
			});
		}
		
		function modAttrValueOrders(flag, sBcAvId, dBcAvId) {
			var bcAttrId = $("#"+sBcAvId).parents(".l-1").find(".l-1H").attr("id").substring(1);
			
			$.ajax({
				url : "${ctx}/cateattr/bcattrvalueorder",
				type : "POST",
				data : {
						flag:flag,
						sBcAvId:sBcAvId,
						dBcAvId:dBcAvId
					   },
		 		success : function(re) {
		 			reloadAttrValues(bcAttrId);
				}
			});   
		}
		
		//加载属性和子属性关系
		function reloadAttrValues(bcAttrId) {
			var tr$ = $("#_"+bcAttrId);
			
			if(tr$.length > 0){
				if(tr$.hasClass("fetch")){
					tr$.parent().find(".l-2").remove();
		 			tr$.trigger("click").removeClass("fetch").trigger("click");
				}
			}else{
				loadBindAttr();				
			}
		}
		
		function subBcAttrValueEvent(tr$) {
			var bcAvId = tr$.attr("id");
			
			tr$.find("td:eq(7) a").on("click", function(event){
				event.stopPropagation();
				
				$.modaldialog('<p>您确定取消该属性值的关联？</p>',{
					title : '取消关联',
					buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
						$.ajax({
							url : "${ctx}/cateattr/bcattrvalueunbind",
							type : "POST",
							data : {bcAvId : bcAvId},
							success : function(re) {
								if(re == 1){
									//tr$.parents(".l-3").remove();
									var bcAttrId = tr$.parents(".l-1").find(".l-1H").attr("id").substring(1);
									reloadAttrValues(bcAttrId);
								}
							}
						}); 
					}}, {text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
				});
			});
		}
		
		function bcAttrValueEvent(tr$) {
			var bcAvId = tr$.attr("id");
			 
			tr$.find("td:eq(5) input").on("click", function(event){
				event.stopPropagation();
				
				modBcAttrValue(bcAvId, this.checked?1:0, 1);
			});
			
			tr$.find("td:eq(6) input").on("click", function(event){
				event.stopPropagation();
				
				modBcAttrValue(bcAvId, this.checked?1:0, 2);
			});
			
			tr$.find("td:eq(7) a").on("click", function(event){
				event.stopPropagation();
				
				$.modaldialog('<p>您确定取消该属性值的相关关联？取消后相应二级属性值也将取消！</p>',{
					title : '取消关联',
					buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
						$.ajax({
							url : "${ctx}/cateattr/bcattrvalueunbind",
							type : "POST",
							data : {bcAvId : bcAvId},
							success : function(re) {
								if(re == 1){
									//tr$.parents(".l-2").remove();
									var bcAttrId = tr$.parents(".l-1").find(".l-1H").attr("id").substring(1);
									reloadAttrValues(bcAttrId);
								}
							}
						}); 
					}}, {text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
				});
			});
		}
		
		//flag 1:修改显示方式,2:是否必填,3:是否筛选
		function modBcAttr(bcAttrId, value, flag) {
			$.ajax({
				url : "${ctx}/cateattr/update",
				type : "POST",
				data : {
						bcAttrId:bcAttrId,
						value:value,
						flag:flag,
						bcId:tBcId
					   },
				success : function(re) {
				}
			});
		}
		
		//flag 1:是否筛选,2:是否标签,3:显示位置
		function modBcAttrValue(bcAvId, value, flag) {
			$.ajax({
				url : "${ctx}/cateattr/valueupdate",
				type : "POST",
				data : {
						bcAvId:bcAvId,
						value:value,
						flag:flag,
						bcId:tBcId
					   },
		 		success : function(re) {
				}
			});
		}
	</script>
</body>
</html>