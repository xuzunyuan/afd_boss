$(function(){
	$('.num').keydown(function(event){
		return (event.which == 8 ||
				event.which == 9 ||
				event.which == 46 ||				
				(event.which >= 48 && event.which <= 57) ||
				(event.which >= 37 && event.which <= 40) ||
				(event.which >= 96 && event.which <= 105));
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