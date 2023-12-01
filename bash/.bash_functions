#--| load all ssh-keys |--#
function sshload () {
    ssh-add -l &>/dev/null
    [[ "$?" == 1 ]] && \
        for I in $HOME/.ssh/*.pub ; do
        ssh-add ${I/.pub/}
    done
  }

#--| show weather |--#
function weather () {
    curl -4 "http://wttr.in/${1}?lang=de"
    :
  }

#--| copy "$file" to "$file.bak" |--#
function bak() {
    cp -af -- "$1" "$1.bak";
  }

#--| quick tar (with zstd) up a directory, appending the current date/time |--#
function tardate() { IFS=$'\t' tar --zstd -cvf "${1}"-$(date +%d%m%y-%H%M%S).tar.zst "${1}"; }

#--| archives |--#
function ex() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1    ;;
      *.tar.gz)    tar xzf $1    ;;
      *.bz2)       bunzip2 $1    ;;
      *.rar)       unrar x $1    ;;
      *.gz)        gunzip $1     ;;
      *.tar)       tar xf $1     ;;
      *.tbz2)      tar xjf $1    ;;
      *.tgz)       tar xzf $1    ;;
      *.zip)       unzip $1      ;;
      *.Z)         uncompress $1 ;;
      *.7z)        7z x $1       ;;
      *.deb)       ar x $1       ;;
      *.tar.xz)    tar xf $1     ;;
      *.tar.zst)   unzstd $1     ;;
      *.lzma)      unlzma $1     ;;
      *.bz2)       bunzip2 $1    ;;
      *.xz)        unxz $1       ;;
      *.exe)       cabextract $1 ;;
      *.cpio)      cpio -id < $1 ;;
      *.cba|*.ace) unace x $1    ;;
      *.zpaq)      zpaq x $1     ;;
      *.arc)       arc e $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
  }

#--| lf |--#
unset lfcd
function lfcd () {
    tmp="$(mktemp)"
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null 2>&1
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                \cd "$dir"
            fi
        fi
    fi
  }

#--| backup tarball |--#
function backup_file() {
    file_name=$(echo "$1" | tr -d / )
    dir="$HOME/backup/"
    [ -d "$dir" ] || mkdir "$dir"
    backup_name="$(date +%Y-%m-%d_%H_%M)_backup_${file_name}.tar.gz"
    echo "# Create $backup_name ..."
    if [[ $(command -v pv) ]]; then
        tar -czf - "$1" | (pv -p --timer --rate --bytes > "${dir}${backup_name}")
    else
        tar -czf "${dir}${backup_name}" "$1"
    fi
    echo "## Backup saved to » "${dir}${backup_name}""
    echo "### Finish."
  }

#--| git status with arguments |--#
function g() {
    if [[ $# -gt 0 ]]; then
        git "$@"
    else
        git status
    fi
}

#--| fzf kill processes |--#
function fzk() {
if [ "$UID" != "0" ]
  then
     pid=$(ps -f -u $UID | sed 1d | fzf -m  --prompt="kill proc > " | awk '{print $2}')
  else
     pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi
  if [ "x$pid" != "x" ]
    then
      echo $pid | xargs kill -${1:-9}
  fi
}

#--| fzf find pid |--#
function fzp() {
  local pid
  pid=$(ps auxw | sed 1d | fzf -m --prompt="find pid > " --preview-window=:hidden | awk '{print $2}')
  if [ "x$pid" != "x" ]
  then
    echo "PID : $pid"
    unset pid
  fi
}

#--| fzf zoxide |--#
fzz() {
  eval "zi"
}

#--| fzf edit files |--#
function fze() {
  local files
      IFS=$'\n' files=($(command fdfind . "$HOME/projects" '/etc' '/opt' '/boot' --type f --type l --hidden --follow --exclude .git | fzf -m --no-info --preview-window=:nohidden --prompt=" edit file > " --reverse))
  [[ -n "$files" ]] && sudo -E ${EDITOR:-nvim} "${files[@]}"
}

#--| fzf edit dotfiles |--#
function fzd() {
  local files
  IFS=$'\n' files=($(command find $HOME/.dotfiles -type f \
    ! -ipath "*/documents/*" \
    ! -ipath "*/backup/*" \
    ! -ipath "*/borg/*" \
    ! -ipath "*/emacs/*" \
    ! -ipath "*/downloads/*" \
    ! -ipath "*/repos/*" \
    ! -ipath "*/projects/*" \
    ! -ipath "*/.git/*" \
    ! -ipath "*/gtk/*" \
    ! -ipath "*/.npm/*" \
    ! -ipath "*/icons/*" \
    ! -ipath "*/oh-my-zsh/*" \
    ! -ipath "*/.cache/*" \
    ! -ipath "*/.local/*" \
    ! -name  ".DS_Store" \
    2>/dev/null \
    | fzf -m --no-info --preview-window=:nohidden --prompt="edit > " --reverse))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

#--| fzf list aliases |--#
function fza() {
  LBUFFER="$LBUFFER$(FZF_DEFAULT_COMMAND=
  alias | sed 's/=/ --- /' | \
    awk -v blu=$(tput setaf 4) -v cyn=$(tput setaf 6) -v bld=$(tput bold) -v rst=$(tput sgr0) -F '---' \
      '{
        print bld cyn $1 rst blu "--" $2
      }' | \
    tr -d "'" | column -tl2 | \
    fzf --prompt="show alias > " \
        --preview 'echo {3..} | batcat --color=always --plain --language=sh' \
        --preview-window 'up:4:nohidden:wrap' | cut -d' ' -f 1)"
}

#--| fzf show logfiles |--#
function fzl() {
  local files
  local FZF_DEFAULT_COMMAND="find -L -type f -exec readlink -f {} +;"
  IFS=$'\n' files=($(command sudo fdfind . '/var/log' -tf -tl | fzf -m --no-info --preview-window=:hidden \
      --prompt="show log > " --reverse))
  [[ -n "$files" ]] && sudo -E batcat -p "${files[@]}"
  unset files
}

#--| fzf show var |--#
function fzv() {
    local var
    var=$(printenv | cut -d= -f1 | fzf --prompt="show var > " --preview-window=:hidden ) \
      && echo "$var=$(printenv "$var")" \
      && unset var
}

#--| fzf attach tmux session |--#
function fzta() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --prompt="tmux attach session > " --preview-window=:hidden --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

#--| fzf change projects dirs |--#
fzproj() {
    result=$(find ~/projects/* -type d -prune -exec basename {} ';' | sort | uniq | nl | fzf --preview-window=:hidden --prompt="jump to project > "| cut -f 2)
    [ -n "$result" ] && \cd ~/projects/$result
    unset result
}

#--| fzf search a file and fzf from a start directory |--#
function fzo(){
  local startDir="$1"

  # Contains the file path if we selected a file with fzf, is empty if
  # we cancelled the search with escape
  local fileMaybe=$(fzf_from "$startDir")
  if [ -n "$fileMaybe" ]; then
    # Use the default editor if it's defined, otherwise vi
    ${EDITOR:-vi} "$fileMaybe"
  fi
  unset startDir
  unset fileMaybe
}

#--| fzf man without options will use fzf to select a page |--#
function fzman() (
    MAN="/usr/bin/man"
    if [ -n "$1" ]; then
        $MAN "$@"
        return $?
    else
        $MAN -k . | fzf --reverse --prompt='show man page > ' --preview-window=:hidden --preview="echo {2} | sed 's/(.*//' | xargs $MAN -P cat" | awk '{print $1}' | sed 's/(.*//' | sed 's/,//'| xargs $MAN
        return $?
    fi
)

#--| fzf select a docker container to start and attach to |--#
function fzda() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
  unset cid
}

#--| fzf select a running docker container to stop |--#
function fzds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
  unset cid
}

#--| delete docker container with multi selection: |--#
function fzdrm() {
  docker ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r docker rm
}

# fzf select a docker image or images to remove |--#
function fzdrmi() {
  docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}

#--| fzf show docker IP addresses |--#
function daddrs() { docker inspect "${1:-bridge}" | jq '.[0].Containers | map(.Name + "\t" + .IPv4Address + "\t" + .IPv6Address)[]' -r | sort -V -k2,3 | column -t; }

#--| check if terminal supports 24bit colors |--#
function checkcolor() {
  awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'
}

#--| cd + ls |--#
cd() {
   builtin cd $@
   ls
}

#--| chroot |--#
function chrootmount() {
    if [ -d "${1}" ]; then
        mount -v -t proc /proc "${1}"/proc
        mount -v --rbind /sys "${1}"/sys
        mount -v --rbind /dev "${1}"/dev
        cp -v /etc/resolv.conf "${1}"/etc/resolv.conf
    else echo "Argument is not a directory."
    fi
}

#--| tiny url |--#
function tiny() {
    local URL=${1:?}
    curl -s "http://tinyurl.com/api-create.php?url=$1"
}

#--| openssl |--#
function openssl-view-certificate () {
    openssl x509 -text -noout -in "${1}"
}

function openssl-view-csr () {
    openssl req -text -noout -verify -in "${1}"
}

function openssl-view-key () {
    openssl rsa -check -in "${1}"
}

function openssl-view-pkcs12 () {
    openssl pkcs12 -info -in "${1}"
}

function openssl-client () {
    openssl s_client -status -connect "${1}":443
}

# Convert PEM private key, PEM certificate and PEM CA certificate
# (used by nginx, Apache, and other openssl apps) to a PKCS12 file
# (typically for use with Windows or Tomcat)
function openssl-convert-pem-to-p12 () {
    openssl pkcs12 -export -inkey "${1}" -in "${2}" -certfile "${3}" -out "${4}"
}

# Convert a PKCS12 file to PEM
function openssl-convert-p12-to-pem () {
    openssl pkcs12 -nodes -in "${1}" -out "${2}"
}

# Check the modulus of a certificate (to see if it matches a key)
function openssl-check-certificate-modulus {
    openssl x509 -noout -modulus -in "${1}" | shasum -a 256
}

# Check the modulus of a key (to see if it matches a certificate)
function openssl-check-key-modulus {
    openssl rsa -noout -modulus -in "${1}" | shasum -a 256
}

# Check the modulus of a certificate request
function openssl-check-key-modulus {
  openssl req -noout -modulus -in "${1}" | shasum -a 256
}

# Encrypt a file (because zip crypto isn't secure)
function openssl-encrypt () {
    openssl aes-256-cbc -in "${1}" -out "${2}"
}

# Decrypt a file
function openssl-decrypt () {
    openssl aes-256-cbc -d -in "${1}" -out "${2}"
}

# Show ssl fingerprint
function sslfprint() {
  url="$1"
  echo -n | openssl s_client -connect "$1":443 | openssl x509 -noout -fingerprint
  }
