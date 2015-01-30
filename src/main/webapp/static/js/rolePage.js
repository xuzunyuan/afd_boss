$(function(){
	$('#delBtn').click(function(e){
		$.modaldialog('您确定删除该角色吗?',
				{title :'确认',
				 buttons : [{text : '确&nbsp;&nbsp;认',click:function(){
					 $('#flg').val('del');
					 $('#frm').submit();
				 }}, 
			            {text : '取&nbsp;&nbsp;消'}]
				});
	});	
	
	$('#saveBtn').click(function(e){
		var roleName = $('#roleName').val();
		
		if(!roleName) {
			$.modaldialog('请填写角色名称！',
					{title :'错误',
					 type : 'error',
					 buttons : [{text : '确&nbsp;&nbsp;认',click:function(){
						 $('#roleName').focus();
					 }}]
					});
			
		} else {
			$('#flg').val('save');
			 $('#frm').submit();
		}
	});
});