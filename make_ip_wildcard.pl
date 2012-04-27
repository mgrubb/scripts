#!/usr/bin/env perl
### Author: Michael Grubb <devel@dailyvoid.com>
### File: make_ip_wildcard.pl
### Created: 2012-01-19 23:36
### Copyright: © 2012, Michael Grubb.  All rights reserved.
### Description: This script takes as input a list of ip network ranges and outputs them in wildcard format
use strict; use warnings;

while (<>)
{
	chomp;
	my $line = $_;
	next if $line =~ m/^\s*#/;
	next if $line =~ m/^\s*$/;
	$line =~ s/\s+//g;
	my ($addrA, $addrB) = split(/-/, $line);
	my @addrA = split(/\./, $addrA);
	my @addrB = split(/\./, $addrB);
	my @addrR = ();

	for ( my $i = 0; $i < 4; $i++ )
	{
		if ( $addrA[$i] == $addrB[$i] )
		{
			$addrR[$i] = $addrA[$i];
		}
		elsif ( $addrA[$i] < $addrB[$i] )
		{
			$addrR[$i] = "$addrA[$i]-$addrB[$i]";
		}
		else
		{
			$addrR[$i] = "$addrB[$i]-$addrA[$i]";
		}
	}
	print join('.', @addrR), "\n";
}

# vim:sw=4:ts=4:ai:
