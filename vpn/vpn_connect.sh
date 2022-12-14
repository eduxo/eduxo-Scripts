#!/bin/bash
# Tento skript slouzi k pripojeni stanice eduxo Workstation k ZeroTier VPN

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


# test, jestli je ZeroTier nainstalovany, pokud ne, nainstaluje se
if ! dpkg --get-selections | grep -qw zerotier;then
    echo -e '\n\e[1;92mZeroTier neni nanistalovan. Instaluji ZeroTier.\e[0m'
    
    # update seznamu balicku
    sudo apt-get update > /dev/null
    
    # instalace balicku
    curl -s https://install.zerotier.com | sudo bash > /dev/null 2>&1
    
    echo -e '\e[1;92mInstalace ZeroTier je kompletni.\e[0m'
    sleep 3
fi

# PRIPOJENI DO VPN
echo -e '\n\e[0;92mZadejte ID VPN, ke ktere se chcete připojit:\e[0m'
read NETID

sudo zerotier-cli join $NETID
sudo zerotier-cli status
sudo zerotier-cli listnetworks
sleep 3
