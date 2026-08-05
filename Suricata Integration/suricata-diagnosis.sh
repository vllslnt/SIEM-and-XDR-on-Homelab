#!/bin/bash

echo "=============================================="
echo "      SURICATA DIAGNOSTIC SCRIPT"
echo "=============================================="

echo
echo "===== Suricata Version ====="
suricata --version

echo
echo "===== Service Status ====="
systemctl status suricata --no-pager

echo
echo "===== Last 30 Service Log Entries ====="
journalctl -u suricata -n 30 --no-pager

echo
echo "===== Last 30 Suricata Log Entries ====="
if [ -f /var/log/suricata/suricata.log ]; then
    tail -n 30 /var/log/suricata/suricata.log
else
    echo "suricata.log not found."
fi

echo
echo "===== Network Interfaces ====="
ip -br addr

echo
echo "===== Configured Capture Interfaces ====="
grep -n "interface:" /etc/suricata/suricata.yaml

echo
echo "===== Configuration Test ====="
suricata -T -c /etc/suricata/suricata.yaml

echo
echo "=============================================="
echo "Diagnostics complete."
echo "=============================================="