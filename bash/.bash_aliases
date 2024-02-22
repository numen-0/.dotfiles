# history | awk '{cmd[$2]++} END {for(elem in cmd) {print cmd[elem] " " elem}}' | sort -n -r | head -10

alias up='sudo apt update && sudo apt upgrade'
alias _='clear'
alias ..='cd ..'
alias fd='fdfind'

alias ls='ls -A --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color'

alias nvim='nvim_fix'
alias leet='nvim leetcode.nvim'
  
alias eclipse="$HOME/stuff/eclipse/eclipse/eclipse"

alias cman='man "$(apropos -s 2 . | fzf --tiebreak=begin --border=none | sed "s|\s(\([0-9]\)).*|.\1|")"'

# git
# alias gs='git status'
# alias ga='git add'
# alias gaa='git add --all'
# alias gc='git commit'
# alias gl='git log --oneline'
# alias gb='git checkout -b'
# alias gd='git diff'
