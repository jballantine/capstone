#!/usr/bin/env bash
# Takes 3 args: tag name, username and password

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath=$2/$1

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login -u $2 -p "i<3docker"
docker tag $1 $dockerpath

# Step 3:
# Push image to a docker repository
docker push $dockerpath