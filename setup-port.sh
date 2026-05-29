#!/bin/bash
# EC2 최초 1회 실행: ubuntu 유저가 sudo 없이 80포트 사용하도록 authbind 설정
set -e

echo "[1/3] authbind 설치..."
sudo apt-get update -y
sudo apt-get install -y authbind

echo "[2/3] 포트 80 권한 설정..."
sudo touch /etc/authbind/byport/80
sudo chown ubuntu /etc/authbind/byport/80
sudo chmod 755 /etc/authbind/byport/80

echo "[3/3] 배포 디렉토리 생성..."
mkdir -p /home/ubuntu/couzl

echo ""
echo "설정 완료. 이제 deploy.yml 이 authbind --deep java -jar 로 포트 80을 사용합니다."
