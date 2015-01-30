$(function(){
	// 手机号码、邮编只允许输入数字
	$('#mobile, #zipCode').keydown(function(event){
		return (event.which == 8 ||
				event.which == 9 ||
				event.which == 46 ||				
				(event.which >= 48 && event.which <= 57) ||
				(event.which >= 37 && event.which <= 40) ||
				(event.which >= 96 && event.which <= 105));
	});
	
	$('#realName').focus();
	
	$('#frm').submit(function(e){
		if(!$('#realName').val()){
			$.modaldialog('请填写真实姓名！',
					{title :'错误',
					 type : 'error',
					 buttons : [{text : '确&nbsp;&nbsp;认',click:function(){
						 $('#realName').focus();
					 }}]
					});
			
			return false;
		}
	});
});