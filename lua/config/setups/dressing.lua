-- Melhora vim.ui.input/select (por exemplo, renomear símbolo e ações de código).
-- Mantém os atalhos padrão dos diálogos; não define atalhos globais.
local M = {}

function M.setup()
  require("dressing").setup({})
end

return M
