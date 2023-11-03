#!/bin/bash

# Define your Docker Hub repository URLs
IMAGE_NAME_PROD="react-prod"
IMAGE_NAME_DEV="react-dev"
IMAGE_TAG="1.0"

# Your secret (set in your GitHub webhook)
SECRET="somesupersecretphrase"

# Function to handle push events
handle_push() {
  ref="$1"
  if [ "$ref" == "refs/heads/dev" ]; then
    # Push event to the 'dev' branch
    echo "Detected push to 'dev' branch. Building and pushing to Dev repo."
    docker build -t $IMAGE_NAME_DEV:$IMAGE_TAG -f ./Dockerfile.dev .
  # login the Docker hub
  docker login -u $LOGIN_CREDS_USR -p $LOGIN_CREDS_PSW
  docker push $IMAGE_NAME_PROD:$IMAGE_TAG
  fi
}

# Function to handle merge events
handle_merge() {
  base="$1"
  head="$2"
  if [ "$base" == "master" ] && [ "$head" == "refs/heads/dev" ]; then
    # Merge event from 'dev' to 'master'
    echo "Detected merge from 'dev' to 'master'. Pushing to Prod repo."
   docker build -t $IMAGE_NAME_PROD:$IMAGE_TAG -f ./Dockerfile.prod .
  # login the Docker hub
  docker login -u $LOGIN_CREDS_USR -p $LOGIN_CREDS_PSW
  docker push $IMAGE_NAME_PROD:$IMAGE_TAG
  fi
}

# Check the GitHub webhook secret
if [ -z "$SECRET" ]; then
  echo "GitHub webhook secret not set. Please provide your secret in the script."
  exit 1
fi

# Read the GitHub webhook headers and payload
read -r headers payload

# Verify the GitHub webhook signature
if [[ "$headers" == *"$SECRET"* ]]; then
  event_type=$(echo "$headers" | grep -Eo 'X-GitHub-Event: (.+)' | cut -d ' ' -f 2)
  if [ "$event_type" == "push" ]; then
    handle_push "$(echo "$payload" | jq -r '.ref')"
  elif [ "$event_type" == "pull_request" ]; then
    base=$(echo "$payload" | jq -r '.pull_request.base.ref')
    head=$(echo "$payload" | jq -r '.pull_request.head.ref')
    handle_merge "$base" "$head"
  else
    echo "Ignoring unsupported event type: $event_type"
    exit 0
  fi
else
  echo "Invalid GitHub webhook signature."
  exit 1
fi

