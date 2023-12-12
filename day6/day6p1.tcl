#! /bin/env tclsh

set counter 0
set iteration 0
set solution 1
set length 0

# Slurp up the data file
set fp [open "data.txt" r]
set file_data [read $fp]
close $fp

# Process data file

set data [split $file_data "\n"]

foreach line $data {
    if {$iteration == 0} {
        foreach word $line {
            if {$counter != 0} {
                lappend l1 [lindex $word 0]
                incr length
            }
            incr counter
        }
        incr iteration
    } else {
        foreach word $line {
            if {$counter != 0} {
                lappend l2 [lindex $word 0]
            }
            incr counter
        }
    }
    set counter 0
}

 

for {set i 0} {$i < $length} {incr i} {
    set record_beat 0
    set max_time [lindex $l1 $i]
    set dist_record [lindex $l2 $i]
 
    for {set time 0} {$time <= $max_time} {incr time} {
        if {$time * [expr {$max_time - $time}] > $dist_record}  {
            incr record_beat
        }
    }
    set solution [expr {$solution * $record_beat}]
}

puts $solution

exit 0