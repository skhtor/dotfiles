#!/bin/bash

# Ensure an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <ciphertext>"
    exit 1
fi

# Get the ciphertext from the command line argument
ciphertext="$1"

# Decrypt the ciphertext using AWS KMS
plaintext=$(aws kms decrypt --ciphertext-blob fileb://<(echo -n "$ciphertext" | base64 -d) --output text --query Plaintext | base64 -d)

# Print the plaintext
echo "$plaintext"
