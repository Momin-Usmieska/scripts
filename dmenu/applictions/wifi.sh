#!/bin/bash

source /home/momin/.config/scripts/dmenu/themes/dracula.sh

### Code to get list of saved networks ####

i=0
saved=0
declare -A pair

while IFS= read -r line; do
	ssid[i]+=$(echo $line | cut -d ":" -f1)
	value="${ssid[$i]}"
	pass=$(echo $line | cut -d ":" -f2)
	pair[$value]=$pass
	i=$((i+1))
done < /home/momin/.config/scripts/dmenu/applictions/password.txt


###  Code For Displaying available wifi networks ###
list="$(nmcli -f SSID -t dev wifi list)"

network=$(printf "%s\n" $list | dmenu -c -l 5 -fn "FontAwesome:size=24" -nb  $col_gray1 -nf $col_gray3 -sb $col_cyan -sf $col_gray4)

active=$(iwgetid -r)


if [[ "$network" == "$active" ]]
then
  notify-send "Wifi" "Already Connected to $network"
	exit 1
fi

if [[ -z "$network" ]]
then
	exit 1
fi




### Code to check if selected network is saved or not ###
for val in "${!pair[@]}" 
do 
	if [[ "$val" == "$network" ]]
	then
		saved=1
		break
	fi
done


### Code to connect to wifi ###


if [[ $saved == "1" ]]
then
	pass=${pair[$network]}
else
	pass=$( echo "" | dmenu -p "Password;" -c -l 1 -fn "FontAwesome:size=24" -nb  $col_gray3 -nf $col_gray3 -sb $col_cyan -sf $col_gray3 )
  if [[ -z "$pass" ]]; then
    exit 1
  fi
	newpair="$network:$pass"
	echo -e "$newpair" >> /home/momin/.config/scripts/dmenu/applictions/password.txt
fi


nmcli dev wifi connect "$network" password "$pass"
