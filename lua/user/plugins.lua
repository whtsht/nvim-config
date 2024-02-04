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

    -- lsp
    { "neovim/nvim-lspconfig" },

    -- completion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },

    -- snippet
    { "hrsh7th/vim-vsnip" },

    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
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
}


local lazy_setup = require("user.lazy_setup")
lazy_setup(plugins)

local lspconfig = require("lspconfig")
lspconfig.pyright.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.jdtls.setup{}
lspconfig.gopls.setup{}

vim.api.nvim_create_augroup("AutoFormatting", {})
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.rs,*.go,*.java',
    group = 'AutoFormatting',
    callback = function()
        vim.lsp.buf.format({ async = true })
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

-- Set up lspconfig
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_servers = { "pyright", "rust_analyzer", "jdtls" }
for _, server in pairs(lsp_servers) do
    require("lspconfig")[server].setup {
        capabilities = capabilities
    }
end
