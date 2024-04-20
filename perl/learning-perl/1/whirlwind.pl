@lines = `perldoc -uf atan2`;
foreach (@lines) {
    s/\w<(.+?)>/\U$1/g;
    print;
}
