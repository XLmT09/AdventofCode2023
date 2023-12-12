#!/usr/bin/perl
use warnings;
use strict;
use POSIX qw(LONG_MAX);

# This variable contains the solution
my $iteration = 0;
my $filename = 'data.txt';
my @seeds;
# The following are dict like data stucts to hold all 
# possile source to dest combinations
my @seed_to_soil;
my @soil_to_fert;
my @fert_to_water;
my @water_to_light;
my @light_to_temp;
my @temp_to_humid;
my @humid_to_location;


open(FH, '<', $filename) or die $!;

while(<FH>){
    my $is_empty_line = $_;
    $is_empty_line =~ s/^\s+|\s+$//g;

    if ($is_empty_line eq '') {
        $iteration++;
    } 
    elsif ($iteration == 0) {
        my @split_array = split(': ', $_); 
        my @final_split_array = split(' ', $split_array[1]);

        for (my $i = 0; $i < @final_split_array; $i += 2) {
            my @seed_range_pair = (int($final_split_array[$i]), (int($final_split_array[$i]) + int($final_split_array[$i + 1])));
            push @seeds, \@seed_range_pair;
        }
    } 
    elsif (index($_, ":") != -1) {
        
        next;
    } 
    elsif ($iteration == 1) {
        my @split_array = split(' ', $_); 
        my @vals = (int($split_array[0]), int($split_array[1]), int($split_array[2]));
        push @seed_to_soil, \@vals;
    }
    elsif ($iteration == 2) {
        my @split_array = split(' ', $_); 
        my @vals = (int($split_array[0]), int($split_array[1]), int($split_array[2]));
        push @soil_to_fert, \@vals;
    }
    elsif ($iteration == 3) {
        my @split_array = split(' ', $_); 
        my @vals = (int($split_array[0]), int($split_array[1]), int($split_array[2]));
        push @fert_to_water, \@vals;
    }
    elsif ($iteration == 4) {
        my @split_array = split(' ', $_); 
        my @vals = (int($split_array[0]), int($split_array[1]), int($split_array[2]));
        push @water_to_light, \@vals;
    }
    elsif ($iteration == 5) {
        my @split_array = split(' ', $_); 
        my @vals = (int($split_array[0]), int($split_array[1]), int($split_array[2]));
        push @light_to_temp, \@vals;
    }
    elsif ($iteration == 6) {
        my @split_array = split(' ', $_); 
        my @vals = (int($split_array[0]), int($split_array[1]), int($split_array[2]));
        push @temp_to_humid, \@vals;
    }
    elsif ($iteration == 7) {
        my @split_array = split(' ', $_); 
        my @vals = (int($split_array[0]), int($split_array[1]), int($split_array[2]));
        push @humid_to_location, \@vals;
    }
}

sub update_current_val {
    my ($sets, $current_val) = @_;

    for my $set (@$sets) {
        if ($set->[0] <= $current_val and $set->[2] + $set->[0] > $current_val) {
            my $offset = $current_val - $set->[0];
            return $offset + $set->[1];
        }
    }

    return $current_val;
}

my $solution_found = 0;
my $current_location = 0;

while ($solution_found != 1) {
    my $current_val = $current_location;

    $current_val = update_current_val(\@humid_to_location, $current_val);
    $current_val = update_current_val(\@temp_to_humid, $current_val);
    $current_val = update_current_val(\@light_to_temp, $current_val);
    $current_val = update_current_val(\@water_to_light, $current_val);
    $current_val = update_current_val(\@fert_to_water, $current_val);
    $current_val = update_current_val(\@soil_to_fert, $current_val);
    $current_val = update_current_val(\@seed_to_soil, $current_val);

    for my $seed_range_pair (@seeds) {
        if ($seed_range_pair->[0] <= $current_val and $seed_range_pair->[1] > $current_val) {
            $solution_found = 1;
            print $current_location;
            last;
        }
    }

    $current_location++;
}

close(FH);