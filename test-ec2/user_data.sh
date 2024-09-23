#! /bin/bash
useradd unixadmin;useradd cloudusr;useradd carrot
passwd unixadmin <<EOF
Samatha@143
Samatha@143
EOF
passwd cloudusr <<EOF
PqLaMz^)!1001
PqLaMz^)!1001
EOF
passwd carrot <<EOF
Carr0TadM1n@132
Carr0TadM1n@132
EOF
echo "unixadmin,cloudusr,carrot ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service sshd restart
