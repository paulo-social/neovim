-- Atalhos padrão do Comment.nvim (sem Leader):
-- Normal: gcc alterna comentário da linha; gbc alterna comentário em bloco.
-- Normal: gc{movimento}/gb{movimento} comentam a região (ex.: gcip, parágrafo).
-- Visual: gc/gb alternam comentário das linhas/da seleção em bloco.
-- Normal: gco/gcO criam comentário abaixo/acima; gcA adiciona ao fim da linha.
-- Consulte :help comment-nvim para operadores, contagens e objetos de texto.
local M = {}

function M.setup()
  require("Comment").setup()
end

return M
