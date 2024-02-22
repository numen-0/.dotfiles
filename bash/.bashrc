# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=2000
HISTFILESIZE=2000

shopt -s checkwinsize
shopt -s cmdhist
shopt -s complete_fullquote
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s extquote
shopt -s force_fignore
shopt -s globasciiranges
shopt -s histappend
shopt -s interactive_comments
shopt -s progcomp
shopt -s promptvars
shopt -s sourcepath

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
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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
# external files
# Functions
if [ -f ~/.config/bash/.bash_functions ]; then
    . ~/.config/bash/.bash_functions
fi
# Alias definitions.
if [ -f ~/.config/bash/.bash_aliases ]; then
    . ~/.config/bash/.bash_aliases
fi
# More aliases
if [ -f ~/.config/bash/.bash_shortcuts ]; then
    . ~/.config/bash/.bash_shortcuts
fi

# config
# set PATH so it includes user's private bin & scripst if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.local/scripts" ] ; then
    PATH="$HOME/.local/scripts:$PATH"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GREP_COLORS='ms=2;37'
# move dot files
export SELECTED_EDITOR="/bin/nano"
DOT_FILES_DIR="$HOME/stuff/shit"
export HISTFILE="$HOME/.config/bash/.bash_history"
export LESSHISTFILE="$DOT_FILES_DIR/.lesshst"
alias wget="wget --hsts-file $DOT_FILES_DIR/.wget-hsts" # "wget --no-hsts"

# blk='\[\033[01;30m\]'   # Black
# red='\[\033[01;31m\]'   # Red
# grn='\[\033[01;32m\]'   # Green
# ylw='\[\033[01;33m\]'   # Yellow
# blu='\[\033[01;34m\]'   # Blue
# pur='\[\033[01;35m\]'   # Purple
# cyn='\[\033[01;36m\]'   # Cyan
# wht='\[\033[01;37m\]'   # White
# clr='\[\033[00m\]'      # Reset

# PS1='\033[0;92m[\W]\[\e[0;93m\]› \[\e[0m\]' # »
change_term_name "(⌐■_■)"
PS1='\[\e[0;1;31m\]$(parse_git_branch)\[\e[0;93m\]$(parse_git_status) \[\e[0;$(location_privileges)m\]\W\[\e[0;93m\] › \[\e[0m\]' # »

# unset one time use functs
unset -f change_term_name

echo "( ·_·)b"

