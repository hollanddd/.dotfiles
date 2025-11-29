# Functions
function git_pull() {
  remote="${1:-origin}"
  git pull $remote $(git rev-parse --abbrev-ref HEAD)
}
alias gull=git_pull

function git_push() {
  remote="${1:-origin}"
  git push $remote $(git rev-parse --abbrev-ref HEAD)
}
alias gush=git_push

# fail prints failure messages to stdout and returns preserving the exit code
# https://stackoverflow.com/questions/75249026/how-do-i-assert-something-in-bash-print-a-useful-error-message-and-then-still
function fail() {
  printf '%s\n' "$1" >&2
  return "${2:-1}"
}

# jwt_decode decodes a JWT token and outputs the payload in JSON format.
function jwt_decode() {
  jq -R 'split(".") | .[1] | @base64d | fromjson' <<< "$1"
}

# trim_quotes() removes quotes from a a string
function trim_quotes() {
  echo "$1" | sed 's/^"\(.*\)"$/\1/'
}
# spinner is a function that shows a spinner while a command is running
# usage sleep 10 & spinner
function spinner()
{
    local pid=$!
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# lolcat is a function that pipes the arguments of a command to lolcat
# lolcat is a rainbow text generator clone of cat
function lat() {
  lolcat "$@"
}

alias pq="pqrs"

# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias zource="omz reload"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="eza --icons -l"
alias ls="eza --icons --group-directories-first --color=always $1"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy && pbpaste"
alias upgrade="~/.dotfiles/upgrade.sh"
alias claude="$HOME/.claude/local/claude"

# Web tooling
alias decode-jwt-"jwt_decode"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias projects="cd $HOME/Documents"

# String manipulation
alias trim-newline="tr -d  '\n'"
alias trim-quotes="trim_quotes"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run dev"

# Docker
alias docker-composer="docker-compose"

# Git
alias gb="git branch"
alias gc="git commit"
alias gz="git cz"
alias gd="git diff"
alias gdc="git diff --cached"
alias gco="git checkout"
alias gap="git add --patch"
alias gl="git log --oneline --decorate --color"
alias glog="git log -1 --pretty=%B | trim-newline"

# Vim
alias vim="nvim"
alias vi="nvim"
alias v="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"

# Embeded
alias export-esp=". $HOME/export-esp.sh"
