use warnings;
use strict;

my @lines;
while(<STDIN>) {
    push @lines, $_;
}

print "12345678901234567890123456789012345678901234567890\n";
my $width = shift @lines;

printf "%*s\n", $width , $_ for @lines;

