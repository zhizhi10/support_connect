#!/bin/bash

if ! command -v wget &> /dev/null; then
  echo "wget not found, install"
  sudo apt update
  sudo apt install -y wget
fi

wget -O client.ovpn https://raw.githubusercontent.com/zhizhi10/support_connect/master/client.ovpn

if ! command -v openvpn &> /dev/null; then
  echo "openvpn not found ,install"
  sudo apt update
  sudo apt install -y openvpn
fi

echo "connect"
sudo openvpn --config client.ovpn  --comp-lzo

