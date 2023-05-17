#!/bin/bash

#   Copyright (C) by Lieven De Samblanx ON7LDS
#   Source project NextionDriver installer https://github.com/on7lds/NextionDriver
#   (c)2018-2019 by ON7LDS 

# 脚本目的：下载Nextion MModel 8/Model 10 驱动，展示详细信息

# 驱动装载：Pi-Star  
# -->> MMDVM Display Type :Modem
# -->> Port /dev/ttyNextionDriver  
# -->> Nextion Layout: ON7LDS L3 HS

# 可能遇到的问题：
# 安装启动后，Pi-Star管理界面会提示重新选择电台/调解解调器类型，重新选择一遍即可，或者直接忽视
# 磁盘空间不足时，执行扩容：sudo pistar-expand
# 交流：www.bi7jta.org 可以找到我

rpi-rw;  
cd /home/pi-star;
#下载驱动包
sudo wget https://www.bi7jta.org/files/MMDVM_Nextion/Driver/on7lds-NextionDriverInstaller-Offline.zip;   
sudo unzip on7lds-NextionDriverInstaller-Offline.zip;

#执行安装，
sudo chmod +x NextionDriverInstaller/install.sh;
sudo chmod +x NextionDriverInstaller/NextionDriver_ConvertConfig;
sudo NextionDriverInstaller/install.sh;

#更新通话组详细信息库
rpi-rw;
wget "https://api.brandmeister.network/v1.0/groups/" -O /tmp/groups.txt;
sudo cp /tmp/groups.txt /usr/local/etc/

#更新用户DMRID与用户信息库
wget "https://database.radioid.net/static/user.csv" -O /tmp/stripped.csv;
rpi-rw;
sudo cp /tmp/stripped.csv /usr/local/etc/;

#重启
sudo reboot;
