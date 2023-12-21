#!/usr/bin/env bash

organize_desktop() {
  desktop_path="$HOME/Desktop"
  if [ ! -d "$desktop_path" ]; then
    echo "Desktop directory not found."
    return 1
  fi

  cd "$desktop_path" || return 1

  # Loop through each file on the desktop
  for file in *; do
    if [ -f "$file" ]; then
      # Get the last modification date of the file
      modification_date=$(stat -f "%Sm" -t "%Y/%m" "$file")

      # Extract year and month
      year=$(echo "$modification_date" | cut -d'/' -f1)
      month=$(echo "$modification_date" | cut -d'/' -f2)

      # Create year directory if it doesn't exist
      mkdir -p "$year"

      # Create month directory if it doesn't exist within the year
      mkdir -p "$year/$month"

      # Move the file to the appropriate directory
      mv "$file" "$year/$month/"
    fi
  done

  echo "Desktop files organized into YY/MM structure."
}
organize_desktop
