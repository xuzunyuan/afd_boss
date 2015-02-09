<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>品牌审核详情-afd</title>
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
		<!-- sellerData -->
		<div class="sellerData cashData">
			<div class="hintBar">
				<dl>
					<dt><i class="icon i-exclaim"></i></dt>
					<dd>
						<h4>请注意：</h4>
						<ul>
							<li><em>·</em>请核实商家申请的品牌与经营范围是否一致，及其品牌资质是否完备。</li>
						</ul>
					</dd>
				</dl>
			</div>
			<form class="form formA">
				<fieldset>
					<div class="mod-info">
						<div class="item">
							<h2>商家注册信息</h2>
							<table>
								<colgroup>
									<col width="120">
									<col>
									<col width="120">
									<col>
									<col width="120">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th>商家账号：</th>
										<td><c:out value="${sellerBrand.loginName}"/></td>
										<th class="">公司名称：</th>
										<td class=""><c:out value="${sellerBrand.coName}"/></td>
									</tr>
									<tr>
										<th>申请时间：</th>
										<td><fmt:formatDate value="${sellerBrand.submitDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></td>
										<th class="emphasis">状态：</th>
										<td class="emphasis">待审核</td>
									</tr>
								</tbody>
							</table>
						</div><!-- item end -->
					</div>
					<div class="legend"><h3>品牌申请信息</h3></div>
					<div class="formBox">
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>品牌名称：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${name}"/></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>授权类型：</label>
								</dt>
								<dd class="item-cont">
									<p>
									<c:choose>
					      				<c:when test="${sellerBrand.authType == '1'}">
					      					自有品牌
					      				</c:when>
					      				<c:when test="${sellerBrand.authType == '2'}">
					      					独家代理
					      				</c:when>
					      				<c:when test="${sellerBrand.authType == '3'}">
					      					一级代理
					      				</c:when>
					      				<c:when test="${sellerBrand.authType == '4'}">
					      					二级代理
					      				</c:when>
					      				<c:when test="${sellerBrand.authType == '5'}">
					      					三级代理
					      				</c:when>
					      			</c:choose>
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>授权有效期：</label>
								</dt>
								<dd class="item-cont">
									<p><fmt:formatDate value="${sellerBrand.authStartDate}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${sellerBrand.authEndDate}" pattern="yyyy-MM-dd"/></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>商标注册证/商标受理通知书：</label>
								</dt>
								<dd class="item-cont">
									<div class="mod-pic pic-papers">
										<img src="${my:random(imgGetUrl)}${sellerBrand.trademarkCert}&op=s1_w110_h110_e1-c3_w110_h110" alt="">
										<div class="maskBar"></div>
										<p class="textBar"><a href="${my:random(imgGetUrl)}${sellerBrand.trademarkCert}" target="_blank">查看大图</a></p>
									</div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>品牌授权书：</label>
								</dt>
								<dd class="item-cont">
									<div class="mod-pic pic-papers">
										<img src="${my:random(imgGetUrl)}${sellerBrand.authCert}&op=s1_w110_h110_e1-c3_w110_h110" alt="">
										<div class="maskBar"></div>
										<p class="textBar"><a href="${my:random(imgGetUrl)}${sellerBrand.authCert}" target="_blank">查看大图</a></p>
									</div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>其他资质：</label>
								</dt>
								<dd class="item-cont">
									<div class="mod-pic pic-papers">
										<img src="${my:random(imgGetUrl)}${sellerBrand.otherCert}&op=s1_w110_h110_e1-c3_w110_h110" alt="">
										<div class="maskBar"></div>
										<p class="textBar"><a href="${my:random(imgGetUrl)}${sellerBrand.otherCert}" target="_blank">查看大图</a></p>
									</div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>经营类目：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${sellerBrand.categories}"/></p>
								</dd>
							</dl>
						</div>
					</div>
				</fieldset>
			</form>
			<c:if test="${sellerBrand.status=='2'}">
				<div class="formBtn">
					<button id="confirm" type="button" class="btnC">审核通过</button>
					<input id="reject" type="button" class="btn" value="驳回申请">
				</div>
			</c:if>
			<c:if test="${not empty sellerBrand.auditContent}">
			<table class="table tableC">
				<colgroup>
					<col width="280">
					<col width="280">
					<col width="460">
				</colgroup>
				<thead>
					<tr>
						<th colspan="4" class="caption">商家审核历史</th>	
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>更新时间</th>
						<th>操作人</th>
						<th>操作说明</th>		
					</tr>
					<tr>
						<td><fmt:formatDate value="${sellerBrand.auditDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></td>
						<td><c:out value="${sellerBrand.auditByName}"/></td>
						<td><c:out value="${sellerBrand.auditContent}"/></td>
					</tr>
				</tbody>
			</table>
			</c:if>
		</div>
	<!-- sellerData end-->
	</div>
	<!-- main end -->

	<script type="text/javascript">
		$(function() {
			$("#confirm").on("click", function(){
				var msg = '<h2><i class="icon i-duigou" style="visibility:hidden;" ></i>确认审核通过吗?</h2><p class="xitongP">点击‘确定’ 审核通过；点击‘取消’取消本次审核操作，并关闭当前窗口。</p>';
				$.modaldialog(msg,{
					title : '审核操作',
					buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:audit, param:{flag:1}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
				});
			});
			$("#reject").on("click", function(){
				var msg = '<dl><dt><label><em>*</em>驳回理由：</label></dt><dd><textarea name="opinion" id="opinion" rows="5"></textarea><div id="warn" class="hint popHint">最多可输入150个中文汉字</div></dd></dl>';
				$.modaldialog(msg,{
					title : '审核操作',
					buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s', click:audit, param:{flag:2}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
				});
			});
		});
		
		function audit(param) {
			var flg = param.flag;
			var opinion = "";
			 
			if(flg == 2){
				opinion = $.trim($("#opinion").val());
				
				if(!opinion){
					$("#opinion").next().text("请填写驳回申请的理由");
					return true;
				}else if(opinion.length > 150){
					$("#opinion").next().text("最多可输入150个中文汉字");
					return true;
				}else{
					$("#opinion").text("最多可输入150个中文汉字");
				}
			}
			 
			$.ajax({
				url : "${ctx}/brand/applyAudit",
				type : "POST",
				data : {sbId:'${sellerBrand.sellerBrandId}', flag:flg, opinion:opinion},
				success : function(data) {
					if(data) {
						//成功通过
						if(flg==1 && data>0){
							$.modaldialog('<h2><i class="icon i-duigou"></i>审核通过</h2>',{
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){window.location.href = '${ctx}/brand/apply';}}]
							});
						}else if(flg==2 && data>0){
							$.modaldialog('<h2><i class="icon i-duigou"></i>申请已被驳回，需卖家重新修改后再次提交审核！</h2>',{
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){window.location.href = '${ctx}/brand/apply';}}]
							});
						}else if(data <= 0){
							$.modaldialog('<h2><i class="icon i-warns"></i>操作失败！</h2>');
						}
					}
				},
				error : function() {
					$.modaldialog('<h2><i class="icon i-warns"></i>操作失败！</h2>');
				}
			});
		}
	</script>
</body>
</html>