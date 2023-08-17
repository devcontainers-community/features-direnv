#!/bin/bash
set -ex
source lib.sh

if [[ $VERSION == system ]]; then
  sudo apt-get update
  sudo apt-get install -y direnv
else
  # https://stackoverflow.com/a/48679640/19522682
  architecture=""
  case $(uname -m) in
      i386)   architecture="386" ;;
      i686)   architecture="386" ;;
      x86_64) architecture="amd64" ;;
      arm)    dpkg --print-architecture | grep -q "arm64" && architecture="arm64" || architecture="arm" ;;
  esac
  
  check_packages curl ca-certificates grep
  
  if [[ $VERSION == latest ]]; then
    # https://stackoverflow.com/a/3077316/19522682
    VERSION=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/direnv/direnv/releases/latest | grep -oP '\d+\.\d+\.\d+')
  fi
  
  curl -fsSLo direnv "https://github.com/direnv/direnv/releases/download/v$VERSION/direnv.freebsd-$architecture"

  chmod 777 direnv
  mv direnv /usr/local/bin/direnv
fi

echo "Updating /etc/bash.bashrc and /etc/zsh/zshrc..."
if [[ "$(cat /etc/bash.bashrc)" != *"$1"* ]]; then
    echo -e 'eval "$(direnv hook bash)"' >> /etc/bash.bashrc
fi
if [ -f "/etc/zsh/zshrc" ] && [[ "$(cat /etc/zsh/zshrc)" != *"$1"* ]]; then
    echo -e 'eval "$(direnv hook zsh)"' >> /etc/zsh/zshrc
fi
