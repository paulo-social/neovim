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

  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "git_branch")
end

return M
