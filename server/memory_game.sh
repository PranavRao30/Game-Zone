#!/bin/bash

generate_number() {
    echo $((RANDOM % 10))
}

display_sequence() {
    local sequence=$1
    echo "Memorize the sequence: $sequence"
    sleep 2
    clear
}

check_input() {
    local sequence=$1
    read -p "Enter the sequence: " user_input
    user_input=$(echo "$user_input" | tr -d ' ')
    sequence=$(echo "$sequence" | tr -d ' ')
    if [ "$user_input" == "$sequence" ]; then
        echo "Correct sequence. Continue."
    else
        echo "Incorrect sequence. Game over!"
        echo "Correct sequence was: $sequence"
        echo "You cleared $((level - 1)) levels."
        exit 1
    fi
}

main() {
    local level=1
    local sequence=""

    while true; do
        sequence="$sequence $(generate_number)"
        display_sequence "$sequence"

        if ! check_input "$sequence"; then
            exit 1
        fi

        ((level++))
    done
}

main
