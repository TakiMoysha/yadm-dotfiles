# set enable-bracketed-paste off

export ZSH="$XDG_DATA_HOME/oh-my-zsh"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export ENCORE_INSTALL="$HOME/.encore"
export PATH="$ENCORE_INSTALL/bin:$PATH"

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
[ -s "$CARGO_HOME/env" ] && . "$CARGO_HOME/env"

# tuning
eval "$(~/.local/bin/mise activate zsh)" # environment manager
eval "$(zoxide init zsh)"

# ZSH_THEME="awesomepanda"
# ZSH_THEME="cloud"
ZSH_THEME="daveverwer"

source $ZSH/oh-my-zsh.sh # should be after zsh env variables

# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true" # to use hyphen-insensitive completion, [case-sensitivity must be off. _ and - will be interchangeable]

zstyle ':omz:update' frequency 13 # how often to check for updates

# ================================================
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# ================================================
DISABLE_MAGIC_FUNCTIONS="true" # if pasting urls and other text is messed up
# DISABLE_LS_COLORS="true" # to colors are messed up
# DISABLE_AUTO_TITLE="true" # disables automatic title setting
# ENABLE_CORRECTION="true" # enable command auto-correction

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  rust
  bun
  sudo
  supervisor
  # podman
  # docker
  kubectl
  dotenv
  zsh-uv-env
  uv
  tmux
)

# autocompletions for k8s
source <(kubectl completion zsh)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# workstation env

#
if type clipcat-menu >/dev/null 2>&1; then
  alias clipedit=" clipcat-menu --finder=builtin edit"
  alias clipdel=" clipcat-menu --finder=builtin remove"

  bindkey -s '^\' "^Q clipcat-menu --finder=builtin insert ^J"
fi

# facility aliases
alias nvidia-settings="nvidia-settings --config=$XDG_CONFIG_HOME/nvidia/settings"
alias filediff="meld"

# development aliases
alias py_create_package="uv init --package"
alias ws="websocat"
alias uvr="uv run"
alias ctunnel="cloudflared tunnel"
alias _package_manager="paru" # yay, pacman
# alias adb='HOME="$XDG_DATA_HOME"/android adb' # is used in android development
alias oc="opencode"
#
function sys-update() {
  """first - read news, if all good - update, else prevent"""
  # informant read
  _package_manager -Syu

  # обновление конфигураций: pacdiff
  # проверка состояния: pacman -Qk
  """
  cat /etc/issue -> Archcraft \r (\l)
  """
}

function unpack() {
    if [[ -f $1 ]]; then
        case $1 in
          *.tar.bz2) tar xvjf $1;;
          *.tar.gz) tar xvzf $1;;
          *.tar.xz) tar xvJf $1;;
          *.tar.lzma) tar --lzma xvf $1;;
          *.bz2) bunzip $1;;
          *.rar) unrar $1;;
          *.gz) gunzip $1;;
          *.tar) tar xvf $1;;
          *.tbz2) tar xvjf $1;;
          *.tgz) tar xvzf $1;;
          *.zip) unzip $1;;
          *.Z) uncompress $1;;
          *.7z) 7z x $1;;
          *) echo "'$1' cannot be extracted via >ex<";;
    esac
    else
        echo "'$1' is not a valid file"
    fi
}


function nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; }

# for localstack compatibility https://docs.localstack.cloud/references/podman/
# alias docker=podman
alias pdm=podman
alias bp=boilerplates # for https://github.com/ChristianLempa/boilerplates/issues

alias kafka_server_up="podman run -d --replace \\
  --name devlab-kafka.dev \\
  --network host \\
  --pod devlab-kafka.pod \\
  -e KAFKA_CFG_NODE_ID=0 \\
  -e KAFKA_CFG_PROCESS_ROLES=controller,broker \\
  -e KAFKA_CFG_LISTENERS=PLAINTEXT://:9092,CONTROLLER://:9093 \\
  -e KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT \\
  -e KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=0@devlab-kafka.dev:9093 \\
  -e KAFKA_CFG_CONTROLLER_LISTENER_NAMES=CONTROLLER \\
  docker.io/bitnami/kafka:latest"
alias kafka_client_up="podman run -d --replace \\
  --name devlab-kafka-client \\
  --network host \\
  --pod devlab-kafka.pod \\
  -e KAFKA_CFG_NODE_ID=1 \\
  -e KAFKA_CFG_PROCESS_ROLES=client \\
  -e KAFKA_CFG_LISTENERS=PLAINTEXT://:9092 \\
  -e KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT \\
  -e KAFKA_CFG_ZOOKEEPER_CONNECT=devlab-zookeeper:2181 \\
  docker.io/bitnami/kafka:latest"
alias zookeeper_up="podman run -d --replace \\
  --name devlab-zookeeper \\
  --network host \\
  --pod devlab-kafka.pod \\
  docker.io/bitnami/zookeeper:latest"
alias mongodb_up="podman run -d --replace \\
  --name devlab-mongodb.dev \\
  --network host \\
  docker.io/bitnami/mongodb:latest"
alias rabbitmq_up="podman run -d --replace \\
  --name devlab-rabbitmq.dev \\
  --network host \\
  -e RABBITMQ_USERNAME=devlab \\
  -e RABBITMQ_PASSWORD=123321 \\
  docker.io/bitnami/rabbitmq:latest"
alias postgres_up="podman run -d --replace \\
  --name devlab-postgres \\
  --health-cmd 'pg_isready -h localhost -q' \\
  -v 'devlab-postgres:/bitnami/postgresql' \\
  -e POSTGRES_PASSWORD=postgres \\
  --network host \\
  --user=$(id -u) \\
  --userns=keep-id docker.io/bitnami/postgresql:latest"
alias redis_up="podman run -d --replace \\
  --name devlab-redis.dev \\
  -e ALLOW_EMPTY_PASSWORD=yes \\
  --network host \\
  docker.io/bitnami/redis:latest"

alias minio_up="podman run -d --replace  \\
  --network host  \\
  --name devlab-minio.dev  \\
  -v 'homelab-minio:/bitnami/minio/data' \\
  -e MINIO_ROOT_USER='minio-root'  \\
  -e MINIO_ROOT_PASSWORD='minio-root-password'  \\
  -e MINIO_SERVER_ACCESS_KEY='minio-access-key' \\
  -e MINIO_SERVER_SECRET_KEY='minio-secret-key' \\
  --user=$(id -u) --userns=keep-id  \\
  docker.io/bitnami/minio:latest"



function init_devlab() {  
  if [[ -z "$DEVLAB_CODING_DIR" ]]; then
    echo "Error: DEVLAB_CODING_DIR is not set."
    return 1
  fi

  if [[ -z "$STOREDIR" ]]; then
    echo "Error: STOREDIR is not set."
    return 1
  fi


  if [[ ! -d "$DEVLAB_CODING_DIR" ]]; then
    mkdir -p "$DEVLAB_CODING_DIR"
    echo "Created directory: $DEVLAB_CODING_DIR"
  else
    echo "Directory already exists <DEVLAB_CODING_DIR>: $DEVLAB_CODING_DIR"
  fi

  if [[ ! -d "$DEVLAB_CONTAINERS_DIR" ]]; then
    mkdir -p "$DEVLAB_CONTAINERS_DIR"
    echo "Created directory: $DEVLAB_CONTAINERS_DIR"
  else
    echo "Directory already exists <DEVLAB_CONTAINERS_DIR>: $DEVLAB_CONTAINERS_DIR"
  fi
}

# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#   tmux attach-session -t default || tmux new-session -s default
# fi

