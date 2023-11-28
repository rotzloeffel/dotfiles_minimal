#--| $HOME/.bashrc |--#

# if not running interactively, don't do anything
[[ -n $PS1 ]] || return

#--| umask |--#

# read and write for the owner only.
# umask 002 # relaxed   -rwxrwxr-x
# umask 022 # cautious  -rwxr-xr-x
# umask 027 # uptight   -rwxr-x---
# umask 077 # paranoid  -rwx------
# umask 066 # bofh-like -rw-------
umask 066

# if root set umask to 022 to prevent new files being created group and world writable
if (( EUID == 0 )); then
    umask 022
fi

#--| general |--#

# cursor blink rate
echo -e '\e[16;550]'

# vi keys in shell
set -o vi

# disable ctrl-s ctrl-q in bash
stty -ixon

#--| source files |--#

# load aliases
if [ -f $bash_aliases ]; then
    . $HOME/bash_aliases
fi

# load functions
if [ -f $HOME/bash_functions ]; then
    . $HOME/bash_functions
fi

# load fzfrc
if [ -f "$HOME}/.fzfrc" ]; then
    source "${HOME}.fzfrc"
fi

# load fzf keybindings
[[ -s "/usr/share/doc/fzf/examples/key-bindings.bash" ]] && source /usr/share/doc/fzf/examples/key-bindings.bash

#--| directories |--#

# ssh sockets
[ -d "$HOME/.ssh/sockets" ] || \mkdir -p $HOME/.ssh/sockets && \chmod 700 $HOME/.ssh/sockets

# nano
[ -d "$HOME/backup/nano" ] || \mkdir -p $HOME/backup/nano/

#--| path |--#

# add to $PATH if directory "$HOME/.local/bin" exists
   if [ -d "$HOME"/.local/bin ]; then
        case ":$PATH:" in
            *:$HOME/.local/bin:*) ;;
            *) PATH=$PATH:"$HOME"/.local/bin ;;
        esac
   fi

# add to $PATH if directory "$HOME/bin" exists
   if [ -d "$HOME"/bin ]; then
        case ":$PATH:" in
            *:$HOME/bin:*) ;;
            *) PATH=$PATH:"$HOME"/bin ;;
        esac
   fi

#--| ssh agent |--#

if [ $(ps ax | grep "[s]sh-agent" | wc -l) -eq 0 ] ; then
    eval $(ssh-agent -s) > /dev/null
    if [ "$(ssh-add -l)" = "The agent has no identities." ] ; then
        ssh-add ~/.ssh/id_ed25519 > /dev/null 2>&1
    fi
fi

#--| keybindings |--#

# useful commands = "bind -p", "bind-l", "bind -v"

# "ALT-v" -> edit commandline with $EDITOR

# bind "ALT+i" to fuzzy find process ids
bind -x '"\ei":"fzp"'

# bind "ALT+o" to fuzzy cd into project dirs
bind -x '"\eo":"fzproj"'

# bind "ALT+p" to fuzzy kill processes
bind -x '"\ep":"fzk"'

# bind "ALT+s" to fuzzy environment vars
bind -x '"\es":"fzv"'

# bind "ALT+m" to fuzzy find man pages
bind -x '"\em":"fzman"'

# bind "ALT+t" to fuzzy attach tmux sessions
bind -x '"\et":"fzta"'

# bind "ALT+g" to fuzzy show logfiles
bind -x '"\eg":"fzl"'

# bind "ALT+a" to fuzzy find aliases
bind -x '"\ea":"fza"'

# bind "ALT+e" to fuzzy edit files
bind -x '"\ee":"fze"'

# bind "ALT+d" to fuzzy edit dotfiles
bind -x '"\ed":"fzd"'

# bind "ALT+f" to fuzzy zoxide
bind -x '"\ef":"zi"'

#--| history |--#

# sets the amount of entries to be unlimited.
export HISTSIZE=""

# sets the filesize to be unlimited.
export HISTFILESIZE=""

# set time format.
export HISTTIMEFORMAT="[%d.%m.%y %T] "

# define commands that should be ignored.
# the commands must be separated by a double point and include the exact option- and flag parameters!
export HISTIGNORE="pwd:vim:ca:cb:sb:cP:cs:ll:cd:v:l:x:ls:ls -ltr:ls -lAhF:cd ..:.."

#--| shell options |--#

# sets the control filter.
export HISTCONTROL="ignoreboth"

# append to the history file, don't overwrite it
shopt -s histappend

# attempts to save all lines of a multiple-line command in the same history entry to allow easy re-editing of multi-line
# commands.
shopt -s cmdhist

# if the "cmdhist" option is enabled, multi-line commands are saved to the history with embedded newlines rather than
# using semicolon separators where possible.
shopt -u lithist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# a command name that is the name of a directory is executed as if it were the argument to the "cd" command.
# this option is only used by interactive shells.
shopt -s autocd

# minor errors in the spelling of a directory component in a cd command will be corrected.
# the errors checked for are transposed characters, a missing character and a character too many.
# if a correction is found, the corrected path is printed, and the command proceeds.
# this option is only used by interactive shells.
shopt -s cdspell

# lists the status of any stopped and running jobs before exiting an interactive shell.
# if any jobs are running, this causes the exit to be deferred until a second exit is attempted without an intervening
# command.
# the shell always postpones exiting if any jobs are stopped.
shopt -s checkjobs

# replaces directory names with the results of word expansion when performing filename completion.
# this changes the contents of the readline editing buffer.
# if not set, bash attempts to preserve what the user typed.
shopt -s direxpand

# attempts spelling correction on directory names during word completion if the directory name initially supplied does
# not exist.
shopt -s dirspell

# includes filenames beginning with a '.' in the results of filename expansion.
shopt -s dotglob

# patterns which fail to match filenames during filename expansion result in an expansion error.
shopt -u failglob

# enables extended pattern matching features for auto completion options.
shopt -s extglob

# matches filenames in a case-insensitive fashion when performing filename expansion.
shopt -u nocaseglob

#--| applications |--#

# load "zoxide" a smarter cd command
if [ -x "$(command -v zoxide)" ]; then
    eval "$(zoxide init bash)"
fi

#--| prompt |--#
if [ -f "$HOME/.bash_prompt" ]; then
  source "$HOME/.bash_prompt"
fi
