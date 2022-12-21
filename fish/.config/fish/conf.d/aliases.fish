alias ls "ls -p -G"

if type -q exa
  alias ls "exa -g --icons"
end

alias la "ls -a"
alias ll "ls -l"
alias lla "ll -a"

alias cat bat

alias sw swallow

alias wget 'wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\"'
alias sx 'startx \"$XDG_CONFIG_HOME/X11/xinitrc\"'
alias nv 'swallow neovide --nofork --multigrid'
alias n 'swallow neovide --nofork --multigrid'
alias neovide 'swallow neovide --nofork --multigrid'
alias mpv 'swallow mpv'
alias nsxiv 'swallow nsxiv'

alias hx 'helix'
