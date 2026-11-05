#!/bin/sh
set -eu

if [ "$(uname -s)" != Darwin ]; then
  echo "Este script requer macOS." >&2
  exit 1
fi

command -v brew >/dev/null 2>&1 || {
  echo "Instale o Homebrew antes de executar este script." >&2
  exit 1
}

# Os servidores LSP são gerenciados pelo Mason, sem instalações duplicadas.
brew install neovim git curl wget fzf ripgrep fd bat universal-ctags \
  tree-sitter-cli stylua prettier node python3 go rust openjdk

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
sh "$script_dir/scripts/install_tools.sh"

echo "Abra o Neovim, execute :PackerSync e reinicie. Depois execute :TSUpdate e :checkhealth."
