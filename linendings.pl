#!/usr/local/bin/perl
use strict; use warnings;

my $lineending = "\n";

my $type = shift @ARGV;

if( $type =~ /unix/ ) {
        $lineending = "\012";
} elsif( $type =~ /dos/ ) {
        $lineending = "\015\012";
} elsif( $type =~ /mac/ ) {
        $lineending = "\015";
} else {
        print "Usage: $0 --unix|--dos|--mac\n";
        exit 1;
}

my @files = @ARGV;

for my $file ( @files ) {
        open FILE, $file or next;        # thanks turnstep
        my @lines = <FILE>;
        close FILE;

        foreach my $i ( 0..$#lines ) {
                $lines[$i] =~ s/(\012|\015\012?)/$lineending/g;
        }

        open FILE,">$file";
        print FILE @lines;
        close FILE;
}


# vim:sw=2:ts=2:sts=2:et:ai:
