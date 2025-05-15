#!/bin/bash
clear

# We ask for the date.
read -p "Enter the date (YYYY-MM-DD): " INPUT_DATE

# Format check
if ! [[ "$INPUT_DATE" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    echo "Incorrect date format. Use e.g. 2025-05-15."
    exit 1
fi

# Convert to log format (e.g. "May 15")
LOG_DATE=$(date -d "$INPUT_DATE" "+%b %e")
if [ $? -ne 0 ]; then
    echo "Invalid date: $INPUT_DATE"
    exit 1
fi

# Filename and system info
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
HOSTNAME=$(hostname)
OUTPUT_FILE="logs_${HOSTNAME}_${TIMESTAMP}.txt"

echo "Saving logs for $INPUT_DATE ($LOG_DATE): $OUTPUT_FILE" > $OUTPUT_FILE

# List and process log files
declare -a LOG_FILES=(
    "/var/log/auth.log"
    "/var/log/syslog"
    "/var/log/kern.log"
    "/var/log/user.log"
    "/var/log/dpkg.log"
    "/var/log/messages"
    "/var/log/Xorg.0.log"
)

for FILE in "${LOG_FILES[@]}"; do
    if [[ -f "$FILE" ]]; then
        echo -e "\n===== $FILE ($LOG_DATE) =====\n" >> $OUTPUT_FILE
        grep "^$LOG_DATE" "$FILE" >> $OUTPUT_FILE
    else
        echo -e "\n[!] Not found: $FILE" >> $OUTPUT_FILE
    fi
done

# separate handling of faillog (binary)
if [[ -f "/var/log/faillog" ]]; then
    echo -e "\n===== faillog (user failed logins) =====\n" >> $OUTPUT_FILE
    faillog >> $OUTPUT_FILE
else
    echo -e "\n[!] Not found: /var/log/faillog" >> $OUTPUT_FILE
fi

# dmesg – no exact date, only 100 lines
echo -e "\n===== dmesg (last 100 lines) =====\n" >> $OUTPUT_FILE
dmesg | tail -n 100 >> $OUTPUT_FILE

echo -e "\nLogs saved successfully: $OUTPUT_FILE"
