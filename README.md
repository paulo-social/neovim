# Neovim Config

Configuração focada em produtividade com um "kit Cursor-like": LSP completo, busca rápida, diagnósticos, snippets, Git integrado e IA no fluxo.

**Visão Geral**

- Gerenciador de plugins: `packer.nvim`.
- LSP: `mason.nvim` + `mason-lspconfig.nvim` + `nvim-lspconfig`.
- Autocomplete: `nvim-cmp`.
- Snippets: `LuaSnip` + `friendly-snippets`.
- Busca/Jump: `telescope.nvim` + `telescope-fzf-native`.
- Diagnósticos: `trouble.nvim`.
- Descoberta de atalhos: `which-key.nvim`.
- Git: `gitsigns.nvim` + `blame.nvim`.
- UI: `lualine.nvim`, `bufferline.nvim`, `dressing.nvim`, `scrollbar.nvim`.
- AI: `copilot.lua` + `codecompanion.nvim`.
- Files: `nvim-tree.lua` (com `.git` e `.github` ocultos).
- Formatting: `conform.nvim`.
- Syntax: `nvim-treesitter`.

**Instalação**

1. Execute o script de dependências no macOS:
   - `./install_darwin.sh`
2. Abra o Neovim e instale plugins:
   - `:PackerSync`
3. Instale/atualize parsers do Tree-sitter:
   - `:TSUpdate`
4. LSPs via Mason:
   - `:Mason`

**Dependências Recomendadas**

- `git`
- `ripgrep` (para `live_grep` no Telescope)
- `fd` (para busca de arquivos no Telescope)
- `node` e `npm` (Copilot/CodeCompanion e alguns LSPs)
- `python3` + `pynvim`
- `go` (para ferramentas Go)
- `rust` + `cargo` (para LSPs Rust e builds nativos)
- `make` (para `telescope-fzf-native`)

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

IA:

- `<Leader>ac` abrir chat (CodeCompanion)
- `<Leader>ai` prompt inline (CodeCompanion)
- `<Leader>aa` ações (CodeCompanion)

Outros:

- `<Leader>w` alternar entre janelas
- `<Leader>t` Tagbar toggle
- `<F5>/<F10>/<F11>/<F12>` DAP (requer `nvim-dap`)
- `<Leader>b` breakpoint (requer `nvim-dap`)

**Customização dos Agentes de IA**

Os prompts que guiam os agentes do `codecompanion` (Architect, Coder, Tester, etc) e os Pipelines foram extraídos da configuração Lua para facilitar a manutenção.  
Para customizar o comportamento de como a IA gera código ou gerencia o fluxo:

- Edite os arquivos `.md` na pasta `lua/config/prompts/agents/`.
- Para editar a estratégia geral (o prompt inicial do Slash Command), edite `lua/config/prompts/pipelines/my_coder.md`.

**Notas**

- Se o `telescope-fzf-native` falhar, instale `make` e rode `:PackerSync` novamente.
- Para alterar o tema, edite `init.lua` e ajuste `colorscheme`.
