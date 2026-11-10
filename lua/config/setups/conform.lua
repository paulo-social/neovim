-- :ConformInfo mostra os formatadores disponíveis para o buffer.
-- Formatação manual: :lua require('conform').format({ async = true })
-- Não há atalho de formatação nem formatação automática ao salvar neste módulo.
local M = {}

function M.setup()
  require("conform").setup({
    -- Executáveis externos por linguagem; Python executa isort antes de black.
    -- Em Rust, usa o LSP como alternativa se rustfmt não estiver disponível.
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { "prettier" },
    },
  })
end

return M
