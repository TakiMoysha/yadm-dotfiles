export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/linux-home/system/pcl-89/.cache"

export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc.py"

export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CARGO_HOME="$HOME/linux-home/system/pcl-89/.cargo"
# export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export RUSTUP_HOME="$HOME/linux-home/system/pcl-89/.local/share/rustup"
# export BUN_INSTALL="$XDG_DATA_HOME/bun"
export BUN_INSTALL="$HOME/linux-home/system/pcl-89/.local/share/bun"

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export DOCKE_CONFIG="$XDG_CONFIG_HOME/docker"
export MINIKUBE_HOME="$XDG_DATA_HOME/minikube"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"

# cargo, bun
export PATH="$CARGO_HOME/bin:$BUN_INSTALL/bin:$XDG_BIN_HOME:$PATH"

# devlab & workspace
# export STOREDIR="$HOME/linux-media"

export WORKSPACE_DIR="$HOME/workspace/"

# homelab
#export HOMELAB_CONTAINERS_DIR="$STOREDIR/containers/homelab"

# Minio
export MC_CONFIG_DIR="$XDG_CONFIG_HOME/mcli/"

# ============================================================ debug
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export BROWSER="vavaldi-stable"
# export QT_QPA_PLATFORM="wayland;xcb"
# export QT_QPA_PLATFORMTHEME=qt5ct
# export CLUTTER_BACKEND=wayland
# export XDG_CURRENT_DESKTOP=sway
# export XDG_SESSION_DESKTOP=sway
# export XDG_SESSION_TYPE=wayland
# export SDL_VIDEODRIVER=wayland
# export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
# =============================================================


