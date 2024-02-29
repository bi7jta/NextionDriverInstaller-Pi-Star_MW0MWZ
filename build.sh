#!/bin/bash

#   Copyright (C) by Lieven De Samblanx ON7LDS
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

#########################################################
#                                                       #
#                 NextionDriver installer               #
#                                                       #
#                 (c)2018-2019 by ON7LDS                #
#                                                       #
#                        V1.04                          #
#                                                       #
#########################################################

if [ "$(which gcc)" = "" ]; then echo "- I need gcc. Please install it." exit; fi
if [ "$(which git)" = "" ]; then echo "- I need git. Please install it." exit; fi
PATH=/opt/MMDVMHost:$PATH
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )" #"
if [ "$EUID" -ne 0 ]
  then echo "- Please run as root (did you forget to prepend 'sudo' ?)"
  exit
fi

echo "+ Getting NextionDriver ..."
#cd /tmp
#rm -rf /tmp/NextionDriver
#git clone https://github.com/on7lds/NextionDriver.git;
cd /home/pi-star/NextionDriver 2>/dev/null
pwd
if [ "$(pwd)" != "/home/pi-star/NextionDriver" ]; then echo "- Getting NextionDriver failed. Cannot continue."; exit; fi


#######################################################################################

THISVERSION=$(cat NextionDriver.h | grep VERSION | sed "s/.*VERSION //" | sed 's/"//g')
TV=$(echo $THISVERSION | sed 's/\.//')
ND=$(which NextionDriver)
V=0
if [ "$ND" != "" ]; then
 VERSIE=$($ND -V | grep version | sed "s/^.*version //")
 V=$(echo $VERSIE | sed 's/\.//')
fi
PISTAR=$(if [ -f /etc/pistar-release ];then echo "OK"; fi)
MMDVM=$(which MMDVMHost)
BINDIR=$(echo "$MMDVM" | sed "s/\/MMDVMHost//")
CONFIGFILE="MMDVM.ini"
CONFIGDIR="/etc/"
FILESDIR="/usr/local/etc/"
SYSTEMCTL="systemctl daemon-reload"
MMDVMSTOP="service mmdvmhost stop"
MMDVMSTART="service mmdvmhost start"
NDOUDSTOP="service nextion-helper stop 2>/dev/null"
NDSTOP="service nextiondriver stop"

#######################################################################################


compileer () {
    echo "+ Compiling ..."
    make
}


rm -f NextionDriver 

compileer

stat NextionDriver 