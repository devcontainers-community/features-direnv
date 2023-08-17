#!/bin/bash
set -ex
source lib.sh

check_packages curl ca-certificates

if [[ $VERSION == system ]]; then
  sudo apt-get update
  sudo apt-get install -y direnv
else
  curl -sS https://webi.sh/gh | sh
  # From installer output
  source ~/.config/envman/PATH.env

  # https://stackoverflow.com/a/48679640/19522682
  architecture=""
  case $(uname -m) in
      i386)   architecture="386" ;;
      i686)   architecture="386" ;;
      x86_64) architecture="amd64" ;;
      arm)    dpkg --print-architecture | grep -q "arm64" && architecture="arm64" || architecture="arm" ;;
  esac
  
  if [[ $VERSION == latest ]]; then
    gh release download -p "direnv.linux-$architecture"
  else
    gh release download "v$VERSION" -p "direnv.linux-$architecture"
  fi

  chmod +x direnv.linux-*
  mv direnv.linux-* /usr/local/bin/direnv
fi
