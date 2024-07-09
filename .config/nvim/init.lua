-- Set <space> as the leader key
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " " -- Same for `maplocalleader`

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Ensure Lazy package manager is installed
require("lmeireles/ensure_lazy")

vim.cmd([[source ~/.config/nvim/common.vim]])

require("lmeireles/plugins")
require("lmeireles/lsp")

vim.cmd("colorscheme onedark")
