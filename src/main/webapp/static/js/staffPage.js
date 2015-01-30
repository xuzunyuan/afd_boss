function limitDigital(jq) {
	jq.bind('input propertychange', function(e){
		var jq = $(this), value = jq.val();

		if(value) {
			var newValue = value.replace(/\D/g, '');

			if(value !== newValue) {
				jq.val(newValue);
			}			
		}
	});
};

$(function(){
	// 手机号码、邮编只允许输入数字
	limitDigital($('#mobile, #zipCode'));
	
	$('#loginName').focus();
	
	var delBtn = $('#delBtn');
	
	delBtn.click(function(e){
		var staffId = delBtn.attr("staffId");
		
		$.modaldialog('您确定删除该用户吗?',
				{title :'确认',
				 buttons : [{text : '确&nbsp;&nbsp;认',click:function(){
					 self.location.href = '../sys/staffDel?staffId=' + staffId;
				 }}, 
			            {text : '取&nbsp;&nbsp;消'}]
				});
	});
	
	$('#frm').submit(function(e){
		if(!$('#loginName').val()){
			$.modaldialog('请填写登录名！',
					{title :'错误',
					 type : 'error',
					 buttons : [{text : '确&nbsp;&nbsp;认',click:function(){
						 $('#loginName').focus();
					 }}]
					});
			
			return false;
		}
		
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
		
		if(!$('#mobile').val()){
			$.modaldialog('请填写手机号码！',
					{title :'错误',
					 type : 'error',
					 buttons : [{text : '确&nbsp;&nbsp;认',click:function(){
						 $('#mobile').focus();
					 }}]
					});
			
			return false;
		}
		
		if(! /^[1]\d{10}$/.test($('#mobile').val())){
			$.modaldialog('请填写正确的手机号码！',
					{title :'错误',
					 type : 'error',
					 buttons : [{text : '确&nbsp;&nbsp;认',click:function(){
						 $('#mobile').focus();
					 }}]
					});
			
			return false;
		}
	});
});