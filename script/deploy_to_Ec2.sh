# Define the branch you want to trigger the Docker build on
MASTER_BRANCH="master"

# Define your Docker image name and tag
IMAGE_NAME_PROD="react-prod"
IMAGE_TAG="1.0"

if [[ "$CI_COMMIT_REF_NAME" == "MASTER_BRANCH" ]]; then
  
  echo 'deploying on another server'

  # login the Docker hub
  docker login -u $LOGIN_CREDS_USR -p $LOGIN_CREDS_PSW
  
  # Pull the Docker image to Docker Hub
  docker pull "$IMAGE_NAME_PROD:$IMAGE_TAG"
  
  #stop and remove the running container
   docker stop react-prod || true
   docker rm react-prod || true
     
  # starting the Docker image
  docker-compose -f docker-compose.yaml -f  docker-compose.dev.yaml up 

  echo "react application is running now access using http://ip_address:8080"
else
  echo "Code pushed to a branch that doesn't trigger deployment"
fi
