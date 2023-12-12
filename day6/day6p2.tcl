#! /bin/env tclsh

set counter 0
set iteration 0
set solution 0
set total_time ""
set dist_record ""
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
                append total_time $word
            }
            incr counter
        }
        incr iteration
    } else {
        foreach word $line {
            if {$counter != 0} {
                append dist_record $word
            }
            incr counter
        }
    }
    set counter 0
}

for {set time 0} {$time <= $total_time} {incr time} {
    if {$time * [expr {$total_time - $time}] > $dist_record}  {
        incr solution
    }
}

puts $solution

exit 0