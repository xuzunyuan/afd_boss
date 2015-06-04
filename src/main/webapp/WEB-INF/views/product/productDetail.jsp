<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/common/common.jsp"%>
<%@page import="com.afd.constants.product.ProductConstants" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>卖家后台|商品管理详情页</title>
		<link rel="stylesheet" href="css/all-debug.css" />
	</head>
	<body id="">
			<!-- main -->
			<div class="main">
				<!-- foldbarV -->
				<div id="foldbarV">
					<div class="foldbarV">
						<div class="foldBtn"></div>
					</div>
				</div>
				<!-- foldbarV end -->
				<div class="goodsDetail">
					<form class="form formA">
						<div class="legend">
							<h3>商品基础信息</h3>
							<a href="${ctx }/product/productList" class="lnkA">返回商品列表页</a>
						</div>
						<fieldset id="attr">
							<dl class="item">
								<dt class="item-label">
									<label>商品类目：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${p.bcName }" /></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>商品标题：</label>
								</dt>
								<dd class="item-cont">
									<p>
										${p.title }
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>商品卖点：</label>
								</dt>
								<dd class="item-cont">
									<p>
										<c:out value="${p.subtitle }" />
									</p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>货号：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${p.artNo }" /></p>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>品牌：</label>
								</dt>
								<dd class="item-cont">
									<p><c:out value="${p.brandName }" /></p>
								</dd>
							</dl>
						</fieldset>
						<fieldset>
							<dl class="item item-attr">
								<dt class="item-label">
									<label>SKU销售属性：</label>
								</dt>
								<dd class="item-cont">
									<table class="table tableD">
									<colgroup>
									</colgroup>
											<col />
											<col />
											<col />
											<col />
											<col />
											<col />
										<thead>
											<tr id="specthead">
											</tr>
										</thead>
										<tbody id="specbody">
										</tbody>
									</table>
								</dd>
							</dl>
						</fieldset>
						<fieldset>
							<dl class="item item-img">
								<dt class="item-label">
									<label>商品图片：</label>
								</dt>
								<dd class="item-cont">
									<ul id="skuImg">
									</ul>
								</dd>
							</dl>
							<dl class="item">
								<dt class="item-label">
									<label>商品描述：</label>
								</dt>
								<dd class="item-cont">
									<div class="mod-frame">${p.detail }</div>
								</dd>
							</dl>
						</fieldset>
					<div class="formBtn">
						<c:choose>
							<c:when test="${p.auditStatus == '0' }">
								<button type="button" class="btnC" onclick="product.downProduct(${p.prodId})">抽样下架</button>
							</c:when>
							<c:when test="${p.auditStatus == '1' }">
								<button type="button" class="btnC" onclick="product.auditPass(${p.prodId})">审核通过</button>
								<input type="button" class="btn" onclick="product.downProduct(${p.prodId})" value="驳回申请" />
							</c:when>
						</c:choose>
					</div>
					</form>
			
					<!-- table -->
					<c:if test="${!empty p.lastAuditName}">
					<table class="table tableC">
						<colgroup>
							<col>
							<col>
							<col width="430">
						</colgroup>
						<thead>
							<tr>
								<th colspan="3" class="caption">商品修改历史</th>	
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>状态更新时间</th>
								<th>操作人</th>
								<th>操作说明</th>		
							</tr>
							<tr>
								<td><fmt:formatDate value="${p.lastAuditDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td>${p.lastAuditName }</td>
								<td>${p.auditContent }</td>
							</tr>
						</tbody>
					</table>
					</c:if>
					<!-- table end -->
				</div>
			</div>

<script type="text/javascript" src="../static/js/product.js?t=2014071601"></script>
<script type="text/javascript" src="../static/js/jquery.md.js?t=2014071601"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-foxibox-0.2_c.js?t=20140703" ></script>
<script type="text/javascript">
	$(function(){
		product = new product();
	
		var attrIds = '${p.attrValueId}';
		
		var attrs = '${p.attrValueName}';
		attrArray = attrs.split('|||');
		var html = '';
		$.each(attrArray,function(){
			attr = this.replace(/,,,/g, ', ');
			attr = attr.split(':::');
			var jq = $('<dl class="item"><dt class="item-label"><label>'+attr[0]+'：</label></dt><dd class="item-cont"><p>'+attr[1]+'</p></dd></dl>');
			jq.appendTo('#attr');
		});
		
		var skus = '${skus }';
		var spechead = '',specbody='<tr>',skuImg='',tmp_spec = "";;
 		<c:forEach items="${skus }" var="s" varStatus="var">
			skuSpec = '${s.skuSpecName}';
			skuSpecArr = skuSpec.split('|||');
			if('${var.count}' =='1'){
				for(var i = 0;i< skuSpecArr.length;i++){
					var specs = skuSpecArr[i].split(':::');
					spechead += "<td>"+specs[0] +"</td>";
				}
			}
			
			$.each(skuSpecArr,function(index){
				var specs = this.split(':::');
				specbody += "<td>"+specs[1] +"</td>";
				
				if(index == 0){
					var jq = $("<li>"+
							"<div class=\"mod-pic\">"+
							"<img src=\"${my:random(imgGetUrl)}${s.skuImgUrl}&op=s2_w86_h86\" alt=\"\" />"+
							"<div class=\"maskBar\"></div>"+
							"<p class=\"textBar\"><a id=\"look\" href=\"${my:random(imgGetUrl)}${s.skuImgUrl}\">查看大图</a></p>"+
						"</div>"+
						"<p>"+specs[0]+"："+specs[1]+"</p>"+
					"</li> ");
					
					if(tmp_spec != specs[1]){
						jq.appendTo('#skuImg');
						tmp_spec = specs[1];
					}
				}
			});
			
			specbody += "<td>&yen;"+${s.salePrice }+"</td><td>&yen;"+${s.marketPrice }+"</td><td>"+${s.stockBalance }+"</td><td>"+${s.sellerNo } +"</td></tr><tr>";
		</c:forEach>
		spechead +="<td>单价</td><td>特卖价</td><td>数量</td><td>商家编号</td>"
		$('#specthead').append(spechead);	
		$('#specbody').append(specbody);	
		
		$("a#look").foxibox();
	});
	
</script>
</body>
</html>
