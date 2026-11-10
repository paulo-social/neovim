#!/bin/sh
# Executar: sh install_darwin.sh. Interrompe em erro ou variável não definida.
set -eu

if [ "$(uname -s)" != Darwin ]; then
  echo "Este script requer macOS." >&2
  exit 1
fi

command -v brew >/dev/null 2>&1 || {
  echo "Instale o Homebrew antes de executar este script." >&2
  exit 1
}

# Instala Neovim e ferramentas: rg/fd/fzf para buscas, ctags para Tagbar,
# compiladores/runtimes e formatadores. Os servidores LSP são gerenciados pelo Mason.
brew install neovim git curl wget fzf ripgrep fd bat universal-ctags \
  tree-sitter-cli stylua prettier node python3 go rust openjdk

# Resolve a pasta do script para permitir executá-lo a partir de outro diretório.
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
sh "$script_dir/scripts/install_tools.sh"

echo "Abra o Neovim, execute :PackerSync e reinicie. Depois execute :TSUpdate e :checkhealth."
