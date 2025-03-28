#!/bin/bash

echo "Creating application directory..."
mkdir -p /home/ec2-user/project

REPOSITORY=/home/ec2-user/project
cd $REPOSITORY

echo "> 현재 실행 중인 프로세스 확인"
CURRENT_PID=$(pgrep -f "python3 -m http.server 8080")

if [ -z "$CURRENT_PID" ]; then
  echo "> 현재 구동 중인 웹 서버가 없습니다."
else
  echo "> 기존 서버 종료: kill -15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 2
fi

echo "> 새로운 서버 시작"
nohup python3 -m http.server 8080 --directory public > nohup.out 2>&1 &
