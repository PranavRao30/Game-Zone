#!/bin/bash

# Initialize the Tic-Tac-Toe board
board=(" " " " " " " " " " " " " " " " " ")

# Function to display the Tic-Tac-Toe board using Zenity
display_board() {
    local board_str=""
    for ((i = 0; i < 9; i++)); do
        board_str+=" ${board[i]} |"
        if (( (i + 1) % 3 == 0 )); then
            board_str="${board_str%|}\n-----------\n"
        fi
    done
    board_str="${board_str%|}"
    zenity --info --width=200 --height=200 --text="$board_str" --title="Tic-Tac-Toe"
}

# Function to check if a player has won
check_winner() {
    local player=$1
    # Check rows, columns, and diagonals for a win
    if [[ ${board[0]} == $player && ${board[1]} == $player && ${board[2]} == $player ]] ||
       [[ ${board[3]} == $player && ${board[4]} == $player && ${board[5]} == $player ]] ||
       [[ ${board[6]} == $player && ${board[7]} == $player && ${board[8]} == $player ]] ||
       [[ ${board[0]} == $player && ${board[3]} == $player && ${board[6]} == $player ]] ||
       [[ ${board[1]} == $player && ${board[4]} == $player && ${board[7]} == $player ]] ||
       [[ ${board[2]} == $player && ${board[5]} == $player && ${board[8]} == $player ]] ||
       [[ ${board[0]} == $player && ${board[4]} == $player && ${board[8]} == $player ]] ||
       [[ ${board[2]} == $player && ${board[4]} == $player && ${board[6]} == $player ]]; 
       then
        zenity --info --text="Player $player wins!" --title="Game Over"
        exit 0
    fi
}

# Function to check if the board is full (a tie)
check_tie() {
    for cell in "${board[@]}"; do
        if [[ $cell == " " ]]; then
            return
        fi
    done
    zenity --info --text="It's a tie!" --title="Game Over"
    exit 0
}

# Function to get player's move using Zenity
get_move() {
    local player=$1
    local valid=false

    while [ "$valid" == false ]; do
        move=$(zenity --entry --text="Player $player, enter your move (1-9):" --title="Tic-Tac-Toe" --entry-text="")
        if [[ ! $move =~ ^[1-9]$ ]]; then
            zenity --info --text="Invalid input. Please enter a number between 1 and 9." --title="Error"
        elif [[ ${board[$((move-1))]} != " " ]]; then
            zenity --info --text="Invalid move. Cell already taken. Choose an empty cell." --title="Error"
        else
            valid=true
        fi
    done

    board[$((move-1))]=$player
}

# Main game loop
main() {
    while true; do
        display_board
        get_move "X"
        check_winner "X"
        check_tie

        display_board
        get_move "O"
        check_winner "O"
        check_tie
    done
}