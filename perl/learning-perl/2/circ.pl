#!/bin/perl

use Math::Trig;

chomp(my $rad = <STDIN>);
$rad = 0 if $rad < 0;
my $circ = $rad * 2 * pi;
print "$circ\n"
