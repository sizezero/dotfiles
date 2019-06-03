
export WHICH_LINUX=generic

if [[ -d /scharp/QUALITY && -d /scharp/xapps ]]; then
    export WHICH_LINUX=scharp
fi

if [[ -d /data/data/com.termux ]]; then
    export WHICH_LINUX=termux
fi

if [[ -f /etc/os-release ]]; then
    grep -q '^ID=ubuntu$' /etc/os-release
    if [[ $? -eq 0 && $(hostname) == 'hector' ]]; then
	export WHICH_LINUX=hector
    fi
fi

if [[ -f $HOME/IS_DREAMHOST_KLEEMANN ]]; then
    export WHICH_LINUX=dreamhost
fi

if [[ -f $HOME/.IS_STEADY ]]; then
    export WHICH_LINUX=steady
fi

if [[ $WHICH_LINUX == "scharp" ]]; then

    source /usr/local/admin/defaults/bashrc.sles

    export JAVA_HOME=/scharp/xapps/fw/share/jdk
    export PATH=$HOME/bin/linux:$HOME/bin:$JAVA_HOME/bin:/scharp/xapps/fw/bin:$HOME/local/bin:$PATH

    PS1='╭─\u@\h: \w\n╰─# '

    umask 022

elif [[ $WHICH_LINUX == "termux" ]]; then

    export PATH=$HOME/bin:$PATH
    # prompt taken from ubuntu
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # above doesn't work so trying a dirt simple one
    PS1='\w\\$ '

elif [[ $WHICH_LINUX == "hector" ]]; then

    force_color_prompt=yes
    source /etc/skel/.bashrc

    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
    fi

    # add android
    ANDROID_HOME=$HOME/usr/android-sdk/sdk
    PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

elif [[ $WHICH_LINUX == "steady" ]]; then

    # older ubuntu
    force_color_prompt=yes
    source /etc/skel/.bashrc

    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
    fi

elif [[ $WHICH_LINUX == "dreamhost" ]]; then

    export PATH=$HOME/bin:$HOME/opt/python-2.7.14/bin:$PATH
    umask 002
    PS1='[\h] \w\\$ '
    export TMPDIR="$HOME/tmp"

else
    # generic distribution

    # it looks like an else clause needs at least one command
    true
fi

# settings common to all distributions

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export PATH=$PATH:$HOME/common-bin
