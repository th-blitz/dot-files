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

	source ../.secrets/ssh.secrets

	for word in "${SSH_VARS[@]}"; do
		echo "${word} | ${!word}" 
		sed -i "s:${word}:${!word}:g" ~/.ssh/config
	done

	echo "[ ok ] installed .ssh/config"

fi




























































