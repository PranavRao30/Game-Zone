#!/bin/bash

select_game() {
    game_choice=$(zenity --list --title="Game Zone" --column="Games" \
                    "Memory Sequence" "Tic Tac Toe" "Word Scramble" "MasterMind" "Exit")

    if [ $? -ne 0 ]; then
        exit 0
    fi

    case $game_choice in
        "Memory Sequence")
            ./memory_sequence_game.bash
            ;;
        "Tic Tac Toe")
            ./tictactoe.bash
            ;;
        "Word Scramble")
            ./word_scramble.bash
            ;;
        "MasterMind")
            ./mastermind.bash
            ;;
        "Exit")
            exit 0
            ;;
        *)
            zenity --error --title="Error" --text="Invalid selection. Please try again."
            ;;
    esac
}

# Main loop for the game menu
while :
do
    select_game
done

