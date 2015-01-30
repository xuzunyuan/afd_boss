<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setAttribute("ctx", request.getContextPath()); %>
<%
request.setAttribute("imgDownPrefix", "http://img");
request.setAttribute("imgDownSuffix", ".yiwangimg.com/rc/getimg?rid=");
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib uri="/WEB-INF/tld/pageNew.tld" prefix="pg"%>
<html>
<head>
	<title>商品审核-一网全城</title>
</head>
<body id="">
			<!-- foldbarV  class="wrap"-->
			<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
			<!-- foldbarV end -->
			<!-- crumbs -->
			<div class="crumbs">
				<ul>
					<li><a href="#">后台首页</a><em>&gt;</em></li>
					<li><a href="#">商品管理</a><em>&gt;</em></li>
					<li><strong>商品审核列表</strong></li>
				</ul>
			</div>
			<!-- crumbs end -->
			<!-- goodsList -->
			<div class="goodsauditList">
				<!-- screening -->
				<div class="screening">
					<form class="form" id="query" action="${ctx }/goods/goodsauditList" method="post" onsubmit="return goods.checkFromData();">
						<fieldset class="default">
							<legend><h3>查询条件</h3></legend>
							<ul class="formBox">
								<li class="item">
									<div class="item-label"><label>商品编号：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textA" name="prodCode" placeholder="商品编号只能输入数字" onkeydown="CheckUtil.limitDigital($(this));" value="${prodcutCondition.prodCode}" />
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>商品标题：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textC" name="title" value="<c:out value="${prodcutCondition.title}"/>"/>
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>更新时间：</label></div>
									<div class="item-cont">
										<input type="text" readonly="readonly" value="<fmt:formatDate value="${prodcutCondition.startDate}" pattern="yyyy-MM-dd" />" name="startDt" class="dateTxt" onClick="WdatePicker()" />
			            				<span> 至 </span>
			            				<input type="text" readonly="readonly" value="<fmt:formatDate value="${prodcutCondition.endDate}" pattern="yyyy-MM-dd" />" name="endDt" class="dateTxt" onClick="WdatePicker()" />									
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>店铺名称：</label></div>
									<div class="item-cont">
										<input type="text" class="txt textA" name="storeName" value="<c:out value="${prodcutCondition.storeName}"/>"/>
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>基础类目：</label></div>
									<div class="select">
										<select name="fc" id="fc">
											<option value="">全部</option>
										</select>
									</div>
									<div class="select">
										<select name="sc" id="sc">
											<option value="">全部</option>
										</select>
									</div>
									<div class="select">
										<select name="bcId" id="tc">
											<option value="">全部</option>
										</select>
									</div>
								</li>
								<li class="item">
									<div class="item-label"><label>审核状态：</label></div>
									<div class="item-cont">
										<div class="select">
											<select name="auditStatus">
												<option value="">全部</option>
											    <option <c:if test="${productCondition.auditStatus == '4'}">selected="selected"</c:if> value="4">待审核</option>
											    <option <c:if test="${productCondition.auditStatus == '3'}">selected="selected"</c:if> value="3">审核中</option>
<%-- 											    <option <c:if test="${productCondition.auditStatus == '2'}">selected="selected"</c:if> value="2">审核驳回</option>
 --%>											</select>
										</div>
									</div>
								</li>													
							</ul>
						</fieldset>
						<div id="foldbarH" class="foldbarH"><!-- 展开后添加class命open -->
							<div id="foldBtn" class="foldBtn" ><i class="ico" onclick="goods.searchMenu();"></i></div>
							<div class="searchBtn"><input type="submit" name="query" class="btn btn-s" value="查&nbsp;&nbsp;询" /></div>
						</div>
						<input type="hidden" name="bcId" id="bcId" value="">									
						<input type="hidden" name="fId" id="fId" value="">
						<input type="hidden" name="sId" id="sId" value="">
						<input type="hidden" name="bcCode" id="bcCode" value="">
			<%-- 		<input type="hidden" name="bcJson" id="bcJson" value="${bcJson}"> 
						<input type="hidden" name="thirdbcId" id="thirdbcId" value=""> --%>
					</form>
				</div>
				<!-- screening end -->
				<!-- 
				<div class="actionBar">
					<input type="checkbox" class="chk" name="allSelect" id="allSelect" /><label for="allSelect">全选</label>
					<input type="button" class="btnA" value="审核通过" />
					<input type="button" class="btnA" value="驳回申请" />
				</div>
				 -->
				<!-- table -->
				<div class="tableWrap">
				<c:choose>
					<c:when test="${!empty requestScope.page.result}">
						<table class="table tableA">
							<colgroup>
								<%-- <col width="40" /> --%>
								<col width="30" />
								<col width="220" />
								<col width="120" />
								<col width="75" />
								<col width="70" />
								<col width="40" />
								<col width="60" />
								<col width="70">
								<col />
								<col width="70" />
								<col width="60">	
								<col width="90">
							</colgroup>
							<thead>
								<tr>
								<!-- 	<th></th> -->
									<th>序号</th>
									<th>商品标题</th>
									<th>商品编号</th>
									<th>市场价（元）</th>
									<th>单价（元）</th>
									<th>库存</th>
									<th>商品状态</th>
									<th>基础类目</th>
									<th>店铺名称</th>
									<th>更新时间</th>
									<th>审核状态</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.result}" var="p" varStatus="var">
								<tr>
<%-- 									<td class="chkbox"><input type="checkbox" class="chk" name="" id="" value="${p.prodId }" /></td>
 --%>									<td>${var.count}</td>
									<td class="o-goodsName align-l">
									<dl>
	                                	<dt><img src="${imgDownPrefix}${p.prodId%6}${imgDownSuffix}${p.imgUrl}&op=s1_w50_h50"></dt>
										<dd>
											<a href="http://item.yiwang.com/detail/${p.defultSkuId}.html" target="_blank"><c:out value="${p.title}"/></a></p>
										</dd>
									</dl>
								</td>
									<th>${p.prodCode }</th>
									<td><fmt:formatNumber pattern="0.00" value="${p.marketPrice }"></fmt:formatNumber></td>
									<td><fmt:formatNumber pattern="0.00" value="${p.salePrice }"></fmt:formatNumber></td>
									<td>${p.stockBalance }</td>
									<td>
									<c:choose>
										<c:when test="${p.status == '1' }">
											<em>待上架</em>
										</c:when>
										<c:when test="${p.status == '2' }">
											<em>已删除</em>
										</c:when>
										<c:when test="${p.status == '3' }">
											<em>上架</em>
										</c:when>
										<c:when test="${p.status == '4' }">
											<em>下架</em>
										</c:when>
									</c:choose>
									</td>
									<td>${p.bcName }</td>
									<td><a href="http://shop.yiwang.com/${p.storeId }/" target="_blank"><c:out value="${p.storeName }"/></a></td>
									<td><fmt:formatDate value="${p.lastUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td><c:choose>
										<c:when test="${p.auditStatus=='2'}">
											<p class="meg">审核驳回</p>
										</c:when>
										<c:when test="${p.auditStatus=='3'}">
											<p>审核中</p>
										</c:when>
										<c:when test="${p.auditStatus=='4'}">
											<p>待审核</p>														
										</c:when>
									</c:choose></td>
									<td class="t-operate">
										<div class="mod-operate">
											<div><a href="${ctx }/goods/goodsDetail?prodId=${p.prodId}">审核申请</a></div>
										<%-- 	<ul>
												<li><a href="${ctx }/goods/goodsbaseData">商品基本料资</a></li>
												<li><a href="${ctx }/goods/goodsPicture">商品图片</a></li>
											</ul> --%>
										</div>
									</td>
								</tr>							
							</c:forEach>
							</tbody>
						</table>
					</c:when>
					<c:otherwise>
						<div class="hintBar screeningMes">暂无符合条件的查询结果</div>
					</c:otherwise>
				</c:choose>
				</div>
				<!-- table end -->
			<c:if test="${fn:length(page.result) > 0}">
				<pg:page name="queryProduct" page="${page}" formId="query"></pg:page>
			</c:if>
			</div>
		<!-- goodsList end -->
	<script type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${ctx}/static/js/goodsAudit.js?t=20140916"></script>
	<script type="text/javascript" src="${ctx}/static/js/jquery.md.js?t=2014061704"></script>
	<script type="text/javascript" src="${ctx }/static/js/check-util.js?t=20140709"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		goods = new goods();
	
	 	var storeName = '${prodcutCondition.storeName}';
	 	
	 	var temBcId = '${prodcutCondition.bcId}'; 
	 	(temBcId == '0')? bcId='' : bcId = temBcId;
	 	var auditStatus = '${prodcutCondition.auditStatus}';
	 	var fId = '${fId}';
	 	var sId = '${sId}';
	 	
	 	var bcCode = '${prodcutCondition.bcCode}';
	 	
	 	if(!!bcCode || !!storeName || !!bcId || (!!auditStatus && auditStatus!='-1')){
			$("fieldset").removeClass("default");
			$("#foldbarH").addClass("open");
	 	}
	 	
	 	goods.fetchSubCategory("#fc", 0);
	 	
	 	$('#fc').change(function(){
	 		goods.fetchSubCategory("#sc", this.value);
	 		$('input[name=fId]').val(this.value);
	 		var bcCode = $(this).children("option:selected").attr("bcCode");
	 		$('input[name=bcCode]').val(bcCode);
	 	});	
	 	$('#sc').change(function(){
	 		goods.fetchSubCategory("#tc", this.value);
	 		$('input[name=sId]').val(this.value);
	 		var bcCode = $(this).children("option:selected").attr("bcCode");
	 		if(bcCode === undefined){
	 			bcCode = $("#fc").children("option:selected").attr("bcCode");
	 		}
	 		$('input[name=bcCode]').val(bcCode);
	 	});
	 	$('#tc').change(function(){
	 		$('input[name=bcId]').val(this.value);
	 		var bcCode = $(this).children("option:selected").attr("bcCode");
	 		if(bcCode === undefined){
	 			bcCode = $("#sc").children("option:selected").attr("bcCode");
	 		}
	 		$('input[name=bcCode]').val(bcCode);
	 	});
	 	
 		if(!!fId){
 			$("#fc").val(fId).trigger("change");
		 	if(!!sId){
		 		$("#sc").val(sId).trigger("change");
		 		
		 		if(sId != $("#sc").val()) {
		 			$("#sc").val('');
		 		}
		 	}
		 	if(!!bcId){
		 		$("#tc").val(bcId).trigger("change");
		 		
		 		if(bcId != $("#tc").val()) {
		 			$("#tc").val('');
		 		}
		 	}
 		}
	});
</script>	
</body>
</html>
