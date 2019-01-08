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
# TODO install here some alias & configuration inside ~/.gitconfig
# likely the best way is to add everithing using something like git --config global
log_section
log_status "Done!"
