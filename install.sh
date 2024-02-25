

[ -f ~/.bashrc ] && rm ~/.bashrc && echo "[ ok ] removed ~/.bashrc"
[ -h "$(pwd)/.bashrc" ] && unlink ~/.bashrc && echo "[ ok ] unlinked ~/.bashrc"
ln -s $(pwd)/.bashrc ~/.bashrc && echo "[ ok ] installed ~/.bashrc"

[ -f ~/.gitconfig ] && rm ~/.gitconfig && echo "[ ok ] removed ~/.gitconfig"
[ -h "$(pwd)/.gitconfig" ] && unlink ~/.gitconfig && echo "[ ok ] unlinked ~/.gitconfig"
ln -s $(pwd)/.gitconfig ~/.gitconfig && echo "[ ok ] installed ~/.gitconfig"


apps=$1
echo "[ .. ] installing .nvim" 
cd .nvim && source ./install.sh && cd ..

echo "[ .. ] installing .ssh" 
cd .ssh && source ./install.sh && cd ..


