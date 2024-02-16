

if [[ -f ~/.bashrc ]]; then

	rm ~/.bashrc || unlink ~/.bashrc

fi

ln -s $(pwd)/.bashrc ~/.bashrc


ln -s $(pwd)/.gitconfig ~/.gitconfig



