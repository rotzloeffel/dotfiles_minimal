#--| $XDG_CONFIG_HOME/shell/aliases |--#

#--| remove aliases |--#
unalias -a

#--| detect os |--#
OS=$( compgen -G "/etc/*release" > /dev/null  && grep '^NAME' /etc/*release | sed 's/NAME=//g;s/"//g' )

#--| debian |--#
if [ "$OS" == "Debian GNU/Linux" ] || [ "$OS" == "Ubuntu" ]; then
    alias apt-cache="sudo apt-cache"
    alias apt-get="sudo apt-get"
    alias apt="sudo apt"
    alias apt-file="sudo apt-file"
    alias dpkg-reconfigure="sudo dpkg-reconfigure"
    alias dpkg="sudo dpkg"
    command -v fdfind > /dev/null && alias fd='fdfind'
fi

#--| verbosity |--#
alias mount="mount -v"
alias chgrp="chgrp -v --preserve-root"
alias chmod="chmod -v --preserve-root"
alias chown="chown -v --preserve-root"
alias mkdir="mkdir -pv"
alias rsync='rsync --archive --verbose --ipv4 --progress --human-readable --stats --update'
alias free="free -hltw"
alias stow="stow -vv"
alias mv="mv -iv"
alias cp="cp -iv"
alias ln="ln -iv"
alias df='df -h'
alias du='du -h'
alias dd="dd status=progress"

#--| colors |--#
alias fgrep="fgrep --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -color=auto"

#--| sudo |--#
alias sudo="sudo "
alias systemctl="sudo systemctl"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias tcpdump="sudo tcpdump"
alias pcinfo="sudo -E inxi -v6 -c5"
alias ports="sudo lsof -i -P -n | grep LISTEN | fzf"

#--| general |--#
alias h='history | fzf'
alias md="mkdir"
alias v="$EDITOR"
alias vi="$EDITOR"
alias vim="$EDITOR"
alias x="exit"
alias q="exit"
alias cert="openssl req -new -x509 -nodes -out cert.pem -keyout cert.key -days 365"
alias htpasswd='openssl passwd -apr1'
alias pyhttpd='python -m http.server --directory .'
alias ncdu="ncdu --color dark -r -e"
alias path="echo $PATH | tr -s ':' '\n'"
alias pscpu='ps -r -aceo user,group,pid,ppid,comm,%mem,%cpu,state,tty| head'
alias reset="reset && source $HOME/.bash_profile"
alias rg="rg --hidden --smart-case"
alias su="su -"
alias tree='tree -a -L 2 -I downloads/ -I .cache -I repos -I .npm'
alias utc='env TZ=UTC date'
alias w3m='w3m -o confirm_qq=false'
alias wget="wget --hsts-file="$XDG_CACHE_HOME/wget-hsts""
alias checkemoji="curl https://unicode.org/Public/emoji/13.0/emoji-test.txt | less"
alias checkencoding="ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1"
alias checkutf8="curl https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt | less"
alias checkvirus="clamscan --recursive=yes --infected /home"
alias ipv4="dig @resolver4.opendns.com myip.opendns.com +short -4"
alias ipv6="dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6"

#--| tmux |--#
alias t='tmux attach || tmux new-session'
alias tks="tmux kill-session -t"
alias tls='tmux list-sessions'
alias tns='tmux new-session -d'

#--| docker |--#
alias d="docker"
alias dnets="docker network ls -q | xargs docker inspect | jq '.[] | select(.Name != \"host\" and .Name != \"none\") | [.] | map(.Name + \"\t\" + (.IPAM.Config | map(.Subnet) | join(\"\t\")))[]' -r | sort -V -k2,3 | column -t"
alias dps="docker ps --format='table {{.ID}}\t{{.Image}}\t{{.Label \"org.label-schema.version\"}}\t{{.Networks}}\t{{.RunningFor}}\t{{.Status}}\t{{.Names}}' | sed '1s/version/VERSION/'"
alias dpsa="docker ps -a --format='table {{.ID}}\t{{.Image}}\t{{.Label \"org.label-schema.version\"}}\t{{.Networks}}\t{{.RunningFor}}\t{{.Status}}\t{{.Names}}' | sed '1s/version/VERSION/'"

#--| ansible |--#
alias ap="ansible-playbook"
alias al="ansible-lint"

#--| cd |--#
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

#--| bookmarks |--#
alias gc="cd  $HOME/.config"
alias gD="cd  $HOME/.dotfiles"
alias gl="cd  $HOME/.local"
alias gB="cd  $HOME/backup"
alias gd="cd  $HOME/downloads"
alias gp="cd  $HOME/projects"
alias gr="cd  $HOME/repos"

#--| edit files |--#
alias cb="$EDITOR $HOME/.bashrc"
alias sb="source  $HOME/.bashrc && echo '== bashrc reloaded =='"
alias cB="$EDITOR $HOME/.bash_profile"
alias sB="source  $HOME/.bash_profile && echo '== bash_profile reloaded =='"

#--| ls |--#
alias ls='ls -h -F --color=always'
alias ll='ls -l'
alias l='ls'
alias la='ls -a'
alias lla='ls -al'
alias l.='ls -d .* 2>/dev/null'
alias lt='find . | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/" '
alias ltr='ls -altr'
alias lsbl='cd > /dev/null ;fd --hidden --follow --type=l'

#--| exa |--#
EXA_DIR_PREVIEW="exa \
  --color=always -T \
  --level=3 \
  --icons \
"

if [[ "$TTY" != /dev/tty*[0-9]* ]]; then
    command -v exa > /dev/null   && \
        alias exa='exa --classify --icons --color=always --group-directories-first' && \
        alias l='ls'             && \
        alias ls='exa  -g'       && \
        alias la='exa  -ag'      && \
        alias ll='exa  -lg'      && \
        alias lla='exa -alg'     && \
        alias l.='exa  -d .*'    && \
        alias lsd='exa -Dalg'    && \
        alias ltr='exa -alg -s modified'    && \
        alias lt='exa  -aTg'
        export FZF_ALT_C_OPTS="--preview=\"$EXA_DIR_PREVIEW {}\""
    else
    command -v exa > /dev/null   && \
        alias exa='exa --classify --color=always --group-directories-first' && \
        alias l='ls'             && \
        alias ls='exa  -g'       && \
        alias la='exa  -ag'      && \
        alias ll='exa  -lg'      && \
        alias lla='exa -alg'     && \
        alias l.='exa  -d .*'    && \
        alias lsd='exa -Dalg'    && \
        alias ltr='exa -alg -s modified'    && \
        alias lt='exa -Td -L 2'
        export FZF_ALT_C_OPTS="--preview=\"$EXA_DIR_PREVIEW {}\""
fi

#--| editor |--#
if [[ "$(command -v nvim)" ]]; then
    alias  vv="nvim -u NORC"
fi

#--| duf |--#
if [[ "$(command -v duf)" ]]; then
    alias df='duf'
fi

#--| fdfind |--#
if [[ "$(command -v fd)" ]]; then
    export FZF_ALT_C_COMMAND="fd --type directory --hidden --follow --ignore-file ~/.config/git/ignore"
    alias fd='fd --hidden --follow'
fi

if [[ "$(command -v fdfind)" ]]; then
    export FZF_ALT_C_COMMAND="fdfind --type directory --hidden --follow --ignore-file ~/.config/git/ignore"
    alias fd='fdfind --hidden --follow'
fi

#--| bat |--#
command -v bat > /dev/null && \
    alias cat="bat -p" && \
    alias less="bat -p" && \
    export BAT_THEME="Nord"

#--| top |--#
command -v htop > /dev/null && \
    alias top='htop'
command -v btop > /dev/null && \
    alias top='btop'

#--| neomutt |--#
command -v neomutt > /dev/null && \
    alias mutt='neomutt'

#--| fzf |--#
if [[ "$TTY" != /dev/ttyv[0-9]* ]]; then
    if [ -x "$(command -v rg)" ]; then
      export FZF_CTRL_T_COMMAND='rg --files --no-ignore --no-messages --follow --hidden --glob "!.git/*" '
      export FZF_CTRL_T_OPTS="--preview-window=right --preview 'bat --style=numbers --color=always --line-range :100 {}'"
      export FZF_DEFAULT_COMMAND='rg --files --no-ignore --follow --hidden --glob "!.git/*" 2> /dev/null'
      export FZF_CTRL_R_OPTS="-e --preview-window=:hidden"
    fi
      export FZF_DEFAULT_OPTS="
        -e --bind 'alt-j:down,alt-k:up,enter:accept'
        --layout=reverse
        --history=$XDG_CACHE_HOME/fzf_history
        --history-size=10000
        --info=inline
        --height=80%
        --multi
        --border
        --no-info
        --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
        --prompt=' : ' --pointer='> ' --marker='* '
        --bind ',:toggle-preview'
        --bind 'ctrl-a:select-all'
        --bind 'ctrl-y:execute-silent(echo {+} | wl-copy -n)'
        --bind 'ctrl-e:execute(echo {+} | xargs -o $EDITOR)'
        --bind 'ctrl-v:execute(code {+})'
        --color fg:#665c54,bg:-1,hl:#fabd2f,fg+:#458588,bg+:-1,hl+:#458588
        --color info:#83a598,prompt:#458588,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54"
      export FZF_CTRL_R_OPTS="-e --preview-window=:hidden"
fi

#--| zoxide |--#
if [[ "$(command -v zoxide)" ]]; then
    export _ZO_FZF_OPTS="
      --no-sort
      --keep-right
      --info=inline
      --layout=reverse
      --exit-0
      --select-1
      --bind=ctrl-z:ignore
      --preview-window=right
      --border
      --color fg:#665c54,bg:-1,hl:#fabd2f,fg+:#458588,bg+:-1,hl+:#458588
      --color info:#83a598,prompt:#458588,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
      --prompt=' : ' --pointer='> ' --marker='* '
      --preview=\"$EXA_DIR_PREVIEW {2..} \"
      "
fi
