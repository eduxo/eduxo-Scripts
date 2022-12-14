#!/bin/bash
# Tento skript slouzi k odpojeni stanice eduxo Workstation od ZeroTier VPN

# ODPOJENI OD VPN
echo -e '\n\e[0;92mZadejte ID VPN, od ktere se chcete odpojit:\e[0m'
read NETID

sudo zerotier-cli leave $NETID
sudo systemctl restart zerotier-one.service
sudo zerotier-cli status
sudo zerotier-cli listnetworks
sleep 3
