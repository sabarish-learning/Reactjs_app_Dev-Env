#!/bin/bash

# Define your Docker image name and tag
IMAGE_NAME_PROD="sabarish24/react-prod"
IMAGE_NAME_DEV="sabarish24/react-dev"
IMAGE_TAG="1.0"

    # Triggered on code push to dev branch
    echo "Building and pushing the image to the dev repository on Docker Hub"
    
    # Build the Docker image
    docker build -t "$IMAGE_NAME_DEV:$IMAGE_TAG" -f ./Dockerfile.dev .
    
    # Login to Docker Hub
    echo "$LOGIN_CREDS_PSW" | docker login -u "$LOGIN_CREDS_USR" --password-stdin
    
    # Push the image to the dev repository
    docker push "$IMAGE_NAME_DEV:$IMAGE_TAG"
