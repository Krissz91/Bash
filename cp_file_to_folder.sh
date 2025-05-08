#!/bin/bash
# copy file to folder
clear

echo -n "Which file are we copying?: "
read file

sleep 1

if [ -f $file ];then
  echo "The file is here..."
elif [ -e $file ];then
  echo "'$file' is here, but it's not a file."
exit 1
else
  echo "The file isn't on the machine, but we're creating one empty..."
  touch $file || { echo "An error occurred while creating the file."; exit 1; }
fi

read -p "Which folder do we copy it to?: " folder

sleep 1

if [ -d $folder ];then
  echo "The folder is here..."
elif [ -e $folder ];then
  echo "'$folder' is here, but it's not a folder."
exit 1
else
  echo "There is no such folder on the machine, but we will create one..."
  mkdir $folder
fi

sleep 1

cp $file $folder && echo "The file was successfully addes to the folder."

exit 0
