#!/bin/bash

# Define your Docker image name and tag
IMAGE_NAME_PROD="sabarish24/react-prod"
IMAGE_NAME_DEV="sabarish24/react-dev"
IMAGE_TAG="1.0"

currentbranch=$(git rev-parse --abbrev-ref HEAD)
                    
                    if [ currentBranch == 'dev' ]; then
                        // Build and push the development image
                      docker build -t $IMAGE_NAME_DEV:$IMAGE_TAG -f ./Dockerfile.dev .
                         echo "$LOGIN_CREDS_PSW" | docker login -u "$LOGIN_CREDS_USR" --password-stdin
                         docker push $IMAGE_NAME_DEV:$IMAGE_TAG
          
                        echo "Docker image has been built and pushed to Dev Docker Hub."
                
                    elif [ currentBranch == 'master' ]; then 
                        // Build and push the production image
                       docker build -t $IMAGE_NAME_PROD:$IMAGE_TAG -f ./Dockerfile.prod .
                        echo "$LOGIN_CREDS_PSW" | docker login -u "$LOGIN_CREDS_USR" --password-stdin
                           docker push $IMAGE_NAME_PROD:$IMAGE_TAG
                       echo "Docker image has been built and pushed to Prod Docker Hub."
                
                    else 
                        echo "Code pushed to a branch that doesn't trigger image build."
                    fi
