#!/bin/bash

input_file="$1"
if [ -z "$input_file" ]
then
  echo "Error: no input file specified"
  exit 1
fi

valid_file="uri-valid.txt"
invalid_file="uri-invalid.txt"

# Ensure that the output files are initially empty
tee "$valid_file" >/dev/null < /dev/null
tee "$invalid_file" >/dev/null < /dev/null

cat "$input_file" | grep \"uri\" | grep -v androidapp | awk -F \" '{print $4}' | while read uri
do
  curl --connect-timeout 1 -s --head "$uri" >/dev/null
  if [ $? -eq 0 ]
  then
    echo "$uri is valid" | tee -a "$valid_file" >/dev/null
  else
    echo "$uri is not a valid site" | tee -a "$invalid_file" >/dev/null
  fi
done
