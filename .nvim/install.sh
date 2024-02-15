#!/bin/bash

NVIM_FLAG="false"

if [[ -z "${apps+x}" ]]; then

	echo 'err : no $apps'

elif [[ -z "$apps" ]]; then

	echo 'err : empty $apps'

elif [[ ! -d $apps ]]; then

	echo 'err : directory $apps does not exist'
	
else 
	yn=""

	if [[ -d $apps/neovim ]]; then
	
		read -p "[ ? ] installation already exists | do you want to re-install ( y / n ) ?" yn
	
		if [[ $yn = "y" ]]; then
			echo "[ ok ] removing neovim installation at $apps/neovim"
			rm -r $apps/neovim
			echo "[ ok ] re-installing neovim"
		fi
	else

		read -p "[ ? ] do you want to install neovim at $apps/neovim ( y / n ) ?" yn
		
		if [[ $yn = "y" ]]; then
			echo "[ ok ] installing neovim at $apps/neovim"
		fi
	fi

	if [[ $yn = "y" ]]; then

		temp=$(pwd)	
		cd $apps
		git clone https://github.com/neovim/neovim.git
		cd neovim
		git checkout stable
		make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$apps/neovim
		make install
		"source $apps/neovim/bin" >> ~/.bashrc
		source $apps/neovim/bin
		cd $temp
		NVIM_FLAG="true"

	else
		echo "[ ok ] NOT installing neovim"
	fi
fi
