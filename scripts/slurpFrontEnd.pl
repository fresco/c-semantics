#!/usr/bin/perl
use strict;
use File::Basename;
use File::Spec::Functions qw(rel2abs catfile);
my $myDirectory = dirname(rel2abs($0));
my $slurpScript = catfile($myDirectory, 'slurp.pl');
require $slurpScript;
my $input = <>;
chomp($input);
print slurp($input);
