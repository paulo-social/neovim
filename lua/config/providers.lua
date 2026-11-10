local M = {}

function M.setup()
  -- Ambiente dedicado: não depende do Python selecionado pelo pyenv no projeto.
  local data = vim.fn.stdpath("data")
  local python = data .. "/python3/bin/python"
  if vim.fn.executable(python) == 1 then
    vim.g.python3_host_prog = python
  end
  -- Prioriza ferramentas instaladas por scripts/install_tools.sh (Go e Python).
  vim.env.PATH = data .. "/bin:" .. vim.env.PATH
end

return M
