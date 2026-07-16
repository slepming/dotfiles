-- Leader must be set before keymaps/plugins that reference it
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.guicursor = "i:block"
opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.smartindent = true

opt.list = false
opt.listchars = "tab: ,multispace:|   ,eol:󰌑"

opt.winborder = "rounded"
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.undofile = true
opt.swapfile = false
opt.wrap = false
opt.fillchars = { eob = " " }

-- Treesitter-based folds (open by default)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
