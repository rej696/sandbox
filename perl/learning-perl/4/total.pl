
# Q1
sub total {
    # my @input = @_;
    my $total = 0;
    $total += $_ for @_;
    return $total;
}


my @fred = qw/ 1 3 5 7 9/;
my $fred_total = total(@fred);
print "The total of \@fred is $fred_total.\n";
print "Enter some numbers on seperate lines: ";
# my $user_total = total(<STDIN>);
my $user_total = total(@fred);
print "The total of those numbers is $user_total.\n";

# Q2
my $part2_total = total(1..1000);
print "The total of part2 is $part2_total.\n";

# Q3
sub average {
    my $total = total(@_);
    $total / @_;
}

sub above_average {
    my $average = average(@_);
    my @result;
    for (@_) {
        push @result, $_ if $_ > $average;
    }
    return @result;
}

my @fred = above_average(1..10);
print "\@fred is @fred\n";
print "(Should be 6 7 8 9 10)\n";
my @barney = above_average(100, 1..10);
print "\@barney is @barney\n";
print "(Should be just 100)\n";


# Q4,5
use v5.10;

sub greet {
    my ($name) = shift;
    state @last;
    if (@last) {
        print "Hi $name! I've seen: @last\n";
    } else {
        print "Hi $name, you are the first one here!\n";
    }
    push @last, $name;
}

greet("Fred");
greet("Barney");
greet("Wilma");
greet("Betty");
