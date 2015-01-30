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
	<title>商品审核详情-一网全城</title>
</head>
<body id="">
	<link rel="stylesheet" href="${ctx}/static/style/classes_.css?t=20140627" />
		<!-- foldbarV -->
		<div id="foldbarV"><div class="foldbarV"><div class="foldBtn"></div></div></div>
		<!-- foldbarV end -->
		<!-- crumbs -->
		<div class="crumbs crumbsA">
			<ul>
				<li><a href="#">后台首页</a><em>&gt;</em></li>
				<li><a href="#">卖家管理</a><em>&gt;</em></li>
				<li><strong>店铺资料</strong></li>
			</ul>
		</div>
		<!-- crumbs end -->
		<!-- sellerData -->
			<div class="sellerData goodsbaseData">
				<div class="hintBar">
					<dl>
						<dt><i class="icon i-exclaim"></i></dt>
						<dd>
							<h4>请注意：</h4>
							<ul>
								<li><em>·</em>请尽量在2个小时内审核完成，以保证卖家商品的及时上架；</li>
								<li><em>·</em>请在确认商品各项信息的完整无误后，完成审核。</li>
							</ul>
						</dd>
					</dl>
				</div>
				<!-- tab -->
				<div class="tab">
					<div class="tabs">
						<ul>
							<li class="on" tab="da"><a href="javascript:;">商品基本资料</a></li>
							<li tab="pi"><a href="javascript:;">商品图片</a></li>
						</ul>
					</div>
				</div>
				<!-- tab end -->
				<form class="form formA">
				  <div id="da">
					<fieldset>
						<dl class="item">
							<dt class="item-label"><label><em>*</em>商品标题：</label></dt>
							<dd class="item-cont">
								<p><c:out value="${product.title}" /></p>
							</dd>
						</dl>
						<dl class="item">
								<dt class="item-label"><label>商品广告语：</label></dt>
								<dd class="item-cont">
									<p><c:out value="${product.subtitle}" /></p>
								</dd>
						</dl>
						<c:if test="${product.marketPrice > 0}">
							<dl class="item">
									<dt class="item-label"><label><em>*</em>市场价：</label></dt>
									<dd class="item-cont">
										<p>￥${product.marketPrice}</p>
									</dd>
							</dl>
							<dl class="item">
									<dt class="item-label"><label><em>*</em>销售价：</label></dt>
									<dd class="item-cont">
										<p class="meg">￥${product.salePrice }</p>
									</dd>
							</dl>
						</c:if>
						<dl class="item">
								<dt class="item-label"><label><em>*</em>商品数量：<P/label></dt>
								<dd class="item-cont">
									<p><span class="meg"><c:out value="${product.stockBalance }" /></span>件</p>
								</dd>
						</dl>
						<dl class="item">
								<dt class="item-label"><label><em>*</em>基础类目：</label></dt>
								<dd class="item-cont">
									<p>${bcName }</p>
								</dd>
						</dl>
					</fieldset>
					<fieldset class="last">
						<dl class="item  item-attr">
								<dt class="item-label"><label>商品属性：</label></dt>
								<dd class="item-cont">
									<ul id="attrs">
										<li>
											品牌：<span>${product.brandName }</span>
										</li>
									</ul>
							</dd>
						</dl>
					 	<c:if test="${thList != null}"> 
							<dl class="item">
								<dt class="item-label">
									<label>多规格属性：</label>
								</dt>
								<dd class="item-cont">
									<table class="table tableD">
										<colgroup>
											<col >
											<col width="140">
											<col width="100">
											<col width="90">
											<col width="75">
										</colgroup>
										<thead>
											<tr>${thList}</tr>
										</thead>
										<tbody>
											<tr> ${tdList }</tr>
										</tbody>
									</table>
								</dd>
							</dl>
						</c:if> 
					</fieldset>
				  </div>
					
				   <div id="pi" style="display: none;">
					<fieldset class="fiel">
						<dl class="item item-img">
							<dt class="item-label">
								<label>商品图片：</label>
							</dt>
							<dd class="item-cont">
								<ul>
								<c:forEach items="${skuImgList }" var="sku">
									<li>
										<div class="mod-pic">
											<img src="${imgDownPrefix}${sku.skuId%6}${imgDownSuffix}${sku.skuImgUrl }&op=s1_w80_h80" alt="">
											<div class="maskBar"></div>
											<c:if test="${sku.skuImgUrl }">
											
											</c:if>
											<p class="textBar"><a id="look" title="" href="${imgDownPrefix}${sku.skuId%6}${imgDownSuffix}${sku.skuImgUrl }">查看大图</a></p>
										</div>
									</li>
								</c:forEach>
								</ul>
								<div class="coloExplain">
									<p>说明：此处图片为SKU展示图片</p>
									<ul>
										<li class="blue"></li>
										<li class="black"></li>
										<li class="ligBlue"></li>
										<li class="purple"></li>
										<li class="pink"></li>
										<li class="yellow"></li>
									</ul>
								</div>
							</dd>
						</dl>
					</fieldset>
					<fieldset class="last">
						<dl class="item item-img">
							<dt class="item-label">
								<label>商品图片：</label>
							</dt>
							<dd class="item-cont">
								<ul>
									<c:forEach items="${imgList }" var="img">
									<c:if test="${img.imgUrl !=null}">
										<li>
											<div class="mod-pic">
												<img src="${imgDownPrefix}${img.prodImgId%6}${imgDownSuffix}${img.imgUrl }&op=s1_w88_h88" alt="">
												<div class="maskBar"></div>
												<p class="textBar"><a id="look" title="" href="${imgDownPrefix}${img.prodImgId%6}${imgDownSuffix}${img.imgUrl }">查看大图</a></p>
											</div>
										</li>
									</c:if>
									</c:forEach>
								</ul>
							</dd>
						</dl>
						<dl class="item">
							<dt class="item-label">
								<label><em>*</em>商品描述：</label>
							</dt>
							<dd class="item-cont">
								<div class="mod-frame">
									${product.detail }
								</div>
							</dd>
						</dl>
					</fieldset>
				  </div>
				</form>
				<div class="formBtn">
						<button type="button" class="btnC">审核通过</button>
						<input type="button" class="btn" value="驳回申请" />
				</div>
				<c:if test="${!empty product.auditComment}">
					<table class="table tableC">
						<colgroup>
							<col>
							<col>
							<col>
							<col width="430">
						</colgroup>
						<thead>
							<tr>
								<th colspan="4" class="caption">审核历史</th>	
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>审核时间</th>
								<th>审核状态</th>
								<th>审核人</th>
								<th>审核结果</th>		
							</tr>
							<tr>
								<td><fmt:formatDate value="${product.lastAuditDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td><c:choose>
									<c:when test="${product.auditStatus=='2'}">
										审核驳回
									</c:when>
									<c:when test="${product.auditStatus=='3'}">
										审核中
									</c:when>
									<c:when test="${product.auditStatus=='4'}">
										待审核									
									</c:when></c:choose></td>
								<td>${product.lastAuditName }</td> 
								<td><c:out value="${product.auditComment }" /> </td>								
							</tr>
						</tbody>
					</table>	
				</c:if>			
			</div>
<script type="text/javascript" src="${ctx}/static/js/jquery-foxibox-0.2_c.js?t=20140703" ></script>
<script type="text/javascript" src="../static/js/jquery.md.js?t=2014061701"></script>
<script type="text/javascript">
$(function(){
	var attrValues ='${product.attrValueName}';
	var attrArr = attrValues.split('|||');
 	$.each(attrArr, function() {
		var attr = this.replace(':::',' ：');
		if(attr.indexOf(',,,') > 0){
			var boxAttr = attr.replace(new RegExp(/(,,,)/g),'，');
			$("#attrs").append('<li>'+boxAttr+'</li>');
		}else{
			$("#attrs").append('<li>'+attr+'</li>');
		}
	}); 	
 	
 	$(document).on("click","div.tabs ul li a",function(){
 		$("div.tabs ul li").removeClass("on");
 		$(this).parent().addClass("on");
 		var tab = $(this).parent().attr("tab");
 		var tab2 = $(this).parent().siblings().attr("tab");
 		$("#"+tab+"").show();
 		$("#"+tab2+"").hide();
 		
 	});	
 	
 	
  	$(document).on("click","button.btnC",function(event){
 		 var msg = '<p><span>•</span>确认审核通过吗？</p>';
		 $.modaldialog(msg,{
			title : '确认审核通过吗？',
			buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:auditPass},{text : '取&nbsp;&nbsp;消',classes : 'btn-s'}]
		}); 
		event.preventDefault();
 	});	
 	
 	$(document).on("click","input.btn",function(event){
 		/* 	var msg = '<p><span>•</span>确认驳回审核吗？</p>'; */
 		var msg = '<dl><dt><label>驳回理由：</label></dt><dd><textarea name="auditComment" id="auditComment" rows="5"></textarea></dd></dl>';
	
		$.modaldialog(msg,{
			title : '驳回申请',
			buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:auditReject},{text : '取&nbsp;&nbsp;消',classes : 'btn-s'}]
			});
		event.preventDefault();
 	});	 


 	$("a#look").foxibox();

});


function auditPass() {
	var prodId = '${product.prodId}';
	$.post("${ctx}/goods/doAudit/1?prodId="+prodId,function(data){
		if(data == "1") {
			$.modaldialog('<h2><i class="icon i-duigou"></i>审核通过</h2>',{
				buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',
							click:function(){
								window.location.href = '../goods/goodsauditList';
							}
						  }]
			});
		}else{
			$.modaldialog('<h2><i class="icon i-warns"></i>操作失败！</h2>');
		}
	}); 
}


function auditReject(){
	var prodId = '${product.prodId}';
	var auditComment = $("#auditComment").val(); 
	
	if($.trim(auditComment).length == 0 ){
		$.modaldialog('<h2><i class="icon i-warns"></i>审核内容不能为空！</h2>');		
		return;
	}
	if(strlen(auditComment) > 300 ){
		$.modaldialog('<h2><i class="icon i-warns"></i>审核内容不能超过150字！</h2>');	
		return;
	}
	
	$.ajax({
		type : "POST",
		async : false,
		cache : false,
		url : "${ctx}/goods/doAudit/2",
		data : "prodId="+prodId+"&auditComment="+auditComment,
		success : function(data) {
			if(data == "1") {
				$.modaldialog('<h2><i class="icon i-duigou"></i>商品上架申请已驳回 </h2>',{
					buttons : [{text:'确&nbsp;&nbsp;定', classes:'btnB btn-s', 
								click:function() {
									window.location.href = '../goods/goodsauditList';
								}
							  }]
					});
			}else{
				$.modaldialog('<h2><i class="icon i-warns"></i>操作失败！</h2>');
			}
		}
	});
}

function strlen(str){
    var len = 0;
    for (var i=0; i<str.length; i++) { 
     var c = str.charCodeAt(i); 
    //单字节加1 
     if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) { 
       len++; 
     } 
     else { 
      len+=2; 
     } 
    } 
    return len;
}


</script>
</body>
</html>
