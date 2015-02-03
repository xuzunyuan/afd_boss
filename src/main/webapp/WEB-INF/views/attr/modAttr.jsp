<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>修改属性名</title>
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
					<form id="myform" class="form formA" method="post" action="${ctx}/attr/update" >
						<fieldset>
							<div class="legend"><h3>添加属性名</h3><a href="${ctx}/attr/list">返回属性名列表</a></div>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>属性名：</label></dt>
								<dd class="item-cont">
									<input type="hidden" name="attrId" id="attrId" value="${attr.attrId}" />
									<input type="text" class="txt textC" name="attrName" id="attrName" value="<c:out value='${attr.attrName}' />" maxlength="30"/>
									<div class="mod-help">
										<i class="ico"></i>
										<div class="text">
											<div class="text-meg">
											 <p>属性名保存成功后，页面将跳转回列表页。</p>
											</div>
										</div>
									</div>
									<div class="hint error"></div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label"><label><em>*</em>拼音码：</label></dt>
								<dd class="item-cont">
									<input type="text" class="txt textC" name="pinyin" id="pinyin" value="${attr.pinyin}" maxlength="50"/>
									<div class="mod-help">
										<i class="ico"></i>
										<div class="text">
											<div class="text-meg">
											 <p>拼音码为自动生成项，请检查其正确性，拼音码可修改。</p>
											</div>
										</div>
									</div>
								</dd>
							</dl>
						</fieldset>
						<div class="formBtn">
							<button id="submitBtn" type="button" class="btnC">保&nbsp;存</button><input type="button" class="btn" value="取&nbsp;消" onclick="window.location.href='${ctx}/attr/list'" />
						</div>
					</form>
				</div>
				<!-- addTemplate end -->
			</div>
			<!-- main end -->

	<script type="text/javascript">
		var attrNameFlag = true;
		
		$(function() {
			$("#attrName").blur(function(){
				var attrName = $.trim(this.value);
				
				if(attrName!=null && attrName.length>0){
					$("#pinyin").val(pinyin.getFullChars(attrName));
					checkName(attrName);
				}else{
					$(this).next().next().text("请填写属性名。");
					$(this).focus();
				}
			});
			
			$("#pinyin").blur(function(){
				var pinyin = $.trim(this.value);
				
				if(pinyin==null || pinyin.length==0){
					$(this).next().next().text("请填写拼音码。");
					$(this).focus();
				}
			});
			
			
			$('#submitBtn').click(function(){
				var attrName = $.trim($("#attrName").val());
				var pinyin = $.trim($("#pinyin").val());
				
				if(attrNameFlag && attrName!=null && attrName.length>0 && pinyin!=null && pinyin.length>0){
					$("#myform").submit();
				}else{
					if(attrName==null || attrName.length==0){
						$("#attrName").next().next().text("请填写属性名。");
						$("#attrName").focus();
					}
					if(pinyin==null || pinyin.length==0){
						$("#pinyin").next().next().text("请填写拼音码。");
						$("#pinyin").focus();
					}
				}
			});
		});
		
		function checkName(attrName) {
			if(attrName){
				$.ajax({
					url : "${ctx}/attr/name/check",
					type : "POST",
					data : {name : attrName, id :"${attr.attrId}"},
					success : function(re) {
						//已存在
						if(re == 1){
							$("#attrName").next().next().text("该属性名已经存在。");
							$("#attrName").focus();
						}else if(re == 0){
							attrNameFlag = true;
							$("#attrName").next().next().text("");
						}
					}
				});
			}
		}
	</script>
</body>
</html>