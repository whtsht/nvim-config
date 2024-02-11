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
