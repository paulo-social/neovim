local M = {}

function M.setup()
	local ok, codecompanion = pcall(require, "codecompanion")
	if not ok then
		return
	end

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
						content = [[
              Você é o Gerente de Projeto. Coordene os agentes na seguinte ordem:
              1. @Architect: Desenhe a solução.
              2. @Coder: Implemente a lógica.
              3. @Tester: Crie os testes.
              4. @Validator: Execute os testes no terminal e reporte falhas.
              5. @GitAgent: Se o @Validator der OK, faça o commit e push.
            ]],
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
					llm = "Você é um Software Architect. Seu papel é desenhar a solução, definir interfaces, tipos e a estrutura de pastas antes de qualquer código ser escrito.",
				},
				strategies = { "chat" },
			},
			{
				name = "Coder",
				roles = {
					llm = "Você é um Senior Developer. Você implementa a lógica de negócio seguindo o plano do Architect, focando em Clean Code e performance.",
				},
				strategies = { "chat" },
			},
			{
				name = "Tester",
				roles = {
					llm = "Você é um SDET. Sua única missão é escrever testes unitários e de integração exaustivos para o código gerado pelo @Coder.",
				},
				strategies = { "chat" },
			},
			{
				name = "Validator",
				roles = {
					llm = "Você é um especialista em CI/CD. Você deve executar comandos de linter (static analysis) e rodar os testes unitários para garantir que tudo compila e passa.",
				},
				strategies = { "chat" },
				opts = { tools = { "cmd_runner" } },
			},
			{
				name = "GitAgent",
				roles = {
					llm = "Você gerencia o controle de versão. Seu papel é criar commits semânticos e realizar o push para o repositório remoto.",
				},
				strategies = { "chat" },
				opts = { tools = { "cmd_runner" } },
			},
		},
	})
end

return M
