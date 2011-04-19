<?php
// This script implements a mass banning tool for phpbb
// It bans by both username and ip it reads it's input from a file

define('IN_PHPBB', true);
define('IN_CRON', true);

$phpbb_root_path = (defined('PHPBB_ROOT_PATH'))
	? PHPBB_ROOT_PATH
	: '/home/mgrubb/public_html/verusvia.org/';

$phpEx = substr(strrchr(__FILE__, '.'), 1);

include($phpbb_root_path . 'common.' . $phpEx);
include($phpbb_root_path . 'includes/functions_user.' . $phpEx);

$user->session_begin(false);
$auth->acl($user->data);

// Get user list
$banFile = $phpbb_root_path . 'bantool/banlist.txt';
$fh = fopen($banFile, 'r');
$banList = array();

if ( $fh )
{
	while (!feof($fh))
	{
		$line = trim(fgets($fh));
		if ( $line == "" )
			continue;
		$banList[strtolower($line)] = 1;
	}
	fclose($fh);
}

$sql = 'SELECT user_id id, user_ip ip, user_email email FROM ' . USERS_TABLE .
		' WHERE username_clean = \'%s\'';

foreach ($banList as $banUser => &$userInfos )
{

//	printf("$sql\n", $banUser);
	$result = $db->sql_query(sprintf($sql, $banUser));
	$userInfos = $db->sql_fetchrow($result);
	$db->sql_freeresult($result);
//	printf("User: '%s', IP: '%s', EMAIL: '%s'\n", $banUser, $userInfos['ip'], $userInfos['email']);
}
unset($userInfos);

foreach ($banList as $user => $info)
{
	if ( defined($info['ip']) )
	{
		user_ban('ip', $info['ip'], 0, 0, false, "Spam User");
	}

	if ( defined($info['email']) )
	{
		user_ban('email', $info['email'], 0, 0, false, "Spam User");
	}

	user_delete('remove', $info['id']);
}
?>
