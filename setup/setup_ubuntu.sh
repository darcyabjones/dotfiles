#!/usr/bin/env bash

set -euo pipefail

REPO="git@"
EMAIL="darcy.ab.jones@gmail.com"
UNAME="darcyabjones"

# Install basic software

sudo apt update
sudo apt upgrade

##  Adds the dev version of mosh
sudo add-apt-repository ppa:keithw/mosh-dev
sudo apt update

sudo apt install \
  zsh mosh \
  vim tmux \
  rsync git \
  python3 python3-pip python3-venv \
  lua5.1 luajit libluajit-5.1-dev \
  wget \
  software-properties-common \
  dirmngr \
  xml2 libxml2 libxml2-dev \
  build-essential


# Create an ssh key if it doesn't exist and register it with ssh-agent
if false
then
  ssh-keygen -t ed25519 -C "${EMAIL}"
  
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
fi


# Configure git

git config --global user.name "${UNAME}"
git config --global user.email "${EMAIL}"


# Setup dotfiles

mkdir -p "${HOME}/.local"
mkdir -p "${HOME}/.local/bin"

mkdir -p "${HOME}/.config"


BASE="${HOME}/.dotfiles"
git clone "${REPO}" "${BASE}"


##  Link dotfiles

ROOTFILES=(
  aliases bash_profile bashrc condarc 
  env inputrc Rprofile 
  tmux.conf zshrc zsh_plugins.txt
)

for f in "${ROOTFILES[@]}"
do
  if [[ -f "${HOME}/.${f}" ]]
  then
    mv "${HOME}/.${f}" "${HOME}/.${f}.bkp"
  fi

  ln -sf "${HOME}/.dotfiles/${f}" "${HOME}/.${f}"
done

mkdir -p "${HOME}/.config/nvim"
ln -sf "${BASE}/config/nvim/init.lua" "${HOME}/.config/nvim/init.lua"
ln -sf "${BASE}/config/nvim/lua" "${HOME}/.config/nvim/lua"


## Rclone

cd /tmp

wget https://downloads.rclone.org/v1.59.2/rclone-v1.59.2-linux-amd64.deb
sudo apt install ./rclone-v1.59.2-linux-amd64.deb

rm rclone-v1.59.2-linux-amd64.deb
cd "${HOME}"


## Neovim

cd /tmp

wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb
sudo apt install nvim-linux64.deb

rm nvim-linux64.deb
cd "${HOME}"


## NVM, NPM, Node

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

nvm install node
nvm install-latest-npm
nvm alias default node
echo "lts/*" > ~/.nvmrc # to default to the latest LTS version


## Miniconda3

cd /tmp

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p "${HOME}/.miniconda3"

cd "${HOME}"


## Julia
### https://julialang.org/downloads/

cd /tmp
wget "https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.1-linux-x86_64.tar.gz"
wget "https://julialang-s3.julialang.org/bin/checksums/julia-1.8.1.md5"
grep "julia-1.8.1-linux-x86_64.tar.gz" "julia-1.8.1.md5"  | md5sum -c

mkdir -p "${HOME}/.julia"
tar -C "${HOME}/.julia" -zxf "./julia-1.8.1-linux-x86_64.tar.gz"

rm -f "./julia-1.8.1-linux-x86_64.tar.gz"
rm -f "./julia-1.8.1.md5"

# Make sure you add things to path as in "env"
if [ -f "${HOME}/.env" ]
then
    . "${HOME}/.env"
fi


## R

#https://cran.r-project.org/bin/linux/ubuntu/fullREADME.html

wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt install r-base

sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+

mkdir -p "${HOME}/.local/lib/R/site-library"
export R_LIBS_USER="${HOME}/.local/lib/R/site-library"


## Rust

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
| sh -s -- -y --no-modify-path --default-toolchain nightly --profile default 
source "${HOME}/.cargo/env"


## Used in neovim
npm install --global pyright
npm install --global bash-language-server
npm install --global awk-language-server
npm install --global vscode-langservers-extracted
npm install --global dockerfile-language-server-nodejs

julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
wget -qO "${HOME}/.local/bin/marksman" https://github.com/artempyanykh/marksman/releases/download/2022-09-13/marksman-linux

# https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#r_language_server

R -e 'install.packages("languageserver")'

# https://github.com/rust-lang/rust-analyzer
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer


# Setup zsh

sudo chsh -s "$(which zsh)" "${USER}"
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote


git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
tmux source "${HOME}/.tmux.conf"
"${HOME}"/.tmux/plugins/tpm/bin/install_plugins
