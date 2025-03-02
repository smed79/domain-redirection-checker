#!/bin/bash

# Bash script to check the final redirection of the domain and resume from the last checked URL if interrupted.

# Check if domains.txt file exists, if not prompt for the file to use
urls_file="domains.txt"
if [[ ! -f "$urls_file" ]]; then
  read -p "File domains.txt not found. Please enter the path to the file you want to use: " urls_file
  if [[ ! -f "$urls_file" ]]; then
    echo "File not found. Exiting."
    exit 1
  fi
fi

# Output file
output_file="output.txt"

# Get the last processed URL from the output file
if [[ -f "$output_file" ]]; then
  last_url=$(tail -n 1 "$output_file" | awk '{print $1}')
  resume=true
else
  resume=false
fi

# Flag to skip the next matching URL
skip_next=false

# Read URLs from the specified file
while read -r line; do
  # Skip lines until the last processed URL is found
  if $resume; then
    if $skip_next; then
      resume=false
    elif [[ "$line" == "$last_url" ]]; then
      skip_next=true
      continue
    else
      continue
    fi
  fi

  # Get effective URL and HTTP status code from curl with a max timeout of 5 seconds
  effective_url=$(curl --max-time 5 -IsL -w "%{url_effective}\n%{http_code}\n" -o /dev/null "$line")
  http_code=$(echo "$effective_url" | tail -1)
  effective_url=$(echo "$effective_url" | head -n -1)

  # Extract and print the domain name
  domain_name=${effective_url#*//}  # Remove everything before //
  domain_name=${domain_name%/*}  # Remove everything after the /

  # Print domain name and append to the output file
  echo "$line => $domain_name" | tee -a "$output_file"

done < "$urls_file"
