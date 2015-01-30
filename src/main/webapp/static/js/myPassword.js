$(function(){
	$('#frm').submit(function(e){
		if(!$('#oldPassword').val()){
			$.modaldialog('请填写旧密码！',
					{title :'错误',
					 type : 'error',
					 buttons : [{text : '确&nbsp;&nbsp;认',click:function(){
						 $('#oldPassword').focus();
					 }}]
					});
			
			return false;
		}
		
		if(!$('#newPassword').val()){
			$.modaldialog('请填写新密码！',
					{title :'错误',
					 type : 'error',
					 buttons : [{text : '确&nbsp;&nbsp;认',click:function(){
						 $('#newPassword').focus();
					 }}]
					});
			
			return false;
		}
		
		if(!$('#newPassword2').val() || ($('#newPassword2').val() != $('#newPassword').val())){
			$.modaldialog('重复密码必须一致！',
					{title :'错误',
					 type : 'error',
					 buttons : [{text : '确&nbsp;&nbsp;认',click:function(){
						 $('#newPassword2').focus();
					 }}]
					});
			
			return false;
		}
	});
});