-- Insere automaticamente pares de parênteses, colchetes, chaves e aspas.
local M = {}

function M.setup()
  require("nvim-autopairs").setup({
    disable_in_macro = true,
    disable_in_visualblock = false,
    disable_in_replace_mode = true,
    enable_moveright = true,
    enable_afterquote = true,
    enable_check_bracket_line = true,
    enable_bracket_in_quote = true,
    enable_abbr = false,
    break_undo = true,
    check_ts = false,
    map_cr = true, -- Enter entre pares aplica a quebra de linha do plugin.
    map_bs = true, -- Backspace pode apagar os dois caracteres de um par vazio.
    map_c_h = false, -- Não redefine Ctrl+h.
    map_c_w = false, -- Não redefine Ctrl+w.
  })
end

return M
