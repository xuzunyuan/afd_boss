function trade() {

	this.displayaddr = [];
	this.alladdr=[];
	this.addrshowtype = 1;
	this.choseaddrs = {};//easy to find chose address info
	this.addrissave=0;
	this.userid=0;
	this.getarea = function(fid, obj) {
		$.ajax({
			url : "geo.action",
			data : {
				fid : fid
			},
			async : false,
			dataType : "json",
			success : function(data) {
				if (data.length == 0) {
					if(obj.prop("id")=='townDiv'){
						obj.hide();
					}
					return false;
				}else{
					obj.show();
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

	this.getaddr = function() {
		type = "get";
		$.ajax({
			url : "addr.action",
			data : {
				type : type
			},
			dataType : "json",
			success : function(data) {
				trade.alladdr = data;
				var html = "";
				var nums = 1;
				for ( var addrindex in data) {
					if (nums <= 2) {

						nums++;
						trade.displayaddr.push(data[addrindex]);
						html += trade.getaddrhtml(data[addrindex]);
					}
					var obj = data[addrindex];
					var index = obj.addrId;
					eval("trade.choseaddrs.a" + index + "=obj;");
				}
				$(".address-lst").html(html);
				if (data.length > 2) {
					$(".btn-add").css('display', 'block');
				}
			}
		});
	};

	this.showaddr = function() {
		var showdata = this.alladdr;
		var html = "";
		for ( var addrindex in showdata) {
			html += this.getaddrhtml(showdata[addrindex]);
		}
		$("#addrlist").html(html);
		$("#addrlist").find("li").removeClass("on");
		$("#addrradio"+$("#addressId").val()).parents("li").addClass("on");
		$("#addrradio"+$("#addressId").val()).prop("checked",true);
	};

	this.getaddrhtml = function(data) {
		var provinceName = data.provinceName;

		var cityName =  data.cityName;
        if(cityName==provinceName){
        	cityName="";
        }
		var districtName = data.districtName;

		var townName =  data.townName;
		if(!townName){
			townName="";
		}
		
		var zipcode=data.zipCode;
		var zipcode_str="";
		if(zipcode){
			zipcode_str="（"+zipcode+"）";
		}
		
		var mobile=data.mobile;
		var tel=data.tel;
		var contact_str="";
		if(!tel){
			tel="";
		}
		if($.trim(mobile)!=""&&$.trim(tel)!=""){
			contact_str=mobile+"/"+tel;
		}else{
			contact_str=mobile+tel;
		}
		str = '<li class="">';
		str += '<p><b>寄送至：</b><a href="javascript:void(0)" onclick="trade.editaddr('+ data.addrId + ',this)">编辑地址</a><label for="moren"><input type="radio" class="rdo" name="addresschose" id="addrradio'+data.addrId+'" onclick="trade.setaddr(\'a'+ data.addrId + '\',this)">';	
		str += '<span>' + trade.htmlEncode(data.receiver)+'</span>';
		str += '<span class="getAdr">' +trade.htmlEncode(provinceName)+trade.htmlEncode(cityName)+trade.htmlEncode(districtName)+trade.htmlEncode(townName)+ trade.htmlEncode(data.addr)+zipcode_str+'</span>';		
		str += '<span>' + trade.htmlEncode(contact_str)+'</span>';
		str += '</span></label></li>';
		return str;
	};
    
	this.editaddr=function(addrid,obj){
		$("#addrlist").find("li").removeClass("on");
		$(obj).parents("li").addClass("on");
		$("#addrradio"+addrid).prop("checked",true);
		$("#addredit").show();	
		$("#addroptname").text("修改");
		$('#addressId').val(addrid);
		trade.addrissave=1;
	    this.filldata(addrid);
	    
	};
	
	this.newaddr = function() {	
		$("#addredit").show();		
	    this.cleardata();
	    $("#addrId").val("");
	    $("addressId").val("");
	    $("#mobile").val($("#qmobile").val());
	    $("#tela").val("");
	    $("#telb").val("");
	    $("#telc").val("");
	    $("#addroptname").text("添加");
		this.addrissave=0;
	};
    this.canceledit=function(){
    	$("#countyDiv").html("<option value='0'>请选择</option>");;
		$("#townDiv").html("<option value='0'>请选择</option>");;
		$("#townDiv").hide();
		$("#receiver").val("");
		$("#addr").val("");
        $("#mobile").val("");
        $("#tel").val("");
        $("#zipCode").val("");
        $("#addrId").val("");
        $("#tela").val("");
	    $("#telb").val("");
	    $("#telc").val("");	
	    $('#addredit').hide();
    };
	this.updateAddr = function(opttype) {
		
		if(!this.checkreceiver()){
			return false;
		}
		if(!this.checkarea()){
			return false;
		}
		if(!this.checkzipcode()){
			return false;
		}		
		if(!this.checkaddr()){
			return false;
		}
		if(!this.checkmobile()){
				return false;
		}			
			if(!this.checktel()){
				showmsg("请填写正确的联系电话");
				return false;
			}
		
		
		var receiver = $("#receiver").val();

		var province = $("#provinceDiv").val();

		var provinceName = $("#provinceDiv option:selected").text();

		var city = $("#cityDiv").val();

		var cityName = $("#cityDiv option:selected").text();

		var district = $("#countyDiv").val();

		var districtName = $("#countyDiv option:selected").text();

		var town = $("#townDiv").val();

		var townName = $("#townDiv option:selected").text();
		if (town == 0) {
			townName = "";
		}
		var addr = $("#addr").val();

		var mobile = $("#mobile").val();
		var tel = $.trim($("#tela").val());
		if(tel!=""){
			var telb=$.trim($("#telb").val());
			if(telb!=""){
				tel=tel+"-"+$.trim($("#telb").val());
			};
					}		
        if($.trim($("#telc").val())!=""){
        	tel+=("-"+$.trim($("#telc").val()));
        }
		var zipCode = $("#zipCode").val();
		
		var addrId=$("#addrId").val();
        if(addrId!=""){
        	opttype="update";//if addrid is exsited this opt is update
        }
		var isDefault = 0;
		if ($("#isdefault").prop("checked")) {
			isDefault = 1;
		}
		var userid=this.userid;
		$("#addbutton").prop("disabled", true);
		$("#addbutton").siblings('span.address-error').show();
		$.ajax({
			url : "addr.action?_input_encode=UTF-8",
			type : "POST",
			data : {
				type : opttype,
				addrId:addrId,
				receiver : receiver,
				province : province,
				provinceName : provinceName,
				city : city,
				cityName : cityName,
				district : district,
				districtName : districtName,
				town : town,
				townName : townName,
				addr : addr,
				mobile : mobile,
				tel:tel,
				zipCode : zipCode,
				isDefault : isDefault,
				status : 1,
				userId : userid
				},
			dataType : "json",
			success : function(data) {
				if (parseInt(data) == 0||!data) {
					showmsg("保存失败");
				} else {
                       if(opttype=='add'){
                    	   eval(" trade.choseaddrs.a" + data.addrId + "=data;");
                    	   trade.alladdr.unshift(data);
                    	   $("#addrId").val(data.addrId);                 	   
                       }
                       if(opttype=='update'){
                    	   eval(" trade.choseaddrs.a" + data.addrId + "=data;");
                    	   for ( var index in trade.alladdr) {
                   			if(trade.alladdr[index].addrId==data.addrId){
                   				trade.alladdr[index]=data;
                   				break;
                   			};
                   		};
                       }                  
                       $("#addressId").val(data.addrId);
                       trade.showaddr();
                       $("#addrtable").show();
                       trade.addrissave=1;
                       trade.userid=data.userId;
                       prodReload();//重新加载商品数据
                       trade.filladdress("a"+data.addrId);
                       $("#addredit").hide();
                       showmsg("保存地址成功");
				}
				$("#addbutton").prop("disabled", false);
				$("#addbutton").siblings('span.address-error').hide();
			}
		});
	};

	/**
	 * delete address
	 */
	this.deladdr=function(addrid,obj)
	{
		//eval("del this.choseaddrs.a" + addrid + ";");
		//eval("del this.alladdrs.a" + addrid + ";");
		
		$.ajax({
			url : "addr.action",
			type : "POST",
			data : {
				type : 'delete',
				addrId:addrid,				
				status : 0
			},
			dataType : "json",
			success : function(data) {		
				if(data>0){
					$("#addbutton").prop("disabled", false);
	                if($("#addrId").val()==addrid){
	                	$("#addrId").val("");
	                }
	                for ( var index in trade.alladdr) {
               			if(trade.alladdr[index].addrId==addrid){
               				trade.alladdr.splice(index-1,1);
               				break;
               			}
               		}
	                trade.displayaddr=trade.alladdr.slice(0,3);
	                $(obj).closest("li").remove();
	                if($("#addrid").val()==addrid){
	                	trade.cleardata();
	                }	                
	                if(trade.addrshowtype==0){
                 	   trade.addrshowtype=1;
                    }
	        		
				}else{
					showmsg("");
				}
				
			}
		});
	};

	/**
	 * choose address
	 */
	this.setaddr = function(addrid, obj) {

		$("#addrlist").find("li").removeClass("on");
		$(obj).parents("li").addClass("on");
		eval("$('#addressId').val(this.choseaddrs."+addrid+".addrId);");
		trade.addrissave=1;
		$('#addredit').hide();
		var addrid_str="a"+$('#addressId').val();
		if(addrid_str==addrid){
			prodReload();
		}
		this.filladdress(addrid);
	};

	this.htmlDecode=function(value) {
		return $('<div />').html(value).text();
		};
	this.htmlEncode=function (value){
		return $('<div />').text(value).html();
		};
	/*
	 * fill back area data
	 */
	this.filldata = function(addrid) {
		var addr;
		eval("addr = this.choseaddrs.a" + addrid + ";");
		$("#receiver").val(addr.receiver);
		$("#mobile").val(addr.mobile);		
		if($.trim(addr.tel)!=""){
			var tel_str=addr.tel;
			var tel_arr=tel_str.split("-");
			if(tel_arr[0]){$("#tela").val(tel_arr[0]);}
			if(tel_arr[1]){$("#telb").val(tel_arr[1]);}
			if(tel_arr[2]){$("#telc").val(tel_arr[2]);}
			
		}
		$("#addr").val(addr.addr);	
		$("#zipCode").val(addr.zipCode);
		$("#addrId").val(addr.addrId);
		$("#provinceDiv option[value='" + addr.province + "']").prop(
				"selected", true);
		var pid = $("#provinceDiv").val();
		this.getarea(pid, $("#cityDiv"));
		$("#cityDiv option[value='" + addr.city + "']").prop("selected", true);
		var cid = $("#cityDiv").val();
		this.getarea(cid, $("#countyDiv"));
		$("#countyDiv option[value='" + addr.district + "']").prop("selected",
				true);
		var ccid = $("#countyDiv").val();
		this.getarea(ccid, $("#townDiv"));
		$("#townDiv option[value='" + addr.town + "']").prop("selected", true);
		$("#areastr").text(this.getareastr());		
	};
	//

	this.getareastr=function(){
		var pname="";
		var cname="";
		var coname="";
		var tname="";
		var names_arr=new Array();
		if($("#provinceDiv").val()!=0){
			pname=$("#provinceDiv").find("option:selected").text();
			names_arr.push(pname);
		}
		if($("#cityDiv").val()!=0){
			cname=$("#cityDiv").find("option:selected").text();
			names_arr.push(cname);
		}		
		if($("#countyDiv").val()!=0){
			coname=$("#countyDiv").find("option:selected").text();
			names_arr.push(coname);
		}		
		if($("#townDiv").val()!=0){
			tname=$("#townDiv").find("option:selected").text();
			names_arr.push(tname);
		}
		return names_arr.join(" ");
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
			 $("#cityDiv").hide();
			 $("#townDiv").show();
			return false;
		}
		$("#countyDiv").prop("length", 1);
		$("#townDiv").prop("length", 1);
		$("#townDiv").hide();
		$("#areastr").text(this.getareastr());	
	};
	this.loadCounty = function() {
		var fid = $("#cityDiv").val();
		if(fid==0){
			$("#countyDiv").prop("length", 1);
			$("#townDiv").prop("length", 1);return;
		}
		this.getarea(fid, $("#countyDiv"));
		$("#townDiv").prop("length", 1);
		$("#areastr").text(this.getareastr());	
	};
	this.loadTown = function() {
		var fid = $("#countyDiv").val();
		if(fid==0){$("#townDiv").prop("length", 1);return;}
		this.getarea(fid, $("#townDiv"));
		$("#areastr").text(this.getareastr());	
	};

	this.fillTownName = function() {
		$("#townDiv option:selected").text();
	};
	
	this.checkzipcode=function(){
		var ret=false;
		var obj=$("#zipCode");
		var value=$.trim(obj.val());
		var pattern =/^[0-9]{6}$/;
		if(value==""){
			return true;
		}
        if(value!="")
        {
            if(pattern.exec(value))
            {
              ret=true;
            }
        }
        
        if(!ret){
        	obj.siblings('div.checkHint.error').find("span").text("请填写邮编,邮编由6位数字组成");
        }else{
        	obj.siblings('div.checkHint.error').find("span").text("");
        }
        return ret;
	};
	this.checkmobile=function(){
		var ret=false;
		var obj=$("#mobile");
		var value=$.trim(obj.val());
		var pattern =/^1\d{10}$/;
        if(value!="")
        {
            if(pattern.exec(value))
            {
              ret=true;
            }
        }else{
        	obj.siblings('div.checkHint.error').find("span").text("请填写正确的手机号码");
        	return false;
        }
        if(!ret){
        	obj.siblings('div.checkHint.error').find("span").text("请填写正确的手机号码");
        }else{
        	obj.siblings('div.checkHint.error').find("span").text("");
        }
        return ret;
	};	
	this.checktel=function(){
		var ret=false;
		var ob1=$("#tela");
		var ob2=$("#telb");
		var ob3=$("#telc");
		
		var value1=$.trim(ob1.val());
		var value2=$.trim(ob2.val());
		var value3=$.trim(ob3.val());
		
		var pattern1 =/^\d{3,4}$/;
		var pattern2 =/^\d{7,8}$/;
		var pattern3 =/^\d{1,4}$/;
		if(value1!=""||value2!=""||value3!=""){
			if(pattern1.exec(value1)&&pattern2.exec(value2))
            {
              ret=true;
            }else{
            	ob3.siblings('div.checkHint.error').find("span").text("请输入正确的电话号码");
            	return false;
            }
			if(value3!=""){
				if(pattern1.exec(value1)&&pattern2.exec(value2)&&pattern3.exec(value3))
	            {
	              ret=true;
	            }else{
	            	ob3.siblings('div.checkHint.error').find("span").text("请输入正确的电话号码");
	            	return false;
	            }
			}
		}else{
			ret=true;
		}
        
        if(!ret){
        	ob3.siblings('div.checkHint.error').find("span").text("请输入正确的电话号码");
        }else{
        	ob3.siblings('div.checkHint.error').find("span").text("");
        }
        	
       
        return ret;
	};
	
	this.checkreceiver=function(){
		var ret=false;
		var obj=$("#receiver");
		var value=$.trim(obj.val());
        if(value!="")
        {
        	var len = value.match(/[^ -~]/g) == null ? value.length : value.length + value.match(/[^ -~]/g).length ;
        	if(len>30){
            	obj.siblings('div.checkHint.error').find("span").text("收货人姓名过长");
            	return false;
        	}else{
        		 ret=true;
        	}
          
        }
        if(!ret){
        	obj.siblings('div.checkHint.error').find("span").text("请输入收货人姓名");
        }else{
        	obj.siblings('div.checkHint.error').find("span").text("");
        }
        return ret;
	};
	
	this.checkaddr=function(){
		var ret=false;
		var obj=$("#addr");
		var value=$.trim(obj.val());
        if(value!="")
        {
        	var len = value.match(/[^ -~]/g) == null ? value.length : value.length + value.match(/[^ -~]/g).length ;
        	if(len>100){
        		obj.siblings('div.checkHint.error').find("span").text("收货地址过长");
            	return false;
        	}else{
        		 ret=true;
        	}
        }
        if(!ret){
        	obj.siblings('div.checkHint.error').find("span").text("请填写收货地址");
        }else{
        	obj.siblings('div.checkHint.error').find("span").text("");
        }
        return ret;
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
	
	this.cleardata=function(){
		//$("#provinceDiv option[value='0']").prop("selected", true);
		//$("#cityDiv").show();
		//$("#cityDiv").html("<option value='0'>请选择</option>");
		$("#cityDiv option[value='0']").prop("selected", true);
		$("#countyDiv").html("<option value='0'>请选择</option>");;
		$("#townDiv").html("<option value='0'>请选择</option>");;
		$("#townDiv").hide();
		$("#receiver").val("");
		$("#addr").val("");
        $("#mobile").val("");
        $("#tel").val("");
        $("#zipCode").val("");
        $("#addrId").val("");
        $("#addressId").val("");
        $("#tela").val("");
	    $("#telb").val("");
	    $("#telc").val("");	
	    $("#areastr").text("");
	};
	
	this.submitcheck=function(){	
		if(trade.addrissave==0||$("#addressId").val()){
			showmsg("请保存收货地址");
			return false;
		}
		
		if(typeof($('input[name=payType]:checked').val())== "undefined"){
			showmsg("请选择支付方式");
			return false;			
		}		
		return true;
	};
	
	this.filladdress=function(addrid){//此处addrid 形如：a1234 以字母a开头
		var addr;
		eval("addr = this.choseaddrs." + addrid + ";");
		
		$("#receiverc").text(addr.receiver);
		
		var provinceName = addr.provinceName;

		var cityName =  addr.cityName;

		var districtName = addr.districtName;

		var townName =  addr.townName;
		if(!townName){townName="";}
		var address = addr.addr;
		var zipcode_str=addr.zipCode;
		if(!!zipcode_str){
			zipcode_str="（"+zipcode_str+"）";
		}else{
			zipcode_str="";
		}
		var phone="";
		if(addr.mobile!==""){
			phone=addr.mobile;
		}else{
			phone=addr.tel;
		}
		$("#addressc").text("寄送至："+provinceName+cityName+districtName+townName+address+zipcode_str);
		$("#phonec").text("收件人："+addr.receiver+" "+phone);
	};
	this.checkuser=function(){
		var obj=$("#qmobile");
		var value=$.trim(obj.val());
		var username=$.trim($("#qname").val());
		var pattern =/^1\d{10}$/;
        if(value!="")
        {
            if(!pattern.exec(value))
            {
            	showmsg("请输入正确的手机号码！");return false;
            }
        }else{
        	if(username==""){
        		showmsg("请输入手机号码或者用户名！");return false;	
        	}
        	
        }
        $("#mobile").val(value);
		$.ajax({
			url : "checkuserinfo.action",
			type : "POST",
			data : {
				mobile : value,
				username:username
			},
			cache : false,
			dataType : "json",
			success : function(data) {
				trade.cleardata();
				$("#addrlist").html('');
				$("#mobile").val(value);
				if(data.userinfo.userId==-1){
					$("#addredit").show();
					$("#addrtable").hide();					
					$("#userinfo").hide();
					trade.userid=0;
					trade.alladdr=[];
					showmsg("此客户没有注册过会员");
				}else{
					trade.userid=data.userinfo.userId;
					trade.addrissave=0;
					var username=data.user.userName;
					var regdate=data.user.regDate;
					var userstatus=data.user.status;
					var regtype=data.user.regFrom;
					$("#username").text(username);
					if(regdate){$("#regdate").text(formatDate(regdate));}					
					if(regtype==""){
						$("#regtype").text("网站测试注册");
					};
					if(regtype=="0"){
						$("#regtype").text("网站注册");
					}; 
					if(regtype=="1"){
						$("#regtype").text("android注册");
					};
					if(regtype=="2"){
						$("#regtype").text("ios注册");
					};
					if(regtype=="3"){
						$("#regtype").text("电话注册");
					};
					if(userstatus=="0"){
						$("#usertatus").text("无效");
					}	
					if(userstatus=="1"){
						$("#usertatus").text("正常");
					}	
					$("#userinfo").show();
					trade.alladdr=data.userinfo.addrs;
					if(data.userinfo.addrs.length>0){
						var html="";			
						for ( var addrindex in data.userinfo.addrs) {
							
							html += trade.getaddrhtml(data.userinfo.addrs[addrindex]);
							trade.displayaddr.push(data.userinfo.addrs[addrindex]);
							var obj = data.userinfo.addrs[addrindex];
							var index = obj.addrId;
							eval("trade.choseaddrs.a" + index + "=obj;");
						}
						
						if(html!=""){
							$("#addrtable").show();
							$("#addredit").hide();
						}else{
							$("#addrtable").hide();
							$("#addredit").show();
						}
						
						$("#addrlist").html(html);
					}else{
						$("#addredit").show();
					}
				}
			}
		});
	};

 this.saveorder=function(){
	 var datas={};
	
	 var payMode='00';
	 var orderType='0';
	 var payType='0';
	 var orderSource="2";
	
	 payMode_str=$("input[name=payMode]:checked").val();
	 if($.trim(payMode_str)!=""){
		 payMode=payMode_str;
	 }
	 var addressId=$("#addressId").val();
	
	 
	 if($("tr[name=cartitem]").length<1){
		 showmsg("请添加商品");
		 return false;
	 }
	 if(product_error==1){
		 showmsg("请删除有问题的商品");
		 return false;
	 }
	 if(addressId==""||this.addrissave==0){
		 showmsg("请选择或保存地址");
		 return false;
	 }
	 var addr;
	 eval("addr = this.choseaddrs.a" + addressId + ";");
     var mobile=addr.mobile;	
	 datas.payMode=$('input[name=payMode]:checked').val();
	 datas.orderType=orderType;
	 datas.payType=payType;
	 datas.orderSource=orderSource;
	 datas.addressId=addressId;
	 datas.mobile=mobile;
	 datastr="";
	 datastr+="payMode="+payMode+"&";
	 datastr+="orderType="+orderType+"&";
	 datastr+="payType="+payType+"&";
	 datastr+="orderSource="+orderSource+"&";
	 datastr+="addressId="+addressId+"&";
	 datastr+="mobile="+mobile+"&";
	 datastr+="userId="+trade.userid+"&";
	 storeinfo=$("input[name^='storeInfo']");

	 storeinfo.each(function(){
		var name= $(this).attr('name');
		var val=$(this).val();
		datastr+=name+"="+val+"&";
	 });
     $("#savebutton").prop("disabled", true);
	 $.ajax({
			url : "saveorder.action?_input_encode=UTF-8",
			type : "POST",
			data :datastr+"1=1",
			success : function(data) {
				if (data == 0) {
					showmsg("保存失败");
				}else{
					//var ids=new Array();
					//for(var index in data){
					//	ids.push(data[index]);
					//}
					//var ids_str=ids.join("_");
					//location.href="succeed?orderids="+ids_str;
					$("#savedmask").show();$("#savedinfo").show();
				}
				$("#savebutton").prop("disabled", false);	
			}
		});
 };
};

function   formatDate(now_str)   { 
	var now=new Date(now_str);
    var   year=now.getFullYear();     
    var   month=now.getMonth()+1;     
    var   date=now.getDate();     
    var   hour=now.getHours();     
    var   minute=now.getMinutes();     
    var   second=now.getSeconds();     
    return   year+"-"+month+"-"+date+"   "+hour+":"+minute+":"+second;     
    }  

function showmsg(msg){
	 $.modaldialog("<p>"+msg+"</p>",{
			title : '提示',
			buttons : [{text:'确&nbsp;&nbsp;定',classes:'btnB btn-s'}],
			hasclose:false
		});		
}
