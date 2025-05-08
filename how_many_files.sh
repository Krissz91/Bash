#!/bin/bash
# How many entries are in the folder?
clear

read -p "Which folder should we examine?: " folder

if [ -d $folder ];then
  echo "There are" $(ls $folder | wc -l) "entries in folder '$folder'"
elif [ -e $folder ];then
  echo "'$folder' is here, but it's not a folder."
exit 1
else
  echo "There is no such folder on the machine."
fi
exit 0
