<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>修改属性值名</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/jquery.md.js?t=2014102001"></script>
	<script type="text/javascript" src="../static/js/JSPinyin.js?t=2014102001"></script>
	<!-- main -->
			<div class="main">
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
									<li><em>·</em>属性名在关联属性值后，才可用于和类目的关联</li>
									<li><em>·</em>属性名关联属性值，可在添加属性名后直接创建属性值，并可在关联维护中对关联进行修改。</li>
								</ul>
							</dd>
						</dl>
					</div>
					<form id="myform" class="form formA" method="post" action="${ctx}/attrvalue/update" >
						<fieldset>
							<div class="legend"><h3>修改属性值</h3><a href="${ctx}/attrvalue/list">返回属性值列表</a></div>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>属性值名：</label></dt>
								<dd class="item-cont">
									<input type="hidden" name="attrValueId" id="attrValueId" value="${attrValue.attrValueId}" maxlength="30"/>
									<input type="text" class="txt textC" name="attrValueName" id="attrValueName" value="<c:out value='${attrValue.attrValueName}' />" />
									<div class="mod-help">
										<i class="ico"></i>
										<div class="text">
											<div class="text-meg">
											 <p>属性值保存成功后，页面将跳转回列表页。</p>
											</div>
										</div>
									</div>
									<div class="hint error">${warn}</div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>拼音码：</label></dt>
								<dd class="item-cont">
									<input type="text" class="txt textC" name="pinyin" id="pinyin" value="${attrValue.pinyin}"  />
									<div class="mod-help">
										<i class="ico"></i>
										<div class="text">
											<div class="text-meg">
											 <p>拼音码为自动生成项，请检查其正确性，拼音码可修改。</p>
											</div>
										</div>
									</div>
									<div class="hint error">${warn}</div>
								</dd>
							</dl>
						</fieldset>
						<div class="formBtn">
							<button id="submitBtn" type="button" class="btnC">保&nbsp;存</button><input type="button" class="btn" value="取&nbsp;消" onclick="window.location.href='${ctx}/attrvalue/list'" />
						</div>
					</form>
				</div>
				<!-- addTemplate end -->
			</div>
			<!-- main end -->

	<script type="text/javascript">
		var attrValueNameFlag = true;
		
		$(function() {
			$("#attrValueName").blur(function(){
				var attrValueName = $.trim(this.value);
				if(attrValueName!=null && attrValueName.length>0){
					$("#pinyin").val(pinyin.getFullChars(attrValueName));
					checkName(attrValueName);
				}else{
					$(this).next().next().text("请填写属性值名。");
					$(this).focus();
				}
			});
			
			$("#pinyin").blur(function(){
				var pinyin = $.trim(this.value);
				
				if(pinyin==null || pinyin.length==0){
					$(this).next().next().text("请填写拼音码。");
					$(this).focus();
				}else{
					$(this).next().next().text("");
				}
			});
			
			
			$('#submitBtn').click(function(){
				var attrValueName = $.trim($("#attrValueName").val());
				var pinyin = $.trim($("#pinyin").val());
				
				if(attrValueNameFlag && attrValueName!=null && attrValueName.length>0 && pinyin!=null && pinyin.length>0){
					$("#myform").submit();
				}else{
					if(attrValueName==null || attrValueName.length==0){
						$("#attrValueName").next().next().text("请填写属性名。");
						$("#attrValueName").focus();
					}
					if(pinyin==null || pinyin.length==0){
						$("#pinyin").next().next().text("请填写拼音码。");
						$("#pinyin").focus();
					}
				}
			});
		});
		
		function checkName(attrValue) {
			if(attrValue){
				$.ajax({
					url : "${ctx}/attrvalue/name/check",
					type : "POST",
					data : {attrValue : attrValue, id :"${attrValue.attrValueId}"},
					success : function(re) {
						//已存在
						if(re == 1){
							$("#attrValueName").next().next().text("该属性值名已经存在。");
							$("#attrValueName").focus();
						}else if(re == 0){
							attrValueNameFlag = true;
							$("#attrValueName").next().next().text("");
						}
					}
				});
			}
		}
	</script>
</body>
</html>