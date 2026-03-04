local M = {}

-- Show if a macro is currently being recorded
local function macro_status()
  local reg = vim.fn.reg_recording()
  if reg ~= "" then
    return "REC @" .. reg
  end
  return ""
end

function M.setup()
  -- Autocmd to refresh lualine when a macro starts/stops recording
  vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
      require("lualine").refresh({ place = { "statusline" } })
    end,
  })
  vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
      -- Timer is needed to ensure the refresh happens after the macro register is cleared
      local timer = vim.loop.new_timer()
      timer:start(50, 0, vim.schedule_wrap(function()
        require("lualine").refresh({ place = { "statusline" } })
      end))
    end,
  })

  require("lualine").setup({
    options = {
      icons_enabled = true, -- Mantido true para os icones de arquivo do termicons funcionarem
      theme = "auto",
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "NvimTree", "neo-tree", "Trouble", "qf" },
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 100,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        { "branch", icon = "🌱" },
        { "diff", symbols = { added = "+", modified = "~", removed = "-" } },
        { "diagnostics", symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" } },
      },
      lualine_c = {
        {
          "filename",
          path = 1, -- 0: Just the filename, 1: Relative path, 2: Absolute path
          symbols = {
            modified = "[+]",
            readonly = "[-]",
            unnamed = "[No Name]",
            newfile = "[New]",
          },
        },
      },
      lualine_x = {
        "encoding",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { "nvim-tree", "neo-tree", "lazy", "fzf", "trouble", "mason", "quickfix", "toggleterm"},
  })
end

return M