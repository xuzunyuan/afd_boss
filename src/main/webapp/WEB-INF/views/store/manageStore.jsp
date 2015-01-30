<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<html>
	<head>
		<title>店铺管理-一网全城</title>
	</head>
	<body>
		<script type="text/javascript" src="../static/js/jquery.md.js?t=20140704"></script>
		<script language="javascript" type="text/javascript" src="${ctx}/static/js/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			$(function(){
				init();
				$(document).on("click","#foldBtn",function(){
					var hasOpen = $("#foldbarH").hasClass("open");
					if(hasOpen){
						$("#foldbarH").removeClass("open");
						$("fieldset").addClass("default");
					}else{
						$("#foldbarH").addClass("open");
						$("fieldset").removeClass("default");
					}
				});
				$(document).on("click","a[name=freeze]",function(){
					var storeId = $(this).attr("storeId");
					$.post(
						"${ctx}/store/isHaveUnfinishOrder",
						{storeId:storeId},
						function(res){
							if(res) {
								var msg = "<p><i class='icon i-warns'></i>该店铺有未完成的订单，请先关闭订单，" + 
											"</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;并再次操作冻结店铺！</p>";
								$.modaldialog(msg,{
									title : '提醒',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){}}]
								});
							} else {
								var msg = "<dl>" + 
											"	<dt>" + 
											"		<label><em>*</em>店铺冻结原因：</label>" + 
											"	</dt>" + 
											"	<dd>" + 
											"		<textarea id='freezeReason' rows='5' maxlength='60'></textarea>" +
											"		<div id='errInfo' class='hint error'></div>" +
											"		<div class='hint popHint'>" + 
											"			最多60字" + 
											"		</div>" +
											"	</dd>" + 
											"</dl>";
								$.modaldialog(msg,{
									title : '冻结理由',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
													var freezeReason = $("#freezeReason").val();
													if(freezeReason.length > 60) {
														$("#errInfo").text("*最多输入60个字，请删除超出的内容！");
														return true;
													}
													if(!freezeReason || $.trim(freezeReason).length == 0) {
														$("#errInfo").text("*请输入冻结理由！");
														return true;
													}
													var msg = "<h2><i class='icon i-warns'></i>" + 
															"确认冻结店铺吗？</h2>" + 
															"<p>冻结店铺后，店铺将关闭，该卖家账号无法正常登录，且店铺中的在售商品也将全部暂停销售！</p>";
													$.modaldialog(msg,{
														title : '提醒',
														buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
																	freezeStore(storeId, freezeReason);
																}},
														           {text:'取&nbsp;&nbsp;消',classes:'btn btn-s',click:function(){}}
														]
													});
											}},
									           {text:'取&nbsp;&nbsp;消',classes:'btn btn-s',click:function(){}}
										]
								});
							}
							
						}
					);
					
				});
				$(document).on("click","a[name=unfreeze]",function(){
					var storeId = $(this).attr("storeId");
					$.post(
						"${ctx}/store/unFreezeStore",
						{storeId:storeId},
						function(res) {
							if(res == 1) {
								var msg = "<h2><i class='icon i-duigou'></i>店铺已恢复正常，请联系卖家登录后上架商品！</h2>";
								$.modaldialog(msg,{
									title : '操作成功',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:reload}]
								});
							} else {
								var msg = "<h2><i class='icon i-errors'></i>店铺解冻失败，请重新尝试，或联系产品部门处理！</h2>";
								$.modaldialog(msg,{
									title : '操作失败',
									buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){}}]
								});
							}
						}
					);
				});
				$(document).on("submit","#query",function(){
					var storeName = $("input[name='storeName']").val();
					if(!!storeName){
						$("input[name='storeName']").val($.trim(storeName));
					}
					var loginName = $("input[name='loginName']").val();
					if(!!loginName){
						$("input[name='loginName']").val($.trim(loginName));
					}
					var realName = $("input[name='realName']").val();
					if(!!realName){
						$("input[name='realName']").val($.trim(realName));
					}
				});
			});
			function init() {
				var storeName = "${storeCondition.storeName}";
				var status = "${storeCondition.status}";
				var createDateStart = "${storeCondition.createDateStart}";
				var createDateEnd = "${storeCondition.createDateEnd}";
				var loginName = "${storeCondition.loginName}";
				var realName = "${storeCondition.realName}";
				if(!!storeName || !!status || !!createDateStart || !!createDateEnd || !!loginName || !!realName) {
					$("fieldset").removeClass("default");
					$("#foldbarH").addClass("open");
				}
			}
			function freezeStore(storeId, freezeReason) {
				$.post(
					"${ctx}/store/freezeStore",
					{storeId:storeId,freezeReason:freezeReason},
					function(res){
						if(res == 1) {
							var msg = "<h2><i class='icon i-duigou'></i>店铺已被冻结！</h2>";
							$.modaldialog(msg,{
								title : '操作成功',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:reload}]
							});
						} else {
							var msg = "<h2><i class='icon i-errors'></i>冻结操作失败，请重新尝试！</h2>";
							$.modaldialog(msg,{
								title : '操作失败',
								buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){}}]
							});
						}
					}
				);
			}
			function reload() {
				if("${operate}" == "1") {
					$("form#query").submit();
				} else {
					$("form#query").submit();
				}
			}
		</script>
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- crumbs -->
		<div class="crumbs">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="#">店铺管理</a><em>&gt;</em></li>
				<c:if test="${operate == '0'}">
					<li><strong>店铺查询列表</strong></li>
				</c:if>
				<c:if test="${operate == '1'}">
					<li><strong>店铺维护列表</strong></li>
				</c:if>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- goodsList -->
		<div class="sellerMessageList">
			<!-- screening -->
			<div class="screening">
				<form class="form" id="query" method="post" action="${operate=='1' ? fn:replace('CTX/store/manageStore','CTX',ctx) : fn:replace('CTX/store/queryStore','CTX',ctx)}">
					<fieldset class="default">
						<legend><h3>查询条件</h3></legend>
						<ul class="formBox">
							<li class="item">
								<div class="item-label"><label>店铺名称：</label></div>
								<div class="item-cont">
									<input type="text" name="storeName" value="${storeCondition.storeName}" class="txt textA">
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>状态：</label></div>
								<div class="item-cont">
									<div class="select">
										<select name="status">
										    <option value="">全部</option>
										    <option value="1" <c:if test="${storeCondition.status == 49}">selected="selected"</c:if>>正常</option>
										    <option value="2" <c:if test="${storeCondition.status == 50}">selected="selected"</c:if>>冻结</option>
										    <option value="0" <c:if test="${storeCondition.status == 48}">selected="selected"</c:if>>未开通</option>
										</select>
									</div>
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>开店时间：</label></div>
								<div class="item-cont">
									<input type="text" readonly="readonly" value="<fmt:formatDate value="${storeCondition.createDateStart}" pattern="yyyy-MM-dd" />" name="createDateStart" class="dateTxt" onClick="WdatePicker()" />
									<span>至</span>
									<input type="text" readonly="readonly" value="<fmt:formatDate value="${storeCondition.createDateEnd}" pattern="yyyy-MM-dd" />" name="createDateEnd" class="dateTxt" onClick="WdatePicker()" />
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>卖家账号：</label></div>
								<div class="item-cont">
									<input type="text" name="loginName" value="${storeCondition.loginName}" class="txt textA">
								</div>
							</li>
							<li class="item">
								<div class="item-label"><label>卖家名称：</label></div>
								<div class="item-cont">
									<input type="text" name="realName" value="${storeCondition.realName}" class="txt textA">
								</div>
							</li>
						</ul>
					</fieldset>
					<!-- foldbarH -->
					<div id="foldbarH" class="foldbarH"><!-- 展开后添加class命open -->
						<div id="foldBtn" class="foldBtn"><i class="ico"></i></div>
						<div class="searchBtn"><input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询"></div>
					</div>
					<!-- foldbarH end -->
				</form>
			</div>
			<!-- screening end -->
			<!-- table -->
			<div class="tableWrap">
				<table class="table tableA">
					<colgroup>
						<col width="40" />
						<col width="100" />
						<col width=""/>
						<col width="80" />
						<col width="60" />
						<col width="140" />
						<col width="130" />
						<col width="150" />
						<col width="110">
					</colgroup>
					<thead>
						<tr>
							<th>序号</th>
							<th>店铺ID</th>
							<th>店铺名称</th>
							<th>店铺类型</th>
							<th>状态</th>
							<th>开店时间</th>
							<th>卖家账号</th>
							<th>卖家名称</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${fn:length(page.result) > 0 }">
								<c:forEach items="${page.result}" var="store" varStatus="var">
									<tr>
										<td>${var.count }</td>
										<th><c:out value="${store.storeId }"></c:out></th>
										<td class="align-l"><a target="_blank" href="http://shop.yiwang.com/${store.storeId}/"><c:out value="${store.storeName }"></c:out></a></td>
										<td><c:out value="${store.typeStr}" /></td>
										<td><c:out value="${store.statusStr}" /></td>
										<td><p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${store.createDate}"/></p></td>
										<td><c:out value="${store.loginName}" /></td>
										<td><c:out value="${store.realName}" /></td>
										<td class="t-operate">
											<c:if test="${operate == '0'}">
												<div>
													<p><a href="${ctx}/store/storeInfo?storeId=${store.storeId}&operate=${operate}">店铺详情</a></p>
												</div>
											</c:if>
											<c:if test="${operate == '1'}">
												<div class="mod-operate">
													<div class="def"><a href="${ctx}/store/storeInfo?storeId=${store.storeId}&operate=${operate}">店铺详情</a><i class="arr"></i></div>
													<ul>
														<c:if test="${store.status == 49 }">
															<li><a name="freeze" storeId="${store.storeId}">冻结店铺</a></li>
														</c:if>
														<c:if test="${store.status == 50 }">
															<li><a name="unfreeze" storeId="${store.storeId}">解冻店铺</a></li>
														</c:if>
													</ul>
												</div>
											</c:if>
										</td>
									</tr>
								</c:forEach>
								
							</c:when>
							<c:otherwise>
								<tr class="emptyGoods">
									<td rowspan="3" colspan="9">暂无符合条件的查询结果</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<!-- table end -->
			<!-- paging -->
			<c:if test="${fn:length(page.result) > 0}">
				<pgNew:page name="query" page="${page}" formId="query"></pgNew:page>
			</c:if>
			<!-- paging end -->
		</div>
		<!-- goodsList end -->
	</body>
</html>