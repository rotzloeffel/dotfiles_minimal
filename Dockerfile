FROM debian:latest
RUN apt update && \
    apt dist-upgrade -y && \
    apt install --no-install-recommends --no-install-suggests bat curl wget git ca-certificates bsdextrautils less zoxide man nmon htop openssh-client lsd vim tmux procps bash-completion fzf exa fd-find ripgrep sudo -y
RUN rm -rf /root/.bashrc /root/.profile /root/.bash_history
COPY vim/ /root/.vim
COPY ssh/.ssh/config /root/.ssh/
COPY tmux/.tmux.conf /root
COPY bash/.bashrc /root
COPY bash/.bash_profile /root
COPY bash/.bash_prompt /root
COPY bash/.bash_logout /root
COPY bash/.bash_aliases /root
COPY bash/.bash_functions /root
COPY bash/.dircolors /root
COPY bash/.fzfrc /root
COPY bash/.inputrc /root
CMD  cd /root ; /usr/bin/bash -l
