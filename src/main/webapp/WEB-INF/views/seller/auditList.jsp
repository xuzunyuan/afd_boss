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
	<script type="text/javascript" src="../static/js/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="../static/js/auditList.js?t=2014061701"></script>
	<script type="text/javascript" src="../static/js/page.js?t=2014061701"></script>

	<div class="main">
		<!-- foldbarV -->
		<div id="foldbarV">
			<div class="foldbarV">
				<div class="foldBtn"></div>
			</div>
		</div>
		<!-- foldbarV end -->
		<!-- crumbs -->
		<div class="crumbs">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="#">卖家管理</a><em>&gt;</em></li>
				<li><strong>卖家入驻审核</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- goodsList -->
		<div class="">
			<!-- screening -->
			<div class="screening">
				<form id="audit" method="post" action="${ctx}/seller/audit" class="form">
					<fieldset id="condition" class="default">
						<legend>
							<h3>查询条件</h3>
						</legend>
						<ul class="formBox">
							<li class="item">
								<div class="item-label">
									<label>卖家账号：</label>
								</div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${pageInfo.conditions.loginName}"/>" name="loginName" id="loginName" class="txt textA" >
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>申请时间：</label>
								</div>
								<div class="item-cont">
									<input type="text" value="${pageInfo.conditions.startDt}" class="dateTxt" onfocus="WdatePicker()" name="startDt" id="startDt"><span>至</span><input type="text" value="${pageInfo.conditions.endDt}" class="dateTxt" onfocus="WdatePicker()" name="endDt" id="endDt">
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>卖家名称：</label>
								</div>
								<div class="item-cont">
									<input type="text" class="txt textA" value="<c:out value='${pageInfo.conditions.realName}'/>" name="realName" id="realName">
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>店铺名称：</label>
								</div>
								<div class="item-cont">
									<input type="text" class="txt textA" value="<c:out value='${pageInfo.conditions.storeName}'/>" name="storeName" id="storeName">
								</div>
							</li> 
							<li class="item">
								<div class="item-label">
									<label>店铺类型：</label>
								</div>
								<div class="item-cont">
									<div class="select">
										<select name="applyType" id="applyType">
						        			<option value="" >全部</option>
						        			<option value="c" ${pageInfo.conditions.applyType == 'c' ? 'selected="selected"' : ''}>个人店铺</option>
											<option value="b" ${pageInfo.conditions.applyType == 'b' ? 'selected="selected"' : ''}>企业店铺</option>
										</select>
									</div>
								</div>
							</li>
						</ul>
					</fieldset>
					<!-- foldbarH -->
					<div id="foldbar" class="foldbarH">
						<!-- 展开后添加class命open -->
						<div class="foldBtn">
							<i class="ico"></i>
						</div>
						<div class="searchBtn">
							<input type="hidden" name="applyDate" value="DESC" />
							<input type="hidden" name="status" value="1" />
							<input type="hidden" name="styleF" id="styleF" value="${pageInfo.conditions.styleF}"/>
							<input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" name="query" id="query">
						</div>
					</div>
					<!-- foldbarH end -->
				</form>
			</div>
			<!-- screening end -->
			<!-- actionBar -->
			<!-- <div class="actionBar">
				<input type="checkbox" class="chk" name="allSelect" id="allSelect" /><label
					for="allSelect">全选</label> <input type="button" class="btnA"
					value="审核通过" /> <input type="button" class="btnA" value="驳回申请" />
				<div class="pagingMini">
					<div class="pagingBtn">
						<a href="javascript:void(0)" class="pageUp disable"></a> <a
							href="#" class="pageDown"></a>
					</div>
					<div class="pageNum">
						<span><b>1</b></span>/<span>20</span>页
					</div>
					<div class="count">
						共<em>23145</em>条记录，本页显示<em>20</em>条
					</div>
				</div>
			</div> -->
			<!-- actionBar end -->
			<!-- table -->
			<div class="tableWrap">
				<table class="table tableA">
					<colgroup>
						<%-- <col width="40" /> --%>
						<col width="40" />
						<%-- <col width="56" /> --%>
						<col />
						<col width="100" />
						<col width="150" />
						<col width="100" />
						<col />
						<col />
						<col width="100" />
						<col width="90">
					</colgroup>
					<thead>
						<tr>
							<!-- <th></th> -->
							<th>序号</th>
							<!-- <th>卖家编码</th> -->
							<th>卖家名称</th>
							<th>所在地区</th>
							<th>申请时间</th>
							<th>卖家账号</th>
							<th>店铺名称</th>
							<th>店铺类型</th>
							<th>基本资料审核状态</th>
							<th>店铺审核状态</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
	      				<c:when test="${fn:length(applysPage.result)>0}">
	      					<c:forEach items="${applysPage.result}" var="apply" varStatus="status"> 
								<tr>
									<!-- <td class="chkbox"><input type="checkbox" class="chk" name="" id="" value="" /></td> -->
									<td>${(applysPage.currentPageNo-1)*applysPage.pageSize+status.count}</td>
									<!-- <th>238096</th> -->
									<td class="align-l">
										<c:choose>
						      				<c:when test="${apply.applyType == 99}">
						      					<c:out value="${apply.realName}"/>
						      				</c:when>
						      				<c:when test="${apply.applyType == 98}">
						      					<c:out value="${apply.coName}"/>
						      				</c:when>
						      			</c:choose>
									</td>
									<td><c:out value="${apply.cityName}"/></td>
									<td><fmt:formatDate value="${apply.applyDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></td>
									<td><c:out value="${apply.loginName}"/></td>
									<td class="align-l">${apply.storeName}</td>
									<td>
										<c:choose>
						      				<c:when test="${apply.applyType == 99}">
						      					个人店铺
						      				</c:when>
						      				<c:when test="${apply.applyType == 98}">
						      					企业店铺
						      				</c:when>
						      			</c:choose>
									</td>
									<td>
										<c:choose>
						      				<c:when test="${apply.status == 49}">待审核</c:when>
						      				<c:when test="${apply.status == 50}">审核通过</c:when>
						      				<c:when test="${apply.status == 51}">已驳回</c:when>
						      			</c:choose>
									</td>
									<td>
										<c:choose>
						      				<c:when test="${apply.storeAuditStatus == 49}">待审核</c:when>
						      				<c:when test="${apply.storeAuditStatus == 50}">审核通过</c:when>
						      				<c:when test="${apply.storeAuditStatus == 51}">已驳回</c:when>
						      			</c:choose>
									</td>
									<td class="t-operate">
										<div class="mod-operate">
											<div class="">
												<a href="../seller/auditP?appId=${apply.appId}">审核申请</a>
											</div>
										</div>
									</td>
								</tr>
							</c:forEach>
	      				</c:when>
	      				<c:when test="${fn:length(applysPage.result)==0}">
							<tr class="emptyGoods">
								<td colspan="10" rowspan="3">暂无符合条件的查询结果</td>
							</tr>
	      				</c:when>
	      			</c:choose>
					</tbody>
				</table>
			</div>
			<!-- table end -->
			<!-- paging -->
			<div class="paging">
				<!-- <div class="ctrlArea">
					<input type="checkbox" class="chk" name="allSelect" id="allSelect2" /><label
						for="allSelect2">全选</label> <input type="button" class="btnA"
						value="审核通过" /> <input type="button" class="btnA" value="驳回申请" />
				</div> -->
			 	<p:page page="${applysPage}" action="../seller/audit"/>
			</div>
			<!-- paging end -->
		</div>
		<!-- goodsList end -->
	</div>
	
	<script type="text/javascript">
		$(function(){
			$("#foldbar").on("click", function(event){
				if(!$(event.target).hasClass("btn-s")){
					if($(this).hasClass("open")){
						$("#condition").addClass("default");
						$(this).removeClass("open");
						$("#styleF").val("");
					}else{
						$("#condition").removeClass("default");
						$(this).addClass("open");
						$("#styleF").val("defalut");
					}
				}
			});
			
			<c:if test="${not empty pageInfo.conditions.styleF}">
				$("#foldbar").trigger("click");
			</c:if>
		});
	</script>
</body>
</html>