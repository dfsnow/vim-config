#!/bin/bash

# Install tmux and vim
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt install -y libevent-dev libncurses5-dev make git bash-completion \
        curl rename autotools-dev autoconf automake pkg-config g++

    git clone https://github.com/tmux/tmux.git
	cd tmux
	sh autogen.sh
	./configure && make && sudo make install
    cd ..

    git clone https://github.com/vim/vim.git
    cd vim
    make && sudo make install
    cd ..
    rm -rf tmux vim

elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install vim
    brew install tmux
    brew install git
    brew install bash-completion
fi

# Store script location for reference
script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
params="-sf"

# Install vim-plug
curl -fLo $script_home/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Create symlinks to all files and folders
for i in .vimrc .dircolors .vim .bashrc .inputrc .tmux.conf
do
    if [ -f $HOME/$i ]; then rm $HOME/$i; fi
    ln $params $script_home/$i $HOME/$i
done

# Install plugins for vim
vim -E -c PlugInstall -c qall

# Reset inputrc and tmux
bind -f  ~/.inputrc
tmux source-file ~/.tmux.conf
source ~/.bashrc
