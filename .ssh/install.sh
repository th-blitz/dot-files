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

	echo "[ ok ] installing .ssh/config"
	
	cp -p $(pwd)/config ~/.ssh/config

	sed -i "s/User ssh_nyu_user/User $ssh_nyu_user/g"  ~/.ssh/config

fi




























































