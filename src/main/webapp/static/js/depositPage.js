$(function(){
	$('#passBtn').click(function(){
		$.modaldialog('确认该卖家的保证金到账吗？',
				{title :'确认',
				 buttons : [{text : '确&nbsp;&nbsp;认', click : function(){
					 	$('#frm').submit();
				 	}}, 
				            {text : '取&nbsp;&nbsp;消'}]
				});
	});
	
	
});