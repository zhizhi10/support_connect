#!/bin/bash
set -e
check_distro() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" != "debian" && "$ID_LIKE" != *"debian"* ]]; then
      echo "This script is only for Debian-based distributions."
      exit 1
    fi
  else
    echo "Cannot determine distribution."
    exit 1
  fi
}

check_apt() {
  if ! command -v apt &> /dev/null; then
    echo "apt is not installed or not found in PATH."
    exit 1
  fi
}

file_list=("client_a" "client_b" "client_c" "client_d" "client_e" "client_f" "client")

check_client() {
  local input=$1
  local found=false

  for file in "${file_list[@]}"; do
    if [ "$file" == "$input" ]; then
      found=true
      break
    fi
  done

  if [ "$found" == false ]; then
    echo "not found $input"
    exit 1
  fi
  wget -O $1.ovpn https://raw.githubusercontent.com/zhizhi10/support_connect/master/key/$1.ovpn
}

check_openvpn() {
  if ! command -v openvpn &> /dev/null; then
    echo "openvpn not found ,install"
    sudo apt update
    sudo apt install -y openvpn
  fi
}

create_service_file() {
  local input=$1
  local service_file="/etc/systemd/system/connect-vpn.service"

  {
    echo "[Unit]"
    echo "Description=OpenVPN Service"
    echo "After=network.target"
    echo ""
    echo "[Service]"
    echo "Type=forking"
    echo "ExecStart=/usr/sbin/openvpn --daemon --config $(pwd)/${input}.ovpn --comp-lzo"
    echo ""
    echo "[Install]"
    echo "WantedBy=multi-user.target"
  } > "$service_file"

  echo "Service file created at $service_file"
}

start_service() {
  systemctl daemon-reload
  systemctl start connect-vpn.service
  systemctl enable connect-vpn.service
  echo "Service started and enabled successfully"
}

tmp_connect() {
  echo "connect"
  sudo openvpn --config $1.ovpn --comp-lzo
}

main() {
  check_distro
  check_apt
  if [ -z "$1" ]; then
    echo "please set a client name"
    exit 1
  fi

  local input=$1

  check_client "$input"
  check_openvpn

  if [ "$2" == "system" ]; then
    create_service_file "$input"
    start_service
  else
    tmp_connect
  fi
}

main "$@"
