#!/bin/bash
echo "Deploying application..."
docker pull govindcloud01/dev:latest
docker stop react-app 2>/dev/null || true
docker rm react-app 2>/dev/null || true
docker run -d --name react-app -p 80:80 govindcloud01/dev:latest
echo "Deployment complete!"
