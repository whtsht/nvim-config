local function apply_kaymaps(keymaps)
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
		{ "<leader>b", "<cmd>bd<cr>" },
		{ "<leader>e", "<cmd>qa<cr>" },
		{ "<leader>n", "<cmd>noh<cr>", { silent = true } },

		{ "k", "gk" },
		{ "j", "gj" },
		{ "H", "g^" },
		{ "L", "g$" },

		{ "<C-a>", "ggVG" },
	},
	c = {
		{ "<C-b>", "<left>" },
		{ "<C-f>", "<right>" },
		{ "<C-a>", "<home>" },
		{ "<C-e>", "<end>" },
		{ "<C-p>", "<up>" },
		{ "<C-n>", "<down>" },
	},
	i = {
		{ "jj", "<esc>" },
		{ "<C-j>", "<Plug>(skkeleton-enable)" },
	},
}

local fzf_keymaps = {
	n = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>" },
		{ "<leader>fb", "<cmd>FzfLua buffers<cr>" },
		{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>" },
		{ "<leader>fq", "<cmd>FzfLua quickfix_stack<cr>" },

		{ "<leader>fl", "<cmd>FzfLua lines<cr>" },
		{ "<leader>ft", "<cmd>FzfLua tabs<cr>" },

		{ "<leader>gp", "<cmd>FzfLua grep_project<cr>" },

		{ "<leader>gf", "<cmd>FzfLua git_files<cr>" },
		{ "<leader>gs", "<cmd>FzfLua git_status<cr>" },
		{ "<leader>gc", "<cmd>FzfLua git_commits<cr>" },
		{ "<leader>gb", "<cmd>FzfLua git_branches<cr>" },
		{ "<leader>gt", "<cmd>FzfLua git_tags<cr>" },
		{ "<leader>ga", "<cmd>FzfLua git_stash<cr>" },
		{
			"<leader>cc",
			function()
				require("neoclip.fzf")()
			end,
		},

		{ "<leader>sh", "<cmd>FzfLua search_history<cr>" },
		{ "<leader>sh", "<cmd>FzfLua command_history<cr>" },
		{ "<leader>mk", "<cmd>FzfLua marks<cr>" },
		{ "<leader>mk", "<cmd>FzfLua jumps<cr>" },
	},
	x = {
		{ "<leader>gv", "<cmd>FzfLua grep_visual<cr>" },
	},
}

local lsp_keymaps = {
	n = {
		{ "[d", vim.diagnostic.goto_prev },
		{ "]d", vim.diagnostic.goto_next },
		{ "K", vim.lsp.buf.hover },
		{ "gd", vim.lsp.buf.definition },
		{ "<leader>rn", vim.lsp.buf.rename },
		{ "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>" },
		{
			"<leader>f",
			function()
				vim.lsp.buf.format({ async = true })
			end,
		},
	},
}

local hop_keymaps = {
	n = {
		{ "<leader><leader>", "<cmd>HopChar2<cr>" },
	},
	x = {
		{ "<leader><leader>", "<cmd>HopChar2<cr>" },
	},
}

local align_keymaps = {
	x = {
		{
			"aa",
			function()
				require("align").align_to_string({ preview = true, regex = true })
			end,
		},
	},
}

apply_kaymaps(basic_keymaps)
apply_kaymaps(fzf_keymaps)
apply_kaymaps(hop_keymaps)
apply_kaymaps(align_keymaps)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(_)
		apply_kaymaps(lsp_keymaps)
	end,
})
