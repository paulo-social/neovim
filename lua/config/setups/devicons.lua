local M = {}

function M.setup()
  local overrides_by_filename = {}
  local overrides_by_extension = {}

  -- Extraindo os icones do termicons para injetar na carga principal
  local ok, mappings = pcall(require, "termicons.mappings")
  if ok then
    local icons = require("termicons.icons").icons
    for key, icon in pairs(mappings.by_filename) do
      overrides_by_filename[key] = icons[icon]
    end
    for key, icon in pairs(mappings.by_extension) do
      overrides_by_extension[key] = icons[icon]
    end
  end

  -- Mantendo os overrides locais (que sobrescrevem o termicons se existir)
  overrides_by_filename[".gitignore"] = { icon = "", color = "#f1502f", name = "Gitignore" }
  overrides_by_extension["log"] = { icon = "", color = "#81e043", name = "Log" }

  require("nvim-web-devicons").setup({
    override = {
      zsh = {
        icon = "",
        color = "#428850",
        cterm_color = "65",
        name = "Zsh",
      },
    },
    color_icons = true,
    default = true,
    strict = true,
    override_by_filename = overrides_by_filename,
    override_by_extension = overrides_by_extension,
  })

  if ok then
    require("nvim-web-devicons").set_default_icon("큪", "#6d8086")
  end
end

return M