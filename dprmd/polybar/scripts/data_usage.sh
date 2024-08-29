#!/bin/bash

interface=$(ip route | grep default | awk '{print $5}')

# Mendapatkan data RX dan TX
rx_bytes=$(cat /sys/class/net/$interface/statistics/rx_bytes)
tx_bytes=$(cat /sys/class/net/$interface/statistics/tx_bytes)

# Menghitung total data yang terpakai dalam Bytes
total_bytes=$(($rx_bytes + $tx_bytes))

# Jika total data kurang dari 1024 KB (1048576 Bytes), tampilkan dalam KB
if [ $total_bytes -lt 1048576 ]; then
  total_kb=$(($total_bytes / 1024))
  echo "$total_kb KB"
else
  # Menghitung total data dalam MB sebagai bilangan pecahan
  total_mb=$(echo "scale=2; $total_bytes / 1048576" | bc)

  if [ $(echo "$total_mb < 1024" | bc) -eq 1 ]; then
    # Jika total data kurang dari 1024 MB, tampilkan dalam MB (dengan pecahan jika perlu)
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
fi
