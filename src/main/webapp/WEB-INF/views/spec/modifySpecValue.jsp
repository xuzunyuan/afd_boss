<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>修改规格值</title>
	</head>
	<body>
		<script type="text/javascript" src="../static/js/jquery.md.js?t=20141022"></script>
		<script type="text/javascript" src="../static/js/JSPinyin.js?t=20141022"></script>
		<script type="text/javascript" src="../static/js/uploadify/jquery.uploadify.min.js?t=2014071601"></script>
		<style type="text/css">
			.upload {
				padding: 0px 0px;
				text-align:center;
			}
			#upload {
				float: left;
				margin: 0px 10px;
			}
		</style>
		<script type="text/javascript">
			$(function(){
				$(document).on("click", "#save", function(){
					var specValueName = $.trim($("#specValueName").val());
					if(!specValueName){
						var msg = "<p><span>•</span>请填写规格值。</p>";
						$.modaldialog(msg,{
							title : '提醒',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
								$("#specValueName").focus();}
							}]
						});
						return;
					}
					var py = $.trim($("#pinyin").val());
					if(!py){
						var msg = "<p><span>•</span>请填写拼音码。</p>";
						$.modaldialog(msg,{
							title : '提醒',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
								$("#pinyin").focus();}
							}]
						});
						return;
					}
					var imgUrl = $("#img").attr("rid");
					$.post(
						"${ctx}/specvalue/updateSpecValue",
						{specValueId:"${specValue.specValueId}", specValueName: specValueName, pinyin: py, imgUrl: imgUrl},
						function(result){
							if(result == 0){
								var msg = "<p><span>•</span>保存成功！</p>";
								$.modaldialog(msg,{
									title : '提醒',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
										location.href = "${ctx}/specvalue/querySpecValues";
									}}]
								});
							} else if (result == -1) {
								var msg = "<p><span>•</span>该规格值名已经存在！</p>";
								$.modaldialog(msg,{
									title : '提醒',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){}}]
								});
							} else if (result == -2) {
								var msg = "<p><span>•</span>更新失败，请重试！</p>";
								$.modaldialog(msg,{
									title : '提醒',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){}}]
								});
							}
						}
					);
				});
				
				$(document).on("keyup", "#specValueName", function(){
					var specValueName = $.trim($("#specValueName").val());
					if(!specValueName){
						$("#nameError").text("请填写规格值名。");
						$("#nameError").removeClass("hidden");
					} else {
						$("#nameError").addClass("hidden");
					}
					var py = pinyin.getFullChars(specValueName);
					$("#pinyin").val(py);
				});
				$(document).on("keyup", "#pinyin", function(){
					var py = $.trim($("#pinyin").val());
					if(!py){
						$("#pinyinError").text("请填写拼音码。");
						$("#pinyinError").removeClass("hidden");
					} else {
						$("#pinyinError").addClass("hidden");
					}
					
				});
				$(document).on("click","#delete",function(){
					$("#img").attr("src","../static/img/temp/color2.png");
					$("#img").attr("rid","");
				});
				$("#upload").uploadify({
					auto	: true,
					multi	: false,
					preventCaching : false,
					buttonClass : 'btn upload',
					buttonText : '上传图片',
					swf	:	'../static/js/uploadify/uploadify.swf',
					uploader : '${imgUploadUrl}',
					height :	25, 
					width  :	75,
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
							$("#img").attr("src",url);
							$("img").attr("rid",d.rid);
						}
					},
					onUploadError : function(file, errorCode, errorMsg, errorString) {
						alert(errorCode);
						alert(errorString);
						alert(errorMsg);
					}
				});
				
			});
		</script>
		
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- addTemplate -->
		<div class="addnewName">
			<div class="hintBar">
				<dl>
					<dt><i class="icon i-exclaim"></i></dt>
					<dd>
						<h4>请注意：</h4>
						<ul>
							<li><em>·</em>规格名在关联规格值后，才可用于和类目的关联</li>
							<li><em>·</em>规格名关联规格值，可在添加规格名后直接创建规格值，并可在关联维护中对关联进行修改。</li>
						</ul>
					</dd>
				</dl>
			</div>
			<form class="form formA">
				<fieldset>
					<div class="legend"><h3>添加规格值</h3><a href="${ctx}/specvalue/querySpecValues">返回规格值列表</a></div>
					<dl class="item">
						<dt class="item-label"><label><em>*</em>规格值名：</label></dt>
						<dd class="item-cont">
							<input id="specValueName" name="specValueName" type="text" class="txt textC" value="<c:out value="${specValue.specValueName}"/>" maxlength="30"/>
							<div class="mod-help">
								<i class="ico"></i>
								<div class="text">
									<div class="text-meg">
									 <p>规格值保存成功后，页面将跳转回列表页。</p>
									</div>
								</div>
							</div>
							<div id="nameError" class="hint error hidden">错误提示</div>
						</dd>
					</dl>
					<dl class="item">
						<dt class="item-label"><label><em>*</em>拼音码：</label></dt>
						<dd class="item-cont">
							<input id="pinyin" name="pinyin" type="text" class="txt textC" value="<c:out value="${specValue.pinyin}"/>" />
							<div class="mod-help">
								<i class="ico"></i>
								<div class="text">
									<div class="text-meg">
									 <p>拼音码为自动生成项，请检查其正确性，拼音码可修改。</p>
									</div>
								</div>
							</div>
							<div id="pinyinError" class="hint error hidden">错误提示</div>
						</dd>
					</dl>
					<dl class="item">
						<dt class="item-label"><label>颜色块：</label></dt>
						<dd class="item-cont">
							<c:choose>
								<c:when test="${!empty(specValue.imgUrl)}">
									<c:choose>
										<c:when test="${fn:substring(specValue.imgUrl,0,5) == 'http:'}">
											<img id="img" src="${specValue.imgUrl}" rid="${specValue.imgUrl}" width="13" height="13" style="float:left;vertical-align:middle;" class="colorBlock">
										</c:when>
										<c:otherwise>
											<img id="img" src="${my:random(imgGetUrl)}${specValue.imgUrl}" rid="${specValue.imgUrl}" width="13" height="13" style="float:left;vertical-align:middle;" class="colorBlock">
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<img id="img" src="../static/img/temp/color2.png" rid="" width="13" height="13" style="float:left;vertical-align:middle;" class="colorBlock">
								</c:otherwise>
							</c:choose>
							<input id="upload" type="button" class="btn" value="上传图片">
							<input id="delete" class="btn" type="button" value="删除"/>
							<p class="hint error">（图片应为jpg、jpeg、gif、png或bmp格式，大小为：13*13）</p>
						</dd>
					</dl>
				</fieldset>
				<div class="formBtn">
					<button id="save" type="button" class="btnC">保&nbsp;存</button><input type="button" class="btn" onclick="window.location.href='${ctx}/specvalue/querySpecValues'" value="取&nbsp;消" />
				</div>
			</form>
		</div>
		<!-- addTemplate end -->
	</body>
</html>