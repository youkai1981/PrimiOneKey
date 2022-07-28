#!/bin/bash
apt update
if [ $? -ne 0 ]; then
    echo "update failed!!!"
    exit
fi

apt upgrade -y
if [ $? -ne 0 ]; then
    echo "upgrade failed!!!"
    exit
fi

apt install -y openjdk-8-jdk git 
if [ $? -ne 0 ]; then
    echo "openjdk-8-jdk or git  failed!!!"
    exit
fi

if [ ! -d "/PrimiHubDataDIR" ]; then
  cd ~/ && git clone https://github.com/youkai1981/PrimiHubDataDIR.git
    if [ $? -ne 0 ]; then
        echo "git clone failed!!!"
        exit
    fi
else
    echo "PrimiHubDataDIR已经存在,请删除后重新运行！"
    echo "如已安装请执行cd ~/fisco && bash nodes/127.0.0.1/start_all.sh "
    exit
fi

mv PrimiHubDataDIR/* ./ && rm -rf DataDIR

chmod 777 ~/fisco/nodes/127.0.0.1/*.sh
chmod 777 ~/fisco/nodes/127.0.0.1/fisco-bcos

cd ~/fisco && bash nodes/127.0.0.1/start_all.sh

echo "transaction hash: 0x002ab26c9ca4003197585503ccfd4ba1a1fcf03a1604ba5ab555c43251cabf1c"
echo "contract address: 0xbde892c99bdeb64c90962c90ab23b305f42969c6"
echo "currentAccount: 0xf5eaba15967aca0064e08e47756f7aabbb645177"

read -p "请记录contract address,按任意键继续！"

cd ~/fisco/console && bash start.sh
