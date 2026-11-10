-- Opções gerais, carregadas antes dos plugins e dos atalhos.
local M = {}

function M.setup()
    -- Prefixo dos atalhos: Espaço. keymaps.lua mantém também \ff e \fg literais.
    vim.g.mapleader = " "

    -- Mantém buffers modificados ao trocar de arquivo; indentação de 4 espaços.
    vim.o.hidden = true
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.smarttab = true
    -- Buscas ignoram maiúsculas, exceto quando o padrão contém uma maiúscula.
    vim.o.ignorecase = true
    vim.o.smartcase = true
    -- Cores RGB e fundo escuro para o tema; Tab insere espaços.
    vim.o.termguicolors = true
    vim.o.background = "dark"
    vim.o.expandtab = true

    -- Torna espaços, fim de linha, tabulações e espaços finais visíveis.
    vim.opt.list = true
    vim.opt.listchars:append("space:.")
    vim.opt.listchars:append("eol:↴")
    vim.opt.listchars:append("tab:→→")
    vim.opt.listchars:append("trail:.")
    -- Exibe posição do cursor e usa UTF-8; destaca a linha atual.
    vim.opt.ruler = true
    vim.opt.encoding = "utf-8"
    vim.opt.expandtab = true
    vim.opt.termguicolors = true
    vim.opt.cursorline = true
    -- Preserva a indentação da linha anterior; Tab/Backspace usam 4 colunas.
    vim.opt.autoindent = true
    vim.opt.smarttab = true
    vim.opt.softtabstop = 4
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    -- Mouse em todos os modos, sintaxe habilitada e linhas sem quebra visual.
    vim.opt.mouse = "a"
    vim.opt.syntax = "on"
    vim.opt.wrap = false
    vim.opt.termguicolors = true

    -- Remove o ~ que aparece em linhas vazias
    vim.opt.fillchars:append("eob: ")

    -- Guia na coluna 80 e números absolutos de linha.
    vim.wo.colorcolumn = "80"
    vim.wo.relativenumber = false
    vim.wo.number = true

    -- Suprime o aviso de migração da scrollbar.
    vim.g.scrollbar_v2_notice = false
end

return M
