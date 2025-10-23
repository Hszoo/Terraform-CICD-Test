#!/bin/bash

# 컨테이너 stop & rm
if [ "$(docker ps -q -f name=hybrid05-web)" ]; then
    docker stop hybrid05-web
    docker rm hybrid05-web
else
    echo "Container hybrid05-web does not exist, skipping stop."
fi

# ECR 로그인
ECR_REGISTRY="329863774288.dkr.ecr.us-east-2.amazonaws.com"
aws ecr get-login-password --region us-east-2 \
  | docker login --username AWS --password-stdin "$ECR_REGISTRY"

# ECR에서 최신 이미지 pull
ECR_IMAGE="$ECR_REGISTRY/hb05-ecr:latest"
docker pull "$ECR_IMAGE"