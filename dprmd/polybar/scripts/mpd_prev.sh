mpc status &> /dev/null
if [[ $? -eq 0 ]]; then
  echo " 󰒮"
else 
  echo ""
fi
