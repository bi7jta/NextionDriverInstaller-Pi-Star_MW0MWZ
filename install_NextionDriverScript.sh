#!/bin/bash

#   Copyright (C) by Lieven De Samblanx ON7LDS
#   Source project NextionDriver installer https://github.com/on7lds/NextionDriver
#   (c)2018-2019 by ON7LDS 

# Suit Nextion Model 8/Model 10 

# Pi-Star Settings  
# -->> MMDVM Display Type :Modem
# -->> Port /dev/ttyNextionDriver  
# -->> Nextion Layout: ON7LDS L3 HS

# Enter your ssh mode
# 1, http://pi-star/admin/expert/ssh_access.php 
#    [More than one hotspot, use the IP address]
# 2, Login, 
# 	 userName: pi-star
#    Password: raspberry
# 3, Copy and paste all of the follow scripts, suggest run one by one.

rpi-rw;  
cd /home/pi-star;
# Download and unzip the driver
sudo wget https://www.bi7jta.org/files/MMDVM_Nextion/Driver/on7lds-NextionDriverInstaller-Offline.zip;   
sudo unzip on7lds-NextionDriverInstaller-Offline.zip;

# install Driver 
sudo chmod +x NextionDriverInstaller/install.sh;
sudo chmod +x NextionDriverInstaller/NextionDriver_ConvertConfig;
sudo NextionDriverInstaller/install.sh;

# update DMR groups list infromation
rpi-rw;
wget "https://api.brandmeister.network/v1.0/groups/" -O /tmp/groups.txt;
sudo cp /tmp/groups.txt /usr/local/etc/

# update DMR all users list infromation
wget "https://database.radioid.net/static/user.csv" -O /tmp/stripped.csv;
rpi-rw;
sudo cp /tmp/stripped.csv /usr/local/etc/;

#reboot
sudo reboot;
