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
- Files: `nvim-tree.lua` (com filtro personalizado para nomes que correspondem a `.git`).
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

- `filters.custom = { ".git" }` usa um padrão Lua amplo: pode ocultar também
  `.github` e `.gitignore`. `U` dentro da árvore alterna esse filtro.
- `I` alterna arquivos ignorados pelo Git; `H` alterna arquivos ocultos.
- `g?` dentro da árvore mostra todos os atalhos locais. Entre eles: `Enter`/`o`
  abre, `a` cria, `r` renomeia, `d` apaga, `c`/`x`/`p` copia/recorta/cola,
  `R` atualiza e `q` fecha. `Tab` abre uma prévia dentro da árvore.

**Atalhos Principais**
Leader: `Espaço`. Salvo indicação contrária, os atalhos abaixo valem no modo
normal (`Esc` para sair da inserção). Digite o prefixo e as letras em sequência.
`<C-...>` significa Ctrl e `<S-...>` significa Shift. Maiúsculas são distintas.

**Buscas com `\ff` e `\fg`**

Esses dois atalhos antigos foram restaurados como aliases literais. O Leader
continua sendo Espaço para preservar todos os outros atalhos.

| Ação | Atalho antigo | Atalho com Leader | Comando equivalente |
| --- | --- | --- | --- |
| Buscar arquivo pelo nome | `\ff` | `Espaço ff` | `:Telescope find_files` |
| Buscar texto nos arquivos | `\fg` | `Espaço fg` | `:Telescope live_grep` |

A janela do Telescope abre com campo de busca, resultados e prévia. As buscas
partem do diretório atual (`:pwd`); use `:cd /caminho/do/projeto` para mudá-lo.
Arquivos ocultos e ignorados ficam fora da busca por padrão. A busca por texto
requer `rg` (ripgrep), instalado por `install_darwin.sh`.

Dentro da busca: `Ctrl+n`/`Ctrl+p` ou setas selecionam, `Enter` abre,
`Ctrl+x`/`Ctrl+v` abrem em split horizontal/vertical e `Ctrl+t` abre em tabpage.
`Ctrl+u`/`Ctrl+d` rolam a prévia; `Tab`/`Shift+Tab` marcam itens;
`Ctrl+q` envia resultados para a quickfix. `Ctrl+c` fecha no modo de inserção;
`Esc` passa para o modo normal e outro `Esc` fecha. `Ctrl+/` na inserção ou `?`
no modo normal mostram a ajuda dos atalhos do seletor.

Para diagnosticar: `:verbose nmap \ff`, `:verbose nmap \fg`,
`:checkhealth telescope` e `:echo executable('rg')` (deve retornar `1`).
`:Telescope keymaps` permite consultar os mapeamentos e suas descrições.

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

A barra superior representa buffers, não tabpages. Os números são posições na
barra. `Espaço x` usa `:bdelete`, que protege alterações não salvas; o botão de
fechar e o clique direito na barra usam `:bdelete!`, que pode descartá-las.

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
No DAP, F5 inicia/continua, F10 executa a próxima linha sem entrar na função,
F11 entra na função e F12 sai dela; é necessário configurar um adaptador.
O módulo inativo do Copilot documenta `Ctrl+l` (aceitar), `Ctrl+]` (próxima),
`Ctrl+k` (anterior) e `Ctrl+\` (descartar), todos para sugestões na inserção.

**Autocomplete e comentários**

| Contexto | Atalho | Ação |
| --- | --- | --- |
| Inserção, nvim-cmp | `Ctrl+Espaço` | Abrir sugestões |
| Inserção, nvim-cmp | `Ctrl+n` / `Ctrl+p` | Abrir menu ou inserir sugestão seguinte/anterior |
| Inserção, nvim-cmp | Setas para baixo/cima | Selecionar sugestão |
| Inserção, nvim-cmp | `Enter` | Confirmar seleção ou primeiro item |
| Inserção, nvim-cmp | `Ctrl+y` | Confirmar item explicitamente selecionado |
| Inserção, nvim-cmp | `Ctrl+e` | Cancelar autocomplete |
| Inserção, nvim-cmp | `Ctrl+b` / `Ctrl+f` | Rolar documentação para cima/baixo |
| Normal, Comment.nvim | `gcc` / `gbc` | Alternar comentário de linha/em bloco |
| Normal, Comment.nvim | `gc{movimento}` / `gb{movimento}` | Comentar região definida pelo movimento |
| Visual, Comment.nvim | `gc` / `gb` | Comentar linhas/seleção em bloco |
| Normal, Comment.nvim | `gco` / `gcO` / `gcA` | Criar comentário abaixo/acima/ao fim da linha |

Snippets são oferecidos pelo autocomplete; não há atalhos personalizados para
saltar entre seus campos. Autopairs insere pares automaticamente e trata Enter
e Backspace entre pares. Os atalhos locais de uma janela podem sobrepor os
globais: por exemplo, `Ctrl+n` seleciona sugestões no autocomplete e resultados
no Telescope, enquanto no modo normal de um arquivo abre/fecha a árvore.

**Comandos manuais e ações automáticas**

| Comando | Uso |
| --- | --- |
| `:PackerStatus` / `:PackerCompile` | Inspecionar plugins / regenerar o loader compilado |
| `:TSInstall <linguagem>` | Instalar um parser adicional |
| `:checkhealth vim.lsp` | Inspecionar clientes e configuração LSP |
| `:Telescope help_tags` / `:Telescope git_branch` | Buscar ajuda / selecionar branches pela extensão |
| `:TodoTelescope` / `:TodoQuickFix` / `:TodoLocList` | Listar marcadores TODO/FIX/etc. no seletor/quickfix/lista local |
| `:BlameToggle` | Abrir/fechar painel de autoria Git |
| `:Gitsigns preview_hunk` / `:Gitsigns diffthis` | Ver trecho alterado / comparação Git |
| `:Gitsigns blame_line` / `:Gitsigns toggle_current_line_blame` | Consultar autoria / alternar autoria inline |
| `:Gitsigns stage_hunk` / `:Gitsigns reset_hunk` | Adicionar trecho ao índice / descartar mudanças do trecho |
| `:Twilight` / `:TwilightEnable` / `:TwilightDisable` | Alternar/ligar/desligar modo de foco |
| `:lua require('conform').format({ async = true })` | Formatar o buffer manualmente |
| `:FzfLua` | Abrir o seletor alternativo; ff/fg usam Telescope |
| `:PlantUML` | Acessar ações de diagramas PlantUML |

Conform configura StyLua (Lua), isort seguido de Black (Python), rustfmt com
alternativa LSP (Rust) e Prettier (JavaScript). Este módulo não cria atalho nem
formatação ao salvar. `:ConformInfo` verifica a disponibilidade dos executáveis.

Ao iniciar, a árvore abre automaticamente. `FileType` ativa Tree-sitter quando
há parser. `ColorScheme` reaplica cores do autocomplete, LSP e TODOs. Mudanças
de buffer/janela atualizam os TODOs e a scrollbar; gravar uma macro atualiza o
indicador `REC` da linha de status. Esses eventos estão comentados nos módulos.

Os comentários cobrem os comandos e atalhos definidos nesta configuração e
os principais padrões herdados dos plugins. A lista completa de comandos
fornecidos por cada plugin está em sua ajuda (`:help`); `:command` lista comandos
disponíveis na sessão e `g?` mostra todos os atalhos locais do NvimTree.

**Organização dos arquivos**

- `init.lua`: instalação, lista de plugins, tema e ordem de inicialização.
- `lua/config/basics.lua`: Leader, indentação, busca e aparência geral.
- `lua/config/providers.lua`: Python dedicado e PATH das ferramentas.
- `lua/config/keymaps.lua`: atalhos globais, comentários de uso e descrições.
- `lua/config/settings.lua`: apresentação dos diagnósticos.
- `lua/config/setups/`: opções, comandos e atalhos específicos dos plugins.
- `install_darwin.sh` e `scripts/install_tools.sh`: dependências e ferramentas.
- `plugin/packer_compiled.lua`: gerado pelo Packer; edite as fontes acima.

**Notas**

- Se o `telescope-fzf-native` falhar, instale `make` e rode `:PackerSync` novamente.
- Para alterar o tema, edite `init.lua` e ajuste `colorscheme`.
