-- Usa o limite de colorcolumn definido em basics.lua e as cores do tema ativo.
local M = {}

function M.setup()
  -- Permite abrir o Neovim antes da primeira instalação do plugin.
  local ok, virt_column = pcall(require, 'virt-column')
  if not ok then
    return
  end

  virt_column.setup({
    char = '│',
    highlight = 'Whitespace',
  })
end

return M
