# diceware-pw-gen

## Description:  
Generates passwords using the Diceware method and outputs results to CSV.  

## Overview:
This is a password generator that uses the Diceware method, which creates passwords by randomly selecting words from a predefined wordlist.  
The script generates a 6-word password and saves the results to a CSV file.  

## Configuration:
It uses the EFF's large wordlist (a curated list of words for password generation).  
Each word provides about 12.9 bits of entropy (a measure of randomness/security).  
The results are saved to a CSV file.  

## Wordlist Download:
The script first checks if the wordlist exists locally. If not, it downloads it from the EFF website using curl.  

## Core Functions:
generate_rolls(): Simulates rolling five dice by generating five random numbers between 1-6  
calculate_entropy(): Calculates the total entropy of the password by multiplying the number of words by the entropy per word  

## Password Generation Process:
Creates arrays to store the dice rolls and selected words.  
For each of the 6 words:  
- Generates 5 random dice rolls  
- Uses these rolls to look up a word in the wordlist (each word in the list has a 5-digit number)  
- Adds the word to the password  
- Stores both the rolls and words for CSV output  

## Output:
Creates a CSV file with columns for:
- The dice roll numbers used  
- The words selected  
- The final password  
- The entropy (measure of password strength)  

The script also displays the generated password and its entropy on screen.  

## Justification:
The Diceware method is particularly secure because:  
- It uses truly random words rather than predictable patterns  
- The resulting passwords are easier to remember than random characters  
- With 6 words, you get about 77.4 bits of entropy (6 × 12.9), which is very strong  
- The EFF wordlist is specifically designed to be memorable and avoid similar-looking words  
    
**Enjoy!**
