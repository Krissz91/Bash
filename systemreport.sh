#!/bin/bash
clear

OUTPUT="system_report_$(date +%F_%H-%M-%S).txt"

{
  echo "===== SYSTEM REPORT ====="
  echo "Generated on: $(date)"
  echo ""

  echo "=== Hostname and Uptime ==="
  hostname
  uptime
  echo ""

  echo "=== OS and Kernel Info ==="
  uname -a
  lsb_release -a 2>/dev/null
  echo ""

  echo "=== CPU and Memory ==="
  top -b -n1 | head -15
  echo ""
  free -h
  echo ""

  echo "=== Disk Usage ==="
  df -h
  echo ""

  echo "=== Top Processes ==="
  ps aux --sort=-%cpu | head -10
  echo ""

  echo "=== Network Info ==="
  ip a
  echo ""
  ss -tuln
  echo ""

  echo "=== User Logins ==="
  who
  last -n 5
  echo ""

  echo "=== Security Events ==="
  grep -i "fail" /var/log/auth.log 2>/dev/null | tail -n 10
  echo ""

  echo "=== Package Updates (Debian/Ubuntu) ==="
  apt list --upgradable 2>/dev/null
} > "$OUTPUT"

echo "Report saved to: $OUTPUT"
