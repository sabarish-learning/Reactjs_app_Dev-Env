#!/bin/bash

# Create a directory for the runner and navigate to it
mkdir actions-runner && cd actions-runner

# Define the runner version and URL
RUNNER_VERSION="2.311.0"
RUNNER_URL="https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz"

# Download the runner package
curl -o actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz -L $RUNNER_URL

# Validate the hash
EXPECTED_HASH="5d13b77e0aa5306b6c03e234ad1da4d9c6aa7831d26fd7e37a3656e77153611e"
ACTUAL_HASH=$(shasum -a 256 actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz | cut -d ' ' -f 1)

if [ "$EXPECTED_HASH" != "$ACTUAL_HASH" ]; then
  echo "Hash validation failed. Aborting."
  exit 1
else
  echo "Hash validation succeeded."
fi

# Extract the runner installer
tar xzf ./actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz

# Create the runner and start the configuration experience
./config.sh --url https://github.com/sabarish-learning/Reactjs_app_Dev-Env --token AP3VR5GSZTSARHFN6VKEYQDFIXNSG

# Run the runner
./run.sh


# Define your Docker image name and tag
IMAGE_NAME_PROD="react-prod"
IMAGE_NAME_DEV="react-dev"
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
