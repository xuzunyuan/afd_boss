<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>规格关联管理</title>
	</head>
	<body>
		<script type="text/javascript" src="../static/js/JSPinyin.js?t=20141022"></script>
		<script type="text/javascript" src="../static/js/uploadify/jquery.uploadify.min.js?t=2014071601"></script>
		<script type="text/javascript" src="../static/js/jquery.md.js?t=20140923"></script>
		<style type="text/css">
			.upload {
				padding: 0px 0px;
				text-align: center;
			}
		</style>
		<script type="text/javascript">
			$(function(){
				$(document).on("click","input[name=color]",function(){
					changeColorDisplay();
				});
				$(document).on("click","#add",function(){
					$("tr.t-empty").remove();
					html = "<tr>"+
							"	<td><input name='chk' ssvId='' type='checkbox' class='chk'></td>" + 
							"	<td name='tdsvName'><input name='svName' class='txt' type='text' maxlength='30'></td>" + 
							"	<td><p name='svPinyin'></p></td>" +
							"	<td class='align-c' name='img'></td>" +
							"	<td class='t-operate align-c'><a name='cacelSSV' ssvId=''>取消关联</a></td>" +
							"</tr>";
					$("#ssvTBody").append(html);
					$("input[name=svName]").last().focus();
					setChkAll();
					setBatchCacelBtn();
				});
				$(document).on("change","input[name=svName]",function(){
					var node = $(this);
					var svName = $.trim($(this).val());
					if(!svName){
						return;
					}
					var exist = false;
					$("p[name=svName]").each(function(){
						if($.trim($(this).text()) == svName){
							exist = true;	
						}
					});
					if(exist){
						var msg = "<p><span>•</span>该规格值已关联。</p>";
						$.modaldialog(msg,{
							title : '提醒',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
									node.focus();
								}
							}]
						});
						return;
					}
					
					var trNode = $(this).parents("tr");
					$(this).remove();
					trNode.children("td[name=tdsvName]").append("<p name='svName'></p>");
					trNode.find("p[name=svName]").text(svName);
					var svPinyin = pinyin.getFullChars(svName);
					$.post(
						"${ctx}/spec/addSpecSpecValue",
						{specId:"${spec.specId}",specValueName:svName,svPinyin:svPinyin,maxDisplayOrder:"${maxDisplayOrder}"},
						function(data){
							trNode.find("input[name=chk]").attr("ssvId", data.ssvId);
							trNode.find("p[name=svName]").text(data.specValueName);
							trNode.find("p[name=svPinyin]").text(data.pinyin);
							if(!!data.imgUrl){
								if(data.imgUrl.substring(0,5) == "http:"){
									trNode.find("td[name=img]").append("<img src='" + data.imgUrl + "' width='13' height='13' class='colorBlock'>");
								}else{
									trNode.find("td[name=img]").append("<img src='${my:random(imgGetUrl)}" + data.imgUrl + "' width='13' height='13' class='colorBlock'>");
								}
							}else{
								trNode.find("td[name=img]").append("<input id='" + data.specValueId + "' type='button' name='upload' specValueId='" + data.specValueId + "' class='btn' value='上传图片'>");
							}
							initUploadBtn();
							changeColorDisplay();
							trNode.find("a[name=cacelSSV]").attr("ssvId", data.ssvId);
							maxDisplayOrder = data.maxDisplayOrder;
						}
					);
					
				});
				$(document).on("change","#chkAll",function(){
					var check = $(this).prop("checked");
					$("input[name=chk]").prop("checked",check);
					if(check && $("input[name=chk]").size() > 0){
						$("#batchCacelSSV").removeClass("disabled");
					}else{
						$("#batchCacelSSV").addClass("disabled");
					}
				});
				$(document).on("change","input[name=chk]",function(){
					setChkAll();
					setBatchCacelBtn();
				});
				$(document).on("click","#batchCacelSSV",function(){
					var ssvIds = [];
					$("input[name=chk]").each(function(){
						var check = $(this).prop("checked");
						if(check){
							if(!$(this).attr("ssvId")){
								$(this).parents("tr").remove();
							} else {
								ssvIds.push($(this).attr("ssvId"));
							}
						}
					});
					if(ssvIds.length == 0){
						if($("[name=svName]").length == 0){
							$("#ssvTBody").append("<tr class='t-empty'>" + 
												"	<td rowspan='3' colspan='5'>暂无关联规格值</td>" +
												"</tr>");
						}
						setChkAll();
						setBatchCacelBtn();
						return;
					}
					$.post(
						"${ctx}/spec/deleteSpecSpecValues",
						{ssvIds:ssvIds.join(",")},
						function(res){
							if(res){
								$.each(ssvIds,function(){
									$("input[ssvid="+this+"]").parents("tr").remove();
									if($("[name=svName]").length == 0){
										$("#ssvTBody").append("<tr class='t-empty'>" + 
															"	<td rowspan='3' colspan='5'>暂无关联规格值</td>" +
															"</tr>");
									}
									setChkAll();
									setBatchCacelBtn();
								});
							}else{
								reload();
							}
						}
					);
				});
				$(document).on("click","a[name=cacelSSV]",function(){
					var ssvId = $(this).attr("ssvId");
					if(!ssvId){
						$(this).parents("tr").remove();
						if($("[name=svName]").length == 0){
							$("#ssvTBody").append("<tr class='t-empty'>" + 
												"	<td rowspan='3' colspan='5'>暂无关联规格值</td>" +
												"</tr>");
						}
						setChkAll();
						setBatchCacelBtn();
						return;
					}
					var node = $(this).parents("tr");
					$.post(
						"${ctx}/spec/deleteSpecSpecValue",
						{ssvId:ssvId},
						function(res){
							if(res){
								node.remove();
								if($("[name=svName]").length == 0){
									$("#ssvTBody").append("<tr class='t-empty'>" + 
														"	<td rowspan='3' colspan='5'>暂无关联规格值</td>" +
														"</tr>");
								}
								setChkAll();
								setBatchCacelBtn();
							}else{
								reload();
							}
						}
					);
				});
				initUploadBtn();
				changeColorDisplay();
			});
			function initUploadBtn(){
				$("input[name=upload]").each(function(){
					var specValueId = $(this).attr("specValueId");
					var parentNode = $(this).parent();
					 
					$(this).uploadify({
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
								var img = "<img src='${my:random(imgGetUrl)}" + d.rid + "' width='13' height='13' class='colorBlock'>";
								 
								parentNode.empty();
								parentNode.append(img);
								saveImgUrl(specValueId, d.rid);
							}
						},
						onUploadError : function(file, errorCode, errorMsg, errorString) {
							alert(errorCode);
							alert(errorString);
							alert(errorMsg);
						}
					});
				});
			}
			function saveImgUrl(specValueId, imgUrl){
				$.post(
					"${ctx}/spec/saveSpecValueImgUrl",
					{specValueId:specValueId,imgUrl:imgUrl},
					null
				);
			}
			function changeColorDisplay(){
				if($("input[name=color]:checked").val() == "on"){
					$("td[name=img] img").removeClass("hidden");
					$("td[name=img] div").removeClass("hidden");
				} else {
					$("td[name=img] img").addClass("hidden");
					$("td[name=img] div").addClass("hidden");
				}
			}
			function setChkAll(){
				var allCheck = true;
				$("input[name=chk]").each(function(){
					var check = $(this).prop("checked");
					if(!check){
						allCheck = false;
						return;
					}
				});
				$("#chkAll").prop("checked",allCheck);
			}
			function setBatchCacelBtn(){
				var anyCheck = false;
				$("input[name=chk]").each(function(){
					var check = $(this).prop("checked");
					if(check){
						anyCheck = true;
						return;
					}
				});
				if(anyCheck){
					$("#batchCacelSSV").removeClass("disabled");
				}else{
					$("#batchCacelSSV").addClass("disabled");
				}
			}
			function reload(){
				location.href = "${ctx}/spec/specSpecValueManage?specId="+${spec.specId};
			}
		</script>
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<div class="propertyMain propertyName propertyNamenorms">
			<div class="hintBar">
				<dl>
					<dt><i class="icon i-exclaim"></i></dt>
					<dd>
						<h4>请注意：</h4>
						<ul>
							<li><em>·</em>规格名在关联规格值后，才可用于和类目的关联；</li>
							<li><em>·</em>规格名关联规格值，可在添加规格名后直接创建规格值，并可在关联维护中对关联进行修改。</li>
						</ul>
					</dd>
				</dl>
			</div>
			<form autocomplete="off" class="form formA">
				<fieldset>
					<div class="legend"><h3>添加规格名关联</h3><a href="${ctx}/spec/querySpecs">返回规格名列表</a></div>
					<dl class="item">
						<dt class="item-label"><label><em>*</em>规格名：</label></dt>
						<dd class="item-cont">
							<p><c:out value="${spec.specName}"></c:out></p>
						</dd>
					</dl>
					<dl class="item">
						<dt class="item-label"><label><em>*</em>拼音码：</label></dt>
						<dd class="item-cont">
							<p><c:out value="${spec.pingyin}"></c:out></p>
						</dd>
					</dl>
					<dl class="item">
						<dt class="item-label"><label>颜色块行是否显示：</label></dt>
						<dd class="item-cont item-radio">
							<input type="radio" class="rdo" name="color" id="yes" value="on"><label for="yes">是</label>
							<input type="radio" class="rdo" name="color" id="no" value="off" checked="checked"><label for="no">否</label>
							<div class="mod-help">
								<i class="ico"></i>
								<div class="text">
									<div class="text-meg">
									 <p>此处颜色块行是否显示，是用于控制下面关联规格值时，颜色块行内容是否显示。</p>
									</div>
								</div>
							</div>
						</dd>
					</dl>
					<dl class="item">
						<dt class="item-label"><label>关联规格值：</label></dt>
						<dd class="item-cont item-property">
							<div class="actionBars">
								<input id="add" type="button" class="btn" value="+ 添加关联规格值">
							</div>
							<div class="checkAll">
								<div><input id="chkAll" type="checkbox" class="chk">全选</div>
								<input id="batchCacelSSV" type="button" value="批量取消关联" class="btn disabled">
							</div>
							<!-- table -->
							<table id="ssvTable" class="table tableA">
								<colgroup>
									<col width="60">
									<col width="240">
									<col width="250">
									<col width="150">	
									<col width="150">
								</colgroup>
								<thead>
									<tr>
										<th></th>
										<th>规格值</th>
										<th>拼音码</th>
										<th class="align-c">颜色块</th>
										<th class="align-c">操作</th>
									</tr>
								</thead>
								<tbody id="ssvTBody">
									<c:choose>
										<c:when test="${fn:length(specSpecValues) > 0 }">
											<c:forEach items="${specSpecValues}" var="specSpecValue">
												<tr>
													<td><input name="chk" ssvId="${specSpecValue.sSVId}" type="checkbox" class="chk"></td>
													<td name="tdsvName"><p name="svName"><c:out value="${specSpecValue.specValueName }"></c:out></p></td>
													<td><p><c:out value="${specSpecValue.pinyin }"></c:out><p></td>
													<td class="align-c" name="img">
														<c:choose>
															<c:when test="${!empty(specSpecValue.imgUrl)}">
																<c:choose>
																	<c:when test="${fn:substring(specSpecValue.imgUrl,0,5) == 'http:'}">
																		<img src="${specSpecValue.imgUrl}"  width="13" height="13" class="colorBlock hidden">
																	</c:when>
																	<c:otherwise>
																		<img src="${my:random(imgGetUrl)}${specSpecValue.imgUrl}"  width="13" height="13" class="colorBlock hidden">
																	</c:otherwise>
																</c:choose>
															</c:when>
															<c:otherwise>
																<input type="button" id="${specSpecValue.specValueId}" name="upload" specValueId="${specSpecValue.specValueId}" class="btn" value="上传图片">
															</c:otherwise>
														</c:choose>
													</td>
													<td class="t-operate align-c"><a name="cacelSSV" ssvId="${specSpecValue.sSVId}">取消关联</a></td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr class="t-empty">
												<td rowspan="3" colspan="5">暂无关联规格值</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>										
							</table>
							<!-- table end -->
						</dd>
					</dl>
				</fieldset>
			</form>
		</div>
	</body>
</html>