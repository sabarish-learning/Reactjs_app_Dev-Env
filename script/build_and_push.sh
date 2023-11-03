#!/bin/bash

# Check the branch before and after the push
old_branch=$(git rev-parse --abbrev-ref HEAD)

# Define your Docker image name and tag
IMAGE_NAME_PROD="react-prod"
IMAGE_NAME_DEV="react-dev"
IMAGE_TAG="1.0"


# Detect branch changes
if [ "$old_branch" == "dev" ] && [ "$1" == "refs/heads/dev" ]; then

  # Build the Docker image
  docker build -t "$IMAGE_NAME_DEV:$IMAGE_TAG" -f ./Dockerfile.dev .
  
  # login the Docker hub
  docker login -u $LOGIN_CREDS_USR -p $LOGIN_CREDS_PSW
  
  # Push the Docker image to Docker Hub
  docker push "$IMAGE_NAME_DEV:$IMAGE_TAG"
  
  echo "Docker image has been built and pushed to Dev Docker Hub."

elif [ "$old_branch" == "dev" ] && [ "$1" == "refs/heads/master" ]; then

# Build the Docker image
  docker build -t "$IMAGE_NAME_PROD:$IMAGE_TAG" -f ./Dockerfile.prod .
  
  # login the Docker hub
  docker login -u $LOGIN_CREDS_USR -p $LOGIN_CREDS_PSW
  
  # Push the Docker image to Docker Hub
  docker push "$IMAGE_NAME_PROD:$IMAGE_TAG"
  
  echo "Docker image has been built and pushed to prod Docker Hub."
else
    echo "Code pushed to a branch that doesn't trigger image build."
fi
