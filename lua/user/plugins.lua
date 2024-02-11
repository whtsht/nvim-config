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

    -- lsp
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
    --aligning lines
    { "Vonr/align.nvim" },

    -- commenting
    {
        'numToStr/Comment.nvim',
        lazy = false,
        config = function()
            require("Comment").setup()
        end
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
        -- config = function()
        --     require("idris2").setup({})
        -- end
    },

    -- coq
    { "whonore/Coqtail" },
    {
        "tomtomjhj/vscoq.nvim",
        config = function()
            require("vscoq").setup()
        end
    },
}


local lazy_setup = require("user.lazy_setup")
lazy_setup(plugins)

-- Set up lspconfig
local lsp_servers = {
    "pyright",
    "rust_analyzer",
    "jdtls",
    "gopls",
    "idris2_lsp"
}
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, server in pairs(lsp_servers) do
   lspconfig[server].setup {
       capabilities = capabilities
   }
end

vim.api.nvim_create_augroup("AutoFormatting", {})
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.rs,*.go,*.java',
    group = 'AutoFormatting',
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

require("lspconfig").efm.setup {
    init_options = {
        documentFormatting = true,
        hover = true,
    },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            lua = {
                { formatCommand = "lua-format -i", formatStdin = true }
            },
            rust = {
                { formatCommand = "rustfmt", formatStdin = true },
            },
            go = {
                { formatCommand = "gofmt", formatStdin = true },
            },
            java = {
                { formatCommand = "google-java-format --aosp -", formatStdin = true }
            },
        }
    }
}
