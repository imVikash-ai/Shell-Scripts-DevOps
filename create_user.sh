#!/bin/bash

<<help
This is the shell scripts
to create users.

help

echo "========================== Creation of User =================="

read -p "Enter the username: " username

read -p "Enter the password: " password

sudo useradd -m -p "$password" "$username"

echo -e "$password\n$password" | sudo passwd "$username" 

echo "========================  Crate user ========================="

