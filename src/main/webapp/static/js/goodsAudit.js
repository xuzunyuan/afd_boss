function goods() {
	this.searchMenu = function(){
		var hasOpen = $("#foldbarH").hasClass("open");
		if(hasOpen){
			$("fieldset").addClass("default");
			$("#foldbarH").removeClass("open");
		}else{
			$("#foldbarH").addClass("open");
			$("fieldset").removeClass("default");
		}
	};
	
	this.checkFromData = function(){
		ref = true;
 		fId = $("select[name=fc]").val();
/*		if(!!fId && fId > 0){
			var sId = $("#sc").val();
			if(!!!sId ||sId < 0){
				$.modaldialog('<h2><i class="icon i-warns"></i>请填写完整类目信息！</h2>');
				ref = false;
			}
			var tId = $("#tc").val();
			if(!!!tId ||tId < 0){
				$.modaldialog('<h2><i class="icon i-warns"></i>请填写完整类目信息！</h2>');
				ref = false;
			}
		} */
		
		var endDate =  $("input[name=endDate]").val();
		var startDate = $("input[name=startDate]").val();
		if(!!endDate && !!startDate){
			if(endDate < startDate){
				$.modaldialog('<h2><i class="icon i-warns"></i>结束时间不能大于起始时间！</h2>');
				ref = false;
			}
		}
		return ref;
	};
	
	this.fetchSubCategory = function(elemId, pId){
		if(pId === ""){
			var bcCode = null;
			if(elemId == "#sc"){
				$('#tc,#sc').empty().append('<option value="">全部</option>');
				 bcCode = $("#sc").children("option:selected").attr("bcCode");
			}else if(elemId =="#tc"){
				$('#tc').empty().append('<option value="">全部</option>');
				bcCode = $("#sc").children("option:selected").attr("bcCode");
			}
			$('input[name=bcCode]').val(bcCode);
		}else if(pId >= 0){
			$.ajax({
				url : "../category/noAuth/bc/pList",
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
	};
	
	this.batchUpdateStatus = function(status){
		var msg = null;
		if($("input[name=prodCheck]:checked").length <=0){
			alert("请勾选要操作的数据！");
			return;
		}
		if(status =="3"){
			msg = '<p><span>•</span>确认批量上架吗？</p>';
		}else if (status =="4"){
			msg = '<p><span>•</span>确认批量下架吗？</p>';
		}else if(status =="2"){
			msg = '<p><span>•</span>确认批量删除吗？</p>';
		}
		$.modaldialog(msg,{
			title : '批量操作确认',
			buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:prodReject,param:status},{text : '取&nbsp;&nbsp;消',classes : 'btn-s'}]
		});
	};
	
	this.updateStatus = function(prodId,status){
		var msg = null;
		if(status =="3"){
			msg = '<p><span>•</span>确认上架吗？</p>';
		}else if (status =="4"){
			msg = '<p><span>•</span>确认下架吗？</p>';
		}else if(status =="2"){
			msg = '<p><span>•</span>确认删除吗？</p>';
		}
		
		$.modaldialog(msg,{
			title : '操作确认',
			buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:updateProdStatus,param:{"prodId":prodId,"status":status}},{text : '取&nbsp;&nbsp;消',classes : 'btn-s'}]
		});
	};
	
	this.suggest = function(obj,type){
		var keyword = $(obj).val();
		if(keyword ==null){
			return;
		}
		
		keyword = type+":"+keyword ;
 		alert(keyword);
		$.ajax({
 			url : "../prod/suggest",
 			type : "POST",
 			data : {keyword : keyword},
 			async: false,
 			success : function(list) {
 				if(list != null && list.length>0){
 					alert(list);
 				}
 			}
 		});
		
	};
	
};

function prodReject(status){
	var ids = "";
	$("input[name=prodCheck]:checked").each(function(){
		var pId = $(this).attr("pId");
		 ids += pId + ",";
	});
	
	$.post('../prod/batchUpdateStatus',{ids:ids,status:status},function(data){
		if(data.success == "1") {
			$.modaldialog('<h2><i class="icon i-duigou"></i>操作成功</h2>',{
				buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
					window.location.href = '../prod/showProd';
					}}]
			});
		}else{
			$.modaldialog('<h2><i class="icon i-duigou"></i>操作失败！</h2>');
		}
		$("#queryProd").submit();
	});
}

function updateProdStatus(param){
	$.post("../prod/updateProdStatus",{prodId:param.prodId,status:param.status},function(data){
		if(data.success == "1") {
				$.modaldialog('<h2><i class="icon i-duigou"></i>操作成功</h2>',{
					buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){
						window.location.href = '../prod/showProd';
						}}]
				});
			}else{
				$.modaldialog('<h2><i class="icon i-duigou"></i>操作失败！</h2>');
			}
		 $("#queryProd").submit();
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
		sel$.append('<option bcCode="'+this.bcCode+'" value="' +  this.bcId + '">' + this.bcName + '</option>');
	});
}