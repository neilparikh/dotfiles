source ~/.bashrc
bind -x '"\C-b": fbr' # bind ^b to fbr
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

bind '"\C-i" menu-complete'
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
