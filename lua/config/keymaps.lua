local M = {}

function M.setup()
  vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
  vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
  vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
  vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)

  vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle NvimTree' })
  vim.keymap.set('n', '<Leader>e', ':NvimTreeFocus<CR>', { silent = true, desc = 'Focus NvimTree' })
  vim.keymap.set('n', '<Leader>w', '<C-w>w', { silent = true, desc = 'Alternar entre janelas' })
  
  vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
  vim.keymap.set('n', '<Leader>t', ':TagbarToggle<CR>', { silent = true })

  vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, { desc = 'Abrir diagnóstico flutuante' })
  vim.keymap.set('n', '<Leader>k', function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = 'Exibir informações do símbolo' })
  vim.keymap.set('n', '<Leader>df', vim.lsp.buf.definition, { desc = 'Ir para definição' })
  vim.keymap.set('n', '<Leader>dc', vim.lsp.buf.declaration, { desc = 'Ir para declaração' })
  vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, { desc = 'Listar implementações' })
  vim.keymap.set('n', '<Leader>dt', vim.lsp.buf.type_definition, { desc = 'Ir para definição de tipo' })
  vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.references, { desc = 'Listar referências' })
  vim.keymap.set('n', '<Leader>s', function() vim.lsp.buf.signature_help({ border = "rounded" }) end, { desc = 'Exibir assinatura da função' })
  vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, { desc = 'Renomear símbolo' })
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, { desc = 'Ações de código' })
  vim.keymap.set('n', '<Leader>db', vim.diagnostic.goto_prev, { desc = 'Ir para diagnóstico anterior' })
  vim.keymap.set('n', '<Leader>dp', vim.diagnostic.goto_next, { desc = 'Ir para próximo diagnóstico' })

  vim.keymap.set('n', '<Leader>ac', ':CodeCompanionChat<CR>', { silent = true, desc = 'Abrir chat (CodeCompanion)' })
  vim.keymap.set('n', '<Leader>ai', ':CodeCompanion<CR>', { silent = true, desc = 'Prompt inline (CodeCompanion)' })
  vim.keymap.set('x', '<Leader>ai', ':CodeCompanion<CR>', { silent = true, desc = 'Prompt inline (CodeCompanion)' })
  vim.keymap.set('n', '<Leader>aa', ':CodeCompanionActions<CR>', { silent = true, desc = 'Ações (CodeCompanion)' })

  local telescope = require('telescope.builtin')
  vim.keymap.set('n', '<Leader>ff', telescope.find_files, { desc = 'Buscar arquivos' })
  vim.keymap.set('n', '<Leader>fg', telescope.live_grep, { desc = 'Buscar texto no projeto' })
  vim.keymap.set('n', '<Leader>fs', telescope.grep_string, { desc = 'Buscar palavra sob o cursor' })
  vim.keymap.set('n', '<Leader>fb', telescope.buffers, { desc = 'Listar buffers' })
  vim.keymap.set('n', '<Leader>fd', telescope.diagnostics, { desc = 'Buscar diagnósticos' })
  vim.keymap.set('n', '<Leader>fr', telescope.resume, { desc = 'Retomar última busca' })

  vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { silent = true, desc = 'Próxima aba' })
  vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true, desc = 'Aba anterior' })
  vim.keymap.set('n', '<Leader>x', ':bdelete<CR>', { silent = true, desc = 'Fechar aba atual' })
  vim.keymap.set('n', '<Leader>X', ':BufferLineCloseOthers<CR>', { silent = true, desc = 'Fechar outras abas' })
  vim.keymap.set('n', '<Leader>1', ':BufferLineGoToBuffer 1<CR>', { silent = true, desc = 'Ir para aba 1' })
  vim.keymap.set('n', '<Leader>2', ':BufferLineGoToBuffer 2<CR>', { silent = true, desc = 'Ir para aba 2' })
  vim.keymap.set('n', '<Leader>3', ':BufferLineGoToBuffer 3<CR>', { silent = true, desc = 'Ir para aba 3' })
  vim.keymap.set('n', '<Leader>4', ':BufferLineGoToBuffer 4<CR>', { silent = true, desc = 'Ir para aba 4' })
  vim.keymap.set('n', '<Leader>5', ':BufferLineGoToBuffer 5<CR>', { silent = true, desc = 'Ir para aba 5' })
  vim.keymap.set('n', '<Leader>6', ':BufferLineGoToBuffer 6<CR>', { silent = true, desc = 'Ir para aba 6' })
  vim.keymap.set('n', '<Leader>7', ':BufferLineGoToBuffer 7<CR>', { silent = true, desc = 'Ir para aba 7' })
  vim.keymap.set('n', '<Leader>8', ':BufferLineGoToBuffer 8<CR>', { silent = true, desc = 'Ir para aba 8' })
  vim.keymap.set('n', '<Leader>9', ':BufferLineGoToBuffer 9<CR>', { silent = true, desc = 'Ir para aba 9' })
  vim.keymap.set('n', '<Leader>$', ':BufferLineGoToBuffer -1<CR>', { silent = true, desc = 'Ir para última aba' })
end

return M
