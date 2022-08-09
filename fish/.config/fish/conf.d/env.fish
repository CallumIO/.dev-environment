set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx TERM xterm-256color

set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_BIN_HOME $HOME/.local/bin

set -gx LESSHISTFILE $XDG_CACHE_HOME/less/history
set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx XINITRC $XDG_CONFIG_HOME/X11/xinitrc
set -gx ASDF_DATA_DIR $XDG_DATA_HOME/asdf
set -gx GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc 
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx GHQ_ROOT $HOME/repos
