<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>店铺管理-一网全城</title>
	</head>
	<body>
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- crumbs -->
		<div class="crumbs crumbsA">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="#">店铺管理</a><em>&gt;</em></li>
				<li><strong>店铺资料</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- sellerData -->
		<div class="sellerData sellerbasic">
			<!-- tab -->
			<div class="tab">
				<div class="tabs">
					<ul>
						<li class="back-btn"><input type="button" class="btn btn-s" value="返&nbsp;&nbsp;回" onclick="window.location.href='${ctx}/${backUrl}'"></li>
						<li class="on"><a href="#">基本资料</a></li>
						<li><a href="${ctx}/store/storeCc?storeId=${storeId}&operate=${operate}">签约品类</a></li>
					</ul>
				</div>
			</div>
			<!-- tab end -->
			<form class="form formA">
				<fieldset>
					<div class="legend"><h3>基本信息</h3></div>
					<div class="formBox">
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>店铺名称：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${store.storeName}" /></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>店铺ID：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${store.storeId}" /></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>店铺类型：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:if test="${store.type == 98}">
											企业店铺
										</c:if>
										<c:if test="${store.type == 99}">
											个人店铺
										</c:if>
									</p>
								</dd>
							</dl>
						</div>
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>开店时间：</label>
								</dt>
								<dd class="item-cont">
									<p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${store.createDate}"/></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>店铺状态：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:if test="${store.status == 48}">
											未开通
										</c:if>
										<c:if test="${store.status == 49}">
											正常
										</c:if>
										<c:if test="${store.status == 50}">
											冻结
										</c:if>
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>店铺LOGO：</label>
								</dt>
								<dd class="item-cont">
									<c:choose>
										<c:when test="${empty store.logoUrl}">
											<img width='100' height='100' src="../static/img/temp/store_03.jpg" alt="">
										</c:when>
										<c:otherwise>
											<img width='100' height='100' src="${imgDownDomain}${store.logoUrl}" alt="">
											<div align="center" style="width:100px;background:#cccccc"><a target="_blank" href="${imgDownDomain}${store.logoUrl}">看大图</a></div>
										</c:otherwise>
									</c:choose>
								</dd>
							</dl>
						</div>
					</div>
					</fieldset>
					<fieldset>
					<div class="legend"><h3>联系信息</h3></div>
					<div class="formBox">
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>联系人：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${store.linkman}" /></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>联系人手机：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${store.mobile}" /></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>联系地址：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:out value="${province}" />
										<c:out value="${city}" />
										<c:out value="${district}" />
										<c:out value="${town}" />
										<c:out value="${store.addr}" />
									</p>
								</dd>
							</dl>
						</div>
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>客服电话-固定：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:choose>
											<c:when test="${store.customerServiceTel !=''}">
												<c:out value="${store.customerServiceTel}" />
											</c:when>
											<c:otherwise>
												无
											</c:otherwise>
										</c:choose>
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>客服电话-手机：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:choose>
											<c:when test="${store.customerServiceMobile !=''}">
												<c:out value="${store.customerServiceMobile}" />
											</c:when>
											<c:otherwise>
												无
											</c:otherwise>
										</c:choose>
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>邮政编码：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${store.zipCode }"/></p>
								</dd>
							</dl>
						</div>
					</div>
					</fieldset>
					<fieldset>
					<div class="legend"><h3>销售信息</h3></div>
					<div class="formBox">
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>主要货源：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:if test="${store.productSource == 49 }">
											渠道代理
										</c:if>
										<c:if test="${store.productSource == 50 }">
											批发市场
										</c:if>
										<c:if test="${store.productSource == 51 }">
											自有品牌
										</c:if>
										<c:if test="${store.productSource == 52 }">
											其它
										</c:if>
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>是否有实体店：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:if test="${store.isHaveOfflineStore == true }">
											是
										</c:if>
										<c:if test="${store.isHaveOfflineStore == false }">
											否
										</c:if>
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>店招：</label>
								</dt>
								<dd class="item-cont">
									<c:choose>
										<c:when test="${empty store.shopSignUrl}">
											<img width='345' height='36' src="../static/img/temp/dianzhao.jpg" alt="">
										</c:when>
										<c:otherwise>
											<img width='345' height='36' src="${imgDownDomain}${store.shopSignUrl}" alt="">
											<div align="center" style="width:345px;background:#cccccc"><a target="_blank" href="${imgDownDomain}${store.shopSignUrl}">看大图</a></div>
										</c:otherwise>	
									</c:choose>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label><em>*</em>店铺简介：</label>
								</dt>
								<dd class="item-cont">
									${store.brief}
								</dd>
							</dl>
						</div>
						<div class="formRow">
							<dl class="item">
								<dt class="item-label">
									<label>是否有工厂：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:if test="${store.isHaveFactory == true }">
											是
										</c:if>
										<c:if test="${store.isHaveFactory == false }">
											否
										</c:if>
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>是否有仓库：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:if test="${store.isHaveWarehouse == true }">
											是
										</c:if>
										<c:if test="${store.isHaveWarehouse == false }">
											否
										</c:if>
									</p>
								</dd>
							</dl>
						</div>
					</div>
				</fieldset>
			</form>
			<table class="table tableC">
				<colgroup>
					<col>
					<col>
					<col>
					<col width="430">
				</colgroup>
				<thead>
					<tr>
						<th colspan="4" class="caption">店铺操作记录</th>	
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>更新时间</th>
						<th>状态名称</th>
						<th>操作人</th>
						<th>操作说明</th>		
					</tr>
					<c:if test="${store.status == 50 && !empty store.freezeDate}">
						<tr>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"  value="${store.freezeDate}"/></td>
							<td>冻结</td>
							<td><c:out value="${store.freezeByName }" /></td>
							<td><c:out value="${store.freezeReason }" /></td>
						</tr>
					</c:if>
					<c:if test="${store.status == 49 && !empty store.unfreezeDate }">
						<tr>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"  value="${store.unfreezeDate}"/></td>
							<td>解冻</td>
							<td><c:out value="${store.unfreezeByName}" /></td>
							<td></td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<!-- sellerData end-->
	</body>
</html>