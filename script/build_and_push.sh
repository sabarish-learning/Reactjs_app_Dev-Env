#!/bin/bash

# Define your Docker image name and tag
IMAGE_NAME_PROD="sabarish24/react-prod"
IMAGE_NAME_DEV="sabarish24/react-dev"
IMAGE_TAG="1.0"

if [ -n "$GITHUB_ACTIONS" ]; then
  # Running in a GitHub Actions environment
  echo "Running in GitHub Actions environment."

  if [ "$GITHUB_EVENT_NAME" == "push" ] && [ "$GITHUB_REF" == "refs/heads/dev" ]; then
    # Triggered on code push to dev branch
    echo "Building and pushing the image to the dev repository on Docker Hub"
    
    # Build the Docker image
    docker build -t "$IMAGE_NAME_DEV:$IMAGE_TAG" -f ./Dockerfile.dev .
    
    # Login to Docker Hub
    echo "$LOGIN_CREDS_PSW" | docker login -u "$LOGIN_CREDS_USR" --password-stdin
    
    # Push the image to the dev repository
    docker push "$IMAGE_NAME_DEV:$IMAGE_TAG"
  else
    echo "Code pushed to a branch that doesn't trigger image build."
  fi
  
  if [ "$GITHUB_EVENT_NAME" == "pull_request" ] && [ "$GITHUB_BASE_REF" == "dev" ] && [ "$GITHUB_HEAD_REF" == "master" ]; then
    # Triggered on a pull request from dev to master
    echo "Building and pushing the image to the prod repository on Docker Hub"
    
    # Build the Docker image
    docker build -t "$IMAGE_NAME_PROD:$IMAGE_TAG" -f ./Dockerfile.prod .
    
    # Login to Docker Hub
    echo "$LOGIN_CREDS_PSW" | docker login -u "$LOGIN_CREDS_USR" --password-stdin
    
    # Push the image to the prod repository
    docker push "$IMAGE_NAME_PROD:$IMAGE_TAG"
  else
    echo "Code pushed to a branch that doesn't trigger image build."
  fi
else
  # Running in a non-GitHub Actions environment (e.g., Ubuntu machine or Jenkins)
  echo "Running in a non-GitHub Actions environment. Make sure Docker is installed and configured."

  # Add your logic to set up Docker and execute the script on your local machine or Jenkins.
  # For Jenkins, you can directly execute this script as a build step.

  # Note: You should ensure that the necessary environment variables (LOGIN_CREDS_PSW, LOGIN_CREDS_USR) are set.
fi
