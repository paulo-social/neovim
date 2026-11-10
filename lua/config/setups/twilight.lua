-- :Twilight alterna o escurecimento fora do contexto do cursor.
-- :TwilightEnable/:TwilightDisable ligam/desligam explicitamente; sem atalho local.
local M = {}

function M.setup()
  require("twilight").setup({
    dimming = {
      alpha = 0.25,
      color = { "Normal", "#ffffff" },
      inactive = false,
    },
    context = 1,
    treesitter = false,
    expand = {
      "function",
      "method",
      "table",
      "if_statement",
      "class",
    },
    exclude = {},
  })
end

return M
