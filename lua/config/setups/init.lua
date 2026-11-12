local M = {}

function M.setup()
  -- Configuração dos plugins, executada uma vez durante a inicialização.
  require('config.setups.virt-column').setup()
  require('config.setups.devicons').setup()
  require('config.setups.nvim-tree').setup()
  require('config.setups.bufferline').setup()
  require('config.setups.lualine').setup()
  require('config.setups.gitsigns').setup()
  require('config.setups.autopairs').setup()
  require('config.setups.scrollbar').setup()
  require('config.setups.treesitter').setup()
  require('config.setups.goplements').setup()
  require('config.setups.twilight').setup()
  require('config.setups.blame').setup()
  require('config.setups.comment').setup()
  require('config.setups.conform').setup()
  -- Integrações de IA desativadas; não há instalação desses plugins em init.lua.
  -- require('config.setups.copilot').setup()
  -- require('config.setups.codecompanion').setup()
  require('config.setups.telescope').setup()
  require('config.setups.luasnip').setup()
  require('config.setups.dressing').setup()

  -- LSP e autocompletion
  require('config.setups.lsp').setup()
  require('config.setups.cmp').setup()
  require('config.setups.todo-comments').setup()

  -- :TodoTelescope lista marcadores TODO/FIX/etc. usando a janela do Telescope.
  require("telescope").load_extension("todo-comments")
  -- Carrega o provedor de texto de :FzfLua; os atalhos ff/fg usam Telescope.
  require("fzf-lua.providers.grep")
end

return M
