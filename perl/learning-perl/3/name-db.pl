#!/bin/perl

my @lines = <STDIN>;
my @names = qw/fred betty barney dino wilma pebbles bamm-bamm/;

# create a list of names with each input
my $result = [ map { $names[$_] } @lines ];

# the quotes are needed to interpolate the list of strings with spaces
print "@$result\n";

# alternative implementation
foreach (@lines) {
    print "$names[$_]\n";
}

# third implementation
print map {$names[$_] . "\n"} @lines;
