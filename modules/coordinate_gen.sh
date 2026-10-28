#! /bin/bash

# =========================================================================
# MODULE: coordinate_gen.sh
# PURPOSE: Procedurally generates authentic Star Wars galactic sectors
# OUTPUT: Prints a string to stdout (e.g., "Mytaranor Sector, Grid K-16")
# =========================================================================

generate_coordinates() {
    #Array of Star Wars galactic sectors and regions
    local sectors=(
        "Mytaranor Sector"
        "Anoat Sector"
        "Arkanis Sector"
        "Coruscant Sector"
        "Chommell Sector"
        "Caladri Sector"
        "Corporate Sector"
        "Outer Rim Frontier"
        "Mid Rim Expansion Grid"
    )

    #Array of alphabet letters for grid coordinates
    local grid_letters=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "X" "Z")

    #Picks a random sector from the array
    #$RANDOM % ${#sectors[@]} calculates a random index based on the size of the array
    local random_sector_index=$(( RANDOM % ${#sectors[@]} ))
    local selected_sector="${sectors[$random_sector_index]}"

    # Pick a random letter for the grid
    local random_letter_index=$(( RANDOM % ${#grid_letters[@]} ))
    local selected_letter="${grid_letters[$random_letter_index]}"

    # Generate a random number between 1 and 99 for the grid identifier
    local selected_number=$(( (RANDOM % 99) + 1 ))

    # Output the final combined string so the main controller can capture it
    echo "${selected_sector}, Grid ${selected_letter}-${selected_number}"

}

# This allows the script to be tested directly when run on its own
generate_coordinates 