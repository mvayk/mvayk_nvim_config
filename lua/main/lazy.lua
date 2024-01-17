local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {'folke/tokyonight.nvim', lazy = false},
    {'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}},
    {'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = {'nvim-lua/plenary.nvim'}},
    {"lopi-py/luau-lsp.nvim", dependencies = { "nvim-lua/plenary.nvim", } },
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'nvim-treesitter/nvim-treesitter'},
    {'neovim/nvim-lspconfig'},
    {'mfussenegger/nvim-lint'},
    {'folke/neodev.nvim'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-cmdline'},
    {'hrsh7th/cmp-vsnip'},
    {'hrsh7th/vim-vsnip'},
    {'L3MON4D3/LuaSnip'},
    {'saadparwaiz1/cmp_luasnip'},
    {'goolord/alpha-nvim'},
})
