-- Destaca marcadores em comentários; :TodoTelescope busca, :TodoQuickFix lista
-- na quickfix e :TodoLocList lista na janela atual. Sem atalhos personalizados.
local M = {}

local highlights = {
  FIX = { fg = "#f38ba8", bg = "#5a1f32" },
  TODO = { fg = "#89dceb", bg = "#123a5a" },
  WARN = { fg = "#f9e2af", bg = "#52380f" },
  NOTE = { fg = "#a6e3a1", bg = "#174225" },
  HACK = { fg = "#cba6f7", bg = "#3c2960" },
  PERF = { fg = "#fab387", bg = "#512810" },
  TEST = { fg = "#94e2d5", bg = "#11433d" },
}

local function termicon(name, fallback)
  local ok, termicons = pcall(require, "termicons.icons")
  if not ok then
    return fallback
  end

  local icon = termicons.icons[name]
  return icon and icon.icon or fallback
end

local function apply_highlights()
  for keyword, colors in pairs(highlights) do
    vim.api.nvim_set_hl(0, "TodoBg" .. keyword, {
      fg = colors.fg,
      bg = colors.bg,
      bold = true,
    })
    vim.api.nvim_set_hl(0, "TodoFg" .. keyword, {
      fg = colors.fg,
    })
    vim.api.nvim_set_hl(0, "TodoSign" .. keyword, {
      fg = colors.fg,
      bg = "NONE",
      bold = true,
    })
  end
end

local function refresh_visible_todos()
  apply_highlights()

  local ok, highlight = pcall(require, "todo-comments.highlight")
  if not ok then
    return
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    pcall(highlight.attach, win, true)
  end
  pcall(highlight.update)
end

function M.setup()
  local group = vim.api.nvim_create_augroup("UserTodoCommentsHighlights", { clear = true })

  require("todo-comments").setup({
    signs = true,
    sign_priority = 8,

    keywords = {
      FIX = {
        icon = "",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = {
        icon = "",
        color = "info",
      },
      WARN = {
        icon = "",
        color = "warning",
        alt = { "WARNING", "XXX" },
      },
      NOTE = {
        icon = "",
        color = "hint",
        alt = { "INFO" },
      },
      HACK = {
        icon = "",
        color = "default",
      },
      PERF = {
        icon = "",
        color = "test",
        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
      },
      TEST = {
        icon = "",
        color = "test",
        alt = { "TESTING", "PASSED", "FAILED" },
      },
    },

    gui_style = {
      fg = "NONE",
      bg = "bold",
    },

    merge_keywords = false,

    highlight = {
      multiline = true,
      multiline_pattern = "^.",
      multiline_context = 10,
      before = "",
      keyword = "wide_bg",
      after = "fg",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = true,
      max_line_len = 400,
      exclude = {},
    },

    colors = {
      error = { "#f38ba8" },   -- red
      warning = { "#f9e2af" }, -- yellow
      info = { "#89dceb" },    -- sky
      hint = { "#a6e3a1" },    -- green
      default = { "#cba6f7" }, -- mauve
      test = { "#fab387" },    -- peach
    },
  })

  -- Reaplica as cores após trocar o tema, quando os highlights dele já existem.
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    pattern = "*",
    callback = function()
      vim.defer_fn(refresh_visible_todos, 20)
    end,
  })

  -- Atualiza marcadores ao entrar em buffers/janelas, inclusive após abrir splits.
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter" }, {
    group = group,
    pattern = "*",
    callback = function()
      vim.defer_fn(refresh_visible_todos, 20)
    end,
  })

  -- Duas atualizações iniciais cobrem a abertura e a montagem da interface.
  vim.defer_fn(refresh_visible_todos, 20)
  vim.defer_fn(refresh_visible_todos, 250)
end

return M
