#!/bin/bash

interface=$(ip route | grep default | awk '{print $5}')

# Mendapatkan jumlah bytes yang diterima dan dikirim
down=$(cat /sys/class/net/$interface/statistics/rx_bytes)
up=$(cat /sys/class/net/$interface/statistics/tx_bytes)
sleep 1
down_new=$(cat /sys/class/net/$interface/statistics/rx_bytes)
up_new=$(cat /sys/class/net/$interface/statistics/tx_bytes)

# Menghitung kecepatan dalam KBps
down_speed=$((($down_new - $down) / 1024))  # Kbps
up_speed=$((($up_new - $up) / 1024))        # Kbps

total_speed=$(($down_speed + $up_speed))

# Konversi ke MBps jika di atas 1024 KBps
if [ $total_speed -ge 1024 ]; then
    total_speed=$(echo "scale=2; $total_speed/1024" | bc)
    echo "${total_speed} MB/s"
else
    echo "${total_speed} KB/s"
fi
