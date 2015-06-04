<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>保证金审核-巨友利</title>
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
							<li><em>·</em>保证金确认到账后，系统将自动开通商家添加和管理专场活动的权限。</li>
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
										<td class="emphasis">
											<c:choose>
												<c:when test="${empty(seller.isPaidDeposit) || seller.isPaidDeposit == '0'}">未到账</c:when>
												<c:when test="${seller.isPaidDeposit == '1'}">已到账</c:when>
											</c:choose>
										</td>
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
										<img src="${my:random(imgGetUrl).concat(apply.btImg)}&op=s2_w110_h110" alt="">
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
										<img src="${my:random(imgGetUrl).concat(apply.orgCodeImg)}&op=s2_w110_h110" alt="">
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
										<img src="${my:random(imgGetUrl).concat(apply.taxImg)}&op=s2_w110_h110" alt="">
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
										<img src="${my:random(imgGetUrl).concat(apply.bankLicenseImg)}&op=s2_w110_h110" alt="">
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
					<c:if test="${empty(seller.isPaidDeposit) || seller.isPaidDeposit == '0'}">
					<button type="button" class="btnC" id="btnPass" onclick="pass()">确认到账</button>
					</c:if>
					<input type="button" class="btn" value="取消" onclick="javascript:location.href='${ctx}/seller/deposit';">	
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
	
	
	<div class="pop" id="popPass" style="display:none">
		<div class="hd">
			<h1>操作确认</h1>
			<span><i class="icon i-close" title="关闭" onclick="closePass()"></i></span>
		</div>
		<div class="bd">
			<div class="pop-con">
				<h2><i class="icon i-duigou"><!--<i class="icon i-warns"></i>--></i>确认保证金到账吗?</h2>
				<p class="xitongP">点击‘确定’ 确认到账；点击‘取消’取消本次审核操作，并关闭当前窗口。</p>
			</div>
			<div class="formBtn">
				<input type="button" value="确定" class="btnB btn-s" onclick="commitPass()">
				<input type="button" value="取消" class="btnA btn-s" onclick="closePass()">
			</div>
		</div>
	</div>
	<div class="mask" id="mask"  style="display:none"></div>
	
<script type="text/javascript">
function closePass() {
	$('#popPass,#mask').hide();
}
function pass(){
	$('#popPass,#mask').show();
}

function commitPass() {
	location.href = '${ctx}/seller/depositPass?sellerId=${seller.sellerId}';
}
</script>
</body>
</html>