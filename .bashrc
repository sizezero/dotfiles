
grep -q '^domain pc.scharp.org$' /etc/resolv.conf
if [[ $? -eq 0 ]]; then
    IS_OPENSUSE=true
fi

if [[ $IS_OPENSUSE == true ]]; then

    source /usr/local/admin/defaults/bashrc.sles

    export JAVA_HOME=/scharp/xapps/fw/share/jdk
    export PATH=$HOME/bin/linux:$HOME/bin:$JAVA_HOME/bin:/scharp/xapps/fw/bin:$PATH

    umask 022
else
    # generic distribution
fi

# settings common to all distributions

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
