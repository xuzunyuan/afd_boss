<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<title>品牌维护-一网全城</title>
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
		<!-- crumbs -->
		<div class="crumbs">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="${ctx}/brand/list?m=33">品牌管理</a><em>&gt;</em></li>
				<li><strong>品牌列表</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- orderSearch -->
		<div class="orderSearch">
			<!-- screening -->
			<div class="screening">
				<form method="post" action="${ctx}/brand/list" class="form">
					<fieldset id="condition" class="default">
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
							<li class="item">
								<div class="item-label">
									<label>品牌状态：</label>
								</div>
								<div class="item-cont">
									<div class="select">
										<select name="brandStatus" id="brandStatus">
											<option value="">全部</option>
											<option value="1" ${pageInfo.conditions.brandStatus == '1' ? 'selected="selected"' : ''}>生效</option>
											<option value="0" ${pageInfo.conditions.brandStatus == '0' ? 'selected="selected"' : ''}>删除</option>
										</select>
									</div>
								</div>
							</li>
							<li class="item">
								<div class="item-label">
									<label>基础类目：</label>
								</div>
								<div class="item-cont">
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
							<input type="hidden" name="styleF" id="styleF" value="${pageInfo.conditions.styleF}"/>
							<input type="submit" class="btn btn-s" value="查&nbsp;&nbsp;询" name="query" id="query" />
						</div>
					</div>
					<!-- foldbarH end -->
				</form>
			</div>
			<!-- screening end -->
			<!-- actionBar -->
			<div class="actionBar">
				<input type="button" class="btnA" value="添加品牌" onclick="window.location.href='${ctx}/brand/add?m=32'">
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
						<col width="" />
						<col width="200" />
						<col width="120" />
						<col width="80" />
						<col width="90" />
						<col width="100" />
					</colgroup>
					<thead>
						<tr>
							<th>序号</th>
							<th>中文名称</th>
							<th>英文名称</th>
							<th>拼音码</th>
							<th>基础类目</th>
							<th>品牌创建时间</th>
							<th>品牌状态</th>
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
										<td class="align-l"><c:out value="${brand.bcName}"/></td>
										<td><fmt:formatDate value="${brand.createDate}" pattern="yyyy-MM-dd HH:mm:ss" type="both"/></td>
										<td>${brand.brandStatus=='1'?'生效':'删除'}</td>
										<td><c:out value="${brand.createName}"/></td>
										<td class="t-operate">
											<div class="mod-operate" id="${brand.brandId}">
												<div class="def">
													<a href="${ctx}/brand/mod?bId=${brand.brandId}">品牌管理</a><i class="arr"></i>
												</div>
												<ul>
													<li><a href="${ctx}/brand/modCate?bId=${brand.brandId}">类目管理</a></li>
													<c:if test="${brand.brandStatus=='1'}">
													<li><a name="del" href="javascript:void(0);">删除品牌</a></li>
													</c:if>
												</ul>
											</div>
										</td>
									</tr>
								</c:forEach>
							</c:when>
		      				<c:when test="${fn:length(brands.result)==0}">
								<tr class="emptyGoods">
									<td colspan="9" rowspan="3">暂无符合条件的查询结果</td>
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
			
			$("#foldbar").on("click", function(event) {
				if (!$(event.target).hasClass("btn-s")) {
					if ($(this).hasClass("open")) {
						$("#condition").addClass("default");
						$(this).removeClass("open");
						$("#styleF").val("");
					} else {
						$("#condition").removeClass("default");
						$(this).addClass("open");
						$("#styleF").val("defalut");
					}
				}
			});

			fetchSubCategory("#fc", 0);
			$('#fc').change(function(){
				fetchSubCategory("#sc", this.value);
			});	
			$('#sc').change(function(){
				fetchSubCategory("#tc", this.value);
			});
			
			<c:if test="${not empty pageInfo.conditions.fc}">
				$("#fc").val("${pageInfo.conditions.fc}").trigger("change");
			</c:if>
		
			<c:if test="${not empty pageInfo.conditions.sc}">
				$("#sc").val("${pageInfo.conditions.sc}").trigger("change");
			</c:if>
		
			<c:if test="${not empty pageInfo.conditions.bcId}">
				$('#tc').val("${pageInfo.conditions.bcId}");
			</c:if>
			
			<c:if test="${not empty pageInfo.conditions.styleF}">
				$("#foldbar").trigger("click");
			</c:if>
			
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
		
		function fetchSubCategory(elemId, pId) {
			if(pId === ""){
				if(elemId == "#sc"){
					$('#tc,#sc').empty().append('<option value="">全部</option>');
				}
			}else if(pId >= 0){
				$.ajax({
					url : "${ctx}/category/noAuth/bc/pList",
					type : "POST",
					data : {pId : pId},
					async: false,
					success : function(list) {
						if(list != null && list.length>0){
							appendOption(elemId, list);
						}
					}
				});
			}
		}
		
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
						$.modaldialog('<p>该品牌已经关联商品，不能被删除！</p>',{
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
		
		function appendOption(elemId, objList) {
			var sel$ = $(elemId);
			sel$.empty();
			
			if("#sc" === elemId){
				$("#tc").empty().append('<option value="">全部</option>');
			}
			
			sel$.append('<option value="">全部</option>');
			$.each(objList, function() {
				sel$.append('<option value="' +  this.bcId + '">' + this.bcName + '</option>');
			});
		}
	</script>
</body>
</html>