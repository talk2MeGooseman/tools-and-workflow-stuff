#!/bin/bash
set -e

echo "Updates packages. Asks for your password."
sudo apt-get update -y

echo "Installs packages. Give your password when asked."
sudo apt-get --ignore-missing install build-essential git-core curl openssl libssl-dev libcurl4-openssl-dev zlib1g zlib1g-dev libreadline6-dev libyaml-dev libsqlite3-dev libsqlite3-0 sqlite3 libxml2-dev libxslt1-dev libffi-dev software-properties-common libgdm-dev libncurses5-dev automake autoconf libtool bison postgresql postgresql-contrib libpq-dev pgadmin3 libc6-dev tmux -y

echo "Installs ImageMagick for image processing"
sudo apt-get install imagemagick --fix-missing -y

echo "Install ZSH"
sudo apt install zsh

if [ -d "$ZSH" ]; then
    echo "oh-my-zsh already installed"
else
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ -d $HOME/.rbenv/bin ]; then
    echo "Skipping rbenv install"
else
    echo 'export PATH=$HOME/.rbenv/bin:$PATH' >> $HOME/.zshrc
    echo "Installs rbenv (Ruby Version Manager) for handling Ruby installation"
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
fi

# Abvoid downloading gem docs
echo "gem: --no-ri --no-rdoc" > $HOME/.gemrc

if ! command -v elixir &> /dev/null
then
    echo "Installing kiex - Elixir Version Manager"
    curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s stable
    echo '[[ -s "$HOME/.kiex/scripts/kiex" ]] && source "$HOME/.kiex/scripts/kiex"' >> $HOME/.zshrc

    echo "Fetching Erlang & Elixir Deps"
    wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
    sudo apt-get update -y
    rm -fr erlang-solutions*

    echo "Install Erlang"
    sudo apt-get install esl-erlang -y

    echo "Install Elixir"
    sudo apt-get install elixir -y
else
    echo "Skipping Erlang/Elixir install"
fi

echo "Install Hex, Elixir package manager"
mix local.hex --force

echo "Install Phoenix application generator"
mix archive.install hex phx_new --force

if ! command -v nvm &> /dev/null
then
    echo "Install NVM (Node Version Manager)"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi

if [ -f $HOME/.tmux.conf ]; then
    echo "tmux.conf exists already, skipping .tmux.conf step to avoid overwritting it."
else
    echo "Add Tak2MeGooseman's tmux conf"
    wget https://raw.githubusercontent.com/talk2MeGooseman/tools-and-workflow-stuff/master/.tmux.conf
    mv .tmux.conf $HOME
fi

if [ -d $HOME/.tmux/plugins/tpm/ ]; then
    echo "Skipping TPM install"
else
    echo "Install TPM, Tmux Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

echo "Installing neovim"
sudo apt install neovim

if [ -f $HOME/.config/nvim/init.vim ]; then
    echo "init.vim exists already, skipping init.vim step to avoid overwritting it."
else
    echo "Add Talk2MeGooseman's .vimrc"
    wget https://raw.githubusercontent.com/talk2MeGooseman/tools-and-workflow-stuff/master/.vimrc
    mkdir --parents $HOME/.config/nvim/;
    mv .vimrc $HOME/.config/nvim/init.vim
fi
