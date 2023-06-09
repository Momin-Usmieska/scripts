#!/bin/bash

source /home/momin/.config/scripts/dmenu/themes/dracula.sh

Dir1=/usr/bin
Dir2=/home/momin/.config/scripts/dmenu/applictions

for entry in "$Dir1"/*
do
	Path+=${entry##*/}$'\n'
done

for entry in "$Dir2"/*
do
	Path+=${entry##*/}$'\n'
done

selected=$(printf "$Path" | dmenu -c -i -fn "FontAwesome:size=24" -nb  $col_gray1 -nf $col_gray3 -sb $col_cyan -sf $col_gray4) 

extension="${selected##*.}"

if [[ $extension == "sh" ]]
then
	/home/momin/.config/scripts/dmenu/applictions/"$selected"
elif [[ $extension == "desktop" ]] 
then
  gtk-launch "$selected"
else
	$selected
fi


