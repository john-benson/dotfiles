vim.g.mapleader="<Space>"
vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', { noremap = true, silent = true })

print("init.lua")

require('config.lazy')
require('config.neotree')
require('config.telescope')
require('config.lsp')

vim.cmd.colorscheme('tokyonight')
vim.opt.termguicolors = true
