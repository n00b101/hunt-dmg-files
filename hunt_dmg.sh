#!/bin/bash

# Output file for global summary
output_file="dmg_files_hashes.txt"

# Clear the output file if it exists
> "$output_file"

# Search for all .dmg files recursively from the root directory
sudo find / -type f -name "*.dmg" 2>/dev/null | while read -r dmg_file; do
  # Calculate the MD5 hash
  hash_value=$(md5 "$dmg_file" | awk '{print $4}')
  
  # Print the file path and hash to the terminal
  echo "Found: $dmg_file"
  echo "MD5 Hash: $hash_value"
  echo "------------------------"
  
  # Write the file path and hash to the global output file
  echo "File: $dmg_file" >> "$output_file"
  echo "MD5 Hash: $hash_value" >> "$output_file"
  echo "------------------------" >> "$output_file"
  
  # Write the MD5 sum and file path to an md5sum.txt in the same directory as the dmg file
  md5sum_file="$(dirname "$dmg_file")/md5sum.txt"
  echo "$hash_value  $dmg_file" >> "$md5sum_file"
  
done

echo "Search completed. Hashes saved to $output_file."
