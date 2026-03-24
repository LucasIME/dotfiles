---
-- LSP setup
---
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gr", function()
    vim.lsp.buf.references()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))

  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, opts)

  vim.keymap.set("n", "<leader>rn", function()
    vim.lsp.buf.rename()
  end, opts)

  vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, opts)
end

local langServersToSetup = { "elixirls", "lua_ls", "pyright", "rust_analyzer", "ts_ls", "bashls", "ruff" }

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = langServersToSetup,
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
  },
})

---
-- Autocompletion config
---

local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
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
