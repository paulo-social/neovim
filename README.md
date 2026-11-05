# Neovim Config

Configuração para Neovim 0.12 ou superior, com LSP, busca, diagnósticos, snippets e Git integrado.

**Visão Geral**

- Gerenciador de plugins: `packer.nvim`.
- LSP: `mason.nvim` + `mason-lspconfig.nvim` + `nvim-lspconfig`.
- Autocomplete: `nvim-cmp`.
- Snippets: `LuaSnip` + `friendly-snippets`.
- Busca/Jump: `telescope.nvim` + `telescope-fzf-native`.
- Diagnósticos: `trouble.nvim`.
- Git: `gitsigns.nvim` + `blame.nvim`.
- UI: `lualine.nvim`, `bufferline.nvim`, `dressing.nvim`, `scrollbar.nvim`.
- Files: `nvim-tree.lua` (com `.git` e `.github` ocultos).
- Formatting: `conform.nvim`.
- Syntax: `nvim-treesitter`.

**Instalação**

1. Execute o script de dependências no macOS:
   - `sh install_darwin.sh`
2. Abra o Neovim e instale plugins:
   - `:PackerSync`, seguido de uma reinicialização do Neovim.
3. Instale/atualize parsers do Tree-sitter:
   - `:TSUpdate`
4. LSPs via Mason:
   - `:Mason`
5. Verifique a instalação:
   - `:checkhealth`

O script instala os executáveis usados pelos plugins. Os servidores LSP ficam a cargo
do Mason. Para reparar apenas o ambiente Python, as ferramentas Go e o LuaSnip,
execute `sh scripts/install_tools.sh`.

**Dependências Recomendadas**

- `git`
- `ripgrep` (para `live_grep` no Telescope)
- `fd` (para busca de arquivos no Telescope)
- `node` e `npm` (servidores LSP)
- `python3`: o script cria um ambiente em `stdpath('data')/python3` com
  `pynvim`, `black`, `isort` e `pylatexenc`. A configuração usa esse Python
  independentemente do ambiente virtual do projeto.
- `go` (para ferramentas Go)
- `rust` + `cargo` (para LSPs Rust e builds nativos)
- `make` (para `telescope-fzf-native`)
- `tree-sitter-cli` >= 0.26.1 (compilação dos parsers)
- `stylua`, `prettier` e `rustfmt` (formatação)
- `bat` (prévia de arquivos) e `wget` (downloads do Mason)

As ferramentas Go são instaladas em `stdpath('data')/bin`, adicionado ao PATH
do Neovim. Isso evita perdê-las ao trocar a versão do Go pelo GVM.

**Manutenção e checkhealth**

- `:PackerSync` atualiza plugins e executa os hooks de compilação do LuaSnip
  e atualização dos parsers. Reinicie o Neovim após concluir.
- `:TSUpdate` sincroniza os parsers com as queries do Tree-sitter. Após atualizar,
  reinicie antes de verificar novamente o healthcheck.
- `:ConformInfo` mostra a disponibilidade dos formatadores.
- `:checkhealth` verifica todos os plugins; `:checkhealth vim.deprecated`
  mostra chamadas obsoletas executadas na sessão.
- O módulo `lua/config/setups/goplements.lua` adapta a verificação do parser Go
  à API nativa, pois o healthcheck do plugin ainda chama `has_parser`, removido
  no ramo `main` do Tree-sitter. Parsers ausentes continuam sendo reportados.
- O Catppuccin usa integrações explícitas, pois sua detecção automática não
  reconhece o Packer e inicializa desnecessariamente o gerenciador `vim.pack`.

O healthcheck também verifica ferramentas opcionais não usadas nesta configuração:
PHP/Composer, Julia, LuaRocks, providers remotos Node/Ruby/Perl e visualizadores
de imagens (`viu`, `chafa`, `ueberzugpp`). Avisos sobre essas ferramentas não
impedem LSP, autocomplete, snippets ou formatação. Os providers remotos são
independentes dos servidores LSP dessas linguagens. Essas verificações permanecem
ativas para indicar dependências que você venha a precisar.

**NvimTree**

- `.git` e `.github` ficam ocultos via `filters.custom`.
- Ajuste em `lua/config/setups/nvim-tree.lua` se quiser mostrar:
  - Remova `custom = { "^%.git$", "^%.github$" }`

**Atalhos Principais**
Leader: `Espaço`

NvimTree:

- `<C-n>` toggle
- `<Leader>e` focus

Telescope:

- `<Leader>ff` buscar arquivos
- `<Leader>fg` buscar texto no projeto
- `<Leader>fs` buscar palavra sob o cursor
- `<Leader>fb` listar buffers
- `<Leader>fd` buscar diagnósticos
- `<Leader>fr` retomar última busca

LSP:

- `<Leader>df` ir para definição
- `<Leader>dc` ir para declaração
- `<Leader>gi` ir para implementações
- `<Leader>dt` ir para definição de tipo
- `<Leader>lr` listar referências
- `<Leader>r` renomear símbolo
- `<Leader>ca` ações de código
- `<Leader>k` hover do símbolo
- `<Leader>s` assinatura da função

Diagnósticos:

- `<Leader>d` diagnóstico flutuante
- `<Leader>db` anterior
- `<Leader>dp` próximo

Buffers:

- `<Tab>` próximo buffer
- `<S-Tab>` buffer anterior
- `<Leader>x` fechar buffer atual
- `<Leader>X` fechar outros buffers
- `<Leader>1`...`<Leader>9` ir para buffer
- `<Leader>$` ir para último buffer

IA (atalhos criados somente se `codecompanion.nvim` estiver instalado):

- `<Leader>ac` abrir chat (CodeCompanion)
- `<Leader>ai` prompt inline (CodeCompanion)
- `<Leader>aa` ações (CodeCompanion)

Outros:

- `<Leader>w` alternar entre janelas
- `<Leader>t` Tagbar toggle
- `<F5>/<F10>/<F11>/<F12>` DAP (criados somente se `nvim-dap` estiver instalado)
- `<Leader>b` breakpoint (criado somente se `nvim-dap` estiver instalado)

Copilot, CodeCompanion e DAP não são instalados pela configuração atual.

**Notas**

- Se o `telescope-fzf-native` falhar, instale `make` e rode `:PackerSync` novamente.
- Para alterar o tema, edite `init.lua` e ajuste `colorscheme`.
