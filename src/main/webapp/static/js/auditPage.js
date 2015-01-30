$(function(){
	$('#passBtn').click(function(){
		$.modaldialog('您确认通过该卖家的申请吗？',
				{title :'确认',
				 buttons : [{text : '确&nbsp;&nbsp;认', click : function(){
					 	$('#flg').val('1');
					 	$('#frm').submit();
				 	}}, 
				            {text : '取&nbsp;&nbsp;消'}]
				});
	});
	
	$('#rejectBtn').click(function(){
		var opinion = $('#opinion').val();
		
		if(!opinion) {
			$.modaldialog('驳回必须填写审批意见！',
					{title :'错误',
					 type : 'error',
					 buttons : [{text : '确&nbsp;&nbsp;认', click : function(){
						 	$('#opinion').focus();
						 }}]
					});
			
			return;
		}
		
		$.modaldialog('您确认驳回该卖家的申请吗？',
				{title :'确认',
				 buttons : [{text : '确&nbsp;&nbsp;认', click : function(){
					 	$('#flg').val('0');
					 	$('#frm').submit();
				 	}}, 
				            {text : '取&nbsp;&nbsp;消'}]
				});
	});
});