#!/bin/bash

if [[ $1 = "prod" || $1 = "dev" ]] && [[ $2 = "down" || $2 = "up" ]]; then
	cd ..
	fileEnv="docker-compose.${1}.yaml"
        downorUp=$2
	echo "Running docker-compose -f docker-compose.yaml -f $fileEnv $downorUp"
        docker-compose -f docker-compose.yaml -f $fileEnv $downorUp 
else
	echo "Need to follow format ./deploy.sh Prod|dev down|up"
fi
