-- Configuração inativa: Copilot não é instalado nem carregado por setups/init.lua.
local M = {}

function M.setup()
  local ok, copilot = pcall(require, 'copilot')
  if not ok then
    return
  end

  copilot.setup({
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = '<C-l>', -- Inserção: Ctrl+l aceita a sugestão.
        next = '<C-]>', -- Inserção: Ctrl+] mostra a próxima sugestão.
        prev = '<C-k>', -- Inserção: Ctrl+k mostra a sugestão anterior.
        dismiss = '<C-\\>', -- Inserção: Ctrl+barra invertida descarta a sugestão.
      },
    },
    panel = { enabled = false },
  })
end

return M
