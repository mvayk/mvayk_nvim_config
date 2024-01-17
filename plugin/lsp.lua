local cmp = require("cmp")
local mason = require("mason")
local rblxlsp = require("luau-lsp")
local lspconfig = require("lspconfig")
local lspkind = require("lspkind")

vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol', -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                         -- can also be a function to dynamically calculate max width such as 
                         -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function (entry, vim_item)
            return vim_item
          end
        })
    },

    preselect = cmp.PreselectMode.None,
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
        --[[
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        --]]

        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "codeium" },
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
    lspconfig.luau_lsp.setup { capabilities = capabilities },
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
