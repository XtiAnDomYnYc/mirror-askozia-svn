<?php
/*
	$Id$
	part of AskoziaPBX (http://askozia.com/pbx)
	
	Copyright (C) 2007-2008 IKT <http://itison-ikt.de>.
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:
	
	1. Redistributions of source code must retain the above copyright notice,
	   this list of conditions and the following disclaimer.
	
	2. Redistributions in binary form must reproduce the above copyright
	   notice, this list of conditions and the following disclaimer in the
	   documentation and/or other materials provided with the distribution.
	
	THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
	INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
	AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
	AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
	OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
	POSSIBILITY OF SUCH DAMAGE.
*/

function javascript_incoming_extension_selector($current_incomingextensionmap, $multiple=false) {
	
	$options[] = array("", gettext("Outgoing Calls Only"));
	$options[] = array("", "");
	$pad = "&nbsp;&nbsp;&nbsp;";

	if (count($a_items = callgroups_get_groups())) {
		$options[] = array("", gettext("Call Groups"));
		foreach ($a_items as $item) {
			$options[] = array($item['uniqid'], $pad . $item['name']);
		}
	}
	
	if (count($a_items = sip_get_phones())) {
		$options[] = array("", gettext("SIP Phones"));
		foreach ($a_items as $item) {
			$options[] = array($item['uniqid'], $pad . $item['callerid'] . " &lt;" . $item['extension'] . "&gt;");
		}
	}
	
	if (count($a_items = iax_get_phones())) {
		$options[] = array("", gettext("IAX Phones"));
		foreach ($a_items as $item) {
			$options[] = array($item['uniqid'], $pad . $item['callerid'] . " &lt;" . $item['extension'] . "&gt;");
		}
	}
	
	if (count($a_items = isdn_get_phones())) {
		$options[] = array("", gettext("ISDN Phones"));
		foreach ($a_items as $item) {
			$options[] = array($item['uniqid'], $pad . $item['callerid'] . " &lt;" . $item['extension'] . "&gt;");
		}
	}
	
	if (count($a_items = analog_get_phones())) {
		$options[] = array("", gettext("Analog Phones"));
		foreach ($a_items as $item) {
			$options[] = array($item['uniqid'], $pad . $item['callerid'] . " &lt;" . $item['extension'] . "&gt;");
		}
	}
	
	if (count($a_items = external_get_phones())) {
		$options[] = array("", gettext("External Phones"));
		foreach ($a_items as $item) {
			$options[] = array($item['uniqid'], $pad . $item['name'] . " &lt;" . $item['dialstring'] . "&gt;");
		}
	}
	
	if (count($a_items = conferencing_get_rooms())) {
		$options[] = array("", gettext("Conference Rooms"));
		foreach ($a_items as $item) {
			$options[] = array($item['uniqid'], $pad . $item['name'] . " &lt;" . $item['number'] . "&gt;");
		}
	}
	
	if (count($a_items = applications_get_apps())) {
		$options[] = array("", gettext("Applications"));
		foreach ($a_items as $item) {
			$options[] = array($item['uniqid'], $pad . $item['name']);
		}
	}
	
	$n = count($options);
	for ($i = 0; $i < $n; $i++) {
		$add_options_string .= "\t\t+ '<option value=\"{$options[$i][0]}\">{$options[$i][1]}</option>'\n";
	}

	echo <<<EOD


var next_incoming_extension_selector_id = 0;

function add_incoming_extension_selector(destination_id, pattern, provider_id) {
	if (pattern === undefined) {
		pattern = '';
	}

	var id = next_incoming_extension_selector_id;

	var insert_string =
		'<tr id="incoming_extension_selector_' + id + '">'
		+ '<td>'
		+ '<input name="incomingpattern_' + id + '" type="text" class="formfld" '
		+ 'id="incomingpattern_' + id + '" size="20" value="' + pattern + '">'
		+ '<select name="destinationid_' + id + '" class="formfld" id="destinationid_' + id + '">'
		$add_options_string
		+ '</select>'
		+ '</td>';

	if (next_incoming_extension_selector_id == 0) {
		insert_string += '<td valign="middle">&nbsp;</td></tr>';

	} else {
		insert_string += '<td valign="middle">'
			+ '<img src="delete.png" title="remove incoming extension mapping" border="0" '
			+ 'style="cursor:pointer;" onclick="remove_incoming_extension_selector(' + id + ')">'
			+ '</td>' +
			'</tr>';
	}

	jQuery("#incoming_extension_selector_last").before(insert_string);

	if (destination_id !== undefined) {
		jQuery('#destinationid_' + id).selectOptions(destination_id, true);
	}

	next_incoming_extension_selector_id++;		
}

function remove_incoming_extension_selector(id) {

	jQuery('#incoming_extension_selector_' + id).remove();

}


EOD;

	if (!count($current_incomingextensionmap)) {
		echo "add_incoming_extension_selector();";
	} else {
		foreach ($current_incomingextensionmap as $map) {
			if (isset($map['incomingpattern'])) {
				echo "add_incoming_extension_selector(\"" . 
					$map['destinationid'] . "\", \"" . $map['incomingpattern'] . "\");";
			} else {
				echo "add_incoming_extension_selector(\"" . $map['destinationid'] . "\");";
			}
		}
	}

}

function javascript_default_value_setter($id, $value) {

	$js = "jQuery('#" . $id . "').val('" . $value . "');";
	$a = "<a href=\"javascript:{}\" onclick=\"$js\" title=\"set default value\">$value</a>";

	return $a;
}

function javascript_public_direct_dial_editor($part) {

	if ($part == "functions") : ?>

		function publicname_slide() {
			if (jQuery("#allowdirectdial").is(":checked")) {
				jQuery("#publicname_wrapper").slideDown();
			} else {
				jQuery("#publicname_wrapper").slideUp();
			}
		}

	<? elseif ($part == "ready") : ?>

		jQuery("#allowdirectdial").click(publicname_slide);
		publicname_slide();

	<? else : ?>

		ERROR: no part defined in javascript_public_direct_dial_editor()!

	<? endif;
}

function javascript_advanced_settings($part) {

	if ($part == "functions") : ?>

	<? elseif ($part == "ready") : ?>

		jQuery("#advanced-settings-opener").click(function(){
			jQuery("#advanced-settings-header").html("<?=gettext("Advanced Settings");?>");
			jQuery("#advanced-settings-container").slideDown();
		});

	<? else : ?>

		ERROR: no part defined in javascript_advanced_settings()!

	<? endif;
}

function javascript_filter_textbox($part) {

	if ($part == "functions") : ?>

	<? elseif ($part == "ready") : ?>

	var filter_text = jQuery('#filtering label').remove().text();

	if(jQuery('#filter').val() != "") {
		jQuery('#filter').attr("disabled","disabled");
	}

	if(jQuery('#filter').val() == "") {
		jQuery('#filter').addClass('placeholder').val(filter_text).focus(function() {
	
			if(this.value == filter_text) {
				jQuery(this).removeClass('placeholder').val('');
			};
	
		}).blur(function() {
			
			if(this.value == '') {
				jQuery(this).addClass('placeholder').val(filter_text);
			};
		});
	}

	<? else : ?>

		ERROR: no part defined in javascript_filter_textbox()!

	<? endif;
}

function javascript_account_statuses($part) {

	if ($part == "functions") : ?>

		function update_statuses_sub(status) {
			var title;
			var src;
			switch(status[1]) {
    	    
				case "OK":
				title = "<?=gettext("connected");?>";
				src = "bullet_green.png";
				break;
    	    
				case "LAGGED":
				title = "<?=gettext("connected but lagged");?>";
				src = "bullet_yellow.png";
				break;
    	    
				case "UNREACHABLE":
				title = "<?=gettext("unreachable");?>";
				src = "bullet_red.png";
				break;
    	    
				case "UNKNOWN":
				title = "<?=gettext("status unknown");?>";
				src = "bullet_white.png";
				break;
    	    
				default:
				title = "<?=gettext("status unknown");?>";
				src = "bullet_white.png";
				break;
			}
    	
			jQuery('#' + status[0]).attr("src", src).attr("title", title);
		}

		function update_statuses() {
    	
			var lines = [];
			var pieces = [];
			var status = [];
			var count = 0;
			var title;
			var src;
			var i = 0;
    	
			jQuery.get('ajax.cgi', { exec_ami: '"sip show statuses"' }, function(data){
				lines = data.split(/\n/);
				for (i = 0; i < lines.length; i++) {
					pieces = lines[i].split(" ");
					update_statuses_sub(pieces);
				}
			});
			jQuery.get('ajax.cgi', { exec_ami: '"iax2 show statuses"' }, function(data){
				lines = data.split(/\n/);
				for (i = 0; i < lines.length; i++) {
					pieces = lines[i].split(" ");
					update_statuses_sub(pieces);
				}
			});
    	
			setTimeout("update_statuses()", 5000);
		}

	<? elseif ($part == "ready") : ?>

		update_statuses();

	<? else : ?>

		ERROR: no part defined in javascript_account_statuses()!

	<? endif;
}

function javascript_generate_passwd($part) {

	if ($part == "functions") : ?>

	<? elseif ($part == "ready") : ?>

		jQuery("#generate").click(function(){
			
			if(!jQuery("#generator_wrapper").is(':visible')) {
				jQuery("#generator_wrapper").slideDown();
			}

			var charlist = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz123456789";
			var plength = 10;
			var passwd = "";
				for (i = 0; i < plength ; i++) {
					passwd += charlist.charAt(Math.floor(Math.random()*charlist.length));
				}
			jQuery('#gen_passwd').val(passwd);
		});

		jQuery("#use").click(function(){
			
			jQuery('#secret').val(jQuery('#gen_passwd').val());
		});

	<? else : ?>

		ERROR: no part defined in javascript_generate_passwd()!

	<? endif;
}

function javascript_userdefined_email_notification($part) {

	if ($part == "functions") : ?>

		function slide_fields() {
			if (jQuery("#user_defined").is(":checked")) {
				jQuery("#maillanguage").attr("disabled","disabled");
				jQuery("#email_notification_wrapper").slideDown();
			} else {
				jQuery("#email_notification_wrapper").slideUp();
				jQuery("#maillanguage").removeAttr("disabled");
			}
		}

	<? elseif ($part == "ready") : ?>

		jQuery("#user_defined").click(slide_fields);
		slide_fields();

	<? else : ?>

		ERROR: no part defined in javascript_userdefined_email_notification()!

	<? endif;
}

function javascript_dyndns($part) {

	if ($part == "functions") : ?>

		function dyndns_slide() {
			if (jQuery("#hostnameupdatesrcpbx").is(":checked") && jQuery("#topology option:selected").val() == "natdynamichost") {
				jQuery("#dyndns_wrapper").slideDown();
			} else {
				jQuery("#dyndns_wrapper").slideUp();
			}
		}

		function attr_change() {
			switch (jQuery("#topology option:selected").val()) {
				case "public":
					jQuery("#extipaddr").attr("disabled","disabled");
					jQuery("#exthostname").attr("disabled","disabled");
					jQuery("#hostnameupdatesrcpbx").attr("disabled","disabled");
					jQuery("#hostnameupdatesrcrouter").attr("disabled","disabled");
					break;
				case "natstatic":
					jQuery("#extipaddr").removeAttr("disabled");
					jQuery("#exthostname").attr("disabled","disabled");
					jQuery("#hostnameupdatesrcpbx").attr("disabled","disabled");
					jQuery("#hostnameupdatesrcrouter").attr("disabled","disabled");
					break;
				case "natdynamichost":
					jQuery("#extipaddr").attr("disabled","disabled");
					jQuery("#exthostname").removeAttr("disabled");	
					jQuery("#hostnameupdatesrcpbx").removeAttr("disabled");
					jQuery("#hostnameupdatesrcrouter").removeAttr("disabled");
					break;
			}
			dyndns_slide();
		}

	<? elseif ($part == "ready") : ?>

		jQuery("input[@name='hostnameupdatesrc']").click(dyndns_slide);
		jQuery("select[@name='topology']").change(attr_change);
		if (!jQuery("input[@name='hostnameupdatesrc']:checked").val()) {
			jQuery("#hostnameupdatesrcrouter").attr("checked", "checked")
		}
		dyndns_slide();
		attr_change();

	<? else : ?>

		ERROR: no part defined in javascript_dyndns()!

	<? endif;
}

?>