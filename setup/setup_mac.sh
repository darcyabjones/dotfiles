#!/usr/bin/env bash

set -euo pipefail

REPO="git@github.com:darcyabjones/dotfiles.git"
EMAIL="darcy.ab.jones@gmail.com"
UNAME="darcyabjones"

# Install basic software


# Create an ssh key if it doesn't exist and register it with ssh-agent
if false
then
  ssh-keygen -t ed25519 -C "${EMAIL}"

  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
fi

brew install \
  tmux \
  tree \
  ca-certificates \
  git \
  cairo \
  jupyterlab \
  coreutils \
  neovim \
  node \
  python@3.10 \
  wget \
  openjdk		 \
  rclone \
  nvm \
  gawk \
  htop \
  gcc@11 \
  libx11 \
  pandoc \
  igv \
  mosh \
  parallel \
  sqlite \
  zstd

brew install --cask julia r rstudio


# Configure git

git config --global user.name "${UNAME}"
git config --global user.email "${EMAIL}"


# Setup dotfiles

mkdir -p "${HOME}/.local"
mkdir -p "${HOME}/.local/bin"

mkdir -p "${HOME}/.config"


BASE="${HOME}/.dotfiles"
git clone "${REPO}" "${BASE}"


wget -O ${BASE}/dircolors https://raw.githubusercontent.com/dracula/dircolors/main/.dircolors

##  Link dotfiles

ROOTFILES=(
  aliases bash_profile bashrc condarc 
  env inputrc Rprofile 
  tmux.conf zshrc zsh_plugins.txt dircolors
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



## NVM, NPM, Node

mkdir "${HOME}/.nvm"

## Miniconda3

cd /tmp

wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
bash Miniforge3-MacOSX-arm64.sh -b -p "${HOME}/.miniforge3"

cd "${HOME}"


## Julia
### https://julialang.org/downloads/


# Make sure you add things to path as in "env"
if [ -f "${HOME}/.env" ]
then
    . "${HOME}/.env"
fi


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

julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer"); Pkg.add("IJulia")'

# https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#r_language_server

R -e 'install.packages("languageserver")'
R -e 'install.packages("IRkernel")'

# https://github.com/rust-lang/rust-analyzer
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer

# Setup zsh

sudo chsh -s "$(which zsh)" "${USER}"
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote


git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
tmux source "${HOME}/.tmux.conf"
"${HOME}"/.tmux/plugins/tpm/bin/install_plugins
