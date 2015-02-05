<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>卖家申请审核-阿凡达</title>
</head>
<body>
	<!-- foldbarV -->
	<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
	<!-- foldbarV end -->
	<!-- sellerData -->
		<div class="sellerData companybaseData">
			<div class="hintBar">
				<dl>
					<dt><i class="icon i-exclaim"></i></dt>
					<dd>
						<h4>请注意：</h4>
						<ul>
							<li><em>·</em>审核通过后，系统将自动开通商家后台权限，允许商家发布新商品及相关操作，但不允许添加专场活动。</li>
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
										<td><a href="#" class="buyerName"><c:out value="${login.loginName}"/></a></td>
										<th class="emphasis">运营审核状态：</th>
										<td class="emphasis">
												<c:choose>
													<c:when test="${apply.status == '1'}">待审核</c:when>
													<c:when test="${apply.status == '2'}">通过</c:when>
													<c:when test="${apply.status == '3'}">驳回</c:when>
												</c:choose>	
										</td>
									</tr>
									<tr>
										<th>申请时间：</th>
										<td><fmt:formatDate value="${apply.applyDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></td>
										<th class="emphasis">保证金到账状态：</th>
										<td class="emphasis">未到账</td>
									</tr>
								</tbody>
							</table>
						</div><!-- item end -->
					</div>
					<div class="legend"><h3>企业信息</h3></div>
					<div class="formBox">
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>公司名称：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:out value="${apply.coName}"/>
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>营业执照注册号：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${apply.coBln}"/></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>法人姓名：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${apply.lpName}"/></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>注册资本：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${apply.registerCapital}"/> / 万元</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>经营范围：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${apply.bizScope}"/></p>
								</dd>
							</dl>
						</div>
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>营业期限：</label>
								</dt>
								<dd class="item-cont">
									<p><fmt:formatDate value="${apply.btStartDate}" pattern="yyyy-MM-dd"/> 至 <fmt:formatDate value="${apply.btEndDate}" pattern="yyyy-MM-dd"/></p>
								</dd>
							</dl>
						</div>
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>营业执照所在地：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${apply.btGeo}"/></p>
								</dd>
							</dl>
						</div>
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>旗下/代理品牌：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${apply.coBrand}"/></p>
								</dd>
							</dl>
						</div>
					</div>
					</fieldset>
					<fieldset>
					<div class="legend"><h3>资料上传</h3></div>
					<div class="formBox">
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>营业执照副本扫描件：</label>
								</dt>
								<dd class="item-cont">
									<div class="mod-pic pic-papers">
										<img src="${my:random(imgGetUrl).concat(apply.btImg)}" alt="">
										<div class="maskBar"></div>
										<p class="textBar"><a href="${my:random(imgGetUrl).concat(apply.btImg)}" target="_blank">查看大图</a></p>
									</div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>组织机构代码证电子版：</label>
								</dt>
								<dd class="item-cont">
									<div class="mod-pic pic-papers">
										<img src="${my:random(imgGetUrl).concat(apply.orgCodeImg)}" alt="">
										<div class="maskBar"></div>
										<p class="textBar"><a href="${my:random(imgGetUrl).concat(apply.orgCodeImg)}" target="_blank">查看大图</a></p>
									</div>
								</dd>
							</dl>
						</div>
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>税务登记证电子版：</label>
								</dt>
								<dd class="item-cont">
									<div class="mod-pic pic-papers">
										<img src="${my:random(imgGetUrl).concat(apply.taxImg)}" alt="">
										<div class="maskBar"></div>
										<p class="textBar"><a href="${my:random(imgGetUrl).concat(apply.taxImg)}"  target="_blank">查看大图</a></p>
									</div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>银行开户许可证电子版：</label>
								</dt>
								<dd class="item-cont">
									<div class="mod-pic pic-papers">
										<img src="${my:random(imgGetUrl).concat(apply.bankLicenseImg)}" alt="">
										<div class="maskBar"></div>
										<p class="textBar"><a href="${my:random(imgGetUrl).concat(apply.bankLicenseImg)}"  target="_blank">查看大图</a></p>
									</div>
								</dd>
							</dl>
						</div>
					</div>
					</fieldset>
					<fieldset class="last">
					<div class="legend"><h3>联系人信息</h3></div>
					<div class="formBox">
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>联系人姓名：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:out value="${apply.bizManName}"/>
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>联系人手机：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:out value="${apply.bizManMobile}"/>
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>联系人固定电话：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${apply.tel}"/></p>
								</dd>
							</dl>
						</div>
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>电子邮箱：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:out value="${apply.bizManEmail}"/>
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>传真号码：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:out value="${apply.fax}"/>
									</p>
								</dd>
							</dl>
						</div>
					</div>
				</fieldset>
				<div class="formBtn">
					<c:if test="${apply.status == '1'}">
					<button type="button" class="btnC" id="btnPass" onclick="pass()">审核通过</button>
					<input type="button" class="btn" value="驳回申请" id="btnReject" onclick="reject()">	
					</c:if>
				</div>
			</form>
			<c:if test="${!empty(audits)}">
			<table class="table tableC">
				<colgroup>
					<col>
					<col>
					<col>
					<col width="430">
				</colgroup>
				<thead>
					<tr>
						<th colspan="4" class="caption">商家审核历史</th>	
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>更新时间</th>
						<th>状态名称</th>
						<th>操作人</th>
						<th>操作说明</th>		
					</tr>
					<c:forEach items="${audits}" var="audit">
						<tr>
						<td><fmt:formatDate value="${audit.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
							<c:choose>
								<c:when test="${audit.auditResult == '0'}">驳回</c:when>
								<c:when test="${audit.auditResult == '1'}">通过</c:when>
							</c:choose>
						</td>
						<td><c:out value="${audit.auditor}"/></td>
						<td><c:out value="${audit.auditOpinion}"/></td>						
					</tr>
					</c:forEach>					
				</tbody>
			</table>
			</c:if>
		</div>
	<!-- sellerData end-->
	
	<form action="" method="post" id="frm">
	<div class="pop" id="popReject" style="display:none">
		<div class="hd">
			<h1>操作确认</h1>
			<span><i class="icon i-close" title="关闭" onclick="closeReject()"></i></span>
		</div>
		<div class="bd">
			<div class="pop-con">
				<dl>
					<dt><label><em>*</em>驳回理由：</label></dt>
					<dd>
						<textarea name="auditOpinion" id="auditOpinion" rows="5"></textarea>
						<div class="hint popHint">最多可输入80个中文汉字</div>
					</dd>
				</dl>
			</div>
			<div class="formBtn">
				<input type="button" value="确 定" class="btnB btn-s" onclick="commitReject()">
				<input type="button" value="取 消" class="btn btn-s" onclick="closeReject()">
			</div>
		</div>
	</div>
	
	
	<div class="pop" id="popPass" style="display:none">
		<div class="hd">
			<h1>操作确认</h1>
			<span><i class="icon i-close" title="关闭" onclick="closePass()"></i></span>
		</div>
		<div class="bd">
			<div class="pop-con">
				<h2><i class="icon i-duigou"><!--<i class="icon i-warns"></i>--></i>确认审核通过吗?</h2>
				<p class="xitongP">点击‘确定’ 审核通过；点击‘取消’取消本次审核操作，并关闭当前窗口。</p>
			</div>
			<div class="formBtn">
				<input type="button" value="确定" class="btnB btn-s" onclick="commitPass()">
				<input type="button" value="取消" class="btnA btn-s" onclick="closePass()">
			</div>
		</div>
	</div>
	<div class="mask" id="mask"  style="display:none"></div>
	<input type="hidden" name="appId" value="${apply.appId}">
	</form>
	
<script type="text/javascript">
$(function(){
	CheckUtil.limitDbLength($('#auditOpinion'), 240);
})

function closeReject() {
	$('#popReject,#mask').hide();
}
function closePass() {
	$('#popPass,#mask').hide();
}
function pass(){
	$('#popPass,#mask').show();
}
function reject(){
	$('#popReject,#mask').show();
}
function commitReject(){
	if(!$.trim($('#auditOpinion').val())) return;
	$('#frm').attr('action', 'auditReject');
	$('#frm').submit();
}
function commitPass() {
	$('#frm').attr('action', 'auditPass');
	$('#frm').submit();
}
</script>
</body>
</html>