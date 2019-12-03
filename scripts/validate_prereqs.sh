#!/bin/bash

# Check if curl exists
hash curl
if [ $? -ne 0 ]; then
    echo "Script needs curl"
    exit 1
fi

# Check if curl exists
hash jq
if [ $? -ne 0 ]; then
    echo "Script needs jq"
    exit 1
fi
