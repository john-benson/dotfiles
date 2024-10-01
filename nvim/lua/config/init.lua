vim.g.mapleader="<Space>"
vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', { noremap = true, silent = true })

require('config.lazy')
require('config.neotree')
require('config.telescope')
require('config.lsp')

vim.wo.relativenumber = true
vim.cmd.colorscheme('tokyonight')
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
