<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>品牌增加-一网全城</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/jquery.md.js?t=2014071601"></script>
	<script type="text/javascript" src="../static/js/uploadify/jquery.uploadify.min.js?t=2014071601"></script>
	<script type="text/javascript" charset="utf-8" src="../static/js/kindeditor/kindeditor.js?t=2014071601"></script>
	<link rel="stylesheet" href="../static/js/uploadify/uploadify.css?t=2014071601" />
	<style type="text/css">
		.uploadBtn{
		 	background:#F0F0F0;
		 	cursor:hand;
			width: 54px;
			height: 24px;
			padding: 0;
			font-size: 12px;
			color: #000000;
			border:1px solid #708090;
			font-weight:100;
			border-radius: 4px;
			-webkit-border-radius: 4px;
			-moz-border-radius: 4px;
		}
		
		 .uploadify:hover .uploadify-button {
			 padding: 0;
		     background:#F0F0F0;
		 }
		 #brandLogo{
		 	float:left;
			margin:59px 0 0 10px;
		 }
	</style>
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
				<li><strong>添加品牌</strong></li>
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
		<div class="brandManagement">
			<form id="myform" class="form formB" method="post" action="${ctx}/brand/add">
				<div class="legend">
					<div class="legend-meg">
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
					</div>
					<h3>添加品牌</h3>
				</div>
				<fieldset>
					<dl class="item">
						<dt class="item-label">
							<label><em>*</em>类目选择：</label>
						</dt>
						<dd class="item-cont">
							<input type="button" class="btn" value="+ 添加基础类目" onclick="selCateClick()">
							<input type="hidden" class="btn" id="bcIds" name="bcIds">
							<input type="hidden" class="btn" id="bcShows" name="bcShows">
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
				<fieldset class="last">
					<dl class="item">
						<dt class="item-label">
							<label><em></em>品牌添加：</label>
						</dt>
						<dd class="item-cont item-conts">
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>中文名称：</label>
								</dt>
								<dd class="item-cont">
									<input id="brandName" name="brandName" type="text" class="txt textC" maxlength="33" > <span>中文品牌名称和英文品牌名称至少填写一项</span>
									<div class="hint error"></div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>英文名称：</label>
								</dt>
								<dd class="item-cont">
									<input id="brandEname" name="brandEname" type="text" class="txt textC" maxlength="100" >
									<div class="hint error"></div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>拼音码：</label>
								</dt>
								<dd class="item-cont">
									<input id="pinyin" name="pinyin" type="text" class="txt textC" maxlength="100">
									<div class="hint error"></div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>品牌缩写名：</label>
								</dt>
								<dd class="item-cont">
									<input id="brandAbbr" name="brandAbbr" type="text" class="txt textC" maxlength="15">
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>品牌Logo：</label>
								</dt>
								<dd class="item-cont">
									<div class="idImg">
										<img id="logoImg" src="../static/img/bramLogo.jpg" alt="" >
										<input type="button" class="btn" value="浏览" id="brandLogo" >
										<input type="hidden" class="btn" id="logoUrl" name="logoUrl">
									</div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>品牌故事：</label>
								</dt>
								<dd class="item-cont">
									<div class="editer">
										<textarea id="brandStory" name="brandStory" cols="100" rows="8" style="width: 711px; height: 460px; visibility: hidden;" ></textarea>
										<div id="brandStoryWarn" class="hint error"></div>
									</div>
								</dd>
							</dl>
						</dd>
					</dl>
				</fieldset>
			</form>
			<div class="formBtn">
				<button id="submitBtn" type="button" class="btnC" >保 存</button>
				<input type="button" class="btn" value="取 消" onclick="window.location.href='${ctx}/brand/list?m=33'">
			</div>
		</div>
		<!-- resultUploding end-->
	</div>
	<!-- main end -->

	<script type="text/javascript">
		var selBcObj = {}, selBcIdObj = {}, bcShow = {};
		var allTBcIds = [];
		var tBcIds = [];
		var fBcId, sBcId;
		
		//表单提交标识
		var brandNameFlag = false;
		var brandEnameFlag = false;
		var pinyinFlag = false;
		var storyFlag = true;
		
		$(function() {
			
			$("#brandName").blur(function(){
				var brandName = $.trim($(this).val());
				if(brandName!=null && brandName.length>0){
					if(isChinese(brandName)){
						if(brandName.length > 33){
							$(this).next().next().text("最多输入33个中文!");
						}else{
							checkName(brandName, 1);
						}
					}else{ 
						$(this).next().next().text("请输入包含中文的名称!");
					}
				}else{
					$(this).next().next().text("");
				}
			});
			
			$("#brandEname").blur(function(){
				var brandEname = $.trim($(this).val());
				if(brandEname!=null && brandEname.length>0){
					if(!isChinese(brandEname)){
						if(brandEname.length > 33){
							$(this).next().text("最多输入33字符!");
						}else{
							checkName(brandEname, 2);
						}
					}else{ 
						$(this).next().text("不能输入中文!");
					}
				}else{
					$(this).next().text("");
				}
			});
			
			$("#pinyin").blur(function(){
				var pinyin = $.trim($(this).val());
				if(pinyin==null || pinyin=='' || isChinese(pinyin)){
					$(this).next().text("请填写中文品牌名全拼，如果没有中文品牌则填写英文品牌，全部字母为小写");
				}else{
					if(pinyin.length > 33){
						$(this).next().text("最多输入33字符!");
					}else{
						pinyinFlag = true;
						$(this).next().text("");
					}
				}
			});
			
			$('#submitBtn').click(function(){
				if(allTBcIds.length > 0){
					var name = $.trim($("#brandName").val());
					var ename = $.trim($("#brandEname").val());
					
					if(pinyinFlag && storyFlag &&
							((brandNameFlag && brandEnameFlag) || 
									(brandNameFlag && (ename==null || ename.length==0)) || 
									((name==null || name=='') && brandEnameFlag))){
						$("#myform").submit();
					}else if((ename==null || ename=='') && (name==null || name.length==0)){
						$("#brandName").focus().next().next().text("请至少输入一个品牌名称");
					}else if(!pinyinFlag){
						$("#pinyin").focus().next().text("请填写中文品牌名全拼，如果没有中文品牌则填写英文品牌，全部字母为小写");
					}
					
				}else{
					$("#cateWarn").text("请添加基础类目!");
				}
			});
			
			KindEditor.ready(function(K) {
				K.create('textarea[name="brandStory"]', {
					uploadJson : '${ctx}/brand/saveImg',
					allowFileManager : false,
					allowPreviewEmoticons: false,
			        urlType:'domain',
					items : ['source', '|', 'undo', 'redo', '|', 'preview', 'template', '|', 
							 'justifyleft', 'justifycenter', 'justifyright','justifyfull', 
							 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 
		                     'clearhtml', 'quickformat', '|', 'fullscreen', '|', 'formatblock', 
		                     'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 
		                     'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', 
		                     '|', 'image', 'table', 'hr', 'emoticons', 'map',  'pagebreak', 'link', 'unlink'
			                ],
					afterCreate : function() {
						var self = this;
						K.ctrl(document, 13, function() {
							self.sync();
							document.forms['frm'].submit();
						});
						K.ctrl(self.edit.doc, 13, function() {
							self.sync();
							document.forms['frm'].submit();
						});
					},
					// 失去焦点同步数据
					afterBlur:function() {
						this.sync();
					},
					afterChange:function() {
						this.sync();
						$("#brandStoryWarn").html("");
						checkLength($("#brandStory"),'brandStoryWarn', 1000);
					},
					// 图片地址
			        afterUpload : function(url) {
			        }
				});
			});
		
			$('#brandLogo').uploadify({
				auto	: true,
				multi	: false,
				preventCaching : false,		
				buttonClass : 'uploadBtn',
				buttonText : '上 传',
				swf	:	'../static/js/uploadify/uploadify.swf',
				uploader : 'http://upload.yiwangimg.com/rc/upload',
				height :	20, 
				width  :	50,
				fileSizeLimit : '100KB',
				fileTypeDesc :	'jpeg files',
				fileTypeExts :	'*.jpg;*.jpeg;*.gif;*.png;*.bmp',
				overrideEvents : ['onUploadProgress', 'onSelect'],
				onUploadStart : function(file) {					
			    },
			    onUploadComplete : function(file) {			    	
		        },
				onFallback : function(){
					alert('上传组件依赖于flash，请安装flash插件后再试！');
				},
				onUploadSuccess : function(file, data, response) {
					if(response) {
						var d = $.parseJSON(data);
						var url = "${imgDownDomain}"+d.rid;
						$('#logoImg').attr('src', url);
						$('#logoUrl').val(d.rid);
					}
				},
				onUploadError : function(file, errorCode, errorMsg, errorString) {
					alert(errorCode);
					alert(errorString);
					alert(errorMsg);
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
						
						addBcId(tBcIds, allTBcIds);
						
						//一级类目ID不存在 
						if(selBcIdObj[fBcId] == undefined){
							selBcIdObj[fBcId] = {};
							selBcIdObj[fBcId][sBcId] = $.merge([], tBcIds);
							selBcIdObj[fBcId]["tl"] = tBcIds.length;
						}else{//一级类目ID存在 
							//二级类目ID不存在 
							if(selBcIdObj[fBcId][sBcId] == undefined){
								selBcIdObj[fBcId][sBcId] = $.merge([], tBcIds);
								selBcIdObj[fBcId]["tl"] += tBcIds.length;
							}else{//二级类目ID存在 
								//保存三级类目
								var num = addBcId(tBcIds, selBcIdObj[fBcId][sBcId]);
							
								selBcIdObj[fBcId]["tl"] += num;
							}
						} 
						
						createTable();
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
		//创建表格
		function createTable() {
			$("#bcIds").val(allTBcIds.join(","));
			
			//类目品牌显示信息,默认都显示
			bcShow = {};
			for(var i in allTBcIds){
				bcShow[allTBcIds[i]] = allTBcIds[i]+"_1_1";
			}
			var bcShows = [];
			for(var key in bcShow){
				bcShows.push(bcShow[key]);
			}
			$("#bcShows").val(bcShows.join(","));
			 
			$("#cateWarn").text("");
			
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
						 tr += '<td><input type="checkbox" name="filter" value="'+tList[index]+'" class="chk chks" checked="checked"></td>';
						 tr += '<td><input type="checkbox" name="tag" value="'+tList[index]+'" class="chk chks" checked="checked"></td>';
						 tr += "<td><a id='"+fBcId+"_"+sBcId+"_"+tList[index]+"' href='javascript:void(0);'>删除</a></td>";
						 tr += "</tr>";
						 	
						 t$.append(tr);
					}
				}
			}
			
			$("#table").find("a").click(function(){
				var idArr =  this.id.split("_");
				 
				delete selBcObj[idArr[2]];
				 
				var ind = $.inArray(idArr[2], selBcIdObj[idArr[0]][idArr[1]]);
				if(ind > -1){
					selBcIdObj[idArr[0]][idArr[1]].splice(ind, 1);
				}
				
				if(selBcIdObj[idArr[0]].tl == 1){
					delete selBcIdObj[idArr[0]];
				}else{
					selBcIdObj[idArr[0]].tl--;
				}
				
				ind = $.inArray(idArr[2], allTBcIds);
				if(ind > -1){
					allTBcIds.splice(ind, 1);
				}
				 
				createTable();
			}).end().find(":checkbox").click(function(){
				var tbcId = this.value;
				
				if($(this).attr("name") == "filter"){
					var ss = bcShow[tbcId].split("_");
					bcShow[tbcId] = ss[0] + "_" + (this.checked?"1":"0") + "_" + ss[2];
				}else if($(this).attr("name") == "tag"){
					var ss = bcShow[tbcId].split("_");
					bcShow[tbcId] = ss[0] + "_" + ss[1] + "_" + (this.checked?"1":"0");
				}
				
				var bcShows = [];
				for(var key in bcShow){
					bcShows.push(bcShow[key]);
				}
				
				$("#bcShows").val(bcShows.join(","));
			});
		}
		//三级类目不存在增加,存在抛弃
		function addBcId(sbcIds, dbcIds) {
			var num = 0;
			for(var i in sbcIds){
				if($.inArray(sbcIds[i], dbcIds) == -1){
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
		function checkName(val, flag) {
			if(val){
				$.ajax({
					url : "${ctx}/brand/check",
					type : "POST",
					data : {name : val, flag : flag},
					success : function(re) {
						//已存在
						if(re == 1){
							if(flag == 1){
								brandNameFlag = false;
								$("#brandName").focus();
								$("#brandName").next().next().text("添加的品牌已经存在!");
							}else if(flag == 2){
								brandEnameFlag = false;
								$("#brandEname").focus();
								$("#brandEname").next().text("添加的品牌已经存在!");
							}
						}else{
							if(flag == 1){
								brandNameFlag = true;
								$("#brandName").next().next().text("");
							}else if(flag == 2){
								brandEnameFlag = true;
								$("#brandEname").next().text("");
							}
						}
					}
				});
			}
		}
		
		function isChinese(s){ 
			var patrn=/[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi; 
			return patrn.exec(s); 
		}
		
		// validate editor
		function checkLength(obj, detail_warn, maxlen) {
			var v = obj.val(), len = v.length;
			 
			if (len > maxlen) {
				storyFlag = false;
				$("#"+detail_warn).html("源码：已超过 <strong>" + (len - maxlen) + 
						"</strong>个字/最多可以输入<strong>1000</strong>个字").css('color', '#FF0000');
			}else{
				storyFlag = true;
			}
		}
	</script>
</body>
</html>