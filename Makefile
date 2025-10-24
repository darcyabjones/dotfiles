OS := mac
THIS_MAKEFILE := "$(abspath $(lastword $(MAKEFILE_LIST)))"
DOTFILES_PREFIX := "$(dir $(abspath $(lastword $(MAKEFILE_LIST))))"
AUTOSTART_TMUX := false

zshrc_mac = zshrc/00-base.sh xrc/00-base.sh xrc/dircolors.sh xrc/01-mac.sh zshrc/zsh_completion.sh zshrc/antidote.sh xrc/R.sh xrc/rust.sh xrc/tmux.sh xrc/vim.sh zshrc/starship.sh zshrc/mambaforge.sh xrc/98-start_tmux_on_load.sh zshrc/99-end.sh
zshrc_linux = zshrc/00-base.sh xrc/00-base.sh xrc/01-linux.sh zshrc/zsh_completion.sh zshrc/antidote.sh xrc/dircolors.sh xrc/R.sh xrc/rust.sh xrc/tmux.sh xrc/vim.sh zshrc/starship.sh zshrc/mambaforge.sh xrc/98-start_tmux_on_load.sh zshrc/99-end.sh

ifeq ($(OS),mac)
	zshrc=$(zshrc_mac)
else
    zshrc=$(zshrc_linux)
endif

bashrc_mac = bashrc/00-base.sh xrc/00-base.sh xrc/dircolors.sh xrc/01-mac.sh bashrc/bash_completion.sh xrc/R.sh xrc/rust.sh xrc/tmux.sh xrc/vim.sh bashrc/starship.sh bashrc/mambaforge.sh xrc/98-start_tmux_on_load.sh
bashrc_linux = bashrc/00-base.sh xrc/00-base.sh xrc/dircolors.sh xrc/01-linux.sh bashrc/bash_completion.sh xrc/R.sh xrc/rust.sh xrc/tmux.sh xrc/vim.sh bashrc/starship.sh bashrc/mambaforge.sh xrc/98-start_tmux_on_load.sh

ifeq ($(OS),mac)
	bashrc=$(bashrc_mac)
else
    bashrc=$(bashrc_linux)
endif

ifeq ($(AUTOSTART_TMUX),true)
	bashrc += xrc/98-start_tmux_on_load.sh
	zshrc += xrc/98-start_tmux_on_load.sh
endif

tmuxconf = tmux/00-base.conf tmux/plugins_tpm.conf tmux/theme_nightfox.conf tmux/98-hide_statusbar.conf tmux/99-end.conf


all: $(zsh) $(bash) $(tmux) $(nvim) ~/.inputrc ~/.dircolors ~/.alacritty.yml ~/.gitconfig ~/.condarc ~/.Rprofile

antidote: ~/.config/antidote
	echo "DONE"

zsh: ~/.zshrc antidote
	echo "DONE"

bash: ~/.bashrc ~/.bash_profile
	echo "DONE"

tmux: ~/.tmux.conf
	echo "DONE"

nvim: ~/.config/nvim
	echo "DONE"

conda: ~/.condarc
	echo "TODO: actually install mambaforge?"

~/.zshrc: $(zshrc)
	cat $^ | (grep -v '#!' || :) > $@

~/.bashrc: $(bashrc)
	cat $^ | (grep -v '#!' || :) > $@

~/.bash_profile: bash_profile
	cp $< $@

~/.tmux.conf: $(tmuxconf)
	cat $^ > $@

~/.inputrc: inputrc
	cp $< $@

~/.dircolors: dircolors/nightfox.dircolors
	cp $< $@

~/.alacritty.yml: alacritty.yml
	cp $< $@

~/.gitconfig: gitconfig
	cp $< $@

~/.condarc: condarc
	cp $< $@

~/.Rprofile: Rprofile
	cp $< $@

~/.config/nvim: nvim
	mkdir -p ~/.config
	ln -sf $< $@

~/.config/antidote:
	mkdir -p ~/.config
	[[ ! -d ~/.config/antidote ]] && git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.config/antidote
	git -C ~/.config/antidote pull
