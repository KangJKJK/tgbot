#!/bin/bash

# 환경 변수 설정
export WORK="/root/HotWalletClaimer"
export NVM_DIR="$HOME/.nvm"

# 색상 정의
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # 색상 초기화

echo -e "${GREEN}각종 봇을 설치합니다.${NC}"
echo -e "${GREEN}스크립트작성자: https://t.me/kjkresearch${NC}"
echo -e "${GREEN}출처: https://github.com/thebrumby/HotWalletBot.git${NC}""

echo -e "${GREEN}설치 옵션을 선택하세요:${NC}"
echo -e "${YELLOW}1. 통합 봇 새로 설치${NC}"
echo -e "${YELLOW}2. 재실행하기${NC}"
read -p "선택: " choice

case $choice in
  1)
    echo -e "${GREEN}통합 봇을 새로 설치합니다.${NC}"

    # 사전 필수 패키지 설치
    echo -e "${YELLOW}시스템 업데이트 및 필수 패키지 설치 중...${NC}"
    sudo apt update
    sudo apt install -y git

    echo -e "${YELLOW}작업 공간 준비 중...${NC}"
    if [ -d "$WORK" ]; then
        echo -e "${YELLOW}기존 작업 공간 삭제 중...${NC}"
        rm -rf "$WORK"
    fi

    # GitHub에서 코드 복사
    echo -e "${YELLOW}GitHub에서 코드 복사 중...${NC}"
    git clone https://github.com/thebrumby/HotWalletBot.git
    cd "$WORK"
    sudo chmod +x install.sh launch.sh

    # Node.js LTS 버전 설치 및 사용
    echo -e "${YELLOW}Node.js LTS 버전을 설치하고 설정 중...${NC}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # nvm을 로드합니다
    nvm install --lts
    nvm use --lts
    npm install -g pm2
    pm2 startup systemd

    echo -e "${YELLOW}시스템 업데이트 및 필수 패키지 설치 중...${NC}"
    sudo apt update
    sudo apt install -y python3 python3-pip git

    echo -e "${YELLOW}Web텔레그렘에 접속후 F12를 누르시고 게임을 실행하세요${NC}"
    read -p "애플리케이션-세션저장소-Birds와 관련된 URL클릭 후 나오는 UserID나 QueryID를 적어두세요 (엔터) : "
    echo -e "${GREEN}다계정의 query_id를 입력할 경우 줄바꿈으로 구분하세요.${NC}"
    echo -e "${GREEN}입력을 마치려면 엔터를 두 번 누르세요.${NC}"
    echo -e "${YELLOW}Userid를 입력하세요(user= 또는 query_id= 포함해서 입력):${NC}"
    
    # 봇 구동
    ./install.sh
    
    # install.sh가 완료될 때까지 대기
    wait $!  # install.sh의 PID가 완료될 때까지 대기

    # launch.sh 실행
    ./launch.sh

    ;;
    
  2)
    echo -e "${GREEN}통합 봇을 재실행합니다.${NC}" 
    cd "$WORK"
    ./launch.sh
    ;;

  *)
    echo -e "${RED}잘못된 선택입니다. 다시 시도하세요.${NC}"
    ;;
esac
