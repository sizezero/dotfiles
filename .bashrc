source /usr/local/admin/defaults/bashrc.sles

export JAVA_HOME=/scharp/xapps/fw/share/jdk
export PATH=$HOME/bin/linux:$HOME/bin:$JAVA_HOME/bin:/scharp/xapps/fw/bin:$PATH

umask 022

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
