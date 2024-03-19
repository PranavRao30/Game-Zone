#!/bin/bash

# File containing a list of words, one word per line
words_file="word_list.txt"

# Function to scramble a word
scramble_word() {
    local original_word=$1
    echo "$original_word" | awk 'BEGIN{srand();}{split($0, a, ""); n = length; for (i = 1; i <= n; i++) { j = int(rand() * n) + 1; temp = a[i]; a[i] = a[j]; a[j] = temp; } for (i = 1; i <= n; i++) printf a[i]; print "";}'
}

# Function to check if the player's guess is correct
check_guess() {
    local scrambled_word=$1
    local player_guess=$(zenity --entry --text="Unscramble the word: $scrambled_word" --title="Word Scramble" --entry-text="")
    if [[ "$player_guess" == "$word" ]]; then
        zenity --info --text="Correct! Well done." --title="Word Scramble"
    else
        zenity --info --text="Incorrect. The correct word is: $word" --title="Word Scramble"
    fi
}

# Main game logic
main() {
    if [ ! -f "$words_file" ]; then
        zenity --error --text="Word list file '$words_file' not found. Please create the file with one word per line." --title="Error"
        exit 1
    fi

    # Read words from the file into an array
    mapfile -t word_list < "$words_file"

    # Select a random word from the list
    word=${word_list[$((RANDOM % ${#word_list[@]}))]}

    # Scramble the word
    scrambled_word=$(scramble_word "$word")

    # Ask the player to unscramble the word
    check_guess "$scrambled_word"
}

# Start the game
main