vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    require('packer').startup(function(use)
        use({ 'rose-pine/neovim', as = 'rose-pine' })
    end)

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }
    use({
        "arsham/arshamiser.nvim",
        requires = {
            "arsham/arshlib.nvim",
            "famiu/feline.nvim",
            "rebelot/heirline.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            -- ignore any parts you don't want to use
            vim.cmd.colorscheme("arshamiser_light")
            require("arshamiser.feliniser")
            -- or:
            -- require("arshamiser.heirliniser")

            _G.custom_foldtext = require("arshamiser.folding").foldtext
            vim.opt.foldtext = "v:lua.custom_foldtext()"
            -- if you want to draw a tabline:
            vim.api.nvim_set_option("tabline", [[%{%v:lua.require("arshamiser.tabline").draw()%}]])
        end,
    })
end)
