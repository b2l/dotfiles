#!/bin/sh

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/philips/ghar.git ~/.ghar

export PATH=$PATH:~/.ghar/bin/ # You may wish to make this permanent

cd ~/.ghar
git clone git@github.com/b2l/dotfiles

ghar install

vim +InstallPlugin +qall

