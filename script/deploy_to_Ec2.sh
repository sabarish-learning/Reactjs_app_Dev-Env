#!/bin/bash

# Check the branch before and after the push
old_branch=$(git rev-parse --abbrev-ref HEAD)

# Define your Docker image name and tag
IMAGE_NAME_PROD="react-prod"
IMAGE_TAG="1.0"

if [ "$old_branch" == "dev" ] && [ "$1" == "refs/heads/master" ]; then
  
  echo 'deploying on another server'

  # login the Docker hub
  docker login -u $LOGIN_CREDS_USR -p $LOGIN_CREDS_PSW
  
  # Pull the Docker image to Docker Hub
  docker pull "$IMAGE_NAME_PROD:$IMAGE_TAG"
  
  #stop and remove the running container
   docker stop react-prod || true
   docker rm react-prod || true
     
  # starting the Docker image
  docker-compose -f docker-compose.yaml -f  docker-compose.dev.yaml up 

  echo "react application is running now access using ip address:8080"
else
  echo "Code pushed to a branch that doesn't trigger deployment"
fi
