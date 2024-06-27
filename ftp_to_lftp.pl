#!/usr/bin/perl

use warnings;
use strict;
use Carp;
$SIG{__WARN__} = \&confess;


my $port = 2222;
my $server;
my $user;
my $pass;

#expected input:
# SFTP Access:
# sftp -o Port=2222 user@server
# sftp -P 2222 user@server
# HTTPS Access:
# https://server/hprc/
# Login: user
# Password: ...

print "paste in ftp details from CASE FTP Link in SFDC, then newline then ctrl-D\n";
while (<>) {
	if (/sftp -o Port=(\d+) (\w+)@(.*)/) {
		$port = $1;
		$user = $2;
		$server = $3;
	}
	if (/Password: (.*)/) {
		$pass = $1;
	}
}

if ($port ne "" && $server ne "" && $user ne "" && $pass ne "") {
	print "\nlftp command to run and re-use from shell history (i.e. make sure to combine with cd):\n\n";
	print "cd /path/to/casedata ; lftp -e \'mirror ; exit\'  -u \'$user,$pass\' -p $port sftp://$server\n\n";
} else {
	print "failed to parse info from input, values parsed =\n";
	print "port = $port\n";
	print "server = $server\n";
	print "user = $user\n";
	print "pass = $pass\n";
}
