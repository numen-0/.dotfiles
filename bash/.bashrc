# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

##############################################################################################
##############################################################################################
echo "( ·_·)b"
export GREP_COLORS='ms=2;37'

# Alias definitions.
if [ -f ~/.config/bash/.bash_aliases ]; then
    . ~/.config/bash/.bash_aliases
fi

# More aliases
if [ -f ~/.config/bash/.bash_shortcuts ]; then
    . ~/.config/bash/.bash_shortcuts
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# move dot files
export SELECTED_EDITOR="/bin/nano"
DOT_FILES_DIR="$HOME/stuff/shit"
export HISTFILE="$HOME/.config/bash/.bash_history"
export LESSHISTFILE="$DOT_FILES_DIR/.lesshst"
alias wget="wget --hsts-file $DOT_FILES_DIR/.wget-hsts" # "wget --no-hsts"

# PS1
change_term_name() {
    echo -ne "\033]0;$1\007";
}
change_term_name "(⌐■_■)"
parse_git_status() {
    [ -z "$(git status --porcelain 2> /dev/null)" ] && echo -n "" || echo -n "[+]"
}
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
location_privileges() {
    if [ -z "$(pwd | grep "$HOME")" ]; then
        sudo -nv 2> /dev/null && echo "1;94" || echo "1;31" 
    else
        echo "92"
    fi
}

# PS1='\033[0;92m[\W]\[\e[0;93m\]› \[\e[0m\]' # »
PS1='\[\e[0;1;31m\]$(parse_git_branch)\[\e[0;93m\]$(parse_git_status) \[\e[0;$(location_privileges)m\]\W\[\e[0;93m\] › \[\e[0m\]' # »

# Cool fzf functions
# go to path
function g_() {
    PLACES=""
    PLACES="$(fdfind . "$HOME/stuff/code" --max-depth 1 -t d -H)"
    PLACES="$(echo -e "$HOME/stuff")\n$PLACES"
    PLACES="$(echo -e "$HOME/.config/bash")\n$PLACES"
    PLACES="$(echo -e "$HOME/.config/nvim")\n$PLACES"
    PLACES="$(echo -e "$HOME/.local/bin")\n$PLACES"
    PLACES="$(echo -e "/var/backups/bacup")\n$PLACES"
    PLACES="$(echo -e "$HOME/stuff/Downloads")\n$PLACES"
    PLACES="$(echo -e "$HOME/stuff/.dotfiles")\n$PLACES"

    JUMP="$(echo -e "$PLACES" | sort -f | fzf --ansi --border=rounded --preview 'tree -m -p {} -y 64' --tiebreak=end)"

    if [ -d "$JUMP" ]; then
        cd "$JUMP"
        pwd
    fi
}
# nvim to path
function n_() {
    PLACES=""
    PLACES="$(fdfind . "$HOME/stuff/code" --max-depth 1 -t d -H)"
    PLACES="$(echo -e "$HOME/.config/bash")\n$PLACES"
    PLACES="$(echo -e "$HOME/.config/nvim")\n$PLACES"
    PLACES="$(echo -e "$HOME/.local/bin")\n$PLACES"

    JUMP="$(echo -e "$PLACES" | sort -f | fzf --ansi --border=rounded --preview 'tree -m -p {} -y 64' --tiebreak=end)"

    if [ -d "$JUMP" ]; then
        cd "$JUMP"
        pwd
        nvim
    fi
}
# launch program
function l_() {
    PROGRAMS="firefox"
    PROGRAMS="nautilus\n$PROGRAMS"
    PROGRAMS="eclipse\n$PROGRAMS"

    SELECTED="$(echo -e "$PROGRAMS" | sort -f | fzf --ansi --border=rounded --tiebreak=begin)"

    if [ "$SELECTED" = "firefox" ]; then 
        firefox &> /dev/null & true
    elif [ "$SELECTED" = "nautilus" ]; then
        nautilus . &> /dev/null & true
    elif [ "$SELECTED" = "eclipse" ]; then
        $HOME/stuff/eclipse/eclipse/eclipse &> /dev/null & true
    else
        echo "not implemented yet."
    fi
}
