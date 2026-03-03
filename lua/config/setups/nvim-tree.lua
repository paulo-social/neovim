local M = {}

function M.setup()
  require("nvim-tree").setup({
    sort = {
      sorter = "case_sensitive",
    },
    filters = {
      dotfiles = false,
      git_ignored = true,
      custom = { ".git" },
      exclude = { vim.fn.stdpath("config") .. "/lua/custom" },
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      icons = {
        hint = "◼",
        info = "◼",
        warning = "◼",
        error = "◼",
      },
    },
    view = {
      adaptive_size = false,
      side = "left",
      width = 30,
      preserve_window_proportions = true,
    },
    git = {
      enable = true,
      ignore = true,
    },
    filesystem_watchers = {
      enable = true,
    },
    actions = {
      open_file = {
        resize_window = false,
      },
    },
    renderer = {
      group_empty = true,
      root_folder_label = false,
      highlight_git = true,
      highlight_opened_files = "none",
      special_files = {
        "Makefile",
        "pyproject.toml",
        "go.mod",
        "go.sum",
        "requirements.txt",
        "Dockerfile",
      },
      indent_markers = {
        enable = true,
      },
      icons = {
        padding = "",
        show = {
          file = true,
          folder = false,
          folder_arrow = true,
          git = false,
        },
        glyphs = {
          default = "󰈚",
          symlink = "",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
          },
          git = {
            unstaged = "◼",
            staged = "◼",
            unmerged = "◼",
            renamed = "◼",
            untracked = "◼",
            deleted = "◼",
            ignored = "◼",
          },
        },
      },
    },
  })

  vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = function()
    require("nvim-tree.api").tree.open()
  end})
end

return M
