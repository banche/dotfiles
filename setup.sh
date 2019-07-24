#!/bin/sh

log_status() {
    echo " -- $1..."
}

log_section() {
    echo "==============="
}

install_file() {
    name=$(basename $1)
    dest="$HOME/.$name"
    src=$1
    if [ -f $dest ]; then
        diff $dest $src &> /dev/null
        if [ $? -ne 0 ]; then
            log_status "Moving $dest -> $dest.back"
            mv $dest "$dest.back"
        else
            return
        fi
    fi
    ln -s $src $dest
}
SCRIPT=$(readlink -m $0)
ROOT=$(dirname $SCRIPT)
log_section
log_status "Installing Vim"
install_file "$ROOT/vim/vimrc"
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone --quiet https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi
log_section
log_status "Installing Tmux"
install_file "$ROOT/tmux/tmux.conf"
install_file "$ROOT/tmux/tmux.theme"
log_section
log_status "Installing git configuration"
install_file "$ROOT/git/gitignore"
git config --global core.excludesfile "~/.gitignore"
log_status "Installing git aliases"
git config --global alias.c commit
git config --global alias.l log
git config --global alias.s status -sb
git config --global alias.ca commit --amend
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.f fetch
git config --global alias.cob checkout -b
git config --global alias.co checkout
log_section
log_status "Done!"
