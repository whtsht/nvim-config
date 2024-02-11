function apply_kaymaps(keymaps)
    for mode, map_opts in pairs(keymaps) do
        for _, map_opt in ipairs(map_opts) do
            local key, action, options = unpack(map_opt)
            if options == nil then
                options = { noremap = true }
            else
                options.noremap = true
            end
            vim.keymap.set(mode, key, action, options)
        end
    end
end

local basic_keymaps = {
    n = {
        { "<leader>w", "<cmd>w<cr>" },
        { "<leader>q", "<cmd>q<cr>" },
        { "<leader>n", "<cmd>noh<cr>", { silent = true } },
        { "k", "gk" },
        { "j", "gj" },
        { "H", "g^" },
        { "L", "g$" },
    },
    c = {
        { "<C-b>", "<left>"  },
        { "<C-f>", "<right>" },
        { "<C-a>", "<home>"  },
        { "<C-e>", "<end>"   },
    },
    i = {
        { "jj", "<esc>" },
    }
}

local fzf_keymaps = {
    n = {
        { "<leader>ff", "<cmd>FzfLua files<cr>"              },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>"            },
        { "<leader>fo", "<cmd>FzfLua oldfiles<cr>"           },

        { "<leader>fl", "<cmd>FzfLua lines<cr>"              },
        { "<leader>ft", "<cmd>FzfLua tabs<cr>"               },

        { "<leader>gf", "<cmd>FzfLua git_files<cr>"             },
        { "<leader>gs", "<cmd>FzfLua git_status<cr>"            },
        { "<leader>gc", "<cmd>FzfLua git_commits<cr>"           },
        { "<leader>gb", "<cmd>FzfLua git_branches<cr>"          },
        { "<leader>gt", "<cmd>FzfLua git_tags<cr>"              },
        { "<leader>ga", "<cmd>FzfLua git_stash<cr>"             },
        { "<leader>cc", function() require('neoclip.fzf')() end },
    },
    x = {
        { "<leader>gv", "<cmd>FzfLua grep_visual<cr>"        },
    },
    i = {
        { "<c-f>p", "<cmd>FzfLua complete_path<cr>"  },
        { "<c-f>f", "<cmd>FzfLua complete_file<cr>"  },
        { "<c-f>l", "<cmd>FzfLua complete_line<cr>"  },
        { "<c-f>b", "<cmd>FzfLua complete_bline<cr>" },
    }
}

local lsp_keymaps = {
    n = {
        { "[d", vim.diagnostic.goto_prev },
        { "]d", vim.diagnostic.goto_next },
        { "K" , vim.lsp.buf.hover        },
        { "gd", vim.lsp.buf.definition },
        { "<leader>rn", vim.lsp.buf.rename },
        { "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>"  },
        { "<leader>f", function() vim.lsp.buf.format { async = true } end },
    },
}

local hop_keymaps = {
    n = {
        { "<leader><leader>", "<cmd>HopChar2<cr>" },
    },
    x = {
        { "<leader><leader>", "<cmd>HopChar2<cr>" },
    }
}

local align_keymaps = {
    x = {
        { "aa", function()
            require('align').align_to_string({ preview = true, regex = true }) end
        },
    }
}

apply_kaymaps(basic_keymaps)
apply_kaymaps(fzf_keymaps)
apply_kaymaps(hop_keymaps)
apply_kaymaps(align_keymaps)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    apply_kaymaps(lsp_keymaps)
  end,
})

vim.keymap.set(
	{ "n", "o", "x" },
	"w",
	"<cmd>lua require('spider').motion('w')<CR>",
	{ desc = "Spider-w" }
)
vim.keymap.set(
	{ "n", "o", "x" },
	"e",
	"<cmd>lua require('spider').motion('e')<CR>",
	{ desc = "Spider-e" }
)
vim.keymap.set(
	{ "n", "o", "x" },
	"b",
	"<cmd>lua require('spider').motion('b')<CR>",
	{ desc = "Spider-b" }
)
