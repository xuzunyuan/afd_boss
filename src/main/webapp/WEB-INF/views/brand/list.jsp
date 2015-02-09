<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>品牌维护-afd</title>
</head>
<body>
	<script type="text/javascript" src="../static/js/datePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="../static/js/page.js?t=2014071601"></script>
	<script type="text/javascript" src="../static/js/jquery.md.js?t=2014071601"></script>

	<!-- main -->
	<div class="main">
		<!-- foldbarV -->
		<div id="foldbarV">
			<div class="foldbarV">
				<div class="foldBtn"></div>
			</div>
		</div>
		<!-- foldbarV end -->
		<!-- orderSearch -->
		<div class="orderSearch">
			<!-- screening -->
			<div class="screening">
				<form method="post" action="${ctx}/brand/list" class="form">
					<fieldset id="condition" class="">
						<legend>
							<h3>查询条件</h3>
						</legend>
						<ul class="formBox">
							<li class="item">
								<div class="item-label">
									<label>中文名称：</label>
								</div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${pageInfo.conditions.brandName}"/>" name="brandName" id="brandName" class="txt textA" />
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>英文名称：</label>
								</div>
								<div class="item-cont">
									<input type="text" value="<c:out value="${pageInfo.conditions.brandEname}"/>" name="brandEname" id="brandEname" class="txt textA" />
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>创建时间：</label>
								</div>
								<div class="item-cont">
									<input type="text" value="${pageInfo.conditions.startDt}" class="dateTxt" onfocus="WdatePicker()" name="startDt" id="startDt" /><span>至</span><input type="text" class="dateTxt" value="${pageInfo.conditions.endDt}" class="dateTxt" onfocus="WdatePicker()" name="endDt" id="endDt"/>
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
							<input type="hidden" name="createDate" value="DESC" />
							<input type="hidden" name="status" value="1" />
							<input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" name="query" id="query" />
						</div>
					</div>
					<!-- foldbarH end -->
				</form>
			</div>
			<!-- screening end -->
			<!-- actionBar -->
			<div class="actionBar">
				<input type="button" class="btnA" value="添加品牌" onclick="window.location.href='${ctx}/brand/add?m=74'">
				<!-- <div class="pagingMini">
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
				</div> -->
			</div>
			<!-- actionBar end -->
			<!-- table -->
			<div class="tableWrap">
				<table class="table tableA">
					<colgroup>
						<col width="40" />
						<col width="" />
						<col width="" />
						<col width="200" />
						<col width="170" />
						<col width="150" />
						<col width="100" />
					</colgroup>
					<thead>
						<tr>
							<th>序号</th>
							<th>中文名称</th>
							<th>英文名称</th>
							<th>拼音码</th>
							<th>品牌创建时间</th>
							<th>创建人</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
	      					<c:when test="${fn:length(brands.result)>0}">
	      						<c:forEach items="${brands.result}" var="brand" varStatus="status"> 
									<tr>
										<td>${brands.beginRow+status.count}</td>
										<th><c:out value="${brand.brandName}"/></th>
										<td><c:out value="${brand.brandEname}"/></td>
										<td><c:out value="${brand.pinyin}"/></td>
										<td><fmt:formatDate value="${brand.createDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></td>
										<td><c:out value="${brand.createByName}"/></td>
										<td class="t-operate">
											<div class="mod-operate" id="${brand.brandId}">
												<div class="def">
													<a href="${ctx}/brand/mod?bId=${brand.brandId}">修改品牌</a><i class="arr"></i>
												</div>
												<ul>
													<li><a name="del" href="javascript:void(0);">删除品牌</a></li>
												</ul>
											</div>
										</td>
									</tr>
								</c:forEach>
							</c:when>
		      				<c:when test="${fn:length(brands.result)==0}">
								<tr class="emptyGoods">
									<td colspan="7" rowspan="3">暂无符合条件的查询结果</td>
								</tr>
		      				</c:when>
		      			</c:choose>
					</tbody>
				</table>
			</div>
			<!-- table end -->
			<!-- paging -->
			<div class="paging">
				<div class="ctrlArea">
					<input type="button" class="btnA" value="添加品牌" onclick="window.location.href='${ctx}/brand/add?m=32'">
				</div>
				<p:page page="${brands}" action="${ctx}/brand/list"/>
			</div>
			<!-- paging end -->
		</div>
		<!-- orderSearch end -->
	</div>
	<!-- main end -->

	<script type="text/javascript">
		$(function() {
			
			$(".mod-operate").find("a").on("click", function(event) {
				var brandId = $(this).parents(".mod-operate").attr("id");
				var op = this.name;
				
				if(op == "del"){
					$.modaldialog('<p>品牌删除后相关信息将不被保留，确定删除？</p>',{
						title : '品牌删除',
						buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:deleteBrand, param:{id:brandId}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
					});
				}
				 
			});
			
			<c:if test="${not empty addFlag}">
				$.modaldialog('<p>品牌已经添加成功！</p>',{
					title : '品牌添加成功',
					buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
				}); 
			</c:if>
			
			<c:if test="${not empty modFlag}">
				$.modaldialog('<p>品牌信息已经修改成功！</p>',{
					title : '品牌修改成功',
					buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
				}); 
			</c:if>
		});
		
		function deleteBrand(param) {
			$.ajax({
				url : "${ctx}/brand/del",
				type : "POST",
				data : {brandId : param.id},
				success : function(re) {
					if(re == 1){
						$.modaldialog('<p>品牌删除成功！</p>',{
							title : '品牌删除',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){window.location.href=window.location.href;}}]
						});
					}else if(re == -1){
						$.modaldialog('<p>该品牌已经被使用，不能删除！</p>',{
							title : '品牌不能被删除',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
						}); 
					}else if(re == 0){
						$.modaldialog('<p>品牌删除失败！</p>',{
							title : '品牌删除',
							buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}]
						});
					}
				}
			}); 
		}
	</script>
</body>
</html>