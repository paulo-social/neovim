-- Servidores de linguagem: navegação, documentação, renomeação e diagnósticos.
-- :Mason gerencia executáveis; :checkhealth vim.lsp inspeciona clientes ativos.
-- Os atalhos que usam esses servidores estão em config/keymaps.lua.
local M = {}

function M.setup()
  -- Anuncia aos servidores o suporte a autocomplete do nvim-cmp.
  vim.lsp.config("*", {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })

  -- Reconhece arquivos .gotmpl como templates Go.
  vim.filetype.add({ extension = { gotmpl = "gotmpl" } })

  require("mason").setup()
  require("mason-lspconfig").setup({
    -- Mason garante estes servidores; mason-lspconfig os habilita automaticamente.
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

  -- ColorScheme: reaplica bordas brancas sempre que o tema for trocado.
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("LspBorders", { clear = true }),
    pattern = "*",
    callback = function()
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#FFFFFF", bg = "NONE" })
      vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = "#FFFFFF", bg = "NONE" })
    end,
  })
  -- Aplica instantaneamente também (caso o colorscheme já tenha carregado)
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#FFFFFF", bg = "NONE" })
  vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = "#FFFFFF", bg = "NONE" })
end

return M
