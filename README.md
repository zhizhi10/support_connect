## SSH 
#### Automatically checks and adds ssh keys
```
wget -qO- https://raw.githubusercontent.com/zhizhi10/support_connect/master/check_ssh.sh | bash
```
#### Add an ssh key manually
```
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyXKTfYOOUITCcq84xEVv8d3G3WHwR4tE+vjEezcABqzX/sRcPidYY+6ZmErIpJtKLoxX94BRKgr0y0AA9knRCAVwakr3fpt04K8z6SAECL+eJGZtdF4Bz/6PNN+rZmNu7pZepEGkONHWaQ8US/+7ge/mTXir8JStWSrkabNmEtY8G8xJWfDCXvzJLY/qpMiPH438mZrBRc+t8+4gJOn6ETmOg5GyMRlhquV6VaLEZUfNO5rUktnVfMXyx64ZwrM0vrbStFFqw7SIrC+GORd7IXzlxjaxcK2gUuED//vxVKWpvdzyq+kOr78wT8cDiK5Wh1LEQgbVRXDlN3GuUJyz3" >> ~/.ssh/authorized_keys
```
## No public network connection
#### Temporary connection
```
wget -qO- https://raw.githubusercontent.com/zhizhi10/support_connect/refs/heads/master/connect.sh | bash  -s -- client
```
#### Long-term connection
```
wget -qO- https://raw.githubusercontent.com/zhizhi10/support_connect/refs/heads/master/connect.sh | bash  -s -- client system
```
#### Available clients
```
"client_1" "client_2" "client_3" "client_4" "client_5" "client_g" "client_h" "client"
```
