-- Mudanças Git na margem, nos números e nas linhas; autoria após 300 ms no cursor.
-- Sem atalhos personalizados. Comandos manuais: :Gitsigns preview_hunk mostra a
-- alteração; :Gitsigns blame_line mostra a autoria; :Gitsigns diffthis abre diff.
-- :Gitsigns stage_hunk adiciona o trecho ao índice; :Gitsigns reset_hunk descarta
-- alterações do trecho. :Gitsigns toggle_current_line_blame alterna autoria inline.
local M = {}

function M.setup()
  require("gitsigns").setup({
    signs = {
      add          = { text = "┃" },
      change       = { text = "┃" },
      delete       = { text = "◼" },
      topdelete    = { text = "◼" },
      changedelete = { text = "┃" },
      untracked    = { text = "┃" },
    },
    signcolumn = true,
    numhl = true,
    linehl = true,
    word_diff = false,
    watch_gitdir = {
      interval = 2000,
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = true,
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 300,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  })
end

return M
