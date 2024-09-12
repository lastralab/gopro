#!/bin/bash
# Tanismo - GoPro Concatenator

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_error() {
    echo -e "${RED}$1${NC}"
}

check_file_size_and_run() {
    local file=$1
    local size_limit=2147483648 

    if [ -f "$file" ] && [ $(stat -c%s "$file") -gt $size_limit ]; then
        local new_file="_${file}"
        run_command "ffmpeg -i \"$file\" -filter:v \"setpts=0.5*PTS\" \"$new_file\" > /dev/null 2>&1" "Reducing size of $file"
        run_command "rm \"$file\"" "Removing original $file"
        run_command "mv \"$new_file\" \"$file\"" "Renaming $new_file to $file"
    fi
}

run_command() {
    local cmd=$1
    local description=$2

    eval "$cmd"
    if [ $? -eq 0 ]; then
        print_success "$description"
    else
        print_error "Error: $description"
    fi
}

echo -e "${BLUE}"
cat << "EOF"

 _____           _                     _
|_   _|_ _ _ __ (_)___ _ __ ___   ___ ( )___
  | |/ _` | '_ \| / __| '_ ` _ \ / _ \|// __|
  | | (_| | | | | \__ \ | | | | | (_) | \__ \
  |_|\__,_|_|_|_|_|___/_| |_| |_|\___/  |___/
 / ___| ___ |  _ \ _ __ ___
| |  _ / _ \| |_) | '__/ _ \
| |_| | (_) |  __/| | | (_) |
 \____|\___/|_|   |_|  \___/_                   _
 / ___|___  _ __   ___ __ _| |_ ___ _ __   __ _| |_ ___  _ __
| |   / _ \| '_ \ / __/ _` | __/ _ \ '_ \ / _` | __/ _ \| '__|
| |__| (_) | | | | (_| (_| | ||  __/ | | | (_| | || (_) | |
 \____\___/|_| |_|\___\__,_|\__\___|_| |_|\__,_|\__\___/|_|


EOF
echo -e "${NC}"

read -p "Enter the final file name prefix: " final_prefix
read -p "Enter the final concatenated file name (e.g., final_output.mp4): " final_concat_name

> filelist.txt

for file in GX*.MP4; do
    if [ -f "$file" ]; then
        base_name="${file%.MP4}"
        reduced_file="${base_name}_2.mp4"
        encoded_file="${final_prefix}_$(ls ${base_name}_2.mp4 | wc -l).mp4"

        run_command "ffmpeg -i \"$file\" -filter:v 'setpts=0.5*PTS' \"$reduced_file\" > /dev/null 2>&1" "Processing $file"
        check_file_size_and_run "$reduced_file"
        run_command "ffmpeg -i \"$reduced_file\" -an -vcodec libx265 -crf 28 \"$encoded_file\" > /dev/null 2>&1" "Encoding $reduced_file"

        echo "file '$encoded_file'" >> filelist.txt

        run_command "rm \"$file\"" "Removing $file"
        run_command "rm \"$reduced_file\"" "Removing $reduced_file"
    fi
done

run_command "ffmpeg -f concat -safe 0 -i filelist.txt -c copy \"$final_concat_name\" > /dev/null 2>&1" "Concatenating files into $final_concat_name"
