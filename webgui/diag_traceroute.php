#!/usr/local/bin/php
<?php
/*
	$Id$
	part of m0n0wall (http://m0n0.ch/wall)

	Copyright (C) 2005-2006 Paul Taylor (paultaylor@winndixie.com) and Manuel Kasper <mk@neon1.net>.
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

$pgtitle = array(gettext("Diagnostics"), gettext("Traceroute"));
require("guiconfig.inc");


define('MAX_TTL', 64);
define('DEFAULT_TTL', 18);

if ($_POST) {
	unset($input_errors);
	unset($do_traceroute);

	/* input validation */
	$reqdfields = explode(" ", "host ttl");
	$reqdfieldsn = explode(",", gettext("Host,ttl"));
	do_input_validation($_POST, $reqdfields, $reqdfieldsn, &$input_errors);

	if (($_POST['ttl'] < 1) || ($_POST['ttl'] > MAX_TTL)) {
		$input_errors[] = sprintf(gettext("Maximum number of hops must be between 1 and %d"), MAX_TTL);
	}

	if (!$input_errors) {
		$do_traceroute = true;
		$host = $_POST['host'];
		$ttl = $_POST['ttl'];
		$resolve = $_POST['resolve'];
	}
}
if (!isset($do_traceroute)) {
	$do_traceroute = false;
	$host = '';
	$ttl = DEFAULT_TTL;
	$resolve = false;
}
?>
<?php include("fbegin.inc"); ?>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td class="tabnavtbl">
  <ul id="tabnav">
<?php 
   	$tabs = array(gettext('Ping') => 'diag_ping.php',
           	      gettext('Traceroute') => 'diag_traceroute.php');
	dynamic_tab_menu($tabs);
?> 
  </ul>
  </td></tr>
  <tr> 
    <td class="tabcont">
<?php if ($input_errors) print_input_errors($input_errors); ?>
			<form action="diag_traceroute.php" method="post" name="iform" id="iform">
			  <table width="100%" border="0" cellpadding="6" cellspacing="0">
                <tr>
				  <td width="22%" valign="top" class="vncellreq"><?=gettext("Host");?></td>
				  <td width="78%" class="vtable"> 
                    <?=$mandfldhtml;?><input name="host" type="text" class="formfld" id="host" size="20" value="<?=htmlspecialchars($host);?>"></td>
				</tr>
				<tr>
				  <td width="22%" valign="top" class="vncellreq"><?=gettext("Maximum number of hops");?></td>
				  <td width="78%" class="vtable">
					<select name="ttl" class="formfld" id="ttl">
					<?php for ($i = 1; $i <= MAX_TTL; $i++): ?>
					<option value="<?=$i;?>" <?php if ($i == $ttl) echo "selected"; ?>><?=$i;?></option>
					<?php endfor; ?>
					</select></td>
				</tr>
				  <tr> 
					<td valign="top" class="vtable">&nbsp;</td>
					<td class="vtable"> <input name="resolve" type="checkbox" id="resolve" value="yes" <?php if ($resolve) echo "checked"; ?>>
					  <strong><?=gettext("Resolve IP addresses to hostnames");?></strong><br>
					</td>
				  </tr>
				<tr>
				  <td width="22%" valign="top">&nbsp;</td>
				  <td width="78%"> 
                    <input name="Submit" type="submit" class="formbtn" value="<?=gettext("Traceroute");?>">
				</td>
				</tr>
				<tr>
				<td valign="top" colspan="2">
				<p><span class="vexpl"><span class="red"><strong><?=gettext("Note:");?></strong></span><?=gettext(" Traceroute may take a while to complete.  You may hit the Stop button on your browser at any time to see the progress of failed traceroutes.");?><p>
				<? if ($do_traceroute) {
					echo('<br><strong>');
					echo gettext("Traceroute output:");
					echo('</strong><br>');
					echo('<pre>');
					ob_end_flush();
					system("/usr/sbin/traceroute " . ($resolve ? "" : "-n ") . "-w 2 -m " . escapeshellarg($ttl) . " " . escapeshellarg($host));
					echo('</pre>');
				}
				?>
				</td>
				</tr>
			</table>
</form>
</td></tr></table>
<?php include("fend.inc"); ?>
