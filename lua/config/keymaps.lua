-- Atalhos globais: 'n' = modo normal; 'x' = seleção visual.
-- <Leader> = Espaço (basics.lua); <C-...> = Ctrl; <S-...> = Shift; <CR> = Enter.
-- Digite as sequências com Leader uma tecla após a outra, no modo normal.
-- Os comentários explicam o uso; desc também aparece em :Telescope keymaps.
local M = {}

function M.setup()
  -- Após saltar para um diagnóstico, mostra a mensagem sem mover o foco.
  local function diagnostic_float(diagnostic, bufnr)
    if diagnostic and vim.api.nvim_buf_is_valid(bufnr) then
      vim.diagnostic.open_float({ bufnr = bufnr, scope = 'cursor', focus = false })
    end
  end

  -- Depuração opcional: os atalhos só existem se nvim-dap estiver instalado.
  -- Esta configuração não instala DAP nem configura adaptadores de depuração.
  local has_dap, dap = pcall(require, 'dap')
  if has_dap then
    -- F5: inicia/continua; F10: executa a linha sem entrar na função.
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Iniciar/continuar depuração' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Depurar: executar próxima linha' })
    -- F11: entra na função; F12: executa até sair da função atual.
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Depurar: entrar na função' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Depurar: sair da função' })
    -- Espaço b: adiciona/remove um ponto de parada na linha atual.
    vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = 'Alternar breakpoint' })
  end

  -- Ctrl+n: abre/fecha a árvore; Espaço e: abre a árvore e coloca o foco nela.
  vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true, desc = 'Abrir/fechar árvore de arquivos' })
  vim.keymap.set('n', '<Leader>e', ':NvimTreeFocus<CR>', { silent = true, desc = 'Focar árvore de arquivos' })
  -- Espaço w: passa para a próxima janela (split), incluindo a árvore lateral.
  vim.keymap.set('n', '<Leader>w', '<C-w>w', { silent = true, desc = 'Alternar entre janelas' })

  -- Espaço t: abre/fecha a lista de símbolos do arquivo; requer ctags.
  vim.keymap.set('n', '<Leader>t', ':TagbarToggle<CR>', { silent = true, desc = 'Abrir/fechar lista de símbolos' })

  -- Espaço d: mensagem de diagnóstico; Espaço k: documentação do símbolo.
  -- Como d também inicia df/dc/dt/db/dp, o atalho d pode aguardar timeoutlen.
  vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, { desc = 'Abrir diagnóstico flutuante' })
  vim.keymap.set('n', '<Leader>k', function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = 'Exibir informações do símbolo' })
  -- Navegação LSP (requer servidor ativo com suporte à operação):
  -- Espaço df: definição; dc: declaração; gi: implementação; dt: tipo.
  vim.keymap.set('n', '<Leader>df', vim.lsp.buf.definition, { desc = 'Ir para definição' })
  vim.keymap.set('n', '<Leader>dc', vim.lsp.buf.declaration, { desc = 'Ir para declaração' })
  vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, { desc = 'Listar implementações' })
  vim.keymap.set('n', '<Leader>dt', vim.lsp.buf.type_definition, { desc = 'Ir para definição de tipo' })
  -- Espaço lr: locais que referenciam o símbolo; s: parâmetros da função.
  vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.references, { desc = 'Listar referências' })
  vim.keymap.set('n', '<Leader>s', function() vim.lsp.buf.signature_help({ border = "rounded" }) end, { desc = 'Exibir assinatura da função' })
  -- Espaço r: renomeia pelo LSP; ca: escolhe uma correção/refatoração disponível.
  vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, { desc = 'Renomear símbolo' })
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, { desc = 'Ações de código' })
  -- Espaço db/dp: diagnóstico anterior/próximo, com mensagem flutuante.
  vim.keymap.set('n', '<Leader>db', function() vim.diagnostic.jump({ count = -1, on_jump = diagnostic_float }) end, { desc = 'Ir para diagnóstico anterior' })
  vim.keymap.set('n', '<Leader>dp', function() vim.diagnostic.jump({ count = 1, on_jump = diagnostic_float }) end, { desc = 'Ir para próximo diagnóstico' })

  -- IA opcional, não instalada aqui: ac abre chat; ai abre prompt (normal ou
  -- seleção visual); aa abre o seletor de ações do CodeCompanion.
  if pcall(require, 'codecompanion') then
    vim.keymap.set('n', '<Leader>ac', ':CodeCompanionChat<CR>', { silent = true, desc = 'Abrir chat (CodeCompanion)' })
    vim.keymap.set('n', '<Leader>ai', ':CodeCompanion<CR>', { silent = true, desc = 'Prompt inline (CodeCompanion)' })
    vim.keymap.set('x', '<Leader>ai', ':CodeCompanion<CR>', { silent = true, desc = 'Prompt inline (CodeCompanion)' })
    vim.keymap.set('n', '<Leader>aa', ':CodeCompanionActions<CR>', { silent = true, desc = 'Ações (CodeCompanion)' })
  end

  -- Telescope: abre uma janela com campo de busca, resultados e prévia.
  -- Usa o diretório atual (:pwd); :cd /caminho/do/projeto altera a base da busca.
  local telescope = require('telescope.builtin')
  -- Espaço ff: busca por nome de arquivo; Espaço fg: busca texto ao digitar (rg).
  vim.keymap.set('n', '<Leader>ff', telescope.find_files, { desc = 'Buscar arquivos' })
  vim.keymap.set('n', '<Leader>fg', telescope.live_grep, { desc = 'Buscar texto no projeto' })
  -- Compatibilidade com os atalhos antigos: barra invertida literal, sem mudar
  -- o Leader dos demais atalhos. Em strings Lua, \\ representa uma única barra.
  vim.keymap.set('n', '\\ff', telescope.find_files, { desc = 'Buscar arquivos (atalho antigo)' })
  vim.keymap.set('n', '\\fg', telescope.live_grep, { desc = 'Buscar texto no projeto (atalho antigo)' })
  -- Espaço fs: procura a palavra sob o cursor; fb: procura nos buffers abertos.
  vim.keymap.set('n', '<Leader>fs', telescope.grep_string, { desc = 'Buscar palavra sob o cursor' })
  vim.keymap.set('n', '<Leader>fb', telescope.buffers, { desc = 'Listar buffers' })
  -- Espaço fd: lista diagnósticos; fr: reabre a última busca com seu estado.
  vim.keymap.set('n', '<Leader>fd', telescope.diagnostics, { desc = 'Buscar diagnósticos' })
  vim.keymap.set('n', '<Leader>fr', telescope.resume, { desc = 'Retomar última busca' })

  -- A barra superior mostra buffers (arquivos abertos), não tabpages do Neovim.
  -- Tab/Shift+Tab: próximo/anterior; Espaço x: :bdelete, que protege alterações
  -- não salvas; Espaço X: fecha os demais buffers pelo BufferLine.
  vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { silent = true, desc = 'Próxima aba' })
  vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true, desc = 'Aba anterior' })
  vim.keymap.set('n', '<Leader>x', ':bdelete<CR>', { silent = true, desc = 'Fechar aba atual' })
  vim.keymap.set('n', '<Leader>X', ':BufferLineCloseOthers<CR>', { silent = true, desc = 'Fechar outras abas' })
  -- Espaço 1 até 9: seleciona a posição na barra (não o número interno do buffer).
  vim.keymap.set('n', '<Leader>1', ':BufferLineGoToBuffer 1<CR>', { silent = true, desc = 'Ir para aba 1' })
  vim.keymap.set('n', '<Leader>2', ':BufferLineGoToBuffer 2<CR>', { silent = true, desc = 'Ir para aba 2' })
  vim.keymap.set('n', '<Leader>3', ':BufferLineGoToBuffer 3<CR>', { silent = true, desc = 'Ir para aba 3' })
  vim.keymap.set('n', '<Leader>4', ':BufferLineGoToBuffer 4<CR>', { silent = true, desc = 'Ir para aba 4' })
  vim.keymap.set('n', '<Leader>5', ':BufferLineGoToBuffer 5<CR>', { silent = true, desc = 'Ir para aba 5' })
  vim.keymap.set('n', '<Leader>6', ':BufferLineGoToBuffer 6<CR>', { silent = true, desc = 'Ir para aba 6' })
  vim.keymap.set('n', '<Leader>7', ':BufferLineGoToBuffer 7<CR>', { silent = true, desc = 'Ir para aba 7' })
  vim.keymap.set('n', '<Leader>8', ':BufferLineGoToBuffer 8<CR>', { silent = true, desc = 'Ir para aba 8' })
  vim.keymap.set('n', '<Leader>9', ':BufferLineGoToBuffer 9<CR>', { silent = true, desc = 'Ir para aba 9' })
  -- Espaço $: seleciona o último buffer da barra.
  vim.keymap.set('n', '<Leader>$', ':BufferLineGoToBuffer -1<CR>', { silent = true, desc = 'Ir para última aba' })
end

return M
