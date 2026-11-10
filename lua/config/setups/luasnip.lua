-- Snippets oferecidos pelo nvim-cmp e confirmados com Enter no menu.
-- Não há atalhos locais para saltar entre campos de snippets.
local M = {}

function M.setup()
  local luasnip = require("luasnip")

  luasnip.config.setup({
    history = true, -- Mantém snippets anteriores disponíveis para navegação.
    updateevents = "TextChanged,TextChangedI",
  })

  -- Carrega friendly-snippets conforme o tipo de arquivo.
  require("luasnip.loaders.from_vscode").lazy_load()
end

return M
