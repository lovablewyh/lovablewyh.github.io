#!/bin/bash

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

#安装构建mcrcon工具所需的软件包
sudo yum install git -y

sudo yum group install "Development Tools" -y

#创建minecraft账户
sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft
if [ ! -d "/opt/minecraft/{backups,tools,server} "];then
          mkdir -p /opt/minecraft/{backups,tools,server}
else
         echo "文件夹已创建"
fi

cd /opt/minecraft/tools && git clone https://gitee.com/whtrys/mcrcon.git

gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon /opt/minecraft/tools/mcrcon/mcrcon.c

#下载minecraft到本地
if [ ! -f  "jdk-17_linux-x64_bin.rpm"];then
    sudo yum install https://api.fcyle.com/minecraft/jdk-17_linux-x64_bin.rpm -y
else
    echo"java环境已搭建"
fi

if [ -f  "/opt/minecraft/server/server.jar"];then
rm -rf /opt/minecraft/server/server.jar
wget https://gitapi.fcyle.com/minecraft/server.jar -P /opt/minecraft/server
else
wget https://gitapi.fcyle.com/minecraft/server.jar -P /opt/minecraft/server
fi
java -Xmx1024M -Xms512M -jar /opt/minecraft/server/server.jar nogui

if [ -f  "/opt/minecraft/server/eula.txt"];then
rm -rf /opt/minecraft/server/eula.txt
wget https://gitapi.fcyle.com/minecraft/eula.txt -P /opt/minecraft/server
else
java -Xmx1024M -Xms512M -jar /opt/minecraft/server/server.jar nogui
wget https://gitapi.fcyle.com/minecraft/eula.txt -P /opt/minecraft/server
fi

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