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

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-l>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"]  = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Set up lspconfig
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_servers = { "pyright", "rust_analyzer", "jdtls" }
for _, server in pairs(lsp_servers) do
    require("lspconfig")[server].setup {
        capabilities = capabilities
    }
end
