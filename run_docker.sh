#!/usr/bin/env bash

## Complete the following steps to get Docker running locally
## Takes one arg: tag name

# Step 1:
# Build image and add a descriptive tag
sudo docker build --tag=$1 .

# Step 2: 
# List docker images
sudo docker image ls

# Step 3: 
# Run flask app
# docker run -p 8000:80 capstone