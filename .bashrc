
IS_OPENSUSE=false
if [[ -d /etc/resolv.conf ]]; then
    grep -q '^domain pc.scharp.org$' /etc/resolv.conf
    if [[ $? -eq 0 ]]; then
	IS_OPENSUSE=true
    fi
fi

IS_TERMUX=false
if [[ -d /data/data/com.termux ]]; then
    IS_TERMUX=true
fi


if [[ $IS_OPENSUSE == true ]]; then

    source /usr/local/admin/defaults/bashrc.sles

    export JAVA_HOME=/scharp/xapps/fw/share/jdk
    export PATH=$HOME/bin/linux:$HOME/bin:$JAVA_HOME/bin:/scharp/xapps/fw/bin:$PATH

    umask 022
elif [[ $IS_TERMUX == true ]]; then
    export PATH=$HOME/bin:$PATH
else
    # generic distribution
    set foo=bar
fi

# settings common to all distributions

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export PATH=$PATH:$HOME/common-bin
