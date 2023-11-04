#!/bin/bash

# Define your Docker image name and tag
IMAGE_NAME_PROD="sabarish24/react-prod"
IMAGE_TAG="1.0"


  echo 'deploying on another server'

  # login the Docker hub
  docker login -u $LOGIN_CREDS_USR -p $LOGIN_CREDS_PSW
  
  # Pull the Docker image to Docker Hub
  docker pull "$IMAGE_NAME_PROD:$IMAGE_TAG"
  
  #stop and remove the running container
   docker stop "$IMAGE_NAME_PROD" || true
   docker rm "$IMAGE_NAME_PROD" || true
     
  # starting the Docker image
  docker-compose -f docker-compose.yaml -f  docker-compose.prod.yaml up 


  echo "deployment completed successfully"
