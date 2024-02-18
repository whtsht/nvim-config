vim.api.nvim_create_augroup("userconfig", {})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = "userconfig",
	desc = "return cursor to where it was last time closing the file",
	pattern = "*",
	command = 'silent! normal! g`"zv',
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = "userconfig",
	desc = "automatically format files when saving",
	pattern = "*.rs,*.go,*.java",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = "userconfig",
	desc = "automatically disable spell check when enter term mode",
	pattern = "*",
	command = "setlocal nospell | startinsert",
})
