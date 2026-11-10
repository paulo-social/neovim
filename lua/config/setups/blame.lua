-- :BlameToggle abre/fecha o painel com a autoria Git das linhas do arquivo.
-- Sem atalho global personalizado nesta configuração.
local M = {}

function M.setup()
  require("blame").setup()
end

return M
