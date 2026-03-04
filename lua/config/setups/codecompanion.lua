local M = {}

local function read_file(filepath)
	local file = io.open(vim.fn.expand(filepath), "r")
	if not file then
		return "Prompt not found: " .. filepath
	end
	local content = file:read("*a")
	file:close()
	return vim.trim(content)
end

function M.setup()
	local ok, codecompanion = pcall(require, "codecompanion")
	if not ok then
		return
	end

	local prompt_dir = "~/.config/nvim/lua/config/prompts/"

	codecompanion.setup({
		adapters = {
			copilot = function()
				return require("codecompanion.adapters").extend("copilot", {})
			end,
		},
		prompt_library = {
			["MyCoder"] = {
				strategy = "chat",
				description = "Cria a arquitetura, cria o código, cria os testes, valida e commita.",
				opts = {
					index = 1,
					is_default = false,
					is_slash_cmd = true,
				},
				prompts = {
					{
						role = "system",
						content = read_file(prompt_dir .. "pipelines/my_coder.md"),
					},
					{
						role = "user",
						content = "Minha tarefa é: ",
					},
				},
			},
		},
		strategies = {
			chat = { adapter = "copilot" },
			inline = { adapter = "copilot" },
		},
		display = {
			chat = {
				window = { layout = "vertical", width = 0.4, position = "right" },
				start_in_insert_mode = true,
			},
		},
		agents = {
			{
				name = "Architect",
				roles = {
					llm = read_file(prompt_dir .. "agents/architect.md"),
				},
				strategies = { "chat" },
			},
			{
				name = "Coder",
				roles = {
					llm = read_file(prompt_dir .. "agents/coder.md"),
				},
				strategies = { "chat" },
			},
			{
				name = "Tester",
				roles = {
					llm = read_file(prompt_dir .. "agents/tester.md"),
				},
				strategies = { "chat" },
			},
			{
				name = "Validator",
				roles = {
					llm = read_file(prompt_dir .. "agents/validator.md"),
				},
				strategies = { "chat" },
				opts = { tools = { "cmd_runner" } },
			},
			{
				name = "GitAgent",
				roles = {
					llm = read_file(prompt_dir .. "agents/git_agent.md"),
				},
				strategies = { "chat" },
				opts = { tools = { "cmd_runner" } },
			},
		},
	})
end

return M
