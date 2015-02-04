$(function(){
	CheckUtil.limitDigital($('.num'));
	
	$('.num').keydown(function(event){
		if(event.which == 13) {
			$(':button[action]').trigger('click');
		}		
	});	
	
	$(':button[action]').click(function(){
		var action = $(this).attr('action');
		var pageNo = $(this).parent().find('.num').val();

		if(pageNo && pageNo>0) {
			var maxPage = $(this).parent().find('.num').attr('maxPage');
			if(pageNo > maxPage) return;
			
			location.href = getHref(action, pageNo);
		}
	});
});

function getHref(action, pageNo) {
	if(action.indexOf('?') == -1) {
		action = action + '?pageNo=' + pageNo;
		
	} else {		
		action = action + '&pageNo=' + pageNo; 
	}
	
	return action;
}