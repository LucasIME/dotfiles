---
-- LSP setup
---
local lsp_zero = require("lsp-zero")
lsp_zero.preset("recommended")

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gr", function()
    vim.lsp.buf.references()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))

  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "<leader>rn", function()
    vim.lsp.buf.rename()
  end, opts)

  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

lsp_zero.setup()

--- if you want to know more about lsp-zero and mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require("mason").setup({})

local langServersToSetup = { "elixirls", "lua_ls", "pyright", "rust_analyzer", "tsserver" }
require("mason-lspconfig").setup({
  ensure_installed = langServersToSetup,
})

local lspConfig = require("lspconfig")
for _, server in ipairs(langServersToSetup) do
  lspConfig[server].setup({})
end

---
-- Autocompletion config
---

local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- Tab key to confirm completion
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),

    -- Ctrl+Space to trigger completion menu
    ["<C-Space>"] = cmp.mapping.complete(),

    -- Scroll up and down in the completion documentation
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
  }),
})
