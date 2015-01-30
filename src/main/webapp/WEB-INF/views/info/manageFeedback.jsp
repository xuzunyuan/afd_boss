<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>意见反馈-一网全城</title>
	</head>
	<body>
		<link rel="stylesheet" href="${ctx}/static/style/classes_.css?t=20141008" />
		<script language="javascript" type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="../static/js/jquery.md.js?t=20140923"></script>
		<script type="text/javascript">
			$(function(){
				$("div.paging").append($("div.ctrlArea"));
				$('#collapse').click(function(){
					if($(this).attr('open')) {
						$('#fsQuery').removeClass('default');
						$('#fld').addClass('open');
						$(this).find('span').html('收起条件');
						$(this).attr('open', false);
					} else {
						$('#fsQuery').addClass('default');
						$('#fld').removeClass('open');
						$(this).find('span').html('更多条件');
						$(this).attr('open', true);
					}
				});
				$(document).on("click", "a[name=deleteFeedback]",function(){
					var feedbackId = $(this).attr('feedbackId');
					var msg = '<p><span>•</span>意见删除后相关信息将不被保留<br /><span>•</span>确认删除吗？</p>';
					$.modaldialog(msg,{
						title : '意见删除',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){deleteFeedback(feedbackId);}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
				});
				$(document).on("change","#allSelect",function(){
					var check = $(this).prop("checked");
					$("#allSelect2").prop("checked",check);
					$("input[name=fdCheck]").prop("checked",check);
				});
				$(document).on("change","#allSelect2",function(){
					var check = $(this).prop("checked");
					$("#allSelect").prop("checked",check);
					$("input[name=fdCheck]").prop("checked",check);
				});
				$(document).on("change","input[name=fdCheck]",function(){
					var allCheck = true;
					$("input[name=fdCheck]").each(function(){
						var check = $(this).prop("checked");
						if(!check){
							allCheck = false;
							return;
						}
					});
					$("#allSelect").prop("checked",allCheck);
					$("#allSelect2").prop("checked",allCheck);
				});
				$(document).on("click","input[name=mulDelete]",checkDelete);
				$(document).on("click","input[name=mulDelete2]",checkDelete);
			});
			function deleteFeedback(feedbackId){
				console.log(feedbackId);
				$.post(
					"${ctx}/info/deleteFeedback",
					{fdId:feedbackId},
					function(count){
						if(parseInt(count) > 0){
							var msg = "<p><span>•</span>意见已删除！</p>";
							$.modaldialog(msg,{
								title : '意见删除',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:reload}]
							});
						}else{
							var msg = "<p><span>•</span>意见删除失败！</p>";
							$.modaldialog(msg,{
								title : '意见删除',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:reload}]
							});
						}
					}
				);
			}
			function checkDelete(){
				var checkFdIds = [];
				$("input[name=fdCheck]:checked").each(function(){
					checkFdIds.push($(this).attr("fdId"));
				});
				if(checkFdIds.length == 0){
					var msg = "<p><span>•</span>请选择删除项！</p>";
					$.modaldialog(msg,{
						title : '意见删除',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
					});
					return;
				}else{
					var msg = '<p><span>•</span>意见删除后相关信息将不被保留<br /><span>•</span>确认删除吗？</p>';
					$.modaldialog(msg,{
						title : '意见删除',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:deleteFeedbacks},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
				}
			}
			function deleteFeedbacks(){
				var fdIds = [];
				$("input[name=fdCheck]:checked").each(function(){
					fdIds.push($(this).attr("fdId"));
				});
				$.post(
					"${ctx}/info/deleteFeedbacks",
					{fdIds:fdIds.join(",")},
					function(count){
						if(parseInt(count) > 0){
							var msg = "<p><span>•</span>意见已删除！</p>";
							$.modaldialog(msg,{
								title : '意见删除',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:reload}]
							});
						}else{
							var msg = "<p><span>•</span>意见删除失败！</p>";
							$.modaldialog(msg,{
								title : '意见删除',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:reload}]
							});
						}
					}
				);
			}
			function reload(){
				location.href = "${ctx}/info/manageFeedback"
			}
		</script>
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- crumbs -->
		<div class="crumbs">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="#">信息管理</a><em>&gt;</em></li>
				<li><strong>意见反馈</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- feedbackSearch -->
		<div class="ideaFeedback">
			<!-- screening -->
			<div class="screening">
				<form id="query" action="${ctx}/info/manageFeedback" method="post"  class="form">
					<fieldset id="fsQuery">
						<legend><h3>查询条件</h3></legend>
						<ul id="formBox" class="formBox">
							<li class="item">
								<div class="item-label"><label>反馈渠道：</label></div>
								<div class="item-cont">
									<div class="select">
										<select name="sourceFrom">
										    <option value="">全部</option>
										    <option <c:if test="${feedbackCondition.sourceFrom == '1'}">selected="selected"</c:if> value="1">买家web端</option>
										    <option <c:if test="${feedbackCondition.sourceFrom == '2'}">selected="selected"</c:if> value="2">Ios客户端</option>
										    <option <c:if test="${feedbackCondition.sourceFrom == '3'}">selected="selected"</c:if> value="3">Android客户端</option>
										    <option <c:if test="${feedbackCondition.sourceFrom == '4'}">selected="selected"</c:if> value="4">卖家</option>
										</select>
									</div>
								</div>
							</li>
<!-- 
							<li class="item">
								<div class="item-label"><label>页面来源： </label></div>
								<div class="item-cont">
									<div class="select">
										<select name="pageFrom">
										    <option value="">全部</option>
										    <option <c:if test="${feedbackCondition.pageFrom == '1'}">selected="selected"</c:if> value="1"}">买家首页</option>
										    <option <c:if test="${feedbackCondition.pageFrom == '2'}">selected="selected"</c:if> value="2"}">频道页</option>
										    <option <c:if test="${feedbackCondition.pageFrom == '3'}">selected="selected"</c:if> value="3"}">详情页</option>
										    <option <c:if test="${feedbackCondition.pageFrom == '4'}">selected="selected"</c:if> value="4"}">列表页</option>
										    <option <c:if test="${feedbackCondition.pageFrom == '5'}">selected="selected"</c:if> value="5"}">购物车</option>
										    <option <c:if test="${feedbackCondition.pageFrom == '6'}">selected="selected"</c:if> value="6"}">买家中心</option>
										    <option <c:if test="${feedbackCondition.pageFrom == '7'}">selected="selected"</c:if> value="7"}">卖家中心</option>
										    <option <c:if test="${feedbackCondition.pageFrom == '8'}">selected="selected"</c:if> value="8"}>客户端</option>
										</select>
									</div>
								</div>
							</li>
-->
							<li class="item">
								<div class="item-label"><label>反馈类型： </label></div>
								<div class="item-cont">
									<div class="select">
										<select name="fdType">
										    <option value="">全部</option>
										    <option <c:if test="${feedbackCondition.fdType == '0'}">selected="selected"</c:if> value="0">页面设计建议</option>
										    <option <c:if test="${feedbackCondition.fdType == '1'}">selected="selected"</c:if> value="1">商品建议</option>
										    <option <c:if test="${feedbackCondition.fdType == '2'}">selected="selected"</c:if> value="2">支付问题</option>
										    <option <c:if test="${feedbackCondition.fdType == '3'}">selected="selected"</c:if> value="3">物流配送建议</option>
										    <option <c:if test="${feedbackCondition.fdType == '4'}">selected="selected"</c:if> value="4">客服建议</option>
										    <option <c:if test="${feedbackCondition.fdType == '5'}">selected="selected"</c:if> value="5">活动建议</option>
										</select>
									</div>
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>是否注册会员： </label></div>
								<div class="item-cont">
									<div class="select">
										<select name="isYwUser">
										    <option value="">全部</option>
										    <option <c:if test="${feedbackCondition.isYwUser == '1'}">selected="selected"</c:if> value="1">是</option>
										    <option <c:if test="${feedbackCondition.isYwUser == '0'}">selected="selected"</c:if> value="0">否</option>
										</select>
									</div>
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>用户名：</label></div>
								<div class="item-cont">
									<input class="txt textA" type="text" name="userName" value="${feedbackCondition.userName}" />
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>反馈时间：</label></div>
								<div class="item-cont">
									<input type="text" readonly="readonly" value="<fmt:formatDate value="${feedbackCondition.fdDateStart}" pattern="yyyy-MM-dd" />" name="fdDateStart" class="dateTxt" onClick="WdatePicker()" />
			            			<span> 至 </span>
			            			<input type="text" readonly="readonly" value="<fmt:formatDate value="${feedbackCondition.fdDateEnd}" pattern="yyyy-MM-dd" />" name="fdDateEnd" class="dateTxt" onClick="WdatePicker()" />
								</div>
							</li>
						</ul>
					</fieldset>
					<!-- foldbarN -->
					<div class="foldbarN open" id="fld"><!-- 展开后添加class命open -->
						<div class="condition" id="collapse"><span>收起条件</span><i class="ico"></i></div>
						<div class="searchBtn" id="searchBtn"><input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" /></div>
					</div>
					<!-- foldbarN end -->
				</form>
			</div>
			<!-- screening end -->
			
			<!-- actionBar -->
			<c:if test="${fn:length(page.result) > 0}">
	 			<div class="actionBar">
					<input type="checkbox" class="chk" name="allSelect" id="allSelect" /><label for="allSelect">全选</label>
					<input type="button" class="btnA" name="mulDelete" value="删除" />
					<pgMini:page name="miniquery" page="${page}" formId="query"/>
				</div>
			</c:if>
			<!-- actionBar end -->
			<!-- table -->
			<div class="tableWrap">
				<table class="table tableA" style="z-index:-1;">
					<colgroup>
						<col width="20">
						<col width="40">
						<col width="110">
						<col width="100">
<!-- 					<col width="100"> -->		
						<col width="110">
						<col width="100">
						<col width="100">
						<col width="330">
						<col width="100">
					</colgroup>
					<thead>
						<tr>
							<th></th>
							<th>序号</th>
							<th>反馈时间</th>
							<th>反馈渠道</th>
<!-- 						<th>页面来源</th> -->
							<th>反馈类型</th>
							<th>是否注册会员</th>
							<th>用户名</th>
							<th>反馈信息</th>
							<th>详情</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${fn:length(page.result) > 0}">
								<c:forEach items="${page.result}" var="feedback" varStatus="var">
									<tr>
										<td class="chkbox"><input type="checkbox" fdId="${feedback.fdId}" class="chk" name="fdCheck" /></td>
										<td>${var.count}</td>
										<td><p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${feedback.fdDate}"/></p></td>
										<td><c:out value="${feedback.strSourceFrom }"/></td>
<!-- 									<td><c:out value="${feedback.strPageFrom }" /></td> -->
										<td><c:out value="${feedback.strFdType }" /></td>
										<td><c:out value="${feedback.strIsYwUser }" /></td>
										<td><c:out value="${feedback.userName }" /></td>
										<td class="align-l">
											<div class="fdcontent">
												<div class="content">
													<c:out value="${feedback.fdContent}"/>
												</div>
												<div class="more-content">
													<c:out value="${feedback.fdContent}"/>
												</div>
											</div>
										</td>
										<td><a name="deleteFeedback" feedbackId="${feedback.fdId}" href="javascript:;">删除</a></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr class="emptyFeedbacks">
									<td rowspan="3" colspan="12">暂无符合条件的查询结果</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<!-- table end -->
			<c:if test="${fn:length(page.result) > 0}">
				<div class="ctrlArea">
					<input type="checkbox" class="chk" name="allSelect2" id="allSelect2" />
					<label for="allSelect2">全选</label>
					<input type="button" class="btnA" name="mulDelete2" value="删除" />
				</div>
				<!-- paging -->
		 		<pgNew:page name="query" page="${page}" formId="query"/>
				<!-- paging end -->
			</c:if>
		</div>
		<!-- feedbackSearch end -->
	</body>
</html>