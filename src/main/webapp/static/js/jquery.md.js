/*
 * jQuery Modal Dialog plugin 1.0
 * Released: July 14, 2008
 * 
 * Copyright (c) 2008 Chris Winberry
 * Email: transistech@gmail.com
 * 
 * Original Design: Michael Leigeber
 * http://www.leigeber.com/2008/04/custom-javascript-dialog-boxes/
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 * @license http://www.opensource.org/licenses/mit-license.php
 * @license http://www.gnu.org/licenses/gpl.html
 * @project jquery.modaldialog
 */
(function($) {
	var dialog$ = undefined;
	var closeClk = undefined;
	var dialogClass = undefined;
	
	var def = {
			//type : 'success',
			title : '操作成功!',
			hasclose : true, 
			buttons : [{text : '确&nbsp;&nbsp;定'}]
	};
	
	//var types = new Array("error", "warning", "success", "prompt");
	
	$.modaldialog = function(msg, options) {
		closeClk = undefined;
		if(dialogClass){
			dialog$.removeClass(dialogClass);
			dialogClass = undefined;
		}
		
		showDialog(msg, options);
	};
	
	// Creates and shows the modal dialog
	function showDialog (msg, options) {
		// Merge default title (per type), default settings, and user defined settings
		var settings = $.extend({}, def, options);
		
		// Make sure the dialog type is valid. If not assign the default one (the first)
		//if(!$.inArray(settings.type, types)) {
		//	settings.type = def.type;
		//};

 
		// Check if the dialog elements exist and create them if not
		if (!document.getElementById('dialog')) {
			var dialog = document.createElement('div');
			dialog.id = 'dialog';
			dialog.className = 'pop';
			dialog.style.cssText="margin:0px;"; 
			
			dialog$ = $(dialog);
			dialog$.html(
				"<div id='dialog-header' class='hd'>" +
					"<h1 id='dialog-title'></h1>" +
					"<span id='dialog-close'><i class='icon i-close' title='关闭'></i></span>" +
				"</div>" +
				"<div id='dialog-content' class='bd'>" +
					"<div id='dialog-content-inner' class='pop-con'>" +
//						"<h2><i class='icon i-duigou'></i></h2>" +
//						"<p>系统已通知卖家安排发货！</p>" +
					"</div>" +
					"<div id='dialog-button-container' class='formBtn'>" +
//						"<input type='button' value='继续下单' class='btnB btn-s'>" +
					"</div>" +
				"</div>"
				);
			
			var dialogmask = document.createElement('div');
			dialogmask.className = 'mask';
			dialogmask.id = 'mask';
			
			$(dialogmask).hide();
			dialog$.hide();
			
			document.body.appendChild(dialogmask);
			document.body.appendChild(dialog);

			// Set the click event for the "x" button			
			$("#dialog-close").click(closeHandle);
		}

		$('#dialog-title').html(settings.title);
		 
		$('#dialog-content-inner').html(msg);
		
		if(settings.dialogClass){
			dialogClass = settings.dialogClass;
			dialog$.addClass(dialogClass);
		}
		if(settings.closeClick){
			closeClk = settings.closeClick;
		}
		if(settings.hasclose===false){
			$("#dialog-close").hide();
		}else if($("#dialog-close").is(":hidden")){
			$("#dialog-close").show();
		}
		
		showPop();
		
		var dlb = $('#dialog-button-container');
		dlb.html('');
		$.each(settings.buttons, function(){
			var self = this, jq = $("<input type='button' value='" + self.text + "'>").appendTo(dlb);
			
			if(self.attr){
				for(var key in self.attr){
					jq.attr(key, self.attr[key]);
				}
			}
			
			jq.addClass(self.classes?self.classes:'btnB btn-s');
			
			jq.click(function(){
				hide();
				
				if(self.click){
					var result;
					if(self.param){
						result = self.click.call(this, self.param);
					}else{
						result = self.click.call(this);
					}
					if(result){
						dialog$.show();
						$('#mask').show();
					}
				}
			});
		});
		
		dialog$.show();
		$('#mask').show();
	}

	function closeHandle() {
		hide ();
		
		if(closeClk){
			closeClk.call(this);
		}
	}
	
	function hide () {
		dialog$.hide();
		$('#mask').hide();
	}	
	
	$(window).resize(function() {
		if ($("#dialog").is(":visible")) {
			showPop();
		}
	});
	 
	function showPop() {
		var objP = dialog$;
		var windowWidth = document.documentElement.clientWidth;   
		var windowHeight = document.documentElement.clientHeight;   
		var popupHeight = objP.height();   
		var popupWidth = objP.width();    
		 
		objP.css({   
			"position": "absolute",   
			"top": (windowHeight-popupHeight)/2+$(document).scrollTop(),   
			"left": (windowWidth-popupWidth)/2   
		});  
	};
})(jQuery);
