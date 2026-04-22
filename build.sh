#!/bin/bash
echo "Building Docker image..."
docker build -t react-devops-app .
docker tag react-devops-app govindcloud01/dev:latest
echo "Build complete!"
