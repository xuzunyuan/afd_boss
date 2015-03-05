	
function product(){

	this.downProduct = function(prodId){
		$.modaldialog('<dl><dt><label>驳回理由：</label></dt><dd><textarea name="auditContent" id="auditContent" rows="5"></textarea></dd></dl>',{
			title : '确认执行下架吗？',
			buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:downProduct, param:{id:prodId}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
		});
	};

	this.auditPass = function(prodId){
		 var msg = '<p><span>•</span>确认审核通过吗？</p>';
		 $.modaldialog(msg,{
			title : '确认审核通过吗？',
			buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:auditPass,param:{id:prodId}},{text : '取&nbsp;&nbsp;消',classes : 'btn-s'}]
		}); 
	}
	
	this.allSelect = function(obj){
		$("input[name=row_checkbox]").prop("checked",obj.checked);
	}
	
	this.batchDownProduct = function(){
		if($("input[name=row_checkbox]:checked").length <=0){
			alert("请勾选抽样下架商品");
			return;
		}
		var ids = "";
		$("input[name=row_checkbox]:checked").each(function(){
			var checked = $(this).prop("checked");
			if(!checked || !$(this).val()){
				return ;
			}else{
				ids += $(this).val() + ",";
			}
		});
		
		$.modaldialog('<dl><dt><label>驳回理由：</label></dt><dd><textarea name="auditContent" id="auditContent" rows="5"></textarea></dd></dl>',{
			title : '确认执行下架吗？',
			buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:batchDownProduct, param:{ids:ids}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
		});
	}
	
}

function auditPass(param){
	$.post("../product/auditPass?prodId="+param.id,function(data){
		if(data == "1") {
			$.modaldialog('<h2><i class="icon i-duigou"></i>审核通过</h2>',{
				buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',
							click:function(){
								window.location.href = '../product/productAudit';
							}
						  }]
			});
		}else{
			$.modaldialog('<h2><i class="icon i-warns"></i>操作失败！</h2>');
		}
	}); 
	
}  


function batchDownProduct(param){
	var auditContent = $("#auditContent").val();
	
	if($.trim(auditContent).length == 0 ){
		$.modaldialog('<h2><i class="icon i-warns"></i>驳回理由不能为空！</h2>');		
		return;
	}
	if(strlen(auditContent) > 300 ){
		$.modaldialog('<h2><i class="icon i-warns"></i>审核内容不能超过150字！</h2>');	
		return;
	}

	$.ajax({
		url : "../product/batchDownProduct",
		type : "POST",
		data : {ids : param.ids,auditStatus:2,auditContent:auditContent},
		success : function(re) {
			if(re){
				$.modaldialog('<p>商品下架成功！</p>',{
					title : '批量处理成功',
					buttons : [{text:'确&nbsp;&nbsp;定', classes:'btnB btn-s', 
						click:function() {
							window.location.href = '../product/productList';}
					}]
				});
			}else {
				$.modaldialog('<h2><i class="icon i-warns"></i>操作失败，请重试！</h2>');
			}
		}
	}); 
}
function downProduct(param){
	var auditContent = $("#auditContent").val();
	
	if($.trim(auditContent).length == 0 ){
		$.modaldialog('<h2><i class="icon i-warns"></i>驳回理由不能为空！</h2>');		
		return;
	}
	if(strlen(auditContent) > 300 ){
		$.modaldialog('<h2><i class="icon i-warns"></i>审核内容不能超过150字！</h2>');	
		return;
	}
	
	$.ajax({
		url : "../product/downProduct",
		type : "POST",
		data : {prodId : param.id,auditStatus:2,auditContent:auditContent},
		success : function(re) {
			if(re){
				$.modaldialog('<p>商品下架成功！</p>',{
					title : '操作成功',
					buttons : [{text:'确&nbsp;&nbsp;定', classes:'btnB btn-s', 
						click:function() {
							window.location.href = '../product/productList';}
						}]
				});
			}else {
				$.modaldialog('<h2><i class="icon i-warns"></i>操作失败，请重试！</h2>');
			}
		}
	}); 
}

function submitFrom(){
	$("#queryForm").submit();
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
