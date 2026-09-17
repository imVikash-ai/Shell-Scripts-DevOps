#!/bin/bash

echo "========================== Creation of User =================="

#read -p "Enter the username: $1" 

#read -p "Enter the password: $2"

sudo useradd -m -p "$2" "$1"

echo -e "$2\n$2" | sudo passwd "$1" 

echo "========================  Crate user ========================="

sudo userdel $1

echo /etc/passwd | grep $1 | wc

echo "as wc is 0 the user is deleted"
