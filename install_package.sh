#!/bin/bash
<<info
This script will install the package
that you pass in the arguments.

info

echo "Install $1"

sudo apt-get update > /dev/null
sudo apt-get install $1 -y

echo "Installation completed"
