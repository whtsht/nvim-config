local lsp_servers = {
	"pyright",
	"jdtls",
	"gopls",
	"idris2_lsp",
}
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, server in pairs(lsp_servers) do
	lspconfig[server].setup({
		capabilities = capabilities,
	})
end

lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
		},
	},
	capabilities = capabilities,
})
