#!/bin/bash

# Define your Docker image name and tag
IMAGE_NAME_PROD="react-prod"
IMAGE_NAME_DEV="react-dev"
IMAGE_TAG="1.0"

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
     echo "Code pushed to a branch that doesn't trigger image build. not working"
fi


if [ "$GITHUB_EVENT_NAME" == "pull_request" ] && [ "$GITHUB_BASE_REF" == "dev" ] && [ "$GITHUB_HEAD_REF" == "master" ]; then

  # Build the Docker image
  docker build -t "$IMAGE_NAME_PROD:$IMAGE_TAG" -f ./Dockerfile.prod .
  
  # Login to Docker Hub
  echo "$LOGIN_CREDS_PSW" | docker login -u "$LOGIN_CREDS_USR" --password-stdin

  # Push the image to the prod repository
  docker push "$IMAGE_NAME_PROD:$IMAGE_TAG"
  else
     echo "Code pushed to a branch that doesn't trigger image build."
fi
