/*! 
 * @Copyright:一网全城电子商务平台
 * @Author:xuzunyuan
 * @Depends: jquery
 * 
 */

$(function(){
	$('#provinceId').change(provinceOnChange);	
	$('#provinceId').trigger('change');
	$("#status").change(function(){
		$("#query").trigger("click");
	});
	
	$('#downImg').click(function(){
		$('#applyDate').val('DESC');
		$("#query").trigger("click");
	});
	
	$('#upImg').click(function(){
		$('#applyDate').val('ASC');
		$("#query").trigger("click");
	});
});

function provinceOnChange() {
	var fid = $(this).val(), city = $('#cityId');
	
	city.find('option:gt(0)').remove();
	
	if(fid) {
		$.ajax({url:'../geoList?fid=' + fid, dataType:'json', type:'post',
			success : function(data) {
				if(data && data.length) {
					var cityValue = city.attr('value');
					
					$(data).each(function() {
						if(this.geoId == cityValue) {
							city.append('<option selected="selected" value="' +  this.geoId + '">' + this.geoName + '</option>');
						} else {
							city.append('<option value="' +  this.geoId + '">' + this.geoName + '</option>');
						}						
					});					
				}	
			},
			error : function() {}
		});
	}		
}