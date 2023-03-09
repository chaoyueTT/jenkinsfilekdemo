#!/bin/bash

# Set the environment and module to deploy
ENVIRONMENT=$ENVIRONMENT
MODULE=$MODULE

# Start the containers
if [ "$ENVIRONMENT" == "prod" ]; then
  echo "Starting the containers in production environment..."
  docker-compose -f .deploy/production/docker-compose.yml up -d $MODULE
else
  echo "Starting the containers in development environment..."
  docker-compose -f .deploy/testing/docker-compose.yml up -d $MODULE
fi
