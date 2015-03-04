	
function product(){

	this.downProduct = function(prodId){
		$.modaldialog('<dl><dt><label>驳回理由：</label></dt><dd><textarea name="auditContent" id="auditContent" rows="5"></textarea></dd></dl>',{
			title : '确认执行下架吗？',
			buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:downawayProduct, param:{id:prodId}},{text : '取&nbsp;&nbsp;消',classes : 'btn btn-s'}]
		});
	};

}

function downawayProduct(param){
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
		url : "../product/doDownaway",
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
				$.modaldialog('<h2><i class="icon i-warns"></i>操作失败！</h2>');
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
