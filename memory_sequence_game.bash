#!/bin/bash

generate_number() {
    echo $((RANDOM % 9 + 1))
}

display_sequence() {
    local sequence=$1
    zenity --info --title="Memory Sequence" --text="Memorize the sequence: $sequence" --width=200 --height=100
    clear
}

check_input() {
    local sequence="$1"

    local user_input=$(zenity --entry --title="Memory Sequence" --text="Enter the sequence:")
    user_input=$(echo "$user_input" | tr -d ' ')
    sequence=$(echo "$sequence" | tr -d ' ')

    if [ "$user_input" == "$sequence" ]; then
        return 0
    else
        zenity --info --title="Memory Sequence" --text="Incorrect sequence. Game over!\nYou entered: $user_input\nCorrect sequence was: $sequence\nYou cleared $((level - 1)) levels."
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
