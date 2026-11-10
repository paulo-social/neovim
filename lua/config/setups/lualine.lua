local M = {}

-- Mostra REC @registro durante a gravação de macro (q{registro}; q para encerrar).
local function macro_status()
	local reg = vim.fn.reg_recording()
	if reg ~= "" then
		return "REC @" .. reg
	end
	return ""
end

function M.setup()
	-- RecordingEnter/Leave atualizam a linha de status ao iniciar/encerrar a macro.
	vim.api.nvim_create_autocmd("RecordingEnter", {
		callback = function()
			require("lualine").refresh({ place = { "statusline" } })
		end,
	})
	vim.api.nvim_create_autocmd("RecordingLeave", {
		callback = function()
			-- Espera o registro de gravação ser limpo antes de atualizar a interface.
			local timer = vim.loop.new_timer()
			timer:start(
				50,
				0,
				vim.schedule_wrap(function()
					require("lualine").refresh({ place = { "statusline" } })
				end)
			)
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
				{ "branch", icon = "⎇" },
				{ "diff", symbols = { added = "+", modified = "~", removed = "-" } },
				{ "diagnostics", symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" } },
			},
			lualine_c = {
				{
					"filename",
					path = 1, -- 0: nome; 1: caminho relativo; 2: caminho absoluto.
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
		extensions = { "nvim-tree", "neo-tree", "lazy", "fzf", "trouble", "mason", "quickfix", "toggleterm" },
	})
end

return M
