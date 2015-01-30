function paymethod(){

	this.getarea = function(fid, obj) {
		$.ajax({
			url : "list/geo.action",
			data : {
				fid : fid
			},
			async : false,
			dataType : "json",
			success : function(data) {
				if (data.length == 0) {
					if(obj.prop("id")=='townDiv'){
						obj.parent().hide();
					}
					return false;
				}else{
					obj.parent().show();
				}
				optList = "<option value='0'>请选择</option>";
				if (data.length == 1&&obj.prop("id")=='cityDiv') {
					optList="";
				}
				for ( var gindex in data) {
					optList += "<option value='" + data[gindex].geoId + "'>"
							+ data[gindex].geoName + "</option>";
				}
				obj.html(optList);				
			}
		});
	};


	
	this.loadCity = function() {
		var fid = $("#provinceDiv").val();
		if(fid==0){
			$("#cityDiv").prop("length", 1);
			$("#countyDiv").prop("length", 1);
			$("#townDiv").prop("length", 1);return;
			}
		this.getarea(fid, $("#cityDiv"));
		if($("#cityDiv option").length==1){
			
			this.loadCounty();
			 $("#cityDiv").parent().hide();
			 $("#townDiv").parent().show();
			return false;
		}else{
			 $("#cityDiv").parent().show();
		}
		$("#countyDiv").prop("length", 1);
		$("#townDiv").prop("length", 1);
		$("#townDiv").parent().hide();	
	};
	this.loadCounty = function() {
		var fid = $("#cityDiv").val();
		if(fid==0){
			$("#countyDiv").prop("length", 1);
			$("#townDiv").prop("length", 1);return;
		}
		this.getarea(fid, $("#countyDiv"));
		$("#townDiv").prop("length", 1);
	};
	this.loadTown = function() {
		var fid = $("#countyDiv").val();
		if(fid==0){$("#townDiv").prop("length", 1);return;}
		this.getarea(fid, $("#townDiv"));
	};

	this.fillTownName = function() {
		$("#townDiv option:selected").text();
	};

	this.checkarea=function(){
		var ret=true; 
		var pid = $("#provinceDiv").val();
		var cid=$("#cityDiv").val();
		var ccid=$("#countyDiv").val();
		var tid= $("#townDiv").val();
		if(pid==0||cid==0||ccid==0){
			ret=false;
		}
		if( $("#townDiv").is(":visible")&&tid==0){
			ret=false;
		}
		if(!ret){
        	$("#areaerror").text("请选择收货区域");
		}else{
			$("#areaerror").text("");
		}
		return ret;
	};
	

	
	this.submitcheck=function(){	
		var pid=$("#provinceDiv").val();
		var cid=$("#cityDiv").val();
		var ccid=$("#countyDiv").val();
		var tid=$("#townDiv").val();
		var fid=0;
		if(pid!=0){
			fid=pid;
		}
		if(cid!=0){
			fid=cid;
		}	
		if(ccid!=0){
			fid=ccid;
		}
		if(tid!=0&&$("#townDiv").is(":visible")){
			fid=tid;
		}
		if(fid==0){
			var msg = '<p>请选择一个区域</p>';
			$.modaldialog(msg,{
				title : '提示',
				buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s',click:function(){}}],
				hasclose:false
			});		   
			return 
		}
		$("#query").submit();
	};
	
	
};

