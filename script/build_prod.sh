#!/bin/bash

# Define your Docker image name and tag
IMAGE_NAME_PROD="sabarish24/react-prod"
IMAGE_NAME_DEV="sabarish24/react-dev"
IMAGE_TAG="1.0"

if []; then
    echo "Building and pushing the image to the prod repository on Docker Hub"
    
    # Build the Docker image
    docker build -t "$IMAGE_NAME_PROD:$IMAGE_TAG" -f ./Dockerfile.prod .
    
    # Login to Docker Hub
     docker login -u $LOGIN_CREDS_USR -p $LOGIN_CREDS_PSW
    
    # Push the image to the prod repository
    docker push "$IMAGE_NAME_PROD:$IMAGE_TAG"

else
fi
