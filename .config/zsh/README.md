##

```shell
zstyle :omz:plugins::ssh-agent agent-forwarding on
zstyle :omz:plugins::ssh-agent identities id_rsa
```

## Podman

> [!note] rootless podman, rootless image

setup `$XDG_CONFIG_HOME/.containers/storage.conf`

## Plugins

```shell
plugins=( \
  git rust bun sudo supervisor docker zsh-uv-env dotenv \
  helm kubectl \
)
```
