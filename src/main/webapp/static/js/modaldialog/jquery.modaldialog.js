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
	var def = {
			type : 'warning',
			title : '提示!',
			buttons : [{text : '确定'}]
	};
	
	var types = new Array("error", "warning", "success", "prompt");
	
	$.modaldialog = function(msg, options) {
		showDialog(msg, options);
	};
	
	// Creates and shows the modal dialog
	function showDialog (msg, options) {
		// Merge default title (per type), default settings, and user defined settings
		var settings = $.extend(def, options);
		
		// Make sure the dialog type is valid. If not assign the default one (the first)
		if(!$.inArray(settings.type, types)) {
			settings.type = def.type;
		};

		// Check if the dialog elements exist and create them if not
		if (!document.getElementById('dialog')) {
			dialog = document.createElement('div');
			dialog.id = 'dialog';
			$(dialog).html(
				"<div id='dialog-header'>" +
					"<div id='dialog-title'></div>" +
					"<div id='dialog-close'></div>" +
				"</div>" +
				"<div id='dialog-content'>" +
					"<div id='dialog-content-inner' />" +
					"<div id='dialog-button-container'>" +
					"</div>" +
				"</div>"
				);
			
			dialogmask = document.createElement('div');
			dialogmask.id = 'dialog-mask';
			
			$(dialogmask).hide();
			$(dialog).hide();
			
			document.body.appendChild(dialogmask);
			document.body.appendChild(dialog);

			// Set the click event for the "x" button			
			$("#dialog-close").click(hide);
		}

		var dl = $('#dialog');
		var dlh = $('#dialog-header');
		var dlc = $('#dialog-content');
		
		$('#dialog-title').html(settings.title);
		$('#dialog-content-inner').html(msg);
				
		// Center the dialog in the window but make sure it's at least 25 pixels from the top
		// Without that check, dialogs that are taller than the visible window risk
		// having the close buttons off-screen, rendering the dialog unclosable 
		dl.css('width', settings.width);
		dl.css('height', settings.height);
		var dialogTop = Math.abs($(window).height() - dl.height()) / 2;
		dl.css('left', ($(window).width() - dl.width()) / 2);
		dl.css('top', (dialogTop >= 25) ? dialogTop : 25);

		// Clear the dialog-type classes and add the current dialog-type class		
		$.each(types, function () { dlh.removeClass(this + "header"); });
		dlh.addClass(settings.type + "header");
		$.each(types, function () { dlc.removeClass(this); });
		dlc.addClass(settings.type);
		
		var dlb = $('#dialog-button-container');
		dlb.html('');
		$.each(settings.buttons, function(){
			dlb.append('&nbsp;&nbsp;&nbsp;&nbsp;');
			var self = this, jq = $("<input type='button' value='" + self.text + "'>").appendTo(dlb);
			
			jq.addClass(settings.type + "button");
			jq.click(function(){
				hide();
				if(self.click) self.click.call(this);
			});
		});
				
		dl.fadeIn("slow");
		$('#dialog-mask').fadeIn("normal");
	}

	function hide () {
		$('#dialog').fadeOut("slow", function () { $(this).hide(0); });
		$('#dialog-mask').fadeOut("normal", function () { $(this).hide(0); });
	}	
})(jQuery);
