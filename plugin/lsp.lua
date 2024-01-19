local cmp = require("cmp")
local mason = require("mason")
local rblxlsp = require("luau-lsp")
local lspconfig = require("lspconfig")
local lspkind = require("lspkind")

vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
    --[[
    formatting = {
      format = function(entry, vim_item)
        -- if you have lspkind installed, you can use it like
        -- in the following line:
        vim_item.kind = require("lspkind").symbolic(vim_item.kind, { mode = "symbol_text" })
        --vim_item.menu = source_mapping[entry.source.name]

        if entry.source.name == "codeium" then
          local detail = (entry.completion_item.data or {}).detail
          vim_item.kind = " Codeium"
          if detail and detail:find(".*%%.*") then
            vim_item.kind = vim_item.kind .. " " .. detail
          end

          if (entry.completion_item.data or {}).multiline then
            vim_item.kind = vim_item.kind .. " " .. "[ML]"
          end
        end
        local maxwidth = 80
        vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
        return vim_item
      end,
    },
    --]]
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
        ['<C-s>'] = cmp.mapping.complete({ reason = cmp.ContextReason.Auto }),
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
    lspconfig.pyre.setup { capabilities = capabilities },
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
