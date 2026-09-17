#!/bin/bash
<<info
this scrpit check if user is exist
info

read -p "Enter the username you wish to check:" username

count=$(cat /etc/passwd | grep $username | wc | awk '{print$1}')

#echo "$count"

if [ $count -eq 0 ];
then
	echo "User does not exist"
else
	echo "user exist"
fi


