#!/bin/bash
declare -A matrix

max_row=$(wc -l < data.txt)
max_col=$(head -n 1 data.txt | wc -c)
max_col=$((max_col - 1))

row=0
col=0
solution=0
current_number=-1
has_two_gears=false
gear_count=0
gear_ratio_value=0

while IFS= read -r -n 1 char; do
  # Check if the character is a newline
  # If so increment row and reset col back to 0
  if [ "$char" == '' ]; then
    ((row++))
    col=0
    continue
  fi
  # This is a corner case wont check for the '*' char unless i add this
  if [ "$char" == '$*' ]; then
    matrix[$row,$col]='*'
    continue
  fi

  matrix[$row,$col]=$char
  ((col++))
done < "data.txt"

check_two_gears() {
    # Check above
    neigh_row=$row
    neigh_col=$col
    local g1=0
    local g2=0
    local neigh_char=''

    # Check if has symbol top
    ((neigh_row--))
    if ((neigh_row >= 0)); then
        neigh_char="${matrix[$neigh_row,$neigh_col]}"
        if [[ "$neigh_char" =~ [0-9] ]]; then
            get_number $neigh_row $neigh_col
            if ((g1 == 0)); then
                g1=$current_number
                ((gear_count++))
            elif ((current_number != g1 && current_number != g2)); then
                g2=$current_number
                ((gear_count++))
            fi
        fi
    fi

    # Check if has symbol top right
    ((neigh_col++))
    if ((neigh_row >= 0 && neigh_col <= max_col)); then
        neigh_char="${matrix[$neigh_row,$neigh_col]}"
        if [[ "$neigh_char" =~ [0-9] ]]; then
            get_number $neigh_row $neigh_col
            if ((g1 == 0)); then
                g1=$current_number
                ((gear_count++))
            elif ((current_number != g1 && current_number != g2)); then
                g2=$current_number
                ((gear_count++))
            fi
        fi
    fi

    # Check if has symbol right
    ((neigh_row++))
    if ((neigh_col <= max_col)); then
        neigh_char="${matrix[$neigh_row,$neigh_col]}"
        if [[ "$neigh_char" =~ [0-9] ]]; then
            get_number $neigh_row $neigh_col
            if ((g1 == 0)); then
                g1=$current_number
                ((gear_count++))
            elif ((current_number != g1 && current_number != g2)); then
                g2=$current_number
                ((gear_count++))
            fi
        fi
    fi

    # Check if has symbol bottom right
    ((neigh_row++))
    if ((neigh_row <= max_row && neigh_col <= max_col)); then
        neigh_char="${matrix[$neigh_row,$neigh_col]}"
        if [[ "$neigh_char" =~ [0-9] ]]; then
            get_number $neigh_row $neigh_col
            if ((g1 == 0)); then
                g1=$current_number
                ((gear_count++))
            elif ((current_number != g1 && current_number != g2)); then
                g2=$current_number
                ((gear_count++))
            fi
        fi
    fi

    # Check if has symbol bottom 
    ((neigh_col--))
    if ((neigh_row <= max_row)); then
        neigh_char="${matrix[$neigh_row,$neigh_col]}"
        if [[ "$neigh_char" =~ [0-9] ]]; then
            get_number $neigh_row $neigh_col
            if ((g1 == 0)); then
                g1=$current_number
                ((gear_count++))
            elif ((current_number != g1 && current_number != g2)); then
                g2=$current_number
                ((gear_count++))
            fi
        fi
    fi

    # Check if has symbol bottom left 
    ((neigh_col--))
    if ((neigh_row <= max_row && neigh_col >= 0)); then
        neigh_char="${matrix[$neigh_row,$neigh_col]}"
        if [[ "$neigh_char" =~ [0-9] ]]; then
            get_number $neigh_row $neigh_col
            if ((g1 == 0)); then
                g1=$current_number
                ((gear_count++))
            elif ((current_number != g1 && current_number != g2)); then
                g2=$current_number
                ((gear_count++))
            fi
        fi
    fi

    # Check if has symbol left 
    ((neigh_row--))
    if ((neigh_col >= 0)); then
        neigh_char="${matrix[$neigh_row,$neigh_col]}"
        if [[ "$neigh_char" =~ [0-9] ]]; then
            get_number $neigh_row $neigh_col
            if ((g1 == 0)); then
                g1=$current_number
                ((gear_count++))
            elif ((current_number != g1 && current_number != g2)); then
                g2=$current_number
                ((gear_count++))
            fi
        fi
    fi

    # Check if has symbol top left 
    ((neigh_row--))
    if ((neigh_row >= 0 && neigh_col >= 0)); then
        neigh_char="${matrix[$neigh_row,$neigh_col]}"
        if [[ "$neigh_char" =~ [0-9] ]]; then
            get_number $neigh_row $neigh_col
            if ((g1 == 0)); then
                g1=$current_number
                ((gear_count++))
            elif ((current_number != g1 && current_number != g2)); then
                g2=$current_number
                ((gear_count++))
            fi
        fi
    fi

    if ((gear_count==2)); then
        gear_ratio_value=$((g1*g2))
    fi
}


get_number() {
    local c=$neigh_col

    # Start from the beginning of the number and then extract it
    while [[ "${matrix[$neigh_row,$c]}" =~ [0-9] ]]; do
        ((c--))
    done

    ((c++))
    local digit="${matrix[$neigh_row,$c]}"
    current_number=$((10#$digit))
    ((c++))
    
    while [[ "${matrix[$neigh_row,$c]}" =~ [0-9] ]]; do
        digit="${matrix[$neigh_row,$c]}"
        current_number=$((current_number * 10 + 10#$digit))
        ((c++))
    done
}

# Access and print values from the matrix
for ((row=0; row<=max_row; row++)); do
    for ((col=0; col<max_col; col++)); do
        current_char="${matrix[$row,$col]}"

        if [[ "$current_char" == '*' ]]; then
            check_two_gears $row $col

            if ((gear_count == 2)); then
                ((solution += gear_ratio_value))
            fi

            gear_count=0
        fi
    done
done

echo $solution