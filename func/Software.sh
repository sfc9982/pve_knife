#!/bin/bash

# NodeJS and Yarn
CheckNodeJS() {
    if command -v npm >/dev/null 2>&1; then 
  $NPMExist=1
    else 
  $NPMExist=0
    fi

    if command -v node >/dev/null 2>&1; then 
  $NodeExist=1
    else 
  $NodeExist=0
    fi

    if [[ $NPMExist -eq 0 || $NodeExist -eq 0]]; then
    echo 'NodeJS not found will install it'
    else
    echo 'NodeJS already installed'
    break
    fi
}

PrepareNodeJS() {
    apt-get install -y lsb-release
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
}

# 注,此处为了兼容多版本,做了字符串拼接

AddNodeJSRepo() {
    URL1="deb https://deb.nodesource.com/node_"
    SRCURL1="deb-src https://deb.nodesource.com/node_"
    VER=$1
    URL2=".x/ stretch main"
    echo $URL1$VER$URL2 > /etc/apt/sources.list.d/nodesource.list
    echo $SRCURL1$VER$URL2 >> /etc/apt/sources.list.d/nodesource.list
    # 看起来像这样子
    # It looks like this
    # deb https://deb.nodesource.com/node_8.x stretch main
    # deb-src https://deb.nodesource.com/node_8.x stretch main
}

AddNodeJSRepoCN() {
    URL1="deb https://mirrors.tuna.tsinghua.edu.cn/nodesource/deb_"
    SRCURL1="deb-src https://mirrors.tuna.tsinghua.edu.cn/nodesource/deb_"
    VER=$1
    URL2=".x/ stretch main"
    echo $URL1$VER$URL2 > /etc/apt/sources.list.d/nodesource.list
    echo $SRCURL1$VER$URL2 >> /etc/apt/sources.list.d/nodesource.list
    # 看起来像这样子
    # It looks like this
    # deb https://mirrors.tuna.tsinghua.edu.cn/nodesource/deb_8.x/ stretch main
    # deb-src https://mirrors.tuna.tsinghua.edu.cn/nodesource/deb_8.x/ stretch main
}

InstallNodeJS () {
    apt update
    apt-get install -y nodejs
    apt-get install gcc g++ make -y
}

SetNPMCNMirror() {
    npm config set registry http://registry.npm.taobao.org/
}

PrepareYarn() {
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
}

InstallYarn() {
    apt-get update && sudo apt-get install yarn
}

SetYarnCNMirror() {
    yarn config set registry https://registry.npm.taobao.org/
}


# Docker
PrepareDocker() {
    apt-get -y install apt-transport-https ca-certificates curl software-properties-common gnupg2
    curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
}

InstallDocker() {
    curl -o- -L https://get.docker.com | bash -s -- 
}

InstallDockerCN() {
    curl -o- -L https://get.docker.com | bash -s -- --mirror Aliyun
}

