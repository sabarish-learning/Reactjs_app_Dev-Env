#!/bin/bash

echo 'testing…'
docker pull sabarish24/react-prod:1.0
docker inspect --type=image sabarish24/react-prod:1.0
echo 'docker image tested successfully'
