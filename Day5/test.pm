#!/usr/bin/perl
use strict;
use warnings;
use Time::HiRes qw(gettimeofday tv_interval);

# Number of iterations
my $iterations = 10_000_000_000;

# Start the timer
my $start_time = [gettimeofday];

# Loop
for my $i (1 .. $iterations) {
    # Code inside the loop (replace this with your actual code)
    my $result = $i * 2;
}

# Stop the timer
my $elapsed_time = tv_interval($start_time);

print "Elapsed time: $elapsed_time seconds\n";