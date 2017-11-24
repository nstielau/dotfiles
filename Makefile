.PHONY: link

link:
	ln -sf ~/.dotfiles/.nanorc ~/.nanorc
	ln -sf ~/.dotfiles/.zshrc ~/.zshrc
	ln -sf ~/.dotfiles/.bashrc ~/.bashrc
	ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
	mkdir -p ~/.oh-my-zsh/custom/themes
	ln -sf ~/.dotfiles/.oh-my-zsh/custom/themes/nstielau.zsh-theme ~/.oh-my-zsh/custom/themes/nstielau.zsh-theme
