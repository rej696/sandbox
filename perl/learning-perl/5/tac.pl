my @lines;
while (<>) {
    unshift @lines, $_;
}

print for @lines;
