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

  use {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  }

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
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
  use("nvim-treesitter/nvim-treesitter")
  use("petertriho/nvim-scrollbar")
  use("maxandron/goplements.nvim")
  use("crusj/hierarchy-tree-go.nvim")
  use("mrcjkb/rustaceanvim")
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
  use { "mskelton/termicons.nvim", requires = { "nvim-tree/nvim-web-devicons" } }
  use('mrloop/telescope-git-branch.nvim')

  use 'nvim-tree/nvim-tree.lua'
  use 'MunifTanjim/nui.nvim'
  use 'MeanderingProgrammer/render-markdown.nvim'
  -- use 'zbirenbaum/copilot.lua'
  -- use 'olimorris/codecompanion.nvim'

  use {
    "ravitemer/mcphub.nvim",
    run = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup({})
    end
  }

  use "vim-test/vim-test"

  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.cmd([[colorscheme catppuccin-mocha]])

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright",
    "gopls",
    "jdtls",
    "html",
    "ts_ls",
    "rust_analyzer",
    "bashls",
    "sqlls",
    "jsonls",
    "lua_ls",
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
  'pyright',
  'gopls',
  'jdtls',
  'html',
  'ts_ls',
  'rust_analyzer',
  'bashls',
  'sqlls',
  'jsonls',
  'lua_ls',
  "django-template-lsp",
  "docker-language-server",
  "djlint",
}

for _, server in ipairs(servers) do
  vim.lsp.config[server] = {
    capabilities = capabilities
  }
end


require('config.settings').setup()
require('config.keymaps').setup()
require('config.basics').setup()
require('config.setups').setup()
