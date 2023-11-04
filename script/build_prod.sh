#!/bin/bash

# Define your Docker image name and tag
IMAGE_NAME_PROD="react-prod"
IMAGE_NAME_DEV="react-dev"
IMAGE_TAG="1.0"


    echo "Building and pushing the image to the prod repository on Docker Hub"
    
    # Build the Docker image
    docker build -t "$IMAGE_NAME_PROD:$IMAGE_TAG" -f ./Dockerfile.prod .
    
    # Login to Docker Hub
    echo "$LOGIN_CREDS_PSW" | docker login -u "$LOGIN_CREDS_USR" --password-stdin
    
    # Push the image to the prod repository
    docker push "$IMAGE_NAME_PROD:$IMAGE_TAG"

