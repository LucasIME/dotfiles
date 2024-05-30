local lazy = require("lazy")

local treesitterObject = {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "romgrk/nvim-treesitter-context", -- Shows context that you are at the top
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "eex", "heex", "javascript", "html", "typescript", "python", "java", "go", "rust" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
    build = ":TSUpdate",
}

local lspZero = {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
        -- LSP Support
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { "lukas-reineke/lsp-format.nvim", config = true },

        -- Autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",

         -- Snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },
}

local plugins = {
    {"olimorris/onedarkpro.nvim",priority = 1000, }, -- Colorschem. Ensure it loads first
    "bling/vim-airline", -- Cool line on the bottom
    "scrooloose/nerdtree", -- Tree explorer
    "ryanoasis/vim-devicons", -- Icons
    "wincent/terminus", -- Enhance terminal integration with vim
    "junegunn/fzf.vim",  -- fzf plugin
    "preservim/nerdcommenter", -- Easy to toggle comments
    "christoomey/vim-tmux-navigator", -- tmux and vim integration
    "github/copilot.vim", -- Github copilot completions
    treesitterObject,
    lspZero
}

lazy.setup(plugins)
