#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/git/completion/git-prompt.sh

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$HOME/.local/lib/python3.5/site-packages:$PATH"
fi

complete -cf sudo

export PYTHONPATH="/opt/qt/lib/python2.7/dist-package:$PYTHONPATH"
export TERM="screen-256color"
export POWERLINE_CONFIG_COMMAND=~/.local/bin/powerline-config

eval $(dircolors ~/.dircolors)

alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
alias tmux="tmux -2"

#PS1='[\[\033[5;34m\]\u\e[m@\h \[\033[5;31m\]\W\e[0;32m$(__git_ps1 " (%s)")\e[m]\$ '

