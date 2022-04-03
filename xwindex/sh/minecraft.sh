#!/bin/bash
export PATH=$PATH:/usr/local/go/bin
LANG=en_US.UTF-8

if [ $(whoami) != "root" ];then
	echo "惟仪涵提醒您:请使用root权限执行本shell哦"
	exit 1;
fi

is64bit=$(getconf LONG_BIT)
if [ "${is64bit}" != '64' ];then
	Red_Error "惟仪涵提醒您:当前面板版本不支持32位系统, 请使用64位系统哦";
fi

Centos6Check=$(cat /etc/redhat-release | grep ' 6.' | grep -iE 'centos|Red Hat')
if [ "${Centos6Check}" ];then
	echo "Centos6不支持安装本shell，请更换Centos7/8安装本shell哦"
	exit 1
fi 

echo "
+----------------------------------------+
| 小惟shell我的世界安装程序              |
+----------------------------------------+
| 制作作者站点:https://www.fcyle.com     |
+----------------------------------------+
| 欢迎安装使用，安装时会切换yum为阿里源  |
+----------------------------------------+
"
read -p "是否同意小惟公约并继续: y/n(输入任意字符为y):" CHOICE
case "${CHOICE}" in
	[nN] | [nN][oO])
		echo "小惟shell运行结束"
		;;
	*)

#获取当前系统的发行版本
VERSION=$(cat /etc/centos-release)

#提取当前系统的版本号
V_NUM=${VERSION:21:1}

BASE_REPO="/etc/yum.repos.d/CentOS-Base.repo"
ALI_REPO="http://mirrors.aliyun.com/repo/Centos-${V_NUM}.repo"

#备份当前软件源
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
echo "备份完成,位置:/yum.repos.d/CentOS-Base.repo.backup"

#下载阿里云镜像源
wget -O ${BASE_REPO} ${ALI_REPO} || curl -o ${BASE_REPO} ${ALI_REPO}

#补丁程序, 防止出现 Couldn't resolve host 'mirrors.cloud.aliyuncs.com' 信息
sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo

#清除缓存
yum clean all

#生成缓存
yum makecache

#更新软件
yum update -y

#清除软件包
yum autoremove -y

#安装构建mcrcon工具所需的软件包
sudo yum install git -y

sudo yum group install "Development Tools" -y

#创建minecraft账户
sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft

mkdir -p /opt/minecraft/{backups,tools,server}

cd /opt/minecraft/tools && git clone https://gitee.com/whtrys/mcrcon.git

gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon /opt/minecraft/tools/mcrcon/mcrcon.c

#下载minecraft到本地
sudo yum install https://api.fcyle.com/minecraft/jdk-17_linux-x64_bin.rpm -y

wget https://gitapi.fcyle.com/minecraft/server.jar -P /opt/minecraft/server

java -Xmx1024M -Xms512M -jar /opt/minecraft/server/server.jar nogui

rm -rf /opt/minecraft/server/eula.txt

wget https://gitapi.fcyle.com/minecraft/eula.txt -P /opt/minecraft/server

rm -rf /opt/minecraft/server/server.properties

wget https://gitapi.fcyle.com/minecraft/server.properties -P /opt/minecraft/server

wget https://gitapi.fcyle.com/minecraft/minecraft.service -P /etc/systemd/system

sudo systemctl daemon-reload

sudo systemctl enable minecraft

sudo firewall-cmd --permanent --zone=public --add-port=25565/tcp

sudo firewall-cmd --reload

sudo systemctl start minecraft

echo "安装完毕"
echo "可执行sudo systemctl status minecraft查询我的世界运行状态"
echo "有bug请联系QQ：914205978"
echo "禁止使用至商业用途"
		;;
esac