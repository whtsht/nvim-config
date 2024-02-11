require("lspconfig").efm.setup {
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true,
    },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            markdown = {
                {
                    lintCommand = "npx textlint --format unix ${INPUT}",
                    lintFormats = { '%f:%l:%n: %m' },
                }
            },
            lua = {
                {
                    formatCommand = "lua-format -i",
                    formatStdin = true
                }
            },
            rust = {
                {
                    formatCommand = "rustfmt",
                    formatStdin = true
                },
            },
            go = {
                {
                    formatCommand = "gofmt",
                    formatStdin = true
                },
            },
            java = {
                {
                    formatCommand = "google-java-format --aosp -",
                    formatStdin = true
                }
            },
        }
    }
}
