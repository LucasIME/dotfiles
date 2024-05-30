vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

require("lmeireles/ensure_lazy")

vim.cmd([[source ~/.config/nvim/common.vim]])

require("lmeireles/plugins")
require("lmeireles/lsp")

vim.cmd("colorscheme onedark")
