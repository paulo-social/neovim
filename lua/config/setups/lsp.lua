local M = {}

function M.setup()
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

  -- Configuração global para adicionar bordas nas janelas flutuantes do LSP
  local border = "rounded"
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = border,
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = border,
  })

  -- Força a cor da borda a ser branca
  vim.api.nvim_create_autocmd("ColorScheme", {
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