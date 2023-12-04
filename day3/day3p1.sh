#!/bin/bash
declare -A matrix

max_row=$(wc -l < data.txt)
max_col=$(head -n 1 data.txt | wc -c)
max_col=$((max_col - 1))

row=0
col=0
solution=0
current_number=-1
has_symbol=false

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

is_symbol() {
    local char_check="${matrix[$neigh_row,$neigh_col]}"
    if [[ "$char_check" == *[@#\$%\&*+=/-]* ]]; then
        has_symbol=true
    fi
}

has_adjacent_symbol() {
    # Check above
    neigh_row=$row
    neigh_col=$col

    # Check if has symbol top
    ((neigh_row--))
    if ((neigh_row >= 0)); then
        is_symbol $neigh_row $neigh_col
        if [[ "$has_symbol" == true ]]; then
            return
        fi
    fi

    # Check if has symbol top right
    ((neigh_col++))
    if ((neigh_row >= 0 && neigh_col <= max_col)); then
        is_symbol $neigh_row $neigh_col
        if [[ "$has_symbol" == true ]]; then
            return
        fi
    fi

    # Check if has symbol right
    ((neigh_row++))
    if ((neigh_col <= max_col)); then
        is_symbol $neigh_row $neigh_col
        if [[ "$has_symbol" == true ]]; then
            return
        fi
    fi

    # Check if has symbol bottom right
    ((neigh_row++))
    if ((neigh_row <= max_row && neigh_col <= max_col)); then
        is_symbol $neigh_row $neigh_col
        if [[ "$has_symbol" == true ]]; then
            return
        fi
    fi

    # Check if has symbol bottom 
    ((neigh_col--))
    if ((neigh_row <= max_row)); then
        is_symbol $neigh_row $neigh_col
        if [[ "$has_symbol" == true ]]; then
            return
        fi
    fi

    # Check if has symbol bottom left 
    ((neigh_col--))
    if ((neigh_row <= max_row && neigh_col >= 0)); then
        is_symbol $neigh_row $neigh_col
        if [[ "$has_symbol" == true ]]; then
            return
        fi
    fi

    # Check if has symbol left 
    ((neigh_row--))
    if ((neigh_col >= 0)); then
        is_symbol $neigh_row $neigh_col
        if [[ "$has_symbol" == true ]]; then
            return
        fi
    fi

    # Check if has symbol top left 
    ((neigh_row--))
    if ((neigh_row >= 0 && neigh_col >= 0)); then
        is_symbol $neigh_row $neigh_col
        if [[ "$has_symbol" == true ]]; then
            return
        fi
    fi
}

get_number() {
    local digit="${matrix[$row,$col]}"
    current_number=$((10#$digit))
    local c=$((col + 1))  # Initialize c with col + 1
    while [[ "${matrix[$row,$c]}" =~ [0-9] ]]; do
        digit="${matrix[$row,$c]}"
        current_number=$((current_number * 10 + 10#$digit))
        ((c++))
    done
}

clear_values() {
    local c=$col  
    while [[ "${matrix[$row,$c]}" =~ [0-9] ]]; do
        matrix[$row,$c]='.'
        ((c++))
    done
}

for ((row=0; row<=max_row; row++)); do
    current_number=-1
    for ((col=0; col<max_col; col++)); do
        current_char="${matrix[$row,$col]}"

        if [[ "$current_char" =~ [0-9] ]]; then
            if [ "$current_number" == -1 ]; then
                get_number $row $col
            fi

            has_adjacent_symbol $row $col
            if [[ "$has_symbol" == true ]]; then
                ((solution += current_number))
                clear_values $row $col
                has_symbol=false 
                current_number=-1
            fi
        fi

        if [ "$current_char" == '.' ]; then
            current_number=-1
        fi  
    done
done

echo $solution