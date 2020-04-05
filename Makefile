.PHONY: link

link:
	ln -sf ~/.dotfiles/.nanorc ~/.nanorc
	ln -sf ~/.dotfiles/.zshrc ~/.zshrc
	ln -sf ~/.dotfiles/.zshrc.linux ~/.zshrc.linux
	ln -sf ~/.dotfiles/.bashrc ~/.bashrc
	ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
	mkdir -p ~/.oh-my-zsh/custom/themes
	ln -sf ~/.dotfiles/.oh-my-zsh/custom/themes/nstielau.zsh-theme ~/.oh-my-zsh/custom/themes/nstielau.zsh-theme
	ln -sf ~/.dotfiles/.fzf_completion.sh ~/.fzf_completion.sh


brew:
	brew install fd # find alternative
	brew install fzf # fuzzy finder
	brew install nano
	brew install wget

dnf:
	dnf install -y nano
	dnf install -y zsh

