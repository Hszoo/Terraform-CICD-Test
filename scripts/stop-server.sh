#!/bin/bash

# 컨테이너 stop & rm
if [ "$(docker ps -q -f name=hybrid05-server)" ]; then
    docker stop hybrid05-server
    docker rm hybrid05-server
else
    echo "Container hybrid05-server does not exist, skipping stop."
fi

# ECR 로그인
ECR_REGISTRY="329863774288.dkr.ecr.ap-northeast-2.amazonaws.com"
aws ecr get-login-password --region ap-northeast-2 \
  | docker login --username AWS --password-stdin "$ECR_REGISTRY"

# ECR에서 최신 이미지 pull
ECR_IMAGE="$ECR_REGISTRY/hybrid05-server-registry:latest"
docker pull "$ECR_IMAGE"