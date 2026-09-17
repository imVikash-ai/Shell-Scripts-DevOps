#!/bin/bash

#  User defined variables

hero="rancho"
villian="Virus"

echo "3 idiots ka hero hai: $hero"

echo "3 idiots ka villain hai: $villian"

# Shell/environment variables (pre-defined)

echo "Current logged in user: $USER"

# User input
read -p "Rancho ka poora namm kya tha? " fullname

echo "Rancho ka poora naam $fullname tha"


# arguments

# ./3_idiots.sh raju farhan rancho

echo "Movie ka naam: $0"

echo "first idiot: $1"

echo "second idiot: $2"

echo "third idiot: $3"

echo "Hence the 3 idiots are: $@"

echo "Total no of idiots: $#"
