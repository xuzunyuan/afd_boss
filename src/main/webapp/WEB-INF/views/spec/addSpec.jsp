<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>添加新规格名</title>
	</head>
	<body>
		<script type="text/javascript" src="../static/js/jquery.md.js?t=20141022"></script>
		<script type="text/javascript" src="../static/js/JSPinyin.js?t=20141022"></script>
		
		<script type="text/javascript">
			$(function(){
				$(document).on("click", "#save", function(){
					var specName = $.trim($("#specName").val());
					if(!specName){
						var msg = "<p><span>•</span>请填写规格名。</p>";
						$.modaldialog(msg,{
							title : '提醒',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
								$("#specName").focus();}
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
									$("#pinyin").focus();
								}
							}]
						});
						return;
					}
					$.post(
						"${ctx}/spec/saveSpec",
						{specName: specName, pinyin: py},
						function(data){
							if(parseInt(data.success) == 0){
								var msg = "<p><span>•</span>保存成功！</p>";
								$.modaldialog(msg,{
									title : '提醒',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
										location.href = "${ctx}/spec/specSpecValueManage?specId=" + data.specId;
									}}]
								});
							} else if (parseInt(data.success) == -1) {
								var msg = "<p><span>•</span>该规格名已经存在！</p>";
								$.modaldialog(msg,{
									title : '提醒',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){}}]
								});
							} else if (parseInt(data.success) == -2) {
								var msg = "<p><span>•</span>添加失败，请重试！</p>";
								$.modaldialog(msg,{
									title : '提醒',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){}}]
								});
							}
						}
					);
				});
				
				$(document).on("keyup", "#specName", function(){
					var specName = $.trim($("#specName").val());
					if(!specName){
						$("#nameError").text("请填写规格名。");
						$("#nameError").removeClass("hidden");
					} else {
						$("#nameError").addClass("hidden");
					}
					var py = pinyin.getFullChars(specName);
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
			<form class="form formA" action="${ctx}/spec/saveSpec" method="post">
				<fieldset>
					<div class="legend"><h3>添加规格名</h3><a href="${ctx}/spec/querySpecs">返回规格名列表</a></div>
					<dl class="item">
						<dt class="item-label"><label><em>*</em>规格名：</label></dt>
						<dd class="item-cont">
							<input id="specName" name="specName" type="text" class="txt textC" maxlength="30"/>
							<div class="mod-help">
								<i class="ico"></i>
								<div class="text">
									<div class="text-meg">
									 <p>添加并保存成功后，页面将跳转到关联规格值页面，进行规格值关联操作。</p>
									</div>
								</div>
							</div>
							<div id="nameError" class="hint error hidden">错误提示</div>
						</dd>
					</dl>
					<dl class="item">
						<dt class="item-label"><label><em>*</em>拼音码：</label></dt>
						<dd class="item-cont">
							<input id="pinyin" name="pinyin" type="text" class="txt textC" />
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
				</fieldset>
				<div class="formBtn">
					<button id="save" type="button" class="btnC">保&nbsp;存</button><input type="button" class="btn" onclick="window.location.href='${ctx}/spec/querySpecs'" value="取&nbsp;消" />
				</div>
			</form>
		</div>
		<!-- addTemplate end -->
	</body>
</html>