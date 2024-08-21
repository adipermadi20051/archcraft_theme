#!/bin/bash

# Cek apakah MPD berjalan
if pgrep -x "mpd" > /dev/null
then
    # Jika MPD berjalan, jalankan ncmpcpp
    alacritty -e ncmpcpp
else
    # Jika MPD tidak berjalan, jalankan MPD dan kemudian ncmpcpp
    mpd
    alacritty -e ncmpcpp
fi
