#!/usr/bin/env bash
set -eux
cp -ar ./vim $HOME/.vim
cp -a ./tmux/.tmux.conf $HOME
cp -ar ./ssh/.ssh $HOME/
cp -ar ./bash/.[^.]* $HOME/
