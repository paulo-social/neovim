-- Janela de busca: :Telescope find_files (nomes) e :Telescope live_grep (texto).
-- Atalhos globais: Espaço ff/fg e \ff/\fg, definidos em keymaps.lua.
-- live_grep requer ripgrep (rg). A base é :pwd; ocultos/ignorados não entram
-- por padrão. A busca de arquivos pode usar fd, rg ou find disponíveis no PATH.
-- Dentro da janela, em inserção: Ctrl+n/p ou setas selecionam; Enter abre;
-- Ctrl+x/v/t abre em split horizontal/vertical/tabpage; Ctrl+c fecha.
-- Esc sai da inserção; no modo normal, Esc fecha e j/k percorrem os resultados.
-- Tab/Shift+Tab marcam itens e avançam/voltam; Ctrl+q envia resultados à quickfix.
-- Ctrl+u/d rolam a prévia; Ctrl+/ (inserção) ou ? (normal) mostram os atalhos.
-- :Telescope keymaps lista mapeamentos; :Telescope help_tags busca na ajuda.
local M = {}

function M.setup()
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      prompt_prefix = "❯ ",
      selection_caret = "● ",
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = { prompt_position = "top" },
      },
    },
  })

  -- Extensões opcionais: fzf acelera a ordenação (compilado com make pelo Packer);
  -- git_branch oferece o seletor :Telescope git_branch. Falhas não impedem buscas.
  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "git_branch")
end

return M
