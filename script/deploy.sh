#!/bin/bash

# Define your Docker image name and tag
IMAGE_NAME_PROD="sabarish24/react-prod"
IMAGE_TAG="1.0"


if [ "$1" = "master" ]; then
  echo 'deploying on another server'

  # login the Docker hub
  docker login -u $LOGIN_CREDS_USR -p $LOGIN_CREDS_PSW
  
  # Pull the Docker image to Docker Hub
  docker pull "$IMAGE_NAME_PROD:$IMAGE_TAG"
  
  
  #stop and remove the running container
 docker-compose -f docker-compose.yaml -f docker-compose.prod.yaml down
     
  # starting the Docker image
  docker-compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d


  echo "deployment completed successfully"
  
  else
    echo "Code pushed to a branch that doesn't trigger image build."
fi
