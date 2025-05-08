#!/bin/bash
clear
# Author: Krisztian Toth
# Created: 07/05/2025
# Description: Interactive backup script with clean relative paths

echo "Üdv, ${USER^}!"
echo "Ez egy interaktív mentési script."

# Request for source
read -rp "Kérem, adja meg a mentendő fájl vagy mappa teljes elérési útját: " source_path

# Control
if [ ! -e "$source_path" ]; then
  echo "Hiba: A megadott fájl vagy mappa nem létezik."
  exit 1
fi

# Target path
read -rp "Kérem, adja meg a cél elérési útvonalat a mentéshez (csak könyvtár): " destination_dir

# Create target directory if it does not exist
mkdir -p "$destination_dir"

# Preparation
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
item_name=$(basename "$source_path")
parent_dir=$(dirname "$source_path")
backup_file="${destination_dir}/${item_name}_backup_${timestamp}.tar.gz"

# Archiving with relative path
echo "Mentés folyamatban..."
tar -czf "$backup_file" -C "$parent_dir" "$item_name" 2>/dev/null

if [ $? -eq 0 ]; then
  echo "Mentés sikeres! Elérési út: $backup_file"
else
  echo "Hiba történt a mentés során."
fi

exit 0
