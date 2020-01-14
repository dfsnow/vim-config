#!/bin/bash

# Install tmux and neovim
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt install -y \
	curl rename git bash-completion \
	libevent-dev libncurses5-dev byacc \
	ninja-build gettext libtool libtool-bin \
	autoconf automake cmake g++ pkg-config unzip

    # Install the latest version of tmux
    git clone https://github.com/tmux/tmux.git
    cd tmux
    sh autogen.sh
    ./configure && make && sudo make install
    cd ..

    # Install the latest version of neovim
    git clone https://github.com/neovim/neovim.git
    cd neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    cd ..
    rm -rf tmux neovim

elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install neovim
    brew install tmux
    brew install git
    brew install bash-completion
fi

# Store script location for reference
script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
params="-sf"

# Make vim plugin directory
mkdir -p $script_home/.vim/

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install git bash completion
curl -fLo $script_home/.git-completion.bash --create-dirs \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

# Create symlinks to all files and folders
for i in .vimrc .vim .dircolors .bashrc .inputrc \
    .tmux.conf .bash_aliases .gitconfig .git-completion.bash
do
    if [ -f $HOME/$i ]; then rm $HOME/$i; fi
    ln $params $script_home/$i $HOME/$i
done

# Neovim init file setup
mkdir -p $HOME/.config/nvim/
cp $script_home/init.vim $HOME/.config/nvim/init.vim

# Install plugins for vim
nvim -E -c PlugInstall -c qall

# Reset inputrc and bashrc
bind -f  ~/.inputrc
source ~/.bashrc
