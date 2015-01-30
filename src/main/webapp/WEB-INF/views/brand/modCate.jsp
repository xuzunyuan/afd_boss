<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>修改类目-一网全城</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/jquery.md.js?t=2014071601"></script>
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
				<li><a href="${ctx}/brand/list?m=33">品牌管理</a><em>&gt;</em></li>
				<li><strong>类目管理</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- relateType -->
		<div class="relateType result">
			<div class="hintBar">
				<dl>
					<dt>
						<i class="icon i-exclaim"></i>
					</dt>
					<dd>
						<h4>请注意：</h4>
						<ul>
							<li><em>·</em>添加品牌时可以同时对多个基础类目进行添加</li>
							<li><em>·</em>中文品牌名称和英文品牌名称至少填写一项，同一个三级类目下面，品牌名称不能重复；拼音码填写的是中文品牌名全拼，如果没有中文品牌则填写英文品牌，字母全部小写。</li>
							<li><em>·</em>品牌Logo须与商标注册图文信息一致，尺寸400X200像素，格式jpg，大小不超过100K</li>
						</ul>
					</dd>
				</dl>
			</div>
		</div>
		<!-- relateType end -->
		<!-- resultUploding -->
		<div class="brandManagement brandManagements">
			<form id="myform" class="form formB" method="post" action="${ctx}/brand/add">
				<div class="legend">
					<!-- <div class="legend-meg">
						<span>品牌输入规则</span>
						<div class="mod-help">
							<i class="ico"></i>
							<div class="text">
								<div class="text-meg">
									<h6>品牌输入规划：</h6>
									<p>1.品牌名称严格采用该品牌官方描述名称，包括品牌中的中文描述、英文字符的大小写以及字符之间的符号（如两个单词间的空格有且仅有一个）；</p>
									<p>2.对于没有明确官方描述的英文名称，品牌采用每个单词首字母大写，单词的其他字母小写方式录入；</p>
									<p>3.英文品牌所有字符（含非字母字符）皆须是在英文半角状态下输入的字符，不能出现在中文状态下的或全角字符状态下输入的字符；</p>
									<p>4.同一个品牌有且只有一个品牌名称，即官方发布的品牌；</p>
									<p>5.至少填写一个中或英文品牌，同一个三级类目下品牌不可重复</p>
								</div>
							</div>
						</div>
					</div> -->
					<h3>类目标签管理</h3>
				</div>
				<fieldset>
					<dl class="item">
						<dt class="item-label"><label>品牌：</label></dt>
						<dd class="item-cont">
							<p><c:out value="${brandName}" /></p>
						</dd>
					</dl>
					<dl class="item">
						<dt class="item-label">
							<label><em>*</em>类目选择：</label>
						</dt>
						<dd class="item-cont">
							<input type="button" class="btn" value="+ 添加基础类目" onclick="selCateClick()">
							<div class="mod-help">
								<i class="ico"></i>
								<div class="text">
									<div class="text-meg">
										<p>此处是否web筛选项和是否手机标签为及时保存。</p>
									</div>
								</div>
							</div>
							<table class="table tableD">
								<colgroup>
									<col width="180">
									<col width="180">
									<col width="180">
									<col width="95">
									<col width="95">
									<col width="70">
								</colgroup>
								<thead>
									<tr>
										<th>一级类目</th>
										<th>二级类目</th>
										<th>三级类目</th>
										<th>是否web筛选项</th>
										<th>是否手机标签</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody id="table">
								</tbody>
							</table>
							<div id="cateWarn" class="hint error"></div>
						</dd>
					</dl>
				</fieldset>
			</form>
			<div class="formBtn">
				<button id="submitBtn" type="button" class="btnC" style="display:none">保 存</button>
				<input type="button" class="btn" value="返回" onclick="window.location.href='${ctx}/brand/list'">
			</div>
		</div>
		<!-- resultUploding end-->
	</div>
	<!-- main end -->

	<script type="text/javascript">
		var selBcObj = {}, selBcIdObj = {};
		var filterBCObj = {}, tagBCObj = {};
		var allTBcIds = [];
		var fBcId, sBcId, tBcIds = [];
		var bbcIds = {};
		
		$(function() {
			<c:if test="${not empty filterJSON}">
				filterBCObj = ${filterJSON};
			</c:if>
			
			<c:if test="${not empty tagJSON}">
				tagBCObj = ${tagJSON};
			</c:if>
			
			<c:if test="${not empty bbcIds}">
				bbcIds = ${bbcIds};
			</c:if>
			
			<c:if test="${not empty selBcObj}">
				selBcObj = ${selBcObj};
			</c:if>
			
			<c:if test="${not empty selBcIdObj}">
				selBcIdObj = ${selBcIdObj};
			</c:if>
			
			if(!jQuery.isEmptyObject(bbcIds)){
				createTable();
			}
			
			$('#submitBtn').click(function(){
				if(allTBcIds.length > 0){
					var bcShows = [];
					for(var i in allTBcIds){
						var showStr = allTBcIds[i] + "_";
						showStr += (filterBCObj[allTBcIds[i]]?"1_":"0_");
						showStr += (tagBCObj[allTBcIds[i]]?"1":"0");
						bcShows.push(showStr);
					}
					bcShows = bcShows.join(",");
					 
					$.ajax({
						url : "${ctx}/brand/modCate",
						type : "POST",
						data : {
							brandId:"${brandId}",
							bcIds:allTBcIds.join(","),
							bcShows:bcShows
						},
						async: false,
						success : function(re) {
							if(re == 1){
								$.modaldialog('<p>修改类目成功！</p>',{
									title:'修改类目',
									hasclose:false,
									buttons : [{text:'确&nbsp;&nbsp;定',click:function(){window.location.href='${ctx}/brand/list';}}]
								});
							}else if(re == 0){
								$.modaldialog('<p>修改类目失败！</p>',{title : '修改类目'});
							}
						}
					}); 
				}else{
					$("#cateWarn").text("请添加基础类目!");
				}
			});
		});
		
		function selectdHandle() {
			var re = true;
			
			fBcId = $('#fc').val();
			sBcId = $('#sc').val();
			
			if(fBcId > -1){
				 $('#tcE').text("");
				 
				 if(sBcId > -1){
					 $('#scE').text("");
					 
					 selBcObj[fBcId] = $('#fc').find("option:selected").text();
					 selBcObj[sBcId] = $('#sc').find("option:selected").text();
					 
					 tBcIds.length = 0;
					
					 $("#tc :checkbox:checked").each(function(){
						selBcObj[this.id] = $(this).next().text();
						tBcIds.push(this.id);
					 }); 
					
					 //有新增类目
					 if(tBcIds.length > 0){
						$('#tcE').text("");
						re = false;
						
						//addBcId(tBcIds, allTBcIds);
						
						//一级类目ID不存在 
						if(selBcIdObj[fBcId] == undefined){
							selBcIdObj[fBcId] = {};
							selBcIdObj[fBcId][sBcId] = $.merge([], tBcIds);
							selBcIdObj[fBcId]["tl"] = tBcIds.length;
							
							$.merge(allTBcIds, tBcIds);
							
							for(var i in tBcIds){
								filterBCObj[tBcIds[i]] = true;
								tagBCObj[tBcIds[i]] = true;
							};
						}else{//一级类目ID存在 
							//二级类目ID不存在 
							if(selBcIdObj[fBcId][sBcId] == undefined){
								selBcIdObj[fBcId][sBcId] = $.merge([], tBcIds);
								selBcIdObj[fBcId]["tl"] += tBcIds.length;
								
								$.merge(allTBcIds, tBcIds);
								
								for(var i in tBcIds){
									filterBCObj[tBcIds[i]] = true;
									tagBCObj[tBcIds[i]] = true;
								};
							}else{//二级类目ID存在 
								//保存三级类目
								
								var num = 0;
								for(var i in tBcIds){
									if(jQuery.inArray(tBcIds[i], selBcIdObj[fBcId][sBcId]) == -1){
										selBcIdObj[fBcId][sBcId].push(tBcIds[i]);
										
										allTBcIds.push(tBcIds[i]);
										
										filterBCObj[tBcIds[i]] = true;
										tagBCObj[tBcIds[i]] = true;
										num ++;
									};
								}
								
								selBcIdObj[fBcId]["tl"] += num;
							};
						} 
						
						createTable();
						
						if(allTBcIds.length > 0){
							$("#submitBtn").show();
						};
					 }else{
						 $('#tcE').text("请选择三级类目");
					 };
				 }else{
					$('#scE').text("请选择二级类目");
				 };
			}else{
				$('#fcE').text("请选择一级类目");
			}
			
			return re;
		}
		//创建表格
		function createTable() {
			if(allTBcIds.length > 0){
				$("#cateWarn").text("");
			}
			
			var t$ = $("#table");
			t$.empty();
			
			for(var fBcId in selBcIdObj){
				var fbool = true;
				
				for(var sBcId in selBcIdObj[fBcId]){
					var sbool = true;
					var tList = selBcIdObj[fBcId][sBcId];
					
					for(var index in tList){
						 var tr = "<tr>";
						 if(fbool){
							 tr += "<td rowspan='"+selBcIdObj[fBcId].tl+"'>"+selBcObj[fBcId]+"</td>";
							 fbool = false;
						 }
						 if(sbool){
							 tr += "<td rowspan='"+selBcIdObj[fBcId][sBcId].length+"'>"+selBcObj[sBcId]+"</td>";
							 sbool = false;
						 }
						 tr += "<td>"+selBcObj[tList[index]]+"</td>";
						 tr += '<td><input type="checkbox" name="filter" value="'+tList[index]+'" class="chk chks" ';
						 if(filterBCObj[tList[index]]){
							 tr += ' checked="checked"';
						 }
						 tr += ' ></td>';
						 tr += '<td><input type="checkbox" name="tag" value="'+tList[index]+'" class="chk chks" ';
						 if(tagBCObj[tList[index]]){
							 tr += ' checked="checked"';
						 }
						 tr += ' ></td>';
						 tr += "<td><a id='"+fBcId+"_"+sBcId+"_"+tList[index]+"' href='javascript:void(0);'>删除</a></td>";
						 tr += "</tr>";
						 	
						 t$.append(tr);
					};
				};
			}
			
			$("#table").find("a").click(function(){
				var idArr =  this.id.split("_");
				
				if(bbcIds[idArr[2]]){
					var params = {
									"brandBcId":bbcIds[idArr[2]], 
									"tId":idArr[2],
									"fId":idArr[0],
									"sId":idArr[1]
								 };
					
					$.modaldialog('<p>您确定删除此类目？</p>',{
						title : '类目删除',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:deleteBrand, param:params},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
					
				}else{
					deleteBrandId(idArr[0], idArr[1], idArr[2]);
				};
			}).end().find(":checkbox").click(function(){
				var tbcId = this.value;
				var flag,value;
				
				if($(this).attr("name") == "filter"){
					flag = 1;
					value = filterBCObj[tbcId] = this.checked;
				}else if($(this).attr("name") == "tag"){
					flag = 2;
					value = tagBCObj[tbcId] = this.checked;
				}
				
				//类目已存在 立即修改库状态
				if(bbcIds[tbcId]){
					modCateShow(bbcIds[tbcId], flag, value);
				};
			});
		}
		
		function modCateShow(bbcId, flag, value) {
			$.ajax({
				url : "${ctx}/brand/modShow",
				type : "POST",
				data : {
					brandBcId:bbcId,
					flag:flag,
					value:value
				},
				async: false,
				success : function(re) {
					if(re == 1){
						$.modaldialog('<p>修改成功！</p>',{
							title : '修改成功',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
						});
					}else if(re == 0){
						$.modaldialog('<p>修改失败！</p>',{title : '修改失败'});
					}
				}
			}); 
		}
		
		function deleteBrandId(fId, sId, tId) {
			delete filterBCObj[tId];
			delete tagBCObj[tId];
			
			var ind = jQuery.inArray(tId, selBcIdObj[fId][sId]);
			if(ind > -1){
				selBcIdObj[fId][sId].splice(ind, 1);
			}
			
			delete selBcObj[tId];
			
			if(selBcIdObj[fId].tl == 1){
				delete selBcIdObj[fId];
			}else{
				selBcIdObj[fId].tl--;
			}
			
			ind = jQuery.inArray(tId, allTBcIds);
			if(ind > -1){
				allTBcIds.splice(ind, 1);
			}
			
			//无新增类目隐藏按钮
			if(allTBcIds.length == 0){
				$("#submitBtn").hide();
			}
			
			createTable();
		}
		
		function deleteBrand(argu) {
			$.ajax({
				url : "${ctx}/brand/del",
				type : "POST",
				data : {
					brandId:"${brandId}",
					brandBcId:argu.brandBcId,
					bcId:argu.tId
				},
				async: false,
				success : function(re) {
					if(re == 1){
						$.modaldialog('<p>类目删除成功！</p>',{
							title : '类目删除成功',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){deleteBrandId(argu.fId, argu.sId, argu.tId);}}]
						});
					}else if(re == -1){
						$.modaldialog('<p>该类类目下品牌已经关联商品，不能被删除！</p>',{title : '类目不能被删除'}); 
					}else if(re == 0){
						$.modaldialog('<p>类目删除失败！</p>',{title : '类目删除成功'});
					}
				}
			}); 
		}
		
		//三级类目不存在增加,存在抛弃
		function addBcId(sbcIds, dbcIds) {
			var num = 0;
			for(var i in sbcIds){
				if(jQuery.inArray(sbcIds[i], dbcIds) == -1){
					dbcIds.push(sbcIds[i]);
					num ++;
				}
			}
			
			return num;
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
							'<label><input id="chkAll" type="checkbox" class="chk"><span>全选</span></label>'+
							'<div id="tcE" class="hint error"></div>'+
						'</div>'+
						'<div class="type-list">'+
							'<ul id="tc">'+
							'</ul>'+
						'</div>'+
					'</div></fieldset>'+
						'</form>', {
				title:"操作确认",
				dialogClass:"pop-type",
				buttons : [{text : '提&nbsp;&nbsp;交', click:selectdHandle},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
			});
			
			$('#chkAll').click(function(){
				if(this.checked){ 
					$("#tc :checkbox").each(function(){this.checked = true;}); 
				}else{ 
					$("#tc :checkbox").each(function(){this.checked = false;}); 
				} 
			});
			
			fetchSubCategory("#fc", 0);
			
			$('#fc').change(function() {
				$('#fcE').text(this.value==-1?"请选择一级类目":"");
				fetchSubCategory("#sc", this.value);
			});
			$('#sc').change(function() {
				$('#scE').text(this.value==-1?"请选择二级类目":"");
				fetchSubCategory("#tc", this.value);
			});
		}
		
		function fetchSubCategory(elemId, pId) {
			if(pId == "-1"){
				$('#tc').empty();
				if(elemId == "#sc"){
					$('#sc').empty().append('<option value="-1">请选择</option>');
				}
			}else if(pId >= 0){
				$.ajax({
					url : "${ctx}/category/noAuth/bc/pList",
					type : "POST",
					data : {
						pId : pId
					},
					async : false,
					success : function(list) {
						if (list != null && list.length > 0) {
							if(elemId == "#tc"){
								appendLi(elemId, list);
							}else{
								appendOption(elemId, list);
							}
						}
					}
				});
			}
		}
		function appendLi(elemId, objList) {
			var ul$ = $(elemId);
			ul$.empty();
			
			$.each(objList, function() {
				ul$.append('<li><label><input id="' +  this.bcId + '" type="checkbox" class="chk"><span>' +  this.bcName + '</span></label></li>');
			});
			 
			ul$.find(":checkbox").click(function(){
				var chkAllFlag = this.checked;
				if(chkAllFlag){ 
					ul$.find(":checkbox").each(function(){
			           	if(!this.checked){
			        	   	chkAllFlag = false;
			        	   	return false;
			           	}
			        });
					
					$('#tcE').text("");
				}
				
				$("#chkAll").prop("checked", chkAllFlag);
			});
		}
		function appendOption(elemId, objList) {
			var sel$ = $(elemId);
			sel$.empty();

			if ("#sc" === elemId) {
				$("#tc").empty();
			}

			sel$.append('<option value="-1">请选择</option>');
			$.each(objList, function() {
				sel$.append('<option value="' +  this.bcId + '">' + this.bcName
						+ '</option>');
			});
		}
	</script>
</body>
</html>