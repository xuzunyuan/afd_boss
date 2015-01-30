<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>卖家申请审核-一网全城</title>
</head>
<body>
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
				<li><a href="#">卖家管理</a><em>&gt;</em></li>
				<li><strong>卖家信息管理</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- sellerData -->
		<div class="sellerData personstorebaseData">
			<!-- tab -->
			<div class="tab">
				<div class="tabs">
					<ul>
						<li class="back-btn"><input type="button" class="btn btn-s" onclick="window.location.href='../seller/info';" value="返&nbsp;&nbsp;回"></li>
						<li class="on" style="cursor: pointer;" value="baseInfo">基本资料项</li>
						<li style="cursor: pointer;" value="storeInfo">店铺资料项</li>
					</ul>
				</div>
			</div>
			<!-- tab end -->
			
			<form class="form formA" id="storeInfo" style="display:none;">
				<fieldset>
					<dl class="item">
						<dt class="item-label">
							<label><em>*</em>店铺名称：</label>
						</dt>
						<dd class="item-cont">
							<p>
								 <%-- <c:if test="${not empty store}"> --%>
								 	<c:out value="${apply.storeName}"></c:out>
								 <%-- </c:if> --%>
							</p>
						</dd>
					</dl>
					<c:if test="${apply.applyType == 98}">
					<dl class="item">
									<dt class="item-label">
										<label><em>*</em>公司类型：</label>
									</dt>
									<dd class="item-cont">
										<p>
											<c:choose>
							      				<c:when test="${apply.coType == 49}">生产厂家</c:when>
							      				<c:when test="${apply.coType == 50}">品牌商</c:when>
							      				<c:when test="${apply.coType == 51}">代理商</c:when>
							      				<c:when test="${apply.coType == 52}">经营商</c:when>
							      				<c:otherwise>其它</c:otherwise>
							      			</c:choose>
										</p>
									</dd>
								</dl>
					</c:if>
					<dl class="item item-last">
						<dt class="item-label">
							<label><em>*</em>签约品类：</label>
						</dt>
						<dd class="item-cont">
							<table class="table tableD">
								<colgroup>
									<col width="50">
									<col width="160">
									<col width="250">
									<col width="90">
									<col width="90">
								</colgroup>
								<thead>
									<tr>
										<th>序号</th>
										<th>一级类目</th>
										<th>二级类目</th>
										<th>扣点</th>
										<th>保证金</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${not empty ccs}">
									<c:set var="label" value="0"></c:set>
									<c:forEach var="cc" items="${ccs}" varStatus="fsta">
										<c:forEach var="scc" items="${cc.categories}" varStatus="ssta">
											<tr>
												<c:set var="label" value="${label+1}"></c:set>
												<td><c:out value="${label}"/></td>
												<c:if test="${ssta.first}"><td rowspan="${fn:length(cc.categories)}"><c:out value="${cc.ccName}"/></td></c:if>
												<td><c:out value="${scc.ccName}"/></td>
												<td>-</td>
												<td>-</td>
											</tr>
										</c:forEach>
									</c:forEach>
									</c:if>
								</tbody>
							</table>
						</dd>
					</dl>
					<c:if test="${apply.applyType == 98}">
						<dl class="item item-last">
							<dt class="item-label">
								<label>类目行业资源：</label>
							</dt>
							<dd class="item-cont">
								<table class="table tableD">
									<colgroup>
										<col width="80">
										<col width="200">
										<col width="180">
										<col width="180">
									</colgroup>
									<thead>
										<tr>
											<th>类目名称</th>
											<th>资质名称</th>
											<th>电子版</th>
											<th>到期日</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${not empty qualis}">
										<c:forEach var="quali" items="${qualis}">
											<tr>
												<td><c:out value="${quali.ccName}"/></td>
												<td><c:out value="${quali.qualiName}"/></td>
												<td>
													<div class="mod-pic">
														<img src="<c:choose><c:when test="${empty quali.quailUrl}">http://img.seller.yiwangimg.com/temp/zhengjian.png</c:when><c:otherwise>${imgDownDomain}${quali.quailUrl}&op=s1_w98_h86_e1-c3_w98_h86</c:otherwise></c:choose>"  alt="">
														<div class="maskBar"></div>
														<p class="textBar"><a href="<c:choose><c:when test="${empty quali.quailUrl}">http://img.seller.yiwangimg.com/temp/zhengjian.png</c:when><c:otherwise>${imgDownDomain}${quali.quailUrl}</c:otherwise></c:choose>" target="_blank">查看大图</a></p>
													</div>
												</td>
												<td>
													<c:out value="${quali.expireDate}" default="永久"/>
												</td>
											</tr>
										</c:forEach>
										</c:if>
									</tbody>
								</table>
							</dd>
						</dl>
					</c:if>
				</fieldset>
			</form>
			
			<form id="baseInfo" class="form formA">
				<div class="mod-info">
					<div class="item">
						<h2>卖家账号注册信息</h2>
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
									<th>卖家账号：</th> 
									<td><c:out value="${login.loginName}"/></td>
									<th>账号状态：</th>
									<td>
									<c:choose>
					      				<c:when test="${login.status == 48}">初始</c:when>
					      				<c:when test="${login.status == 49}">正常</c:when>
					      				<c:when test="${login.status == 50}">冻结</c:when>
					      			</c:choose>
			      					</td>
									<th class="emphasis">基本资料审核状态：</th>
									<td class="emphasis">
										<c:choose>
						      				<c:when test="${empty apply}">未申请</c:when>
						      				<c:when test="${apply.status == 49}">待审核</c:when>
						      				<c:when test="${apply.status == 50}">审核通过</c:when>
						      				<c:when test="${apply.status == 51}">已驳回</c:when>
						      			</c:choose>
									</td>
								</tr>
								<tr>
									<th>验证手机号：</th>
									<td>${login.mobile}</td>
									<th>卖家昵称：</th> 
									<td><c:out value="${login.nickname}"/></td>
									<th class="emphasis">保证金到账状态：</th>
									<td class="emphasis">
										<c:choose>
						      				<c:when test='${not empty store and store.isPaidDeposit}'>已到账</c:when>
						      				<c:otherwise>未到账</c:otherwise>
						      			</c:choose> 
									</td>
								</tr>
								<tr>
									<th>注册时间：</th>
									<td><fmt:formatDate value="${login.regDate}" pattern="yyyy-MM-dd HH:mm" type="both"/></td>
									<th>店铺类型：</th>
									<td>
										<c:choose>
						      				<c:when test="${apply.applyType == 99}">
						      					个人店铺
						      				</c:when>
						      				<c:when test="${apply.applyType == 98}">
						      					商家店铺
						      				</c:when>
						      			</c:choose>
									</td>
									<th class="emphasis">店铺资料审核状态：</th>
									<td class="emphasis">
										 <c:choose>
						      				<c:when test="${apply.storeAuditStatus == 49}">待审核</c:when>
						      				<c:when test="${apply.storeAuditStatus == 50}">审核通过</c:when>
						      				<c:when test="${apply.storeAuditStatus == 51}">已驳回</c:when>
						      			</c:choose>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- item end -->
				</div>
				
				<c:choose>
      				<c:when test="${apply.applyType == 99}">
      					 <fieldset class="last">
      					 	<dl class="item">
								<dt class="item-label">
									<label>卖家编号：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:out value="${login.sellerId}"/>
									</p>
								</dd>
							</dl>
      					 	<dl class="item">
								<dt class="item-label">
									<label>入驻申请时间：</label>
								</dt>
								<dd class="item-cont">
									<p><c:if test="${not empty apply}"><fmt:formatDate value="${apply.applyDate}" pattern="yyyy-MM-dd HH:mm" type="both"/></c:if></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>卖家名称：</label>
								</dt>
								<dd class="item-cont">
									<p><c:if test="${not empty apply}"><c:out value="${apply.realName}"/></c:if></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>是否办理营业执照：</label>
								</dt>
								<dd class="item-cont">
									<p><c:if test="${not empty apply}"><c:out value="${apply.isBizLicense ? '办理' : '不办理'}"></c:out></c:if></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>身份证号码：</label>
								</dt>
								<dd class="item-cont">
									<p><c:if test="${not empty apply}"><c:out value="${apply.certCode}"/></c:if></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>身份证到期日期：</label>
								</dt>
								<dd class="item-cont">
									<p><c:if test="${not empty apply}"><fmt:formatDate value="${apply.certExpireDate}" pattern="yyyy-MM-dd" type="date"/></c:if></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>卖家半身照：</label>
								</dt>
								<dd class="item-cont">
									<div class="mod-pic pic-id">
										<img src="<c:choose><c:when test="${empty pic}">http://img.seller.yiwangimg.com/images/img_06.png</c:when><c:otherwise>${imgDownDomain}${pic}&op=s1_w116_h86_e1-c3_w116_h86</c:otherwise></c:choose>"  alt="">
										<div class="maskBar"></div>
										<p class="textBar">
											<a href="<c:choose><c:when test="${empty pic}">http://img.seller.yiwangimg.com/images/img_06.png</c:when><c:otherwise>${imgDownDomain}${pic}</c:otherwise></c:choose>" target="_blank">查看大图</a>
										</p>
									</div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>身份证正面照：</label>
								</dt>
								<dd class="item-cont">
									<div class="mod-pic pic-id">
										<c:if test="${not empty frontUrl}">
										<img src="<c:choose><c:when test="${empty frontUrl}">http://img.seller.yiwangimg.com/temp1.png</c:when><c:otherwise>${imgDownDomain}${frontUrl}&op=s1_w116_h86_e1-c3_w116_h86</c:otherwise></c:choose>"  >
										<div class="maskBar"></div>
										<p class="textBar">
											<a href="<c:choose><c:when test="${empty frontUrl}">http://img.seller.yiwangimg.com/temp1.png</c:when><c:otherwise>${imgDownDomain}${frontUrl}</c:otherwise></c:choose>" target="_blank">查看大图</a>
										</p>
										</c:if>
									</div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>身份证背面照：</label>
								</dt>
								<dd class="item-cont">
									<div class="mod-pic pic-id">
										<c:if test="${not empty backUrl}">
										<img src="<c:choose><c:when test="${empty backUrl}">http://img.seller.yiwangimg.com/temp2.png</c:when><c:otherwise>${imgDownDomain}${backUrl}&op=s1_w116_h86_e1-c3_w116_h86</c:otherwise></c:choose>" >
										<div class="maskBar"></div>
										<p class="textBar">
											<a href="<c:choose><c:when test="${empty backUrl}">http://img.seller.yiwangimg.com/temp2.png</c:when><c:otherwise>${imgDownDomain}${backUrl}</c:otherwise></c:choose>" target="_blank">查看大图</a>
										</p>
										</c:if>
									</div>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>手机号码：</label>
								</dt>
								<dd class="item-cont">
									<p><c:if test="${not empty apply}">${apply.mobile}</c:if></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>固定电话：</label>
								</dt>
								<dd class="item-cont">
									<p><c:if test="${not empty apply}"><c:out value="${apply.tel}"/></c:if></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>联系地址：</label>
								</dt>
								<dd class="item-cont">
									<p><c:if test="${not empty apply}"><c:out value="${cityName}"/>&nbsp;&nbsp;<c:out value="${apply.addr}"/></c:if></p>
								</dd>
							</dl>
							<dl class="item item-last">
								<dt class="item-label">
									<label><em>*</em>邮政编码：</label>
								</dt>
								<dd class="item-cont">
									<p><c:if test="${not empty apply}">${apply.zipCode}</c:if></p>
								</dd>
							</dl>
						</fieldset>
					</c:when>
      				<c:when test="${apply.applyType == 98}">
      					 <fieldset>
								<div class="legend"><h3>营业执照信息（副本）</h3></div>
								<div class="formBox">
									<div class="formRow">
										<dl class="item">
											<dt class="item-label">
												<label>卖家编号：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${login.sellerId}"/>
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label>入驻申请时间：</label>
											</dt>
											<dd class="item-cont">
												<p><c:if test="${not empty apply}"><fmt:formatDate value="${apply.applyDate}" pattern="yyyy-MM-dd HH:mm" type="both"/></c:if></p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>公司名称：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${apply.coName}"/>
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>公司所在地：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${cityName}"/>&nbsp;&nbsp;<c:out value="${apply.addr}"/>
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>公司电话：</label>
											</dt>
											<dd class="item-cont">
												<p>
													${apply.tel}
												</p>
											</dd>
										</dl>
									</div>
									<div class="formRow">
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>营业执照副本电子版：</label>
											</dt>
											<dd class="item-cont">
												<div class="mod-pic pic-papers">
													<img src="<c:choose><c:when test="${empty url[0]}">http://img.seller.yiwangimg.com/temp/zhengjian.png</c:when><c:otherwise>${imgDownDomain}${url[0]}&op=s1_w98_h86_e1-c3_w98_h86</c:otherwise></c:choose>" alt="">
													<div class="maskBar"></div>
													<p class="textBar"><a href="<c:choose><c:when test="${empty url[0]}">http://img.seller.yiwangimg.com/temp/zhengjian.png</c:when><c:otherwise>${imgDownDomain}${url[0]}</c:otherwise></c:choose>" target="_blank">查看大图</a></p>
												</div>
											</dd>
										</dl>
									</div>
								</div>
								</fieldset>
								<fieldset>
								<div class="legend"><h3>组织机构代码证</h3></div>
								<div class="formBox">
									<div class="formRow">
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>组织机构代码证：</label>
											</dt>
											<dd class="item-cont">
												<p>
													${apply.orgCode}
												</p>
											</dd>
										</dl>
									</div>
									<div class="formRow">
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>组织机构代码证电子版：</label>
											</dt>
											<dd class="item-cont">
												<div class="mod-pic pic-papers">
													<img src="<c:choose><c:when test="${empty url[1]}">http://img.seller.yiwangimg.com/temp/zhengjian.png</c:when><c:otherwise>${imgDownDomain}${url[1]}&op=s1_w98_h86_e1-c3_w98_h86</c:otherwise></c:choose>" alt="">
													<div class="maskBar"></div>
													<p class="textBar"><a href="<c:choose><c:when test="${empty url[1]}">http://img.seller.yiwangimg.com/temp/zhengjian.png</c:when><c:otherwise>${imgDownDomain}${url[1]}</c:otherwise></c:choose>" target="_blank">查看大图</a></p>
												</div>
											</dd>
										</dl>
									</div>
								</div>
								</fieldset>
								<fieldset>
								<div class="legend"><h3>税务登记证</h3></div>
								<div class="formBox">
									<div class="formRow">
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>纳税人识别号：</label>
											</dt>
											<dd class="item-cont">
												<p>
													${apply.taxNo}
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>纳税人类型：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:choose>
									      				<c:when test="${apply.taxType == 49}">一般纳税人</c:when>
									      				<c:when test="${apply.taxType == 50}">小规模纳税人</c:when>
									      				<c:when test="${apply.taxType == 51}">非增值税纳税人</c:when>
									      			</c:choose>
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label>纳税税率：</label>
											</dt>
											<dd class="item-cont">
												<p>
													${apply.taxRatio}%
												</p>
											</dd>
										</dl>
									</div>
									<div class="formRow">
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>税务登记证电子版：</label>
											</dt>
											<dd class="item-cont">
												<div class="mod-pic pic-papers">
													<img src="<c:choose><c:when test="${empty url[2]}">http://img.seller.yiwangimg.com/temp/zhengjian.png</c:when><c:otherwise>${imgDownDomain}${url[2]}&op=s1_w98_h86_e1-c3_w98_h86</c:otherwise></c:choose>" alt="">
													<div class="maskBar"></div>
													<p class="textBar"><a href="<c:choose><c:when test="${empty url[2]}">http://img.seller.yiwangimg.com/temp/zhengjian.png</c:when><c:otherwise>${imgDownDomain}${url[2]}</c:otherwise></c:choose>" target="_blank">查看大图</a></p>
												</div>
											</dd>
										</dl>
									</div>
								</div>
								</fieldset>
								<fieldset>
								<div class="legend"><h3>开户银行许可证</h3></div>
								<div class="formBox">
									<div class="formRow">
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>银行开户名：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${apply.bankAcctName}"/>
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>公司银行账号：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${apply.bankAcctNo}"/>
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label>开户银行支行名称：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${apply.branchName}"/>
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label>开户银行支行联行号：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${apply.branchNo}"/>
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label>开户银行支行所在地：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${bankCityName}"/>
												</p>
											</dd>
										</dl>
									</div>
									<div class="formRow">
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>银行开户许可证电子版：</label>
											</dt>
											<dd class="item-cont">
												<div class="mod-pic pic-papers">
													<img src="<c:choose><c:when test="${empty url[3]}">http://img.seller.yiwangimg.com/temp/zhengjian.png</c:when><c:otherwise>${imgDownDomain}${url[3]}&op=s1_w98_h86_e1-c3_w98_h86</c:otherwise></c:choose>" alt="">
													<div class="maskBar"></div>
													<p class="textBar"><a href="<c:choose><c:when test="${empty url[3]}">http://img.seller.yiwangimg.com/temp/zhengjian.png</c:when><c:otherwise>${imgDownDomain}${url[3]}</c:otherwise></c:choose>" target="_blank">查看大图</a></p>
												</div>
											</dd>
										</dl>
									</div>
								</div>
								</fieldset>
								<fieldset class="last">
								<div class="legend"><h3>卖家入驻信息人信息</h3></div>
								<div class="formBox">
									<div class="formRow">
										<dl class="item">
											<dt class="item-label">
												<label>联系人姓名：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${apply.realName}"/>
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>联系人手机：</label>
											</dt>
											<dd class="item-cont">
												<p>
													${apply.mobile}
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label>其他联系姓名：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${apply.otherContactor}"/>
												</p>
											</dd>
										</dl>
									</div>
									<div class="formRow">
										<dl class="item">
											<dt class="item-label">
												<label>其他联系手机号：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${apply.otherMobile}"/>
												</p>
											</dd>
										</dl>
										<dl class="item">
											<dt class="item-label">
												<label><em>*</em>电子邮箱：</label>
											</dt>
											<dd class="item-cont">
												<p>
													<c:out value="${apply.email}"/>
												</p>
											</dd>
										</dl>
									</div>
								</div>
							</fieldset>
      				</c:when>
      			</c:choose>
			</form>
			
			<c:if test="${!empty(audits)}">
			<table class="table tableC">
				<colgroup>
					<col>
					<col>
					<col>
					<col>
					<col width="430">
				</colgroup>
				<thead>
					<tr>
						<th colspan="5" class="caption">审核历史</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>更新时间</th>
						<th>审核项目</th>
						<th>状态名称</th>
						<th>操作人</th>
						<th>操作说明</th>
					</tr>
					<c:forEach var="audit" items="${audits}">
					<tr>
						<td><fmt:formatDate value="${audit.auditDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></td>
						<td>
							<c:choose>
			      				<c:when test="${audit.auditType == 49}">基本资料审核</c:when>
			      				<c:when test="${audit.auditType == 50}">店铺审核</c:when>
			      			</c:choose>
						</td>
						<td><c:out value="${audit.auditResult ? '审核通过' : '审核驳回'}"/></td>
						<td><c:out value="${audit.auditor}"/></td>
						<td><c:out value="${audit.auditOpinion}"/></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</c:if>
			
		</div>
		<!-- sellerData end-->
	</div>
	<!-- main end -->
	
	<script type="text/javascript">
		$(function(){
			$(".tabs li").on("click", function(){
				var $li = $(this);
				if(!$li.hasClass("back-btn")){
					$li.siblings("li").removeClass("on");
					$li.addClass("on");
					
					var name = $li.attr("value");
					if(name == "baseInfo"){
						$("#storeInfo").hide();
						$("#baseInfo").show();
					}else{
						$("#baseInfo").hide();
						$("#storeInfo").show();
					}
				}
			});
		});
	</script>
</body>
</html>