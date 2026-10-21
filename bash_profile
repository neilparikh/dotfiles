source ~/.bashrc
bind -x '"\C-b": fbr' # bind ^b to fbr
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

bind '"\C-i" menu-complete'
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

# Added by `rbenv init` on Wed Nov 13 12:31:27 PST 2024
eval "$(rbenv init - --no-rehash bash)"
