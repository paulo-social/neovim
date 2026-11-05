local M = {}

function M.setup()
  vim.lsp.config("*", {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })

  vim.filetype.add({ extension = { gotmpl = "gotmpl" } })

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

  -- Força a cor da borda a ser branca
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
