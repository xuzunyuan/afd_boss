<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%request.setAttribute("ctx", request.getContextPath()); %>
<%request.setAttribute("imgUrl", "http://upload.yiwang.com/rc/getimg"); %>
<%request.setAttribute("prodUrl", "http://item.yiwang.com/detail/"); %>
<%request.setAttribute("prodSnapUrl", "http://member.yiwang.com/index.php?r=product/tradesnapshot&itemid="); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<html>
	<head>
		<title></title>
	</head>
	<body>
		<link rel="stylesheet" href="${ctx}/static/style/classes_.css?t=20140626" />
        <!-- main -->
			<div class="main">
				<!-- foldbarV -->
				<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
				<!-- foldbarV end -->
				<!-- crumbs -->
				<div class="crumbs crumbsA">
					<ul>
						<li><a href="#">后台首页</a><em>&gt;</em></li>
						<li><a href="#">物流管理</a><em>&gt;</em></li>
						<li><strong>运费模板</strong></li>
					</ul>
				</div>
				<!-- crumbs end -->
				<!-- carriageTemplate -->
				<div class="carriageTpl">						
					<div class="btnBox">
						<input type="button" class="btn" onclick="location.href ='${ctx}/freight/freightAdd'" value="新增运费模板">
					</div>
					<!-- table -->
					<c:forEach items="${tpls}" var="tpl" varStatus="status">	
					<table class="table tableB carriageTable">
						<colgroup>
							<col width="140">
							<col width="338">
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<td colspan="6" class="ctrlArea">
									<h3><c:out value="${tpl.tplName}"/></h3>
									<span class="o-operate"><a href="${ctx}/freight/freightEdit?fid=<c:out value="${tpl.ywFreightTplId}"/>">修改</a></span>
									<span>最后编辑时间：<em><fmt:formatDate value="${tpl.lastUpdateDate}" pattern="yyyy-MM-dd HH:mm"/></em></span>
								</td>
							</tr>
							
							<tr>
								<th>配送方式</th>
								<th>配送区域</th>
								<c:if test="${tpl.priceType=='w'}"><th>首重（kg）</th></c:if> 
								<c:if test="${tpl.priceType=='v'}"><th>首体积（m³）</th></c:if> 
								<c:if test="${tpl.priceType=='n'}"><th>首件（件）</th></c:if> 
								<th>运费(元)</th>
								<c:if test="${tpl.priceType=='w'}"><th>续重（kg）</th></c:if> 
								<c:if test="${tpl.priceType=='v'}"><th>续体积（m³）</th></c:if> 
								<c:if test="${tpl.priceType=='n'}"><th>续件（件）</th></c:if> 								
								<th>运费(元)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>普通快递</td>
								<td class="c-area">吉林省</td>
								<td><c:if test="${empty tpl.baseUnits}">0</c:if><c:out value="${tpl.baseUnits}"/></td>
								<td><c:if test="${tpl.baseFee==0}">0.0</c:if><c:if test="${empty tpl.baseFee}">0.00</c:if><c:out value="${tpl.baseFee}"/></td>
								<td><c:if test="${empty tpl.increUnits}">0</c:if><c:out value="${tpl.increUnits}"/></td>
								<td><c:if test="${tpl.increFee==0}">0.0</c:if><c:if test="${empty tpl.increFee}">0.00</c:if><c:out value="${tpl.increFee}"/></td>
							</tr>
						</tbody>
					</table>
					<!-- table end -->
					</c:forEach>
					
				</div>
				<!-- carriageTemplate end-->
			</div>
			<!-- main end -->
        
	</body>
</html>
