#!/bin/bash
echo "Building Docker image..."
sudo docker build -t react-devops-app -f /home/ubuntu/.jenkins/workspace/react-devops-pipeline/Dockerfile /home/ubuntu/.jenkins/workspace/react-devops-pipeline
#docker build -t react-devops-app -f $(pwd)/Dockerfile $(pwd)
docker tag react-devops-app govindcloud01/dev:latest
echo "Build complete! Fhaaah....!!"
