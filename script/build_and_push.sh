#!/bin/bash

# Define your Docker image name and tag
IMAGE_NAME_PROD="sabarish24/react-prod"
IMAGE_NAME_DEV="sabarish24/react-dev"
IMAGE_TAG="1.0"

 def currentBranch = sh(script: 'git rev-parse --abbrev-ref HEAD', returnStdout: true).trim()
                    
                    if (currentBranch == 'dev') {
                        // Build and push the development image
                      docker build -t $IMAGE_NAME_DEV:$IMAGE_TAG -f ./Dockerfile.dev .
                        withDockerRegistry([credentialsId: '261b4bc0-b4a4-471f-a23c-0821e2dd462d', url: 'https://index.docker.io/v1/']) {
                         docker push $IMAGE_NAME_DEV:$IMAGE_TAG
                        }
                        echo "Docker image has been built and pushed to Dev Docker Hub."
                    }
                    else if (currentBranch == 'master') {
                        // Build and push the production image
                       docker build -t $IMAGE_NAME_PROD:$IMAGE_TAG -f ./Dockerfile.prod .
                        withDockerRegistry([credentialsId: '261b4bc0-b4a4-471f-a23c-0821e2dd462d', url: 'https://index.docker.io/v1/']) {
                           docker push $IMAGE_NAME_PROD:$IMAGE_TAG
                        }
                        echo "Docker image has been built and pushed to Prod Docker Hub."
                    }
                    else {
                        echo "Code pushed to a branch that doesn't trigger image build."
                    }
