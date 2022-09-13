#!/usr/bin/env bash
# Takes 3 args: tag name, username and password

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath=$2/capstone

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login -u $2 -p $3
docker tag capstone:$1 $dockerpath:$1

# Step 3:
# Push image to a docker repository
docker push $dockerpath:$1