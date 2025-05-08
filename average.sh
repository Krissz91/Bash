#!/bin/bash
# average
clear

number=0
piece=0
average=0
amount=0

until [ $number == "q" ]
do

read -p "Enter a number between 1 and 100 or leave by q: " number

if (($number<0)) || (($number>100));then
  echo "Between 1 and 100 or leave by q!"
else
  amount=$((amount+number))
  ((piece++))
fi

done

echo "The number of amount: '$amount'"
echo "The number of piece: '$((piece-1))'"
average=$((amount/(piece-1))) && echo "The average number: '$average'"

exit 0
