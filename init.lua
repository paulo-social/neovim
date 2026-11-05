require('config.basics').setup()
require('config.providers').setup()

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'AlexvZyl/nordic.nvim'

  use 'neovim/nvim-lspconfig'
  use 'mason-org/mason.nvim'
  use 'mason-org/mason-lspconfig.nvim'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use { 'L3MON4D3/LuaSnip', run = 'make install_jsregexp' }
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind.nvim'
  use("sheerun/vim-polyglot")
  use("lewis6991/gitsigns.nvim")
  use("sbdchd/vim-run")
  use("preservim/tagbar")
  use("RRethy/vim-illuminate")
  use("folke/twilight.nvim")
  use("editorconfig/editorconfig-vim")
  use("mhinz/vim-grepper")
  use("brooth/far.vim")
  use("nvim-lualine/lualine.nvim")
  use("olexsmir/gopher.nvim")
  use("catppuccin/nvim")
  use("windwp/nvim-autopairs")
  use("yanskun/gotests.nvim")
  use("fatih/vim-go")
  use {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    run = function()
      require('nvim-treesitter').update():wait(300000)
    end,
  }
  use("petertriho/nvim-scrollbar")
  use("maxandron/goplements.nvim")
  use("crusj/hierarchy-tree-go.nvim")
  use("numToStr/Comment.nvim")
  use("FabijanZulj/blame.nvim")
  use("nvim-telescope/telescope.nvim")
  use("nvim-lua/plenary.nvim")
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use("folke/trouble.nvim")
  use("stevearc/dressing.nvim")
  use("stevearc/conform.nvim")
  use("akinsho/bufferline.nvim")
  use 'nvim-tree/nvim-web-devicons' -- or use 'echasnovski/mini.icons'
  use "mskelton/termicons.nvim"
  use('mrloop/telescope-git-branch.nvim')

  use 'nvim-tree/nvim-tree.lua'
  use 'MunifTanjim/nui.nvim'
  use 'MeanderingProgrammer/render-markdown.nvim'
  use "folke/todo-comments.nvim"
  use "vim-test/vim-test"
  use "ibhagwan/fzf-lua"
  use "folke/tokyonight.nvim"

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

  if packer_bootstrap then
    require('packer').sync()
  end
end)

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
vim.cmd([[colorscheme catppuccin-frappe]])

require('config.setups').setup()
require('config.settings').setup()
require('config.keymaps').setup()
