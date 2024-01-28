local options = {
    opt = {
        -- basic
        compatible = false,
        encoding = "utf-8",
        fileencoding = "utf-8",
        clipboard = "unnamedplus",
        completeopt = {"menu", "preview", "noselect"},
        timeoutlen = 500,
        shell = "zsh",

        -- backup and history
        writebackup = false,
        swapfile = false,
        undofile = true,

        -- pattern matching
        ignorecase = true,
        smartcase = true,

        -- indenting
        tabstop = 4,
        expandtab = true,
        softtabstop = 4,
        shiftwidth = 4,

        -- display
        number = true,
        relativenumber = true,
        list = true,
        listchars = {
            eol = '↵',
            space = "·",
            tab = ">·",
            trail = "~",
            extends = ">",
            precedes = "<"
        },
        background = "dark",
        spell = true,
        spelllang = 'en,cjk',
    },
    g = {
        mapleader = " ",
    }
}

for scope, table in pairs(options) do
    for setting, value in pairs(table) do
        vim[scope][setting] = value
    end
end
