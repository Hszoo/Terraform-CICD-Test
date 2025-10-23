#!/bin/bash
set -e

echo "--------------- START : AWS-CICD-Pipeline Server Deploy -----------------"
cd /home/ec2-user/AWS-CICD-Pipeline

echo "[Check] 현재 디렉토리: $(pwd)"
echo "[Check] 파일 목록:"
ls -al

echo "[AWS] ECR 로그인"
aws ecr get-login-password --region ap-northeast-2 \
  | docker login --username AWS --password-stdin 329863774288.dkr.ecr.ap-northeast-2.amazonaws.com/hybrid05-server-registry
  
echo "[Docker Compose] 실행 중인 컨테이너 중지"
docker compose down || true

echo "[Docker Compose] 컨테이너 실행"
docker compose up -d

echo "-------------- COMPLETE : AWS-CICD-Pipeline Server Deploy ---------------"