#!/bin/bash

echo "========================================="
echo "       NETWORK CONFIGURATION CHECK"
echo "========================================="

echo
echo "===== Interfaces ====="
ip -br addr

echo
echo "===== Interface Status ====="
ip -br link

echo
echo "===== Routing Table ====="
ip route

echo
echo "===== Listening Ports ====="
ss -tulnp

echo
echo "========================================="
echo "Network check complete."
echo "========================================="

# Note:
# "Please use chmod +x" <filename> to enable execution permission.