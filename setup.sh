#!/bin/bash

# Install tmux and vim
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt install -y libevent-dev libncurses5-dev make curl autotools-dev autoconf automake pkg-config g++

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
fi

# Store script location for reference
script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
params="-sf"

# Install vim-plug and tmux config
curl -fLo $script_home/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/gpakosz/.tmux.git .tmux
mv .tmux/.tmux.conf ./.tmux.conf
tmux source-file ~/.tmux.conf
rm -rf .tmux

# Create symlinks to all files and folders
for i in .vimrc .dircolors .tmux.conf .vim .bashrc
do
    ln $params $script_home/$i $HOME/$i
done

# Install plugins for vim
vim -E -c PlugInstall -c qall

# Change to -i '' -e on Mac
sed -i 's/g:dracula_colorterm = 1/g:dracula_colorterm = 0/g' \
    $script_home/.vim/vim-plug/vim/colors/dracula.vim


