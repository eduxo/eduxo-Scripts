#!/bin/bash

# TESTOVANO:
# Ubuntu 22.04

# ZDROJE:
# https://ubuntu.com/server/docs/containers-lxd

# Test internet connection
function check_internet() {
  printf "Checking if you are online...\n"
  wget -q --spider http://github.com
  if [ $? -eq 0 ]; then
    echo -e '\e[0;92mOnline. Continuing.\e[0m'
  else
    echo -e '\e[0;91mOffline. Go connect to the internet then run the script again.\e[0m'
  fi
}

check_internet


# Container 
echo -e '\n\e[0;92mZadejte jmeno kontejneru:\e[0m'
read NAME
echo -e '\e[0;92mZadejte pozadovanou IP adresu kontejneru '$NAME' (ze site 10.20.30.0/24):\e[0m'
read IP

# Create container
echo -e '\n\e[0;92mVytvarim kontejner '$NAME'\e[0m'
lxc launch ubuntu:lts $NAME

# Upgrade container
echo -e '\e[0;92mAktualizuji kontejner '$NAME'\e[0m'
sleep 5
lxc exec $NAME -- apt-get -q update > /dev/null
lxc exec $NAME -- apt-get -q upgrade -y > /dev/null
lxc exec $NAME -- apt-get -q autoremove -y > /dev/null

# Setting container
echo -e '\e[0;92mNastavuji kontejner '$NAME'\e[0m'

# Add user to container
echo -e '\e[0;92mVytvarim uzivatele sysadmin v kontejneru '$NAME'\e[0m'
lxc exec $NAME -- groupadd sysadmin
lxc exec $NAME -- useradd -rm -d /home/sysadmin -s /bin/bash -g sysadmin -G sudo -u 1001 sysadmin
lxc exec $NAME -- sh -c 'echo "sysadmin:Netlab!23" | chpasswd' 

# Enable SSH Password Authentication
lxc exec $NAME -- sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
lxc exec $NAME -- systemctl restart sshd

# Add static IP adress
lxc stop $NAME
lxc network attach lxdbr0 $NAME eth0 eth0
lxc config device set $NAME eth0 ipv4.address $IP
lxc start $NAME


# --------------------------------NASTAVENÍ PRO ÚLOHY---------------------------------------



# --------------------------------NASTAVENÍ PRO ÚLOHY---------------------------------------


# Edit /etc/hosts
# echo -e '\e[0;92mPro nastaveni domain-name je nutne opravneni:\e[0m'
sudo sh -c 'echo "'$IP'     '$NAME'.eduxo.lab	'$NAME'" >> /etc/hosts'

echo -e '\n\e[0;92mKontejner '$NAME' je pripraven:\e[0m
Container-name: '$NAME'
Domain-name: '$NAME'.eduxo.lab
IP adresa: '$IP'\n'
