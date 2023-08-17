#!/bin/bash
set -ex
source lib.sh

if [[ $VERSION == system ]]; then
  check_packages direnv
else
  check_packages curl ca-certificates sudo
  curl -sfL https://direnv.net/install.sh | bash
fi

echo "Updating /etc/bash.bashrc and /etc/zsh/zshrc..."
if [[ -f /etc/bash.bashrc ]]; then
    echo -e 'eval "$(direnv hook bash)"' >> /etc/bash.bashrc
fi
if [ -f "/etc/zsh/zshrc" ]; then
    echo -e 'eval "$(direnv hook zsh)"' >> /etc/zsh/zshrc
fi
