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
    },
    c = {
        { "<C-b>", "<left>"  },
        { "<C-f>", "<right>" },
        { "<C-a>", "<home>"  },
        { "<C-e>", "<end>"   },
    },
}

local fzf_keymaps = {
    n = {
        { "<leader>ff", "<cmd>FzfLua files<cr>"              },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>"            },
        { "<leader>fo", "<cmd>FzfLua oldfiles<cr>"           },
        -- { "<leader>fql", "<cmd>FzfLua quickfix<cr>"       },
        -- { "<leader>fqs", "<cmd>FzfLua quickfix_stack<cr>" },
        -- { "<leader>fll", "<cmd>FzfLua loclist<cr>"        },
        -- { "<leader>fls", "<cmd>FzfLua loclist_stack<cr>"  },
        { "<leader>fl", "<cmd>FzfLua lines<cr>"              },
        --{ "<leader>f", "<cmd>FzfLua lines<cr>"             },
        { "<leader>ft", "<cmd>FzfLua tabs<cr>"               },
        { "<leader>fa", "<cmd>FzfLua args<cr>"               },

        -- { "<leader>gp", "<cmd>FzfLua grep<cr>"            },
        { "<leader>gl", "<cmd>FzfLua grep_last<cr>"          },
        { "<leader>gc", "<cmd>FzfLua grep_cword<cr>"         },
        { "<leader>gC", "<cmd>FzfLua grep_cWORD<cr>"         },
        { "<leader>gp", "<cmd>FzfLua grep_project<cr>"       },

        { "<leader>lp", "<cmd>FzfLua live_grep<cr>"          },
        { "<leader>lr", "<cmd>FzfLua live_grep_resume<cr>"   },
        { "<leader>lg", "<cmd>FzfLua live_grep_glob<cr>"     },
        { "<leader>ln", "<cmd>FzfLua live_grep_native<cr>"   },
    },
    x = {
        { "<leader>gv", "<cmd>FzfLua grep_visual<cr>"        },
        { "ga"        , "<cmd>EasyAlign<cr>"                 },
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
    },
}

local hop_keymaps = {
    n = {
        { "<leader>ht", "<cmd>HopChar2<cr>"     },
        { "<leader>hs", "<cmd>HopLineStart<cr>" },
        { "<leader>hp", "<cmd>HopPattern<cr>"   },
    },
    x = {
        { "<leader>ht", "<cmd>HopChar2<cr>"     },
        { "<leader>hs", "<cmd>HopLineStart<cr>" },
        { "<leader>hp", "<cmd>HopPattern<cr>"   },
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
apply_kaymaps(lsp_keymaps)
apply_kaymaps(hop_keymaps)
apply_kaymaps(align_keymaps)
