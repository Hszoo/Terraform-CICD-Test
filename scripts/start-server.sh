#!/bin/bash
set -e

echo "--------------- START : Terraform-CICD-Pipeline Server Deploy -----------------"
cd /home/ec2-user/hb05-terraform

echo "[Check] 현재 디렉토리: $(pwd)"
echo "[Check] 파일 목록:"
ls -al

echo "[AWS] ECR 로그인"
ECR_REGISTRY="329863774288.dkr.ecr.us-east-2.amazonaws.com"
aws ecr get-login-password --region us-east-2 \
  | docker login --username AWS --password-stdin "$ECR_REGISTRY"
  
echo "[Docker Compose] 실행 중인 컨테이너 중지"
docker compose down || true

echo "[Docker Compose] 컨테이너 실행"
docker compose up -d

echo "-------------- COMPLETE : Terraform-CICD-Pipeline Server Deploy ---------------"