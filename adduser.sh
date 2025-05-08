#!/bin/bash
# Add user to the Linux system
clear

if [ $(id -u) -eq 0 ];then
  echo -n "What name should we give the user?: "
  read user

egrep "^$user:" /etc/passwd >/dev/null

if [ $? -eq 0 ];then
  echo "The user is already in the system."
else
  read -p "Password: " password
  useradd -m $user
  echo $user:$password | sudo chpasswd
  echo "We have created the user and set the password."
fi

else
  echo "Only root or someone with root privileges can use the script."
fi

exit 0
