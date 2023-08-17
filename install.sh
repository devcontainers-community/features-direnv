#!/bin/bash
set -ex
source lib.sh

if [[ $VERSION == system ]]; then
  check_packages direnv
else
  check_packages curl ca-certificates sudo

  export bin_path=/usr/local
  curl -sfL https://direnv.net/install.sh | bash
fi

echo "Updating /etc/bash.bashrc and /etc/zsh/zshrc..."
if [[ "$(cat /etc/bash.bashrc)" != *"$1"* ]]; then
    echo -e 'eval "$(direnv hook bash)"' >> /etc/bash.bashrc
fi
if [ -f "/etc/zsh/zshrc" ] && [[ "$(cat /etc/zsh/zshrc)" != *"$1"* ]]; then
    echo -e 'eval "$(direnv hook zsh)"' >> /etc/zsh/zshrc
fi
