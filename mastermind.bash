#!/bin/bash

# Function to generate a random 4-digit code
generate_code() {
    echo "$((RANDOM % 10 ))$((RANDOM % 10 ))$((RANDOM % 10))$((RANDOM % 10))"
}

# Function to provide feedback using ASCII characters
provide_feedback() {
    local guess=$1
    local code=$2

    feedback=""

    for ((i = 0; i < 4; i++)); do
        if [ "${guess:$i:1}" == "${code:$i:1}" ]; then
            feedback+="● "
        elif [[ "${code}" == *"${guess:$i:1}"* ]]; then
            feedback+="○ "
        else
            feedback+="× "
        fi
    done

    echo "Guess: $guess"
    echo "Code: $feedback"
}

# Main game logic
main() {
    echo "Welcome to Mastermind!"
    echo "Try to guess the 4-digit code. Each digit represents a color."

    # Generate the secret code
    secret_code=$(generate_code)

    while true; do
        player_guess=$(zenity --entry --title="Mastermind" --text="Enter your guess:" --entry-text="$player_guess")

        # Validate the input
        if [[ ! $player_guess =~ ^[0-9]{4}$ ]]; then
            zenity --error --title="Error" --text="Invalid input. Please enter a 4-digit code using digits 0 to 9."
            continue
        fi

        # Provide feedback
        feedback=$(provide_feedback "$player_guess" "$secret_code")

        # Display feedback using Zenity
        zenity --info --title="Mastermind" --text="$feedback" --width=200 --height=100
         # Check if the player guessed correctly
        if [ "$player_guess" == "$secret_code" ]; then
            zenity --info --title="Mastermind" --text="Congratulations!\nYou guessed the correct code: $secret_code" --width=200 --height=100
            break
        fi
    done
}

# Start the game
main