#--| $HOME/.bash_profile |--#

#--| applications |--#

if [[ "$(command -v nvim)" ]]; then
  export VISUAL='vim'
  export EDITOR='vim'
fi

if [[ "$(command -v rg)" ]]; then
  if [ -f "${HOME}/.config/ripgrep/ripgreprc" ]; then
    export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
  fi
fi

export PAGER='less'
export TTY=$(tty)
export GPG_TTY="$(tty)"

#--| xdg |--#

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DOCUMENTS_DIR="${HOME}/documents"
export XDG_DOWNLOAD_DIR="${HOME}/downloads"
export XDG_MUSIC_DIR="${HOME}/music"
export XDG_PICTURES_DIR="${HOME}/pictures"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_VIDEOS_DIR="${HOME}/videos"

#--| less |--#

#export LESS="-RFi"
export LESS="-SXIFRs"
export LESSHISTFILE="-"
export LESS_TERMCAP_mb=$'\E[1;32m'
export LESS_TERMCAP_md=$'\E[01;34m' LESS_TERMCAP_me=$'\E[1m' GROFF_NO_SGR=1
export LESS_TERMCAP_se=$'\E[0m' LESS_TERMCAP_so=$'\E[01;31m'
export LESS_TERMCAP_us=$'\E[04;36m' LESS_TERMCAP_ue=$'\E[0m'
export MANPAGER="less"

#--| misc |--#

export CLICOLOR=1
export ESCDELAY=0
export PROMPT_EOL_MARK=""
export SUDO_PROMPT="[sudo] %p's password: "

#--| read .bashrc |--#

if [ -f "$HOME"/.bashrc ]; then
  . "$HOME"/.bashrc
fi
