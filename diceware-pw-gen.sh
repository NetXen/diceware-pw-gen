#!/bin/bash

# Diceware Password Generator
# Generates passwords using the diceware method and outputs results to CSV

# Configuration
WORDLIST_URL="https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt"
WORDLIST_FILE="eff_large_wordlist.txt"
OUTPUT_FILE="diceware_passwords.csv"
NUM_WORDS=6
ENTROPY_PER_WORD=12.9 # log2(7776) bits per word

# Download wordlist if it doesn't exist
if [ ! -f "$WORDLIST_FILE" ]; then
    echo "Downloading wordlist..."
    curl -s -o "$WORDLIST_FILE" "$WORDLIST_URL"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download wordlist"
        exit 1
    fi
fi

# Function to generate random dice rolls
generate_rolls() {
    for i in {1..5}; do
        echo -n "$((RANDOM % 6 + 1))"
    done
}

# Function to calculate total entropy
calculate_entropy() {
    echo "$NUM_WORDS * $ENTROPY_PER_WORD" | bc
}

# Create CSV header
echo "Roll Numbers,Words,Password,Entropy (bits)" > "$OUTPUT_FILE"

# Generate password
rolls=()
words=()
password=""

for i in {1..6}; do
    # Generate dice rolls
    roll=$(generate_rolls)
    rolls+=("$roll")
    
    # Look up word in wordlist
    word=$(grep "^$roll" "$WORDLIST_FILE" | cut -f2)
    if [ -z "$word" ]; then
        echo "Error: Failed to find word for roll $roll"
        exit 1
    fi
    words+=("$word")
    
    # Build password
    if [ -n "$password" ]; then
        password="$password$word"
    else
        password="$word"
    fi
done

# Calculate entropy
entropy=$(calculate_entropy)

# Format arrays for CSV
rolls_str=$(IFS=","; echo "${rolls[*]}")
words_str=$(IFS=","; echo "${words[*]}")

# Write to CSV
echo "\"$rolls_str\",\"$words_str\",\"$password\",$entropy" >> "$OUTPUT_FILE"

echo "Password generated and saved to $OUTPUT_FILE"

# Display the generated password
echo -e "\nGenerated Password: $password"
echo "Entropy: $entropy bits"