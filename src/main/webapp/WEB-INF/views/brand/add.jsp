<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>品牌增加-巨有利</title>
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
							<li><em>·</em>品牌名称不能重复；品牌全拼是自动生成项，为中文品牌全拼，如果没有中文品牌则显示英文品牌。</li>
							<li><em>·</em>品牌Logo许与商标注册图文信息一致，尺寸400X200像素，格式jpg，大小不超过100K</li>
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
						<div class="mod-help mod-helps">
							<i class="ico"></i>
							<div class="text">
								<div class="text-meg">
									<h6>品牌输入规划：</h6>
									<p>1.品牌名称严格采用该品牌官方描述名称，包括品牌中的中文描述、英文字符的大小写以及字符之间的符号（如两个单词间的空格有且仅有一个）；</p>
									<p>2.对于没有明确官方描述的英文名称，品牌采用每个单词首字母大写，单词的其他字母小写方式录入；</p>
									<p>3.英文品牌所有字符（含非字母字符）皆须是在英文半角状态下输入的字符，不能出现在中文状态下的或全角字符状态下输入的字符；</p>
									<p>4.同一个品牌有且只有一个品牌名称，即官方发布的品牌；</p>
								</div>
							</div>
						</div>
					</div>
					<h3>添加品牌</h3>
				</div>
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
									<label>品牌简述：</label>
								</dt>
								<dd class="item-cont">
									<textarea id="brandAbbr" name="brandAbbr" rows="5" cols="60"></textarea>
									<div class="hint error"></div>
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
				<input type="button" class="btn" value="取 消" onclick="window.location.href='${ctx}/brand/list?m=75'">
			</div>
		</div>
		<!-- resultUploding end-->
	</div>
	<!-- main end -->

	<script type="text/javascript">
		//表单提交标识
		var brandNameFlag = false;
		var brandEnameFlag = false;
		var pinyinFlag = false;
		var storyFlag = true;
		var brandAbbrFlag = true;
		
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
				pinyinFlag = false;
				
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
			
			$("#brandAbbr").blur(function(){
				brandAbbrFlag = false;
				
				var brandAbbr = $.trim($(this).val());
				if(brandAbbr.length > 150){
					$(this).next().text("最多输入150个汉字!");
				}else{
					brandAbbrFlag = true;
					$(this).next().text("");
				}
			});
			
			$('#submitBtn').click(function(){
				var name = $.trim($("#brandName").val());
				var ename = $.trim($("#brandEname").val());
				
				if(brandAbbrFlag && pinyinFlag && storyFlag &&
						((brandNameFlag && brandEnameFlag) || 
								(brandNameFlag && (ename==null || ename.length==0)) || 
								((name==null || name=='') && brandEnameFlag))){
					$("#myform").submit();
				}else if((ename==null || ename=='') && (name==null || name.length==0)){
					$("#brandName").focus().next().next().text("请至少输入一个品牌名称");
				}else if(!pinyinFlag){
					$("#pinyin").focus().next().text("请填写中文品牌名全拼，如果没有中文品牌则填写英文品牌，全部字母为小写");
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
				uploader : '${imgUploadUrl}',
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
						var url = "${my:random(imgGetUrl)}"+d.rid;
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