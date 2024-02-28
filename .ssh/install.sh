#!/bin/bash

yn='@'

if [[ -f "~/.ssh/config" ]]; then

	read -p "[ ? ] ~/.ssh/config exists; re-write this file (y/n) ?" yn
	
	if [[ $yn = "y" ]]; then
		echo "[ ok ] removing default config"
		rm -r ~/.ssh/config
	else
		echo "[ ok ] NOT touching config"
	fi
fi

if [ $yn = "y" ] || [ $yn = "@" ]; then

	cp config ~/.ssh/config

	if [ -z ${ssh_nyu_user+x} ]; then echo '[ not ok ! ] $ssh_nyu_user='' is unset'; else sed -i "s/User ssh_nyu_user/User $ssh_nyu_user/g"  ~/.ssh/config; fi 
	
	echo "[ ok ] installed .ssh/config"

fi




























































