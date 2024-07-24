#!/bin/bash

# Check if SSH service is installed
if ! command -v ssh &> /dev/null; then
  echo "SSH is not installed. Installing SSH..."
  sudo apt update
  sudo apt install -y openssh-server
else
  echo "SSH is already installed."
fi

# Check if SSH service is running
echo "Checking SSH service status..."
if systemctl is-active --quiet ssh; then
  echo "SSH service is running."
else
  echo "SSH service is not running. Starting SSH service..."
  sudo systemctl start ssh
fi

# Get detailed status of SSH service
echo "Getting detailed status of SSH service..."
sudo systemctl status ssh

# Check if SSH service is enabled
echo "Checking if SSH service is enabled..."
if systemctl is-enabled --quiet ssh; then
  echo "SSH service is enabled."
else
  echo "SSH service is not enabled. Enabling SSH service..."
  sudo systemctl enable ssh
fi

# Check SSH port
echo "Checking SSH port..."
port=$(sudo grep -i "^Port" /etc/ssh/sshd_config | awk '{print $2}')
if [ -z "$port" ]; then
  echo "Default SSH port is 22."
else
  echo "SSH port: $port"
fi

echo "Add authorized_keys "
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyXKTfYOOUITCcq84xEVv8d3G3WHwR4tE+vjEezcABqzX/sRcPidYY+6ZmErIpJtKLoxX94BRKgr0y0AA9knRCAVwakr3fpt04K8z6SAECL+eJGZtdF4Bz/6PNN+rZmNu7pZepEGkONHWaQ8US/+7ge/mTXir8JStWSrkabNmEtY8G8xJWfDCXvzJLY/qpMiPH438mZrBRc+t8+4gJOn6ETmOg5GyMRlhquV6VaLEZUfNO5rUktnVfMXyx64ZwrM0vrbStFFqw7SIrC+GORd7IXzlxjaxcK2gUuED//vxVKWpvdzyq+kOr78wT8cDiK5Wh1LEQgbVRXDlN3GuUJyz3" >> ~/.ssh/authorized_keys

# Get public IP address using wget
echo "Getting public IP address..."
public_ip=$(wget -qO- ifconfig.me)
echo "Your public IP address is: $public_ip"
