#!/bin/bash
# This script renames all files in the current directory

# Loop through the files
for file in *; do
  # Get the file extension
  extension="${file##*.}"

  # Get the file name without the extension
  filename="${file%.*}"

  # Set the new file name
  new_filename="${filename}_$(date +%Y-%m-%d).${extension}"

  # Rename the file
  mv "$file" "$new_filename"

  # Print confirmation
  echo "Renamed $file to $new_filename"
done
