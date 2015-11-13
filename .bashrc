export PYTHONPATH=/opt/qt/lib/python2.7/dist-package
source ~/.git-prompt.sh
export PS1='[\u@\h \[\e[33m\]\w\[\e[0;32m\]$(__git_ps1 " (%s)")\[\e[m\]\$ '
