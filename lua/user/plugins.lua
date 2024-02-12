local plugins = {
    -- color scheme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },

    -- interface for tree-sitter
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = "all",
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                }
            }
        end
    },

    -- status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        lazy = false,
        priority = 1000,
        config = function()
            require("lualine").setup()
        end
    },

    -- indent guide
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = false,
        config = function()
            require("ibl").setup()
        end
    },

    -- lsp progress messages
    {
        "j-hui/fidget.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("fidget").setup()
        end
    },

    -- general purpose language server
    {
        "mattn/efm-langserver",
        lazy = false,
    },

    -- fuzzy finder.
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup()
        end
    },

    -- motions on speed
    {
        "phaazon/hop.nvim",
        config = function()
            require("hop").setup()
        end
    },

    -- move by subwords
    { "chrisgrieser/nvim-spider"},

    -- Clipboard manager
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {
            {'ibhagwan/fzf-lua'},
        },
        config = function()
            require('neoclip').setup()
        end,
    },

    -- language server
    { "neovim/nvim-lspconfig" },

    -- completion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { 'saadparwaiz1/cmp_luasnip' },

    -- snippet
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local loader = require("luasnip.loaders.from_vscode")
            loader.lazy_load({ paths = {"./snippets"}})
            loader.lazy_load()
        end
    },

    -- aligning lines
    { "Vonr/align.nvim" },

    -- auto pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config =  function()
            require("nvim-autopairs").setup()
        end
    },

    -- commenting
    {
        'numToStr/Comment.nvim',
        lazy = false,
        config = function()
            require("Comment").setup()
        end
    },

    -- better quickfix window
    {
        "kevinhwang91/nvim-bqf",
    },

    -- show git diff markers
    {
        "airblade/vim-gitgutter",
        lazy = false,
    },

    -- idris lsp
    {
        "ShinKage/idris2-nvim",
        dependencies = { "neovim/nvim-lspconfig", "MunifTanjim/nui.nvim" },
    },

    -- coq
    { "whonore/Coqtail" },
    {
        "tomtomjhj/vscoq.nvim",
        config = function()
            require("vscoq").setup()
        end
    },

    -- markdown
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    -- skk
    {
        "vim-skk/skkeleton",
        dependencies = { 'vim-denops/denops.vim' },
        config = function()
            vim.fn["skkeleton#initialize"]()
            vim.fn["skkeleton#config"]({ globalDictionaries = {"/usr/share/skk/SKK-JISYO.L"} })
        end
    },
}

local lazy_setup = require("user.lazy_setup")
lazy_setup(plugins)
