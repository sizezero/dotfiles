
export WHICH_LINUX=generic

if [[ -d /scharp/QUALITY && -d /scharp/xapps ]]; then
    export WHICH_LINUX=scharp
fi

if [[ -d /data/data/com.termux ]]; then
    export WHICH_LINUX=termux
fi

if [[ -f /etc/os-release ]]; then
    grep -q '^ID=ubuntu$' /etc/os-release
    if [[ $? -eq 0 && $(hostname) == 'olivia' ]]; then
        if [[ $(whoami) == 'robert' ]]; then
            export WHICH_LINUX=hector-robert
        elif [[ $(whoami) == 'work' ]]; then
            export WHICH_LINUX=hector-work
        else
            export WHICH_LINUX=hector
        fi
    fi
    grep -q '^ID=debian$' /etc/os-release
    if [[ $? -eq 0 && $(hostname) == 'bibi' ]]; then
        export WHICH_LINUX=bibi
    fi
fi

if [[ -f $HOME/IS_DREAMHOST_KLEEMANN ]]; then
    export WHICH_LINUX=dreamhost
fi

if [[ -f $HOME/.IS_STEADY ]]; then
    export WHICH_LINUX=steady
fi

if [[ $? -eq 0 && $(hostname) == 'hector' ]]; then
    export WHICH_LINUX=old-hector
fi

if [[ $WHICH_LINUX == "scharp" ]]; then

    source /usr/local/admin/defaults/bashrc.sles

    export JAVA_HOME=/scharp/xapps/fw/share/jdk
    export PATH=$HOME/bin/linux:$HOME/bin:$JAVA_HOME/bin:/scharp/xapps/fw/bin:$HOME/local/bin:$PATH


    export INSTALL4J_JAVA_HOME=/scharp/xapps/fw/share/jdk1.8.0_144

    PS1='╭─\u@\h: \w\n╰─# '

    umask 022

    export TERM=xterm-256color

elif [[ $WHICH_LINUX == "termux" ]]; then

    export PATH=$HOME/bin:$PATH
    # prompt taken from ubuntu
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # above doesn't work so trying a dirt simple one
    #PS1='\w\\$ '
    PS1='╭─\u@\h: \w\n╰─# '

elif [[ $WHICH_LINUX == "hector-robert" ]]; then

    force_color_prompt=yes
    source /etc/skel/.bashrc

    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
    fi

    # add android
    ANDROID_HOME=$HOME/usr/android-sdk/sdk
    PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

    # add scala
    PATH="$HOME/.local/share/coursier/bin:$PATH"

    # taken from default ubuntu and added newline and strange unicode
    PS1='╭─\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n╰─\$ '

    # renamed .dir_colors to .dircolors so it should be pickup up by /etc/skel/.bashrc
    #test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

    JAVA_HOME=/usr/lib/jvm/default-java

    # RUST
    . "$HOME/.cargo/env"

elif [[ $WHICH_LINUX == "hector-work" ]]; then

    force_color_prompt=yes
    source /etc/skel/.bashrc

    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
    fi

    # taken from default ubuntu and added newline and strange unicode
    PS1='╭─\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n╰─\$ '

    test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

    M=kleemann@maggot.pc.scharp.org
    
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

elif [[ $WHICH_LINUX == "old-hector" ]]; then

    source /etc/bash.bashrc

    LESSCHARSET=utf8
#    PS1='[\u@\h $(tty | tail -c2) \W]\$ '
    PS1='╭─\[\[\033[01;32m\]\u@\h\[\033[00m\]: T$(tty | tail -c2) \[\033[01;34m\]\w\[\033[00m\]]\n╰─\$ '
#    PS1='╭─\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n╰─\$ '

    setterm --blank=5

    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
    fi

    export PATH="$PATH:$HOME/common-bin/arch"

    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # needed for ssh-agent to work
    export SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/ssh-agent.socket

elif [[ $WHICH_LINUX == "bibi" ]]; then

    ####################################################################
    # copied from default bibi install from velvet-os

    # If not running interactively, don't do anything
    case $- in
        *i*) ;;
          *) return;;
    esac

    # don't put duplicate lines or lines starting with space in the history.
    # See bash(1) for more options
    HISTCONTROL=ignoreboth

    # append to the history file, don't overwrite it
    shopt -s histappend

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=1000
    HISTFILESIZE=2000

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color|*-256color) color_prompt=yes;;
    esac

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    #force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	    # a case would tend to support setf rather than setaf.)
	    color_prompt=yes
        else
	    color_prompt=
        fi
    fi

    # moved to later
    #if [ "$color_prompt" = yes ]; then
    #    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #else
    #    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    #fi
    #unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    #case "$TERM" in
    #xterm*|rxvt*)
    #    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    #    ;;
    #*)
    #    ;;
    #esac

    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        #alias dir='dir --color=auto'
        #alias vdir='vdir --color=auto'

        #alias grep='grep --color=auto'
        #alias fgrep='fgrep --color=auto'
        #alias egrep='egrep --color=auto'
    fi

    # colored GCC warnings and errors
    #export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

    # some more ls aliases
    #alias ll='ls -l'
    #alias la='ls -A'
    #alias l='ls -CF'

    # Alias definitions.
    # You may want to put all your additions into a separate file like
    # ~/.bash_aliases, instead of adding them here directly.
    # See /usr/share/doc/bash-doc/examples in the bash-doc package.

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
      if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
      elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi
    fi
    ####################################################################

    # custom stuff for bibi

    # auto detection of color prompt isn't working
    color_prompt=yes
    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
    esac

    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
    fi

    # TODO add more complicated stuff once this works

else
    # generic distribution

    # it looks like an else clause needs at least one command
    true
fi

# settings common to all distributions

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export PATH=$PATH:$HOME/common-bin

# not all distributions have X running but, if they do, handle cut and paste
alias "c=xclip -selection clipboard"
alias "v=xclip -o -selection clipboard"
