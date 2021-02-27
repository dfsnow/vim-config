#!/bin/bash

# Install script for debian-based systems
if [[ "$OSTYPE" == "linux-gnu" ]]; then

    # Prompt to install from source, otherwise from apt
    read -p "Install tmux/neovim from source? [yn] " -n 1 -r source_answer
    echo

    # Install basic utilities
    sudo apt install -y \
	curl stow rename git bash-completion libssl-dev fd-find

    if [[ "$source_answer" =~ ^[Yy]$ ]]; then

	# Install build dependencies for tmux and neovim
	sudo apt install -y \
	    libevent-dev libncurses5-dev byacc \
	    ninja-build gettext libtool libtool-bin \
	    autoconf automake cmake g++ pkg-config unzip \
	    nodejs npm

	# Install the latest version of tmux
	git clone https://github.com/tmux/tmux.git build_tmux
	cd build_tmux || exit
	sh autogen.sh
	./configure && make && sudo make install
	cd ..

	# Install the latest version of neovim
	git clone https://github.com/neovim/neovim.git build_neovim
	cd build_neovim || exit
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
	cd ..
	rm -rf build_tmux build_neovim

    else
	sudo apt install -y tmux neovim nodejs npm
    fi

# Install script for mac-based systems
elif [[ "$OSTYPE" == "darwin"* ]]; then

    # Install brew package if not exists, else upgrade
    function install_or_upgrade {
	if brew ls --versions "$1" >/dev/null; then
	    HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$1"
	else
	    HOMEBREW_NO_AUTO_UPDATE=1 brew install "$1"
	fi
    }

    for pkg in stow neovim tmux git bash-completion fd node; do
	install_or_upgrade "$pkg"
    done
fi

# Create symlinks to all files and folders using GNU stow
for pkg in tmux vim bash git; do
    stow "$pkg"
done

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins for vim
nvim +PlugInstall +PlugUpdate +qall

# Reset inputrc and bashrc
bind -f  ~/.inputrc
source "$HOME"/.bashrc
