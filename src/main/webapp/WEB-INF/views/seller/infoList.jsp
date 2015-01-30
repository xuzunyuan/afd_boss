<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>卖家信息管理-一网全城</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="../static/js/page.js?t=2014061701"></script>
	<script type="text/javascript" src="../static/js/jquery.md.js?t=2014061701"></script>

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
		<div class="crumbs">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="#">卖家管理</a><em>&gt;</em></li>
				<li><strong>卖家信息管理</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- goodsList -->
		<div class="sellerMessageList">
			<!-- screening -->
			<div class="screening">
				<input type="hidden" id="loginId" name="loginName"/>
				<form class="form" method="post" action="${ctx}/seller/info">
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
									<label>注册时间：</label>
								</div>
								<div class="item-cont">
									<input type="text" value="${pageInfo.conditions.startDt}" class="dateTxt" onfocus="WdatePicker()" name="startDt" id="startDt"><span>至</span><input type="text" value="${pageInfo.conditions.endDt}" class="dateTxt" onfocus="WdatePicker()" name="endDt" id="endDt">
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>账号状态：</label>
								</div>
								<div class="item-cont">
									<div class="select">
										<select name="status" id="status">
						           			<option value="">全部</option>
						           			<option value="0" ${pageInfo.conditions.status == '0' ? 'selected="selected"' : ''}>初始</option>
						           			<option value="1" ${pageInfo.conditions.status == '1' ? 'selected="selected"' : ''}>正常</option>
						           			<option value="2" ${pageInfo.conditions.status == '2' ? 'selected="selected"' : ''}>冻结</option>
						           		</select>	
									</div>
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>验证手机号：</label>
								</div>
								<div class="item-cont">
									<input value="<c:out value="${pageInfo.conditions.mobile}"/>" name="mobile" id="mobile" type="text" class="txt textA">
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>卖家名称：</label>
								</div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${pageInfo.conditions.realName}"/>" name="realName" id="realName" class="txt textC" >
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
							<li class="item">
								<div class="item-label">
									<label>资料审核状态：</label>
								</div>
								<div class="item-cont">
									<div class="select">
										<select name="baseStatus" id="baseStatus">
											<option value="" >全部</option>
						        			<option value="1" ${pageInfo.conditions.baseStatus == '1' ? 'selected="selected"' : ''}>待审核</option>
											<option value="2" ${pageInfo.conditions.baseStatus == '2' ? 'selected="selected"' : ''}>审核通过</option>
											<option value="3" ${pageInfo.conditions.baseStatus == '3' ? 'selected="selected"' : ''}>已驳回</option>
						      			</select>
									</div>
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>店铺审核状态：</label>
								</div>
								<div class="item-cont">
									<div class="select">
										<select name="storeAuditStatus" id="storeAuditStatus">
											<option value="" >全部</option>
						        			<option value="1" ${pageInfo.conditions.storeAuditStatus == '1' ? 'selected="selected"' : ''}>待审核</option>
											<option value="2" ${pageInfo.conditions.storeAuditStatus == '2' ? 'selected="selected"' : ''}>审核通过</option>
											<option value="3" ${pageInfo.conditions.storeAuditStatus == '3' ? 'selected="selected"' : ''}>已驳回</option>
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
					value="禁用账号" /> <input type="button" class="btnA" value="启用账号" />
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
						<col width="100" />
						<col width="80" />
						<col width="100" />
						<col width="130" />
						<col width="80" />
						<col />
						<col />
						<col />
						<col width="50" />
						<col width="130">
					</colgroup>
					<thead>
						<tr>
							<!-- <th></th> -->
							<th>序号</th>
							<!-- <th>卖家编码</th> -->
							<th>卖家账号</th>
							<th>卖家昵称</th>
							<th>验证手机号</th>
							<th>注册时间</th>
							<th>账号状态</th>
							<th>卖家名称</th>
							<th>店铺名称</th>
							<th>店铺类型</th>
							<th>店铺状态</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					<c:choose>
	      				<c:when test="${fn:length(pageLoginList.result)>0}">
	      					<c:forEach items="${pageLoginList.result}" var="login" varStatus="status"> 
							<tr>
								<!-- <td class="chkbox"><input type="checkbox" class="chk" name="" id="" value="" /></td> -->
								<td>${pageLoginList.beginRow+status.count}</td>
								<!-- <th>238096</th> -->
								<td><c:out value="${login.loginName}"/></td>
								<td><c:out value="${login.nickname}"/></td>
								<td><c:out value="${login.mobile}"/></td>
								<td><fmt:formatDate value="${login.regDate}" pattern="yyyy-MM-dd HH:mm" type="both"/></td>
								<td>
									<c:choose>
					      				<c:when test="${login.status == 48}">初始</c:when>
					      				<c:when test="${login.status == 49}">正常</c:when>
					      				<c:when test="${login.status == 50}">冻结</c:when>
					      			</c:choose> 
								</td>
								<td class="align-l">
									<c:choose>
					      				<c:when test="${not empty login.applyType and login.applyType == 99}">
					      					<c:out value="${login.realName}"/>
					      				</c:when>
					      				<c:when test="${not empty login.applyType and login.applyType == 98}">
					      					<c:out value="${login.coName}"/>
					      				</c:when>
					      			</c:choose>
								</td>
								<td class="align-l"><c:out value="${login.storeName}"/></td>
								<td>
									<c:choose>
					      				<c:when test="${not empty login.applyType and login.applyType == 99}">
					      					个人店铺
					      				</c:when>
					      				<c:when test="${not empty login.applyType and login.applyType == 98}">
					      					企业店铺
					      				</c:when>
					      			</c:choose>
								</td>
								<td>
									<c:choose>
					      				<c:when test="${empty login.storeStatus}">待开通</c:when>
					      				<c:when test="${login.storeStatus == 49}">已开通</c:when>
					      				<c:when test="${login.storeStatus == 50}">已关闭</c:when>
					      			</c:choose>
								</td>
								<td class="t-operate">
									<p>
										<a href="javascript:void(0);" onclick="resetPwd(${login.sellerLoginId});">密码重置</a> | <a href="specification?loginId=${login.sellerLoginId}">查看详细</a>
									</p>
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
						value="禁用账号" /> <input type="button" class="btnA" value="启用账号" />
				</div> -->
				<p:page page="${pageLoginList}" action="../seller/info"/>
			</div>
			<!-- paging end -->
		</div>
		<!-- goodsList end -->
	</div>
	<!-- main end -->
	
	 
	
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
						$("#styleF").val("defalut");
						$(this).addClass("open");
					}
				}
			});
			
			<c:if test="${not empty pageInfo.conditions.styleF}">
				$("#foldbar").trigger("click");
			</c:if>
		});
		
		function resetPwdOp() {
			var loginId = $("#loginId").val();
			 
			$.ajax({
				url : "resetPassword",
				type : "POST",
				data : {loginId : loginId},
				success : function(data) {
					$("#loginId").val("");
					if(data) {
						$.modaldialog('<h2><i class="icon i-duigou"></i>密码重置成功！</h2>');
					}  else {
						$.modaldialog('<h2><i class="icon i-duigou"></i>密码重置失败！</h2>');
					}
				},
				error : function() {
					$("#loginId").val("");
					$.modaldialog('<h2><i class="icon i-duigou"></i>密码重置失败！</h2>');
				}
			});
		}
		function resetPwd(loginId) {
			$.modaldialog('<p>系统将重置该卖家的登录密码为：123456，确认重置吗？</p>',{
					title : '密码重置!',
					buttons : [{text : '确&nbsp;&nbsp;定',click:resetPwdOp},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
			});
			
			$("#loginId").val(loginId);
		}
	</script>
	
</body>
</html>