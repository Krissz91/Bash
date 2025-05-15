#!/bin/bash
clear

# Author: Krisztian Toth
# Created: 15/05/2025
# Description: Backup script with clean relative paths

echo "Greetings, ${USER^}!"
echo "This is a backup script."

# Request for source
read -rp "Please enter the full path to the file or folder you want to save: " source_path

# Control
if [ ! -e $source_path ];then
    echo "Error: The specified file or folder does not exist."
    exit 1
else
    echo "$source_path is exist."
fi

# Target path
read -rp "Please enter the full path to the library: " destination_dir

# Create target directory if it does not exist
if [ -d $destination_dir ];then
    echo "$destination_dir is exist."
else
    echo "$destination_dir is not exist, but we create one."
    mkdir -p $destination_dir
fi

# Preparation
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
item_name=$(basename $source_path)
parent_dir=$(dirname $source_path)
backup_file="${destination_dir}/${item_name}_backup_${timestamp}.tar.gz"

# Archiving with relative path
echo "Saving in progress..."
tar -czf $backup_file -C $parent_dir $item_name 2>/dev/null

if [ $? -eq 0 ];then
    echo "Save successful! Path: $backup_file"
else
   echo "An error occurred during the save."
fi
exit 0
