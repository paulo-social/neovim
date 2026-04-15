local M = {}

function M.setup()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local lspkind = require('lspkind')

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' }
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,
        ellipsis_char = '...',
        show_labelDetails = true,
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "󰕳",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      })
    },
    window = {
      completion = cmp.config.window.bordered({
        max_height = 15,
        border = "single",
        winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder",
      }),
      documentation = cmp.config.window.bordered({
        max_height = 10,
        border = "single",
        winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder",
      }),
    }
  })

  -- Configurar cores para a janela de completion
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1e1e2e", fg = "#cdd6f4" })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#45475a", fg = "#89b4fa", bold = true })
      vim.api.nvim_set_hl(0, "PmenuBorder", { fg = "#FFFFFF" })
      vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#FFFFFF" })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#FFFFFF" })
    end,
  })

  -- Aplicar instantaneamente também
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1e1e2e", fg = "#cdd6f4" })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#45475a", fg = "#89b4fa", bold = true })
  vim.api.nvim_set_hl(0, "PmenuBorder", { fg = "#FFFFFF" })
  vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#FFFFFF" })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#FFFFFF" })
end

return M
