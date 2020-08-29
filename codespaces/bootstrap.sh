#!/bin/bash

if
  [[ "${USER:-}" == "root" ]]
then
  echo "This script works only with normal user, it wont work with root, please log in as normal user and try again." >&2
  exit 1
fi

set -e

echo "Updates packages. Asks for your password."
sudo apt-get update -y

echo "Installs packages. Give your password when asked."
sudo apt-get --ignore-missing install build-essential git-core curl openssl libssl-dev libcurl4-openssl-dev zlib1g zlib1g-dev libreadline6-dev libyaml-dev libsqlite3-dev libsqlite3-0 sqlite3 libxml2-dev libxslt1-dev libffi-dev software-properties-common libgdm-dev libncurses5-dev automake autoconf libtool bison postgresql postgresql-contrib libpq-dev pgadmin3 libc6-dev tmux -y

echo "Installs ImageMagick for image processing"
sudo apt-get install imagemagick --fix-missing -y

echo "Installs RVM (Ruby Version Manager) for handling Ruby installation"
# Retrieve the GPG key.
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

echo "gem: --no-ri --no-rdoc" > ~/.gemrc

echo "Installing kiex - Elixir Version Manager"
curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s stable
echo '[[ -s "$HOME/.kiex/scripts/kiex" ]] && source "$HOME/.kiex/scripts/kiex"' >> ~/.bashrc

echo "Fetching Erlang & Elixir Deps"
wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
sudo apt-get update -y
rm -fr erlang-solutions*

echo "Install Erlang"
sudo apt-get install esl-erlang -y

echo "Install Elixir"
sudo apt-get install elixir -y

echo "Install Hex, Elixir package manager"
mix local.hex --force

echo "Install Phoenix application generator"
mix archive.install hex phx_new --force

echo "Add Tak2MeGooseman's tmux conf"
wget https://raw.githubusercontent.com/talk2MeGooseman/tools-and-workflow-stuff/master/.tmux.conf
mv .tmux.conf ~/

echo "Install TPM, Tmux Plugin Manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Add Talk2MeGooseman's .vimrc"
wget https://raw.githubusercontent.com/talk2MeGooseman/tools-and-workflow-stuff/master/.vimrc
mv .vimrc ~/

echo "Install docker-compose since Codespaces has Docker but not compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

exec /bin/bash --login
