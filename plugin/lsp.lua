local cmp = require("cmp")
local mason = require("mason")
local rblxlsp = require("luau-lsp")
local lspconfig = require("lspconfig")

vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
    }, {
        { name = "buffer" },
        { name = "path" },
    }),
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

rblxlsp.setup()

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("neodev").setup({})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
    luau_lsp = function()
        require("luau-lsp").setup { capabilities = capabilities }
    end,
    lspconfig.lua_ls.setup { capabilities = capabilities },
    lspconfig.clangd.setup { capabilities = capabilities },
}

rblxlsp.setup {
  server = {
    settings = {
      -- https://github.com/folke/neoconf.nvim/blob/main/schemas/luau_lsp.json
      ["luau-lsp"] = {
        completion = {
          imports = {
            enabled = true, -- enable auto imports
          },
        },
      },
    },
  },
}

rblxlsp.config {}
