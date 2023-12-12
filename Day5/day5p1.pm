#!/usr/bin/perl
use warnings;
use strict;
use POSIX qw(LONG_MAX);

# This variable contains the solution
my $iteration = 0;
my $lowest_location = LONG_MAX;
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
    
        foreach my $seed (split(' ', $split_array[1]))  
        { 
            push @seeds, int($seed); 
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

for my $seed (@seeds)  
{ 
    my $current_val = $seed;
    for my $set (@seed_to_soil) {
        if ($set->[1] <= $current_val and $set->[2] + $set->[1] >= $current_val) {
            my $offset = $current_val - $set->[1];
            $current_val = $offset + $set->[0];
            last;    
        }
    }

    for my $set (@soil_to_fert) {
        if ($set->[1] <= $current_val and $set->[2] + $set->[1] >= $current_val) {
            my $offset = $current_val - $set->[1];
            $current_val = $offset + $set->[0];
            last;    
        }
    }

    for my $set (@fert_to_water) {
        if ($set->[1] <= $current_val and $set->[2] + $set->[1] >= $current_val) {
            my $offset = $current_val - $set->[1];
            $current_val = $offset + $set->[0];
            last;    
        }
    }

    for my $set (@water_to_light) {
        if ($set->[1] <= $current_val and $set->[2] + $set->[1] >= $current_val) {
            my $offset = $current_val - $set->[1];
            $current_val = $offset + $set->[0];
            last;    
        }
    }

    for my $set (@light_to_temp) {
        if ($set->[1] <= $current_val and $set->[2] + $set->[1] >= $current_val) {
            my $offset = $current_val - $set->[1];
            $current_val = $offset + $set->[0];
            last;    
        }
    }

    for my $set (@temp_to_humid) {
        if ($set->[1] <= $current_val and $set->[2] + $set->[1] >= $current_val) {
            my $offset = $current_val - $set->[1];
            $current_val = $offset + $set->[0];
            last;    
        }
    }

    for my $set (@humid_to_location) {
        if ($set->[1] <= $current_val and $set->[2] + $set->[1] >= $current_val) {
            my $offset = $current_val - $set->[1];
            $current_val = $offset + $set->[0];
            last;    
        }
    }

    if ($current_val < $lowest_location) {
        $lowest_location = $current_val;
    }
}

print $lowest_location;

close(FH);