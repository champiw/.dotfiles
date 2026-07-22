vim.o.number = true
vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.g.mapleader = " "

-- leader + cd = change directory
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
-- leader + so = source config 
vim.keymap.set('n', '<leader>so', ':update<CR> :source<CR>')
-- ctrl + bksp = delete whole word
vim.keymap.set('i', '<C-BS>', '<C-W>', { noremap = true })

vim.pack.add({
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
})

require("gruvbox").setup()
vim.cmd.colorscheme("gruvbox")
--vim.cmd(":hi statusline guibg=NONE")
