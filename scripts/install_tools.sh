#!/bin/sh
set -eu

# Mantém providers e ferramentas independentes do pyenv/GVM do projeto.
nvim_data="${XDG_DATA_HOME:-$HOME/.local/share}/${NVIM_APPNAME:-nvim}"
nvim_python="$nvim_data/python3"
mkdir -p "$nvim_data/bin"
python3 -m venv "$nvim_python"
"$nvim_python/bin/python" -m pip install --upgrade pip pynvim black isort pylatexenc

# Expõe só as ferramentas; preserva o Python do projeto para os servidores LSP.
for tool in black isort latex2text; do
  ln -sf "$nvim_python/bin/$tool" "$nvim_data/bin/$tool"
done

for tool in \
  github.com/fatih/gomodifytags@latest \
  github.com/josharian/impl@latest \
  github.com/cweill/gotests/...@develop \
  github.com/koron/iferr@latest \
  olexsmir.xyz/json2go/cmd/json2go@latest
do
  GOBIN="$nvim_data/bin" go install "$tool"
done

luasnip_dir="$nvim_data/site/pack/packer/start/LuaSnip"
if [ -d "$luasnip_dir" ]; then
  make -C "$luasnip_dir" install_jsregexp
fi
