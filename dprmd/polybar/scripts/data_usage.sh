#!/bin/bash

# Ganti 'wlan0' dengan nama interface jaringan Anda
interface="wlan0"

# Mendapatkan data RX dan TX
rx_bytes=$(cat /sys/class/net/$interface/statistics/rx_bytes)
tx_bytes=$(cat /sys/class/net/$interface/statistics/tx_bytes)

# Menghitung total data yang terpakai dalam Bytes
total_bytes=$(($rx_bytes + $tx_bytes))

# Menghitung total data dalam MB
total_mb=$(($total_bytes / 1048576))

if [ $total_mb -lt 1024 ]; then
  # Jika total data kurang dari 1024 MB, tampilkan dalam MB
  echo "$total_mb MB"
else
  # Jika total data lebih dari atau sama dengan 1024 MB, tampilkan dalam GB
  total_gb=$(echo "scale=1; $total_mb / 1024" | bc)
  rounded_gb=$(printf "%.0f" "$total_gb") # Pembulatan ke bilangan bulat
  if [ "$(echo "$total_gb == $rounded_gb" | bc)" -eq 1 ]; then
    # Jika tidak ada pecahan, tampilkan sebagai bilangan bulat
    echo "$rounded_gb GB"
  else
    # Jika ada pecahan, tampilkan dengan satu desimal
    echo "$total_gb GB"
  fi
fi
