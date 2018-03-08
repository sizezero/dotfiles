
IS_OPENSUSE=false
if [[ -f /etc/resolv.conf ]]; then
    grep -q '^domain pc.scharp.org$' /etc/resolv.conf
    if [[ $? -eq 0 ]]; then
	IS_OPENSUSE=true
    fi
fi

IS_TERMUX=false
if [[ -d /data/data/com.termux ]]; then
    IS_TERMUX=true
fi

IS_UBUNTU_HECTOR=false
if [[ -f /etc/os-release ]]; then
    grep -q '^ID=ubuntu$' /etc/os-release
    if [[ $? -eq 0 && $(hostname) == 'hector' ]]; then
	IS_UBUNTU_HECTOR=true
    fi
fi

if [[ $IS_OPENSUSE == true ]]; then

    source /usr/local/admin/defaults/bashrc.sles

    export JAVA_HOME=/scharp/xapps/fw/share/jdk
    export PATH=$HOME/bin/linux:$HOME/bin:$JAVA_HOME/bin:/scharp/xapps/fw/bin:$PATH

    umask 022

elif [[ $IS_TERMUX == true ]]; then

    export PATH=$HOME/bin:$PATH
    # prompt taken from ubuntu
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # above doesn't work so trying a dirt simple one
    PS1='\w\\$ '

elif [[ $IS_UBUNTU_HECTOR == true ]]; then

    force_color_prompt=yes
    source /etc/skel/.bashrc

    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
    fi

    # add android
    ANDROID_HOME=$HOME/usr/android-sdk/sdk
    PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

else
    # generic distribution

    # it looks like an else clause needs at least one command
    true
fi

# settings common to all distributions

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export PATH=$PATH:$HOME/common-bin
