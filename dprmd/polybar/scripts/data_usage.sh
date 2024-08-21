#!/bin/bash

# Ganti 'wlan0' dengan nama interface jaringan Anda
interface="wlan0"

# Mendapatkan data RX dan TX
rx_bytes=$(cat /sys/class/net/$interface/statistics/rx_bytes)
tx_bytes=$(cat /sys/class/net/$interface/statistics/tx_bytes)

# Menghitung total data yang terpakai dalam Megabytes
total_bytes=$((($rx_bytes + $tx_bytes) / 1024 / 1024))

# Menampilkan total data yang terpakai
echo "$total_bytes MB"
