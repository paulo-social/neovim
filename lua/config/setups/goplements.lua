local M = {}

function M.setup()
  -- O healthcheck do plugin ainda usa has_parser, removido no Tree-sitter main.
  -- Consulta a API nativa e mantém o aviso quando o parser realmente falta.
  local health = require("goplements.health")
  if not require("nvim-treesitter.parsers").has_parser then
    health.treesitter_parser_installed = function(lang)
      local ok, err = pcall(vim.treesitter.language.add, lang)
      if ok then
        vim.health.ok("Treesitter parser for " .. lang .. " is installed")
      else
        vim.health.error("Treesitter parser for " .. lang .. " could not be loaded: " .. tostring(err))
      end
    end
  end
end

return M
