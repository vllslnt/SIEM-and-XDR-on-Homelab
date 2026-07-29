#!/bin/bash

echo "========================================="
echo "        WAZUH SERVER SYSTEM CHECK"
echo "========================================="

echo
echo "===== Host Information ====="
hostnamectl

echo
echo "===== Ubuntu Version ====="
cat /etc/os-release

echo
echo "===== CPU ====="
lscpu

echo
echo "===== Memory ====="
free -h

echo
echo "===== Disk Usage ====="
df -h

echo
echo "========================================="
echo "System check complete."
echo "========================================="

# Note:
# "Please use chmod +x" <filename> to enable execution permission.