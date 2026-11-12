-- Entrada da configuração: opções/providers, plugins, tema, setups e atalhos.
-- Manutenção: :PackerSync instala/atualiza/remove plugins e recompila o loader;
-- :PackerCompile só regenera plugin/packer_compiled.lua (não editar à mão).
-- :PackerStatus mostra os plugins; :checkhealth verifica as dependências.
require('config.basics').setup()
require('config.providers').setup()

-- Na primeira execução, instala o Packer via Git no diretório de dados do Neovim.
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]] -- Carrega o gerenciador recém-instalado.
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  -- Gerenciador e tema alternativo (o tema ativo é definido ao final deste arquivo).
  use 'wbthomason/packer.nvim'
  use 'AlexvZyl/nordic.nvim'
  -- Guia fina para o limite de coluna, usando um caractere em vez de uma faixa.
  use 'lukas-reineke/virt-column.nvim'

  -- Configurações de servidores e instalador: :Mason abre o gerenciador de LSPs.
  use 'neovim/nvim-lspconfig'
  use 'mason-org/mason.nvim'
  use 'mason-org/mason-lspconfig.nvim'

  -- Autocomplete, fontes de sugestões, snippets e ícones dos tipos de conclusão.
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  -- O hook make compila suporte a transformações de snippets após instalar/atualizar.
  use { 'L3MON4D3/LuaSnip', run = 'make install_jsregexp' }
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind.nvim'
  -- Sintaxe e indentação para várias linguagens.
  use("sheerun/vim-polyglot")
  -- Git na margem/linha atual; execução de código; painel de símbolos (ctags).
  use("lewis6991/gitsigns.nvim")
  use("sbdchd/vim-run")
  use("preservim/tagbar")
  -- Realce de referências e modo de foco (:Twilight).
  use("RRethy/vim-illuminate")
  use("folke/twilight.nvim")
  -- Respeita .editorconfig; Grepper busca texto; Far oferece busca/substituição.
  use("editorconfig/editorconfig-vim")
  use("mhinz/vim-grepper")
  use("brooth/far.vim")
  -- Linha de status, ferramentas Go, tema ativo e fechamento automático de pares.
  use("nvim-lualine/lualine.nvim")
  use("olexsmir/gopher.nvim")
  use("catppuccin/nvim")
  use("windwp/nvim-autopairs")
  -- Geração de testes e ferramentas de desenvolvimento Go.
  use("yanskun/gotests.nvim")
  use("fatih/vim-go")
  -- Parsers para sintaxe; :TSUpdate atualiza, :TSInstall <linguagem> instala.
  use {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    run = function()
      -- Aguarda até 5 minutos pela atualização no hook do Packer.
      require('nvim-treesitter').update():wait(300000)
    end,
  }
  -- Barra de rolagem, implementações/interfaces e hierarquia de chamadas Go.
  use("petertriho/nvim-scrollbar")
  use("maxandron/goplements.nvim")
  use("crusj/hierarchy-tree-go.nvim")
  -- Operadores gc/gb para comentários e painel de autoria Git (:BlameToggle).
  use("numToStr/Comment.nvim")
  use("FabijanZulj/blame.nvim")
  -- Busca interativa, biblioteca auxiliar e ordenador nativo compilado com make.
  use("nvim-telescope/telescope.nvim")
  use("nvim-lua/plenary.nvim")
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  -- Lista de diagnósticos, diálogos de entrada/seleção, formatação e barra de buffers.
  use("folke/trouble.nvim")
  use("stevearc/dressing.nvim")
  use("stevearc/conform.nvim")
  use("akinsho/bufferline.nvim")
  -- Ícones de arquivos e seletor de branches do Telescope.
  use 'nvim-tree/nvim-web-devicons'
  use "mskelton/termicons.nvim"
  use('mrloop/telescope-git-branch.nvim')

  -- Árvore de arquivos, componentes de UI e renderização de Markdown.
  use 'nvim-tree/nvim-tree.lua'
  use 'MunifTanjim/nui.nvim'
  use 'MeanderingProgrammer/render-markdown.nvim'
  -- Marcadores TODO/FIX, execução de testes e busca alternativa via :FzfLua.
  use "folke/todo-comments.nvim"
  use "vim-test/vim-test"
  use "ibhagwan/fzf-lua"
  use "folke/tokyonight.nvim" -- Tema alternativo; não é ativado automaticamente.

  -- :PlantUML oferece ações para diagramas; saída em /tmp, visualizador do macOS.
  use {
    'Maduki-tech/nvim-plantuml',
    config = function()
        require('plantuml').setup({
            output_dir = '/tmp',
            viewer = 'open',
            auto_refresh = true,
        })
    end
  }

  -- Primeira execução: instala os plugins declarados; reinicie após a conclusão.
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Evita configurar módulos que ainda estão sendo instalados.
if packer_bootstrap then
  return
end

-- A detecção automática do tema consulta vim.pack, mas usamos Packer.
require('catppuccin').setup({
  auto_integrations = false,
  integrations = {
    cmp = true,
    fzf = true,
    gitsigns = true,
    illuminate = { enabled = true },
    lsp_trouble = true,
    mason = true,
    nvimtree = true,
    render_markdown = true,
    telescope = true,
  },
})
vim.cmd([[colorscheme catppuccin-mocha]]) -- Aplica a variante Mocha do Catppuccin.

-- Configura os plugins antes dos diagnósticos e dos atalhos que chamam suas APIs.
require('config.setups').setup()
require('config.settings').setup()
require('config.keymaps').setup()
