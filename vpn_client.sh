#! /bin/bash

# root or not check
if [[ "${UID}" -gt 0 ]]
then
        echo "you are NOT ROOT user change to root user"
        echo "Enter the ROOT PASSWORD"

        sudo su
        
	if [[ "${?}" = 0 ]]
        then
                echo " now you are root user"
        else
                echo " now you are not a root user"
                exit 1
        fi
fi
#check the usage
#usage() {
#	echo "--------------------------------------------------------"
#	echo " USAGE: ./EXECUTABLE USRNAME PASSWORD"
#	echo " script is make sure as permission 755"      
#	echo " executable (as a shell script)"
#	echo " USERNAME-->your vpn provoider authentication username"
#	echo " PASSWORD--> YOUR VPN PROVOIDER Authentication password"
#	echo "--------------------------------------------------------"
#	exit 20
#}
#
#if [[ "${#}" -ne 3 ]]
#then
#	usage
#fi

#closing file descriptors
#close 0
#close 1
#close 2

OPV=/etc/openvpn
if [ -d "$OPV" ]; then
    echo "[INFO] $OPV directory is founded."
    else
 apt-get install openvpn
fi

#checking files directory is there or not
DIR='openvpn'
if [[ -d "DIR" ]] ; then
        echo "[INFO] DIRECTORY :${DIR}"
        cd openvpn
else
        #creating directory
        mkdir openvpn
        cd openvpn
fi
file="./*.crt"
file1="./*.key"
if [[ -f "$file" && -f "$file1" ]];
then
    echo "[INFO] certificate files found."
else
    echo "[INFO] certificate files NOT found"
    
fi

#Firewall Rules to Connect VPN Server
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.ip_forward=1
ufw allow ssh
ufw allow 1194/udp

 FILENAME='VPNBook.com-OpenVPN-PL226.zip'

if [[ -f "${FILENAME}" ]]
then
echo "[INFO] already found:Zipfile ${FILENAME}"
else
wget https://www.vpnbook.com/free-openvpn-account/VPNBook.com-OpenVPN-PL226.zip
#unzipping vpn ziping
unzip VPNBook.com-OpenVPN-PL226.zip
fi


#reading vpn region
#echo "Enter region config in listed outed "
#read -t 200  RECONFIG

RECONFIG='vpnbook-pl226-udp53.ovpn'

USER_NAME='vpnbook'
PASSWORD='kh3u5c9'

if [[ "${1}" ]]
then
RECONFIG="${1}"
fi

if [[ "${2}" ]]
then
  USER_NAME="{2}"
fi

if [[ "${2}" ]]
then
  PASSWORD="{3}"
fi

 openvpn --config "${RECONFIG}" --auth-user-pass <(echo -e "${USER_NAME}\n${PASSWORD}") &

