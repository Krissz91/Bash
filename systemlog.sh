#!/bin/bash

OUTPUT_FILE="full_log_output.txt"

echo "Linux rendszerlogok mentése..." > "$OUTPUT_FILE"

# auth.log
if [[ -f "/var/log/auth.log" ]]; then
    echo -e "\n===== /var/log/auth.log =====\n" >> "$OUTPUT_FILE"
    cat /var/log/auth.log >> "$OUTPUT_FILE"
else
    echo -e "\n[!] Nem található: /var/log/auth.log" >> "$OUTPUT_FILE"
fi

# syslog
if [[ -f "/var/log/syslog" ]]; then
    echo -e "\n===== /var/log/syslog =====\n" >> "$OUTPUT_FILE"
    cat /var/log/syslog >> "$OUTPUT_FILE"
else
    echo -e "\n[!] Nem található: /var/log/syslog" >> "$OUTPUT_FILE"
fi

# dmesg
echo -e "\n===== dmesg (kernel buffer) =====\n" >> "$OUTPUT_FILE"
dmesg >> "$OUTPUT_FILE"

echo -e "\n✅ Logok mentve ide: $OUTPUT_FILE"
