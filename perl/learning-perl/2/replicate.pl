#!/bin/perl

my $str = <STDIN>; # no chomp so string is printed on seperatn lines
chomp(my $num = <STDIN>);
print $str x $num;
