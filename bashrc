# utils
safe_source() {
    [ -f $1 ] && source $1
}

# autocompletion
safe_source /usr/local/etc/bash_completion.d/brew
safe_source /usr/local/etc/bash_completion.d/git-completion.bash
safe_source /usr/share/bash-completion/completions/git
__git_complete g __git_main
safe_source /usr/local/etc/bash_completion.d/tmux
safe_source /usr/local/etc/bash_completion.d/vagrant
safe_source /usr/local/etc/bash_completion.d/tmuxinator

# vim/editor
alias v="vim"
export EDITOR="vim"

function gv() {
    cd $(git rev-parse --show-toplevel)
    vim -p $(git diff --name-only)
    cd -
}

function gv_master() {
    cd $(git rev-parse --show-toplevel)
    vim -p $(git diff --name-only $(git merge-base HEAD origin/master))
    cd -
}

# Go
export GOPATH="$HOME/go_work"
export PATH="$GOPATH/bin:$PATH"

# aliases
alias g=git
alias prettyjson="python -m json.tool"
alias ls="ls -G"
alias t=todo
alias clclip="echo ' ' | pbcopy"
alias ag='ag --path-to-ignore ~/.ignore'

# fzf
safe_source ~/.fzf.bash
safe_source ~/dotfiles/fzf.bash

# other
export HISTFILESIZE=2500
export PATH="~/bin:$PATH"
export PATH="~/.cargo/bin:$PATH"
export PATH="~/.cabal/bin:$PATH"
export PATH="~/.local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
safe_source ~/dotfiles/prompt.bash
safe_source ~/dotfiles/local.bash
bind -x '"\C-b": fbr' # bind ^b to fbr
shopt -s cdspell
export HISTIGNORE="git s:cd:git push:git pull:fg:vim:gv:gv_master:rc"
alias gi="git"
export REVIEW_BASE="master"
