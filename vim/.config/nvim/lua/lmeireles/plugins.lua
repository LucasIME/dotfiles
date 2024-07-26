local lazy = require("lazy")

local treesitterObject = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "romgrk/nvim-treesitter-context", -- Shows context that you are at the top
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "query",
        "elixir",
        "eex",
        "heex",
        "javascript",
        "html",
        "typescript",
        "python",
        "java",
        "go",
        "rust",
      },
      auto_install = true,
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

    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", opts = {} },

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

local telescope = { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder!
    require("telescope").setup({
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<C-p>", builtin.git_files, {})
  end,
}

local autoFormat = {
  "stevearc/conform.nvim",
  lazy = false,
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
    },
  },
}

local copilot = {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({})
  end,
}

local plugins = {
  { "olimorris/onedarkpro.nvim", priority = 1000 }, -- Colorschem. Ensure it loads first
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  "bling/vim-airline", -- Cool line on the bottom
  "scrooloose/nerdtree", -- Tree explorer
  "ryanoasis/vim-devicons", -- Icons
  "wincent/terminus", -- Enhance terminal integration with vim
  "junegunn/fzf.vim", -- fzf plugin
  "preservim/nerdcommenter", -- Easy to toggle comments
  "christoomey/vim-tmux-navigator", -- tmux and vim integration
  treesitterObject,
  lspZero,
  telescope,
  autoFormat,
  copilot,
}

lazy.setup(plugins)
