#!/bin/bash
<<info
This is the loops tutorial.
loops: anything that you can repeat again and again and again based on conditions.
for loop conditions
1....10

start point = 1
end point = 10
increment/decrement = +/-
info

for (( num=1 ; num<=10 ; num++))
do
	echo "$num"
	echo "Hello"
done

