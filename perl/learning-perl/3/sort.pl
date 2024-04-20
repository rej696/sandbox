#!/bin/perl

# multiple lines
my @lines = <STDIN>;
print sort @lines;

#one line
chomp @lines;
print join(" " , sort @lines) . "\n" ;
