#!/bin/bash
clear

# Extracting date and hostname
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
HOSTNAME=$(hostname)
OUTPUT_FILE="logs_${HOSTNAME}_${TIMESTAMP}.txt"

echo "Saving Linux system logs: $OUTPUT_FILE" > $OUTPUT_FILE

# auth.log
if [[ -f "/var/log/auth.log" ]]; then
    echo -e "\n===== /var/log/auth.log (last 100 lines) =====\n" >> $OUTPUT_FILE
    tail -n 100 /var/log/auth.log >> $OUTPUT_FILE
else
    echo -e "\n[!] Not found: /var/log/auth.log" >> $OUTPUT_FILE
fi

# syslog
if [[ -f "/var/log/syslog" ]]; then
    echo -e "\n===== /var/log/syslog (last 100 lines) =====\n" >> $OUTPUT_FILE
    tail -n 100 /var/log/syslog >> $OUTPUT_FILE
else
    echo -e "\n[!] Not found: /var/log/syslog" >> $OUTPUT_FILE
fi

# dmesg
echo -e "\n===== dmesg (last 100 lines of kernel buffer) =====\n" >> $OUTPUT_FILE
dmesg | tail -n 100 >> $OUTPUT_FILE

echo -e "\nLogs saved to: $OUTPUT_FILE"
